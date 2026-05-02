package com.example.controller;

import com.example.DAO.EnvoyerDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

@WebServlet("/recette")
public class RecetteController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            EnvoyerDao dao = new EnvoyerDao();

            Map<String, Integer> stats = dao.getStatsGlobales();
            req.setAttribute("totalFrais", stats.get("recette"));
            req.setAttribute("totalVolume", stats.get("volume"));
            req.setAttribute("totalTransactions", stats.get("count"));
            req.getRequestDispatcher("/WEB-INF/views/fragments/recette.jsp").forward(req, resp);

        } catch (SQLException e) {
            resp.sendError(500, "Erreur SQL : " + e.getMessage());
        }
    }
}