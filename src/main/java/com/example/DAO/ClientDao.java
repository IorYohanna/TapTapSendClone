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
        } catch (Exception e) {
            throw new RuntimeException("Erreur de connexion : " + e.getMessage(), e);
        }
    }

    public void ajouter(Client c) throws SQLException {
        String check = "SELECT COUNT(*) FROM CLIENT WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(check)) {
            ps.setString(1, c.getEmail());
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                throw new SQLException("Cet email est déjà utilisé par un autre client.");
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
            ps.executeUpdate();
        }
    }

    public List<Client> lister() throws SQLException {
        List<Client> liste = new ArrayList<>();
        String sql = "SELECT * FROM CLIENT";
        try (Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                liste.add(mapRow(rs));
            }
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
        }
        return null;
    }

    public void modifier(Client c) throws SQLException {
        String check = "SELECT COUNT(*) FROM CLIENT WHERE email = ? AND numtel != ?";
        try (PreparedStatement ps = conn.prepareStatement(check)) {
            ps.setString(1, c.getEmail());
            ps.setString(2, c.getNumtel());
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                throw new SQLException("Cet email est déjà utilisé par un autre client.");
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
            ps.executeUpdate();
        }
    }

    public void supprimer(String numtel) throws SQLException {
        String sql = "DELETE FROM CLIENT WHERE numtel = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, numtel);
            ps.executeUpdate();
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
            String searchPattern = "%" + keyword + "%";

            for (int i = 1; i <= 6; i++) {
                ps.setString(i, searchPattern);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    liste.add(mapRow(rs));
                }
            }
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