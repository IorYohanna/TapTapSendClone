package com.example.DAO;

import com.example.config.Db;
import com.example.model.Client;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClientDao {

    private Connection conn;

    public ClientDao() {
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

    public void ajouter(Client c) throws SQLException {
        String checkNumtel = "SELECT COUNT(*) FROM CLIENT WHERE numtel = ?";
        try (PreparedStatement ps = conn.prepareStatement(checkNumtel)) {
            ps.setString(1, c.getNumtel());
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                throw new SQLException(
                        "Le numéro de téléphone « " + c.getNumtel() + " » est déjà utilisé par un autre client.");
            }
        }

        String checkEmail = "SELECT COUNT(*) FROM CLIENT WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(checkEmail)) {
            ps.setString(1, c.getEmail());
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                throw new SQLException("L'email « " + c.getEmail() + " » est déjà utilisé par un autre client.");
            }
        }

        String sql = "INSERT INTO CLIENT (numtel, nom, sexe, pays, solde, email) VALUES (?,?,?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getNumtel());
            ps.setString(2, c.getNom());
            ps.setString(3, c.getSexe());
            ps.setString(4, c.getPays());
            ps.setInt(5, c.getSolde());
            ps.setString(6, c.getEmail());
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("L'ajout du client « " + c.getNom() + " » a échoué, aucune ligne insérée.");
            }
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de l'ajout du client « " + c.getNom() + " » : " + e.getMessage(), e);
        }
    }

    public List<Client> lister() throws SQLException {
        List<Client> liste = new ArrayList<>();
        String sql = "SELECT * FROM CLIENT ORDER BY numtel ASC";
        try (Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                liste.add(mapRow(rs));
            }
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de la récupération de la liste des clients : " + e.getMessage(), e);
        }
        return liste;
    }

    public Client findByNumtel(String numtel) throws SQLException {
        String sql = "SELECT * FROM CLIENT WHERE numtel = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, numtel);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return mapRow(rs);
            }
        } catch (SQLException e) {
            throw new SQLException(
                    "Erreur lors de la recherche du client avec le numéro « " + numtel + " » : " + e.getMessage(), e);
        }
        return null;
    }

    public void modifier(Client c) throws SQLException {
        String checkEmail = "SELECT COUNT(*) FROM CLIENT WHERE email = ? AND numtel != ?";
        try (PreparedStatement ps = conn.prepareStatement(checkEmail)) {
            ps.setString(1, c.getEmail());
            ps.setString(2, c.getNumtel());
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                throw new SQLException("L'email « " + c.getEmail() + " » est déjà utilisé par un autre client.");
            }
        }

        String sql = "UPDATE CLIENT SET nom=?, sexe=?, pays=?, solde=?, email=? WHERE numtel=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getNom());
            ps.setString(2, c.getSexe());
            ps.setString(3, c.getPays());
            ps.setInt(4, c.getSolde());
            ps.setString(5, c.getEmail());
            ps.setString(6, c.getNumtel());
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException(
                        "Aucun client trouvé avec le numéro « " + c.getNumtel() + " », modification impossible.");
            }
        } catch (SQLException e) {
            throw new SQLException(
                    "Erreur lors de la modification du client « " + c.getNumtel() + " » : " + e.getMessage(), e);
        }
    }

    public void supprimer(String numtel) throws SQLException {
        String sql = "DELETE FROM CLIENT WHERE numtel = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, numtel);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException(
                        "Aucun client trouvé avec le numéro « " + numtel + " », suppression impossible.");
            }
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de la suppression du client « " + numtel + " » : " + e.getMessage(), e);
        }
    }

    public List<Client> rechercherParNom(String keyword) throws SQLException {
        List<Client> liste = new ArrayList<>();
        String sql = "SELECT * FROM CLIENT WHERE nom LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next())
                    liste.add(mapRow(rs));
            }
        } catch (SQLException e) {
            throw new SQLException(
                    "Erreur lors de la recherche de clients par nom « " + keyword + " » : " + e.getMessage(), e);
        }
        return liste;
    }

    public List<Client> rechercherGlobal(String keyword) throws SQLException {
        List<Client> liste = new ArrayList<>();
        String sql = "SELECT * FROM CLIENT WHERE " +
                "numtel LIKE ? OR " +
                "nom LIKE ? OR " +
                "sexe LIKE ? OR " +
                "pays LIKE ? OR " +
                "email LIKE ? OR " +
                "CAST(solde AS TEXT) LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String pattern = "%" + keyword + "%";
            for (int i = 1; i <= 6; i++)
                ps.setString(i, pattern);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next())
                    liste.add(mapRow(rs));
            }
        } catch (SQLException e) {
            throw new SQLException(
                    "Erreur lors de la recherche globale avec le mot-clé « " + keyword + " » : " + e.getMessage(), e);
        }
        return liste;
    }

    private Client mapRow(ResultSet rs) throws SQLException {
        return new Client(
                rs.getString("numtel"),
                rs.getString("nom"),
                rs.getString("sexe"),
                rs.getString("pays"),
                rs.getInt("solde"),
                rs.getString("email"));
    }
}