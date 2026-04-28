package com.example.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import io.github.cdimascio.dotenv.Dotenv;

public class db {
    static final Dotenv dotenv = Dotenv.load();

    static final String DB_URL = dotenv.get("DB_URL");
    static final String DB_USER = dotenv.get("DB_USER");
    static final String DB_PASSWORD = dotenv.get("DB_PASSWORD");

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("connexion reussi");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return conn;
    }

}
