package com.example.config;

import java.sql.Connection;

public class TestConnexion {
    public static void main(String[] args) {
        System.out.println("Tentative de connexion...");
        
        try (Connection conn = db.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("La connexion au db est reussie !");
            } else {
                System.out.println("La connexion n\'a pas abouti'.");
            }
        } catch (Exception e) {
            System.err.println("ERREUR : " + e.getMessage());
            e.printStackTrace();
        }
    }
}