package com.example.controller;

import com.example.DAO.EnvoyerDao;
import com.example.model.Envoyer;
import com.example.service.PdfReleveService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import java.util.List;
import java.util.Map;

@WebServlet("/releve-pdf")
public class ReleveController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String numtel = req.getParameter("numtel");
        String moisStr = req.getParameter("mois");

        if (numtel == null || moisStr == null) {
            resp.sendError(400, "Paramètres manquants");
            return;
        }

        try {
            String[] parts = moisStr.split("-");
            int annee = Integer.parseInt(parts[0]);
            int mois = Integer.parseInt(parts[1]);

            EnvoyerDao dao = new EnvoyerDao();
            List<Envoyer> envois = dao.getEnvoisParClientEtMois(numtel, mois, annee);
            Map<String, String> infosClient = dao.getInfosClient(numtel);

            if (infosClient.isEmpty()) {
                resp.sendError(404, "Client introuvable : " + numtel);
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