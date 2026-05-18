package com.example.DAO;

import com.example.config.Db;
import com.example.model.Client;
import com.example.model.Envoyer;
import com.example.service.EmailService;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class EnvoyerDao {

    private Connection conn;
    private final EmailService emailService = new EmailService();

    public EnvoyerDao() {
        try {
            this.conn = Db.getConnection();
            if (!this.conn.getAutoCommit()) {
                this.conn.rollback();
                this.conn.setAutoCommit(true);
            }
        } catch (Exception e) {
            throw new RuntimeException(
                    "Impossible d'établir la connexion à la base de données : " + e.getMessage(), e);
        }
    }

    private double tauxVersEuro(String pays) throws Exception {
        if (pays.equalsIgnoreCase("France"))
            return 1.0;
        String sql1 = "SELECT montant1, montant2 FROM TAUX " +
                "WHERE pays1 = 'France' AND pays2 = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql1)) {
            ps.setString(1, pays);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return (double) rs.getInt("montant1") / rs.getInt("montant2");
            }
        }

        String sql2 = "SELECT montant1, montant2 FROM TAUX " +
                "WHERE pays1 = ? AND pays2 = 'France'";
        try (PreparedStatement ps = conn.prepareStatement(sql2)) {
            ps.setString(1, pays);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return (double) rs.getInt("montant2") / rs.getInt("montant1");
            }
        }

        throw new Exception("Taux introuvable pour le pays : " + pays);
    }

    private int convertirEurVersLocal(double montantEur, String pays) throws Exception {
        double taux = tauxVersEuro(pays); // EUR par unité locale
        return (int) Math.round(montantEur / taux);
    }

    public void envoyerArgent(Envoyer env) throws Exception {

        if (env.getMontant() <= 0) {
            throw new Exception("Le montant doit être supérieur à 0 EUR.");
        }
        String checkId = "SELECT COUNT(*) FROM ENVOYER WHERE idEnv = ?";
        try (PreparedStatement ps = conn.prepareStatement(checkId)) {
            ps.setString(1, env.getIdEnv());
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                throw new Exception(
                        "L'ID de transaction « " + env.getIdEnv() + " » existe déjà.");
            }
        }

        try {
            conn.setAutoCommit(false);

            PreparedStatement ps1 = conn.prepareStatement(
                    "SELECT solde, pays, nom, email FROM CLIENT WHERE numtel = ?");
            ps1.setString(1, env.getNumEnvoyeur());
            ResultSet rs1 = ps1.executeQuery();
            if (!rs1.next())
                throw new Exception("Envoyeur introuvable");

            int soldeEnv = rs1.getInt("solde");
            String paysEnv = rs1.getString("pays");
            String nomEnv = rs1.getString("nom");
            String mailEnv = rs1.getString("email");

            PreparedStatement ps2 = conn.prepareStatement(
                    "SELECT pays, nom, email FROM CLIENT WHERE numtel = ?");
            ps2.setString(1, env.getNumRecepteur());
            ResultSet rs2 = ps2.executeQuery();
            if (!rs2.next())
                throw new Exception("Récepteur introuvable");

            String paysRec = rs2.getString("pays");
            String nomRec = rs2.getString("nom");
            String mailRec = rs2.getString("email");

            if (paysEnv.equalsIgnoreCase(paysRec)) {
                throw new Exception("Le transfert doit être international !");
            }

            int montantEur = env.getMontant(); // ex: 12 EUR

            PreparedStatement ps3 = conn.prepareStatement(
                    "SELECT frais FROM FRAIS_ENVOI WHERE ? BETWEEN montant1 AND montant2");
            ps3.setInt(1, montantEur);
            ResultSet rs3 = ps3.executeQuery();
            int fraisEur = rs3.next() ? rs3.getInt("frais") : 0;

            int totalEur = montantEur + fraisEur;

            int debitLocal = convertirEurVersLocal(totalEur, paysEnv);

            if (soldeEnv < debitLocal) {
                String deviseEnv = obtenirDevise(paysEnv);
                throw new Exception(
                        "Solde insuffisant — requis : " + debitLocal + " " + deviseEnv
                                + ", disponible : " + soldeEnv + " " + deviseEnv);
            }

            int creditLocal = convertirEurVersLocal(montantEur, paysRec);

            PreparedStatement ps4 = conn.prepareStatement(
                    "UPDATE CLIENT SET solde = solde - ? WHERE numtel = ?");
            ps4.setInt(1, debitLocal);
            ps4.setString(2, env.getNumEnvoyeur());
            ps4.executeUpdate();

            PreparedStatement ps5 = conn.prepareStatement(
                    "UPDATE CLIENT SET solde = solde + ? WHERE numtel = ?");
            ps5.setInt(1, creditLocal);
            ps5.setString(2, env.getNumRecepteur());
            ps5.executeUpdate();

            PreparedStatement ps6 = conn.prepareStatement(
                    "INSERT INTO ENVOYER VALUES (?, ?, ?, ?, ?, ?)");
            ps6.setString(1, env.getIdEnv());
            ps6.setString(2, env.getNumEnvoyeur());
            ps6.setString(3, env.getNumRecepteur());
            ps6.setInt(4, montantEur); // on stocke le montant en EUR
            ps6.setDate(5, Date.valueOf(env.getDate()));
            ps6.setString(6, env.getRaison());
            ps6.executeUpdate();

            conn.commit();

            String deviseEnv = obtenirDevise(paysEnv);
            String deviseRec = obtenirDevise(paysRec);

            try {
                emailService.envoyerNotificationEnvoyeur(
                        mailEnv, nomEnv, debitLocal, deviseEnv, env.getNumRecepteur());
            } catch (Exception mailEx) {
                System.err.println("⚠️ Mail envoyeur non envoyé : " + mailEx.getMessage());
            }

            try {
                emailService.envoyerNotificationRecepteur(
                        mailRec, nomRec, creditLocal, deviseRec, env.getNumEnvoyeur());
            } catch (Exception mailEx) {
                System.err.println("⚠️ Mail récepteur non envoyé : " + mailEx.getMessage());
            }

        } catch (Exception e) {
            conn.rollback();
            throw e;
        }
    }

    private String obtenirDevise(String pays) {
        switch (pays.toLowerCase()) {
            case "france":
                return "EUR";
            case "madagascar":
                return "MGA";
            case "etat unis":
                return "USD";
            case "maroc":
                return "MAD";
            case "senegal":
                return "XOF";
            default:
                return "devise locale";
        }
    }

    public Map<String, Integer> getStatsGlobales() throws SQLException {
        Map<String, Integer> stats = new HashMap<>();
        String sql = """
                    SELECT
                        COALESCE(SUM(f.frais), 0) AS total_recette,
                        COALESCE(SUM(e.montant), 0) AS total_volume,
                        COUNT(e.idEnv) AS total_count
                    FROM ENVOYER e
                    JOIN FRAIS_ENVOI f ON e.montant BETWEEN f.montant1 AND f.montant2
                """;

        try (Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                stats.put("recette", rs.getInt("total_recette"));
                stats.put("volume", rs.getInt("total_volume"));
                stats.put("count", rs.getInt("total_count"));
            }
        }
        return stats;
    }

    public List<Envoyer> lister() throws SQLException {
        List<Envoyer> list = new ArrayList<>();
        String sql = "SELECT * FROM ENVOYER ORDER BY idEnv ASC";
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            Envoyer e = new Envoyer(
                    rs.getString("idEnv"),
                    rs.getString("numEnvoyeur"),
                    rs.getString("numRecepteur"),
                    rs.getInt("montant"),
                    rs.getDate("date").toLocalDate(),
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
                    rs.getDate("date").toLocalDate(),
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

        String sql = "SELECT * FROM ENVOYER WHERE date::date = ?::date";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, date);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(new Envoyer(
                    rs.getString("idEnv"),
                    rs.getString("numEnvoyeur"),
                    rs.getString("numRecepteur"),
                    rs.getInt("montant"),
                    rs.getDate("date").toLocalDate(),
                    rs.getString("raison")));
        }
        return list;
    }

    public List<Envoyer> getEnvoisParClientEtMois(String numtel, int mois, int annee) throws SQLException {
        List<Envoyer> list = new ArrayList<>();
        String sql = """
                    SELECT * FROM ENVOYER
                    WHERE "numEnvoyeur" = ?
                      AND EXTRACT(MONTH FROM date) = ?
                      AND EXTRACT(YEAR FROM date) = ?
                    ORDER BY date ASC
                """;
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, numtel);
        ps.setInt(2, mois);
        ps.setInt(3, annee);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(new Envoyer(
                    rs.getString("idEnv"),
                    rs.getString("numEnvoyeur"),
                    rs.getString("numRecepteur"),
                    rs.getInt("montant"),
                    rs.getTimestamp("date").toLocalDateTime().toLocalDate(),
                    rs.getString("raison")));
        }
        return list;
    }

    public Map<String, String> getInfosClient(String numtel) throws SQLException {
        Map<String, String> infos = new LinkedHashMap<>();
        ClientDao clientDao = new ClientDao();
        Client client = clientDao.findByNumtel(numtel);

        if (client != null) {
            infos.put("nom", client.getNom());
            infos.put("sexe", client.getSexe());
            infos.put("pays", client.getPays());
            infos.put("solde", client.getSolde() + " " + obtenirDevise(client.getPays()));
            infos.put("email", client.getEmail());
        }
        return infos;
    }

    public int getTotalVolume() throws SQLException {
        String sql = "SELECT COALESCE(SUM(montant), 0) FROM ENVOYER";
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int getTotalFrais() throws SQLException {
        String sql = "SELECT COALESCE(SUM(f.frais), 0) FROM ENVOYER e JOIN FRAIS_ENVOI f ON e.montant BETWEEN f.montant1 AND f.montant2";
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

}