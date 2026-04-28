package com.example.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.example.config.Db;
import com.example.model.Envoyer;

public class EnvoyerDao {
    public static Connection conn;

    static {
        try {
            conn = Db.getConnection();
        } catch (Exception e) {
            throw new RuntimeException("Erreur de Connexion", e);

        }
    }

    private static final String Lister = " SELECT * FROM \"Envoyer\"";
    private static final String Supprimer = " DELETE FROM \"Envoyer\" WHERE idEnv = ?";

    public List<Envoyer> listerEnv() {
        List<Envoyer> liste = new ArrayList<>();

        try (Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(Lister)) {
            while (rs.next()) {
                liste.add(mapRow(rs));
            }

        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération de la liste : " + e.getMessage());
            e.printStackTrace();
        }

        return liste;
    }

    public boolean ajouterEnv(Envoyer envoyer) {
        String verifSql = "SELECT COUNT(*) FROM \"Envoyer\" WHERE idEnv = ?";
        String insererSql = "INSERT INTO \"Envoyer\" (idEnv, numEnvoyeur, numRecepteur, montant, date, raison) VALUES (?,?,?,?,?,?)";

        try (PreparedStatement checkStmt = conn.prepareStatement(verifSql)) {
            checkStmt.setString(1, envoyer.getIdEnv());

            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return false;
                }
            }

            try (PreparedStatement insertStmt = conn.prepareStatement(insererSql)) {
                insertStmt.setString(1, envoyer.getIdEnv());
                insertStmt.setString(2, envoyer.getNumEnvoyeur());
                insertStmt.setString(3, envoyer.getNumRecepteur());
                insertStmt.setInt(4, envoyer.getMontant());
                insertStmt.setTimestamp(5, envoyer.getDate());
                insertStmt.setString(6, envoyer.getRaison());

                int rowsAffected = insertStmt.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void modifierEnvoyer(Envoyer envoyer, Map<String, Object> data) {
        if (data == null || data.isEmpty()) {
            return;
        }

        StringBuilder sql = new StringBuilder("UPDATE \"Envoyer\" SET ");
        List<Object> values = new ArrayList<>();

        data.forEach((column, value) -> {
            sql.append(column).append(" = ? ,");
            values.add(value);
        });

        sql.setLength(sql.length() - 2);
        sql.append(" WHERE idEnv = ?");
        values.add(envoyer.getIdEnv());

        try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < values.size(); i++) {
                stmt.setObject(i + 1, values.get(i));
            }

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                System.out.println("Mise a jour reussi de envoyer !");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void SupprimerEnvoyer(Envoyer envoyer) {
        try (PreparedStatement stmt = conn.prepareStatement(Supprimer)) {
            stmt.setString(1, envoyer.getIdEnv());
            stmt.executeUpdate();
            System.out.println("Envoyer supprimer avec succes !");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Envoyer mapRow(ResultSet rs) throws SQLException {
        return new Envoyer(
                rs.getString("idEnv"),
                rs.getString("numEnvoyeur"),
                rs.getString("numRecepteur"),
                rs.getInt("montant"),
                rs.getTimestamp("date"),
                rs.getString("raison")
        );
    }
}
