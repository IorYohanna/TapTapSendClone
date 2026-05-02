package com.example.controller;

import com.example.DAO.EnvoyerDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/recette")
public class RecetteController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.setContentType("text/html;charset=UTF-8");

        try {
            EnvoyerDao dao = new EnvoyerDao();
            int totalFrais = dao.getTotalFrais();

            resp.getWriter().write(
                    "<span class='recette-montant'>" + totalFrais + " EUR</span>");

        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("<span class='error'>Erreur : " + e.getMessage() + "</span>");
        }
    }
}