package com.example.DAO;

import com.example.config.Db;
import com.example.model.FraisEnvoi;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class FraisDao {

    private Connection conn;
    private static final Set<String> COLONNES_AUTORISEES = Set.of("montant1", "montant2", "frais");

    public FraisDao() {
        try {
            this.conn = Db.getConnection();
            if (!this.conn.getAutoCommit()) {
                this.conn.rollback();
                this.conn.setAutoCommit(true);
            }
        } catch (Exception e) {
            throw new RuntimeException("Impossible d'établir la connexion à la base de données : " + e.getMessage(), e);
        }
    }

    public void ajouter(String id, int m1, int m2, int frais) throws SQLException {

        String checkId = "SELECT COUNT(*) FROM FRAIS_ENVOI WHERE idfrais = ?";
        try (PreparedStatement ps = conn.prepareStatement(checkId)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                throw new SQLException("L'ID de frais « " + id + " » existe déjà.");
            }
        }
        
        if (m1 >= m2) {
            throw new SQLException("La borne inférieure (" + m1
                    + ") doit être strictement inférieure à la borne supérieure (" + m2 + ").");
        }
        if (frais < 0) {
            throw new SQLException("Les frais ne peuvent pas être négatifs (valeur reçue : " + frais + ").");
        }

        String sql = "INSERT INTO FRAIS_ENVOI (idfrais, montant1, montant2, frais) VALUES (?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.setInt(2, m1);
            ps.setInt(3, m2);
            ps.setInt(4, frais);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("L'ajout de la tranche de frais « " + id + " » a échoué, aucune ligne insérée.");
            }
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de l'ajout de la tranche de frais « " + id + " » : " + e.getMessage(),
                    e);
        }
    }

    public List<FraisEnvoi> lister() throws SQLException {
        List<FraisEnvoi> liste = new ArrayList<>();
        String sql = "SELECT * FROM FRAIS_ENVOI ORDER BY idfrais ASC";
        try (Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                liste.add(new FraisEnvoi(
                        rs.getString("idfrais"),
                        rs.getInt("montant1"),
                        rs.getInt("montant2"),
                        rs.getInt("frais")));
            }
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de la récupération des tranches de frais : " + e.getMessage(), e);
        }
        return liste;
    }

    public void modifier(FraisEnvoi frais, Map<String, Object> data) throws SQLException {
        if (data == null || data.isEmpty()) {
            throw new SQLException(
                    "Aucune donnée fournie pour la modification de la tranche « " + frais.getIdfrais() + " ».");
        }

        for (String col : data.keySet()) {
            if (!COLONNES_AUTORISEES.contains(col)) {
                throw new SQLException(
                        "Colonne non autorisée : « " + col + " ». Colonnes acceptées : " + COLONNES_AUTORISEES + ".");
            }
        }

        StringBuilder sql = new StringBuilder("UPDATE FRAIS_ENVOI SET ");
        List<Object> values = new ArrayList<>();

        data.forEach((column, value) -> {
            sql.append(column).append(" = ?, ");
            values.add(value);
        });

        sql.setLength(sql.length() - 2);
        sql.append(" WHERE idfrais = ?");
        values.add(frais.getIdfrais());

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < values.size(); i++) {
                ps.setObject(i + 1, values.get(i));
            }
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Aucune tranche de frais trouvée avec l'ID « " + frais.getIdfrais()
                        + " », modification impossible.");
            }
        } catch (SQLException e) {
            throw new SQLException(
                    "Erreur lors de la modification de la tranche « " + frais.getIdfrais() + " » : " + e.getMessage(),
                    e);
        }
    }

    public void supprimer(String idfrais) throws SQLException {
        String sql = "DELETE FROM FRAIS_ENVOI WHERE idfrais=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, idfrais);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException(
                        "Aucune tranche de frais trouvée avec l'ID « " + idfrais + " », suppression impossible.");
            }
        } catch (SQLException e) {
            throw new SQLException(
                    "Erreur lors de la suppression de la tranche « " + idfrais + " » : " + e.getMessage(), e);
        }
    }
}