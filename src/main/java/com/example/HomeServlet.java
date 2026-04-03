package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet principale de l'application, mappée sur la racine "/".
 * Cette servlet gère les requêtes GET et POST pour la page d'accueil.
 * Elle peut être étendue pour gérer d'autres fonctionnalités comme
 * l'authentification,
 * la gestion des sessions, ou le routage vers d'autres pages.
 */
@WebServlet("/") // Annotation alternative au web.xml pour Jakarta EE
public class HomeServlet extends HttpServlet {

    /**
     * Méthode appelée pour les requêtes GET.
     * Actuellement, elle redirige vers la page index.jsp.
     * À développer : logique métier, récupération de données, etc.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Logique pour traiter la requête GET
        // Par exemple : vérifier l'authentification, récupérer des données de la base,
        // etc.

        // Redirection vers la page JSP
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    /**
     * Méthode appelée pour les requêtes POST.
     * À implémenter selon les besoins (formulaires, AJAX, etc.).
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Logique pour traiter la requête POST
        // Par exemple : traitement de formulaires, mise à jour de données, etc.

        // Réponse par défaut
        response.getWriter().write("POST request handled");
    }

    // Autres méthodes HTTP peuvent être ajoutées ici (PUT, DELETE, etc.) si
    // nécessaire
}