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
        } catch (Exception e) {
            throw new RuntimeException("Erreur de connexion à la base de données", e);
        }
    }

    public void ajouter(String idTaux, int montant1, int montant2) throws SQLException {
        String sql = "INSERT INTO TAUX (idtaux, montant1, montant2) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, idTaux);
            ps.setInt(2, montant1);
            ps.setInt(3, montant2);
            ps.executeUpdate();
            System.out.println("Taux ajouté avec succès.");
        }
    }

    public List<Taux> lister() throws SQLException {
        List<Taux> liste = new ArrayList<>();
        String sql = "SELECT * FROM TAUX";
        try (Statement st = conn.createStatement(); 
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                String idtaux = rs.getString("idtaux");
                int montant1 = rs.getInt("montant1");
                int montant2 = rs.getInt("montant2");

                Taux taux = new Taux(idtaux, montant1, montant2);
                liste.add(taux);
            }
        }
        return liste;
    }

    public void modifier(String idTaux, int nouveauMontant1, int nouveauMontant2) throws SQLException {
        String sql = "UPDATE TAUX SET montant1 = ?, montant2 = ? WHERE idtaux = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, nouveauMontant1);
            ps.setInt(2, nouveauMontant2);
            ps.setString(3, idTaux);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Taux mis à jour avec succès.");
            } else {
                System.out.println("Aucun taux trouvé avec l'ID : " + idTaux);
            }
        }
    }

    public void supprimer(String idTaux) throws SQLException {
        String sql = "DELETE FROM TAUX WHERE idtaux = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, idTaux);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Taux supprimé avec succès.");
            } else {
                System.out.println("Aucun taux trouvé avec l'ID : " + idTaux);
            }
        }
    }


    public int getValeurConversion(String idTaux) throws SQLException {
        String sql = "SELECT montant2 FROM TAUX WHERE idtaux = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, idTaux);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("montant2");
                }
            }
        }
        return 1; 
    }
}