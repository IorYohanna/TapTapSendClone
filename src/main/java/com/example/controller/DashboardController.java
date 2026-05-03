package com.example.controller;

import com.example.DAO.ClientDao;
import com.example.DAO.EnvoyerDao;
import com.example.model.Envoyer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
    private ClientDao clientDao = new ClientDao();
    private EnvoyerDao envoyerDao = new EnvoyerDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            int totalClients = clientDao.lister().size();
            List<Envoyer> tousLesEnvois = envoyerDao.lister();
            int countEnvois = tousLesEnvois.size();

            int totalVolume = envoyerDao.getTotalVolume();
            int totalRecette = envoyerDao.getTotalFrais();

            String today = LocalDate.now().toString();
            List<Envoyer> envoisAujourdhui = envoyerDao.rechercherParDate(today);
            int countAujourdhui = envoisAujourdhui.size();

            int volAujourdhui = envoisAujourdhui.stream().mapToInt(Envoyer::getMontant).sum();

            List<Envoyer> recentOps = tousLesEnvois.size() > 5
                    ? tousLesEnvois.subList(tousLesEnvois.size() - 5, tousLesEnvois.size())
                    : tousLesEnvois;

            req.setAttribute("stats_total_clients", totalClients);
            req.setAttribute("stats_total_envois", countEnvois);
            req.setAttribute("stats_total_recette", totalRecette);
            req.setAttribute("stats_total_vol", totalVolume);
            req.setAttribute("stats_aujourdhui_vol", volAujourdhui);
            req.setAttribute("stats_aujourdhui_count", countAujourdhui);
            req.setAttribute("recentEnvois", recentOps);

            req.getRequestDispatcher("/index.jsp").forward(req, res);

        } catch (SQLException e) {
            res.sendError(500, "Erreur Dashboard : " + e.getMessage());
        }
    }
}