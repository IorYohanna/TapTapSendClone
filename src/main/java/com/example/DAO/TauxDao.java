package com.example.DAO;

import com.example.config.Db;
import com.example.model.Taux;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TauxDao {

    private Connection conn;

    public TauxDao() {
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

    public void ajouter(String idTaux, int montant1, int montant2, String pays1, String pays2) throws SQLException {

        String checkId = "SELECT COUNT(*) FROM TAUX WHERE idtaux = ?";
        try (PreparedStatement ps = conn.prepareStatement(checkId)) {
            ps.setString(1, idTaux);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                throw new SQLException("L'ID de taux « " + idTaux + " » existe déjà.");
            }
        }
        
        if (pays1 == null || pays1.isBlank() || pays2 == null || pays2.isBlank()) {
            throw new SQLException("Les pays ne peuvent pas être vides pour le taux « " + idTaux + " ».");
        }
        if (pays1.equalsIgnoreCase(pays2)) {
            throw new SQLException("Le taux de conversion doit concerner deux pays différents (reçu : « " + pays1
                    + " » → « " + pays2 + " »).");
        }

        String sql = "INSERT INTO TAUX (idtaux, montant1, montant2, pays1, pays2) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, idTaux);
            ps.setInt(2, montant1);
            ps.setInt(3, montant2);
            ps.setString(4, pays1);
            ps.setString(5, pays2);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("L'ajout du taux « " + idTaux + " » a échoué, aucune ligne insérée.");
            }
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de l'ajout du taux « " + idTaux + " » (" + pays1 + " → " + pays2
                    + ") : " + e.getMessage(), e);
        }
    }

    public List<Taux> lister() throws SQLException {
        List<Taux> liste = new ArrayList<>();
        String sql = "SELECT * FROM TAUX ORDER BY idtaux ASC";
        try (Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                liste.add(new Taux(
                        rs.getString("idtaux"),
                        rs.getInt("montant1"),
                        rs.getInt("montant2"),
                        rs.getString("pays1"),
                        rs.getString("pays2")));
            }
        } catch (SQLException e) {
            throw new SQLException(
                    "Erreur lors de la récupération de la liste des taux de conversion : " + e.getMessage(), e);
        }
        return liste;
    }

    public void modifier(String idTaux, int nouveauMontant1, int nouveauMontant2, String nouveauPays1,
            String nouveauPays2) throws SQLException {
        if (nouveauPays1 == null || nouveauPays1.isBlank() || nouveauPays2 == null || nouveauPays2.isBlank()) {
            throw new SQLException(
                    "Les pays ne peuvent pas être vides pour la modification du taux « " + idTaux + " ».");
        }
        if (nouveauPays1.equalsIgnoreCase(nouveauPays2)) {
            throw new SQLException("Le taux de conversion doit concerner deux pays différents (reçu : « " + nouveauPays1
                    + " » → « " + nouveauPays2 + " »).");
        }

        String sql = "UPDATE TAUX SET montant1 = ?, montant2 = ?, pays1 = ?, pays2 = ? WHERE idtaux = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, nouveauMontant1);
            ps.setInt(2, nouveauMontant2);
            ps.setString(3, nouveauPays1);
            ps.setString(4, nouveauPays2);
            ps.setString(5, idTaux);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Aucun taux trouvé avec l'ID « " + idTaux + " », modification impossible.");
            }
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de la modification du taux « " + idTaux + " » : " + e.getMessage(), e);
        }
    }

    public void supprimer(String idTaux) throws SQLException {
        String sql = "DELETE FROM TAUX WHERE idtaux = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, idTaux);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Aucun taux trouvé avec l'ID « " + idTaux + " », suppression impossible.");
            }
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de la suppression du taux « " + idTaux + " » : " + e.getMessage(), e);
        }
    }

    public int getValeurConversion(String pays1) throws SQLException {
        String sql = "SELECT montant2 FROM TAUX WHERE pays1 = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, pays1);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return rs.getInt("montant2");
            }
        } catch (SQLException e) {
            throw new SQLException(
                    "Erreur lors de la récupération du taux de conversion pour « " + pays1 + " » : " + e.getMessage(),
                    e);
        }
        throw new SQLException("Aucun taux de conversion trouvé pour le pays « " + pays1 + " ».");
    }
}