package com.example.DAO;

import com.example.config.Db;
import com.example.model.FraisEnvoi;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class FraisDao {
    private static Connection conn;

    public FraisDao() {
        try {
            conn = Db.getConnection();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void ajouter(String id, int m1, int m2, int frais) throws SQLException {
        String sql = "INSERT INTO FRAIS_ENVOI (idfrais, montant1, montant2, frais) VALUES (?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.setInt(2, m1);
            ps.setInt(3, m2);
            ps.setInt(4, frais);
            ps.executeUpdate();
        }
    }

    public List<FraisEnvoi> lister() throws SQLException {
        List<FraisEnvoi> liste = new ArrayList<>();
        String sql = "SELECT * FROM FRAIS_ENVOI";
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                String idfrais = rs.getString("idfrais");
                int montant1 = rs.getInt("montant1");
                int montant2 = rs.getInt("montant2");
                int frais = rs.getInt("frais");
                FraisEnvoi fraisEnvoie = new FraisEnvoi(idfrais, montant1, montant2, frais);
                liste.add(fraisEnvoie);
            }
        }
        return liste;
    }

    public static void modifier(FraisEnvoi frais, Map<String, Object> data) {
        if (data == null || data.isEmpty()) {
            return;
        }

        StringBuilder sql = new StringBuilder("UPDATE \"FRAIS_ENVOI\" SET ");
        List<Object> values = new ArrayList<>();

        data.forEach((column, value) -> {
            sql.append(column).append(" = ? ,");
            values.add(value);
        });

        sql.setLength(sql.length() - 2);
        sql.append(" WHERE idfrais = ?");
        values.add(frais.getFrais());

        try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < values.size(); i++) {
                stmt.setObject(i + 1, values.get(i));
            }

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                System.out.println("Mise a jour reussi de frais !");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void supprimer(String idfrais) throws SQLException {
        String sql = "DELETE FROM frais_envoi WHERE idfrais=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, idfrais);
            ps.executeUpdate();
        }
    }
}