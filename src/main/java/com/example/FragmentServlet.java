package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * Servlet pour charger des fragments JSP dynamiquement via HTMX.
 * Cette servlet est appelée par les requêtes hx-get depuis le client.
 * Elle peut retourner du HTML généré côté serveur pour des mises à jour
 * partielles de la page.
 */
@WebServlet("/fragment")
public class FragmentServlet extends HttpServlet {

    /**
     * Méthode appelée pour les requêtes GET sur /fragment.
     * Elle définit des attributs de requête et forward vers fragment.jsp.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Définir des attributs pour le fragment JSP
        // Par exemple : données de base de données, calculs, etc.
        request.setAttribute("now", new Date()); // Date actuelle pour l'exemple

        // Forward vers le fragment JSP
        request.getRequestDispatcher("/fragment.jsp").forward(request, response);
    }

    // Autres méthodes peuvent être ajoutées pour gérer POST, etc., si nécessaire
}