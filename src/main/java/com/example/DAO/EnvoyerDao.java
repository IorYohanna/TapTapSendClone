package com.example.DAO;

import com.example.config.Db;
import com.example.model.Envoyer;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class EnvoyerDao {

    private Connection conn;

    public EnvoyerDao() {
        try {
            this.conn = Db.getConnection();
        } catch (Exception e) {
            throw new RuntimeException("Erreur de connexion : " + e.getMessage(), e);
        }
    }

    public void envoyerArgent(Envoyer env) throws Exception {
        try {
            conn.setAutoCommit(false);
            PreparedStatement ps1 = conn.prepareStatement(
                    "SELECT solde, pays FROM CLIENT WHERE numtel=?");
            ps1.setString(1, env.getNumEnvoyeur());
            ResultSet rs1 = ps1.executeQuery();
            if (!rs1.next())
                throw new Exception("Envoyeur introuvable");

            int soldeEnv = rs1.getInt("solde");
            String paysEnv = rs1.getString("pays");

            PreparedStatement ps2 = conn.prepareStatement(
                    "SELECT pays FROM CLIENT WHERE numtel=?");
            ps2.setString(1, env.getNumRecepteur());
            ResultSet rs2 = ps2.executeQuery();
            if (!rs2.next())
                throw new Exception("Récepteur introuvable");

            String paysRec = rs2.getString("pays");

            if (paysEnv.equals(paysRec)) {
                throw new Exception("Le transfert doit être international !");
            }
            PreparedStatement ps3 = conn.prepareStatement(
                    "SELECT frais FROM FRAIS_ENVOI WHERE ? BETWEEN montant1 AND montant2");
            ps3.setInt(1, env.getMontant());
            ResultSet rs3 = ps3.executeQuery();
            int fraisEuro = rs3.next() ? rs3.getInt("frais") : 0;

            double tauxDebitLocal = obtenirTauxDepuisEuro(paysEnv);
            int totalDebitLocal = (int) Math.round((env.getMontant() + fraisEuro) * tauxDebitLocal);

            double tauxCreditLocal = obtenirTauxDepuisEuro(paysRec);
            int montantCreditLocal = (int) Math.round(env.getMontant() * tauxCreditLocal);

            if (soldeEnv < totalDebitLocal) {
                throw new Exception("Solde insuffisant (Requis: " + totalDebitLocal
                        + " en devise locale, Disponible: " + soldeEnv + ")");
            }

            PreparedStatement ps4 = conn.prepareStatement(
                    "UPDATE CLIENT SET solde = solde - ? WHERE numtel=?");
            ps4.setInt(1, totalDebitLocal);
            ps4.setString(2, env.getNumEnvoyeur());
            ps4.executeUpdate();

            PreparedStatement ps5 = conn.prepareStatement(
                    "UPDATE CLIENT SET solde = solde + ? WHERE numtel=?");
            ps5.setInt(1, montantCreditLocal);
            ps5.setString(2, env.getNumRecepteur());
            ps5.executeUpdate();

            PreparedStatement ps6 = conn.prepareStatement(
                    "INSERT INTO ENVOYER VALUES (?, ?, ?, ?, ?, ?)");
            ps6.setString(1, env.getIdEnv());
            ps6.setString(2, env.getNumEnvoyeur());
            ps6.setString(3, env.getNumRecepteur());
            ps6.setInt(4, env.getMontant()); // montant en EUR
            ps6.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            ps6.setString(6, env.getRaison());
            ps6.executeUpdate();

            conn.commit();

        } catch (Exception e) {
            conn.rollback();
            throw e;
        }
    }

    private double obtenirTauxDepuisEuro(String pays) throws Exception {
        if (pays.equalsIgnoreCase("France"))
            return 1.0;

        String sql1 = "SELECT montant1, montant2 FROM TAUX WHERE pays1 = 'France' AND pays2 = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql1)) {
            ps.setString(1, pays);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return (double) rs.getInt("montant2") / rs.getInt("montant1");
            }
        }
        String sql2 = "SELECT montant1, montant2 FROM TAUX WHERE pays1 = ? AND pays2 = 'France'";
        try (PreparedStatement ps = conn.prepareStatement(sql2)) {
            ps.setString(1, pays);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return (double) rs.getInt("montant1") / rs.getInt("montant2");
            }
        }

        double tauxPaysVersEuro = obtenirTauxPaysVersEuro(pays);
        if (tauxPaysVersEuro != 0) {
            return 1.0 / tauxPaysVersEuro;
        }

        throw new Exception("Taux de conversion introuvable pour le pays : " + pays);
    }

    private double obtenirTauxPaysVersEuro(String pays) throws Exception {
        if (pays.equalsIgnoreCase("France"))
            return 1.0;

        String sql1 = "SELECT montant1, montant2 FROM TAUX WHERE pays1 = 'France' AND pays2 = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql1)) {
            ps.setString(1, pays);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return (double) rs.getInt("montant1") / rs.getInt("montant2");
            }
        }

        String sql2 = "SELECT montant1, montant2 FROM TAUX WHERE pays1 = ? AND pays2 = 'France'";
        try (PreparedStatement ps = conn.prepareStatement(sql2)) {
            ps.setString(1, pays);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return (double) rs.getInt("montant2") / rs.getInt("montant1");
            }
        }

        throw new Exception("Taux vers EUR introuvable pour le pays : " + pays);
    }

    public List<Envoyer> lister() throws SQLException {
        List<Envoyer> list = new ArrayList<>();
        String sql = "SELECT * FROM ENVOYER ORDER BY date DESC";
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            Envoyer e = new Envoyer(
                    rs.getString("idEnv"),
                    rs.getString("numEnvoyeur"),
                    rs.getString("numRecepteur"),
                    rs.getInt("montant"),
                    rs.getTimestamp("date"),
                    rs.getString("raison"));
            list.add(e);
        }
        return list;
    }

    public Envoyer findById(String id) throws SQLException {
        PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM ENVOYER WHERE idEnv=?");
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new Envoyer(
                    rs.getString("idEnv"),
                    rs.getString("numEnvoyeur"),
                    rs.getString("numRecepteur"),
                    rs.getInt("montant"),
                    rs.getTimestamp("date"),
                    rs.getString("raison"));
        }
        return null;
    }

    public void modifier(Envoyer env) throws SQLException {
        String sql = "UPDATE ENVOYER SET raison=? WHERE idEnv=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, env.getRaison());
        ps.setString(2, env.getIdEnv());
        ps.executeUpdate();
    }

    public void supprimer(String id) throws SQLException {
        PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM ENVOYER WHERE idEnv=?");
        ps.setString(1, id);
        ps.executeUpdate();
    }

    public List<Envoyer> rechercherParDate(String date) throws SQLException {
        List<Envoyer> list = new ArrayList<>();
        String sql = "SELECT * FROM ENVOYER WHERE DATE(date)=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, date);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(new Envoyer(
                    rs.getString("idEnv"),
                    rs.getString("numEnvoyeur"),
                    rs.getString("numRecepteur"),
                    rs.getInt("montant"),
                    rs.getTimestamp("date"),
                    rs.getString("raison")));
        }
        return list;
    }
}