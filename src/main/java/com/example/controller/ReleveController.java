package com.example.controller;

import com.example.DAO.EnvoyerDao;
import com.example.DAO.ClientDao; 
import com.example.model.Envoyer;
import com.example.model.Client;
import com.example.service.PdfReleveService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet("/releve/*")
public class ReleveController extends HttpServlet {

    private ClientDao clientDao = new ClientDao();
    private EnvoyerDao envoyerDao = new EnvoyerDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();

        if (path == null || path.equals("/form")) {
            try {
                List<Client> clients = clientDao.lister();
                req.setAttribute("clients", clients);

                req.getRequestDispatcher("/WEB-INF/views/fragments/releve.jsp").forward(req, resp);
            } catch (SQLException e) {
                resp.sendError(500, "Erreur lors de la récupération des clients");
            }
        }


        else if (path.equals("/generate")) {
            String numtel = req.getParameter("numtel");
            String moisStr = req.getParameter("mois");

            if (numtel == null || moisStr == null || moisStr.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/releve/form?error=Parametres_manquants");
                return;
            }

            try {
                String[] parts = moisStr.split("-");
                int annee = Integer.parseInt(parts[0]);
                int mois = Integer.parseInt(parts[1]);

                List<Envoyer> envois = envoyerDao.getEnvoisParClientEtMois(numtel, mois, annee);
                Map<String, String> infosClient = envoyerDao.getInfosClient(numtel);

                if (infosClient == null || infosClient.isEmpty()) {
                    resp.sendError(404, "Client introuvable");
                    return;
                }

                String filename = "releve_" + numtel + "_" + moisStr + ".pdf";
                resp.setContentType("application/pdf");
                resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

                new PdfReleveService().genererReleve(
                        resp.getOutputStream(), numtel, infosClient, mois, annee, envois);

            } catch (Exception e) {
                resp.sendError(500, "Erreur génération PDF : " + e.getMessage());
            }
        }
    }
}