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

            int solde = rs1.getInt("solde");
            String paysEnv = rs1.getString("pays");

            PreparedStatement ps2 = conn.prepareStatement(
                    "SELECT pays FROM CLIENT WHERE numtel=?");
            ps2.setString(1, env.getNumRecepteur());
            ResultSet rs2 = ps2.executeQuery();

            if (!rs2.next())
                throw new Exception("Recepteur introuvable");

            String paysRec = rs2.getString("pays");

            if (paysEnv.equals(paysRec)) {
                throw new Exception("Transfert doit être international !");
            }

            PreparedStatement ps3 = conn.prepareStatement(
                    "SELECT frais FROM FRAIS_ENVOI WHERE ? BETWEEN montant1 AND montant2");
            ps3.setInt(1, env.getMontant());
            ResultSet rs3 = ps3.executeQuery();

            int frais = 0;
            if (rs3.next())
                frais = rs3.getInt("frais");

            if (solde < env.getMontant() + frais) {
                throw new Exception("Solde insuffisant !");
            }

            Statement st = conn.createStatement();
            ResultSet rs4 = st.executeQuery("SELECT montant2 FROM TAUX WHERE montant1=1");

            int taux = 1;
            if (rs4.next())
                taux = rs4.getInt("montant2");

            int montantConverti = env.getMontant() * taux;

            PreparedStatement ps4 = conn.prepareStatement(
                    "UPDATE CLIENT SET solde = solde - ? WHERE numtel=?");
            ps4.setInt(1, env.getMontant() + frais);
            ps4.setString(2, env.getNumEnvoyeur());
            ps4.executeUpdate();

            
            PreparedStatement ps5 = conn.prepareStatement(
                    "UPDATE CLIENT SET solde = solde + ? WHERE numtel=?");
            ps5.setInt(1, montantConverti);
            ps5.setString(2, env.getNumRecepteur());
            ps5.executeUpdate();

           
            PreparedStatement ps6 = conn.prepareStatement(
                    "INSERT INTO ENVOYER VALUES (?, ?, ?, ?, ?, ?)");
            ps6.setString(1, env.getIdEnv());
            ps6.setString(2, env.getNumEnvoyeur());
            ps6.setString(3, env.getNumRecepteur());
            ps6.setInt(4, env.getMontant());
            ps6.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            ps6.setString(6, env.getRaison());
            ps6.executeUpdate();

            conn.commit();

        } catch (Exception e) {
            conn.rollback();
            throw e;
        }
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