package com.example.controller;

import com.example.DAO.FraisDao;
import com.example.model.FraisEnvoi;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet("/frais/*")
public class FraisController extends HttpServlet {

    private FraisDao fraisDao;

    @Override
    public void init() {
        fraisDao = new FraisDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();

        if (path == null || path.equals("/") || path.equals("/list")) {
            handleList(req, res);

        } else if (path.equals("/form")) {
            String idfrais = req.getParameter("idfrais");
            if (idfrais != null && !idfrais.isEmpty()) {
                try {
                    fraisDao.lister().stream()
                        .filter(f -> f.getIdfrais().equals(idfrais))
                        .findFirst()
                        .ifPresent(f -> req.setAttribute("frais", f));
                } catch (SQLException e) {
                    req.setAttribute("error", e.getMessage());
                }
            }
            req.getRequestDispatcher("/WEB-INF/views/frais/form.jsp").forward(req, res);

        } else if (path.equals("/delete")) {
            String idfrais = req.getParameter("idfrais");
            try {
                fraisDao.supprimer(idfrais);
                res.sendRedirect(req.getContextPath() + "/frais/list?success=supprime");
            } catch (SQLException e) {
                res.sendRedirect(req.getContextPath() + "/frais/list?error=" + e.getMessage());
            }

        } else {
            res.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();

        if (path.equals("/save")) {
            String idfrais  = req.getParameter("idfrais");
            int    montant1 = Integer.parseInt(req.getParameter("montant1"));
            int    montant2 = Integer.parseInt(req.getParameter("montant2"));
            int    frais    = Integer.parseInt(req.getParameter("frais"));
            String action   = req.getParameter("action");

            try {
                if ("modifier".equals(action)) {
                    FraisEnvoi f = new FraisEnvoi(idfrais, montant1, montant2, frais);
                    FraisDao.modifier(f, Map.of(
                        "montant1", montant1,
                        "montant2", montant2,
                        "frais",    frais
                    ));
                } else {
                    fraisDao.ajouter(idfrais, montant1, montant2, frais);
                }
                res.sendRedirect(req.getContextPath() + "/frais/list?success=" + action);
            } catch (Exception e) {
                req.setAttribute("error", e.getMessage());
                req.getRequestDispatcher("/WEB-INF/views/frais/form.jsp").forward(req, res);
            }
        }
    }

    private void handleList(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            List<FraisEnvoi> liste = fraisDao.lister();
            req.setAttribute("liste", liste);
        } catch (SQLException e) {
            req.setAttribute("error", e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/frais/list.jsp").forward(req, res);
    }
}