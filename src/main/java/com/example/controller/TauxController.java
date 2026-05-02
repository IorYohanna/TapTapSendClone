package com.example.controller;

import com.example.DAO.TauxDao;
import com.example.model.Taux;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/taux/*")
public class TauxController extends HttpServlet {

    private TauxDao tauxDao;

    @Override
    public void init() {
        tauxDao = new TauxDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();

        if (path == null || path.equals("/") || path.equals("/list")) {
            handleList(req, res);

        } else if (path.equals("/form")) {
            String idtaux = req.getParameter("idtaux");
            if (idtaux != null && !idtaux.isEmpty()) {
                try {
                    List<Taux> tous = tauxDao.lister();
                    tous.stream()
                        .filter(t -> t.getIdtaux().equals(idtaux))
                        .findFirst()
                        .ifPresent(t -> req.setAttribute("taux", t));
                } catch (SQLException e) {
                    req.setAttribute("error", e.getMessage());
                }
            }
            req.getRequestDispatcher("/WEB-INF/views/taux/form.jsp").forward(req, res);

        } else if (path.equals("/delete")) {
            String idtaux = req.getParameter("idtaux");
            try {
                tauxDao.supprimer(idtaux);
                res.sendRedirect(req.getContextPath() + "/taux/list?success=supprime");
            } catch (SQLException e) {
                res.sendRedirect(req.getContextPath() + "/taux/list?error=" + e.getMessage());
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
            String idtaux   = req.getParameter("idtaux");
            int    montant1 = Integer.parseInt(req.getParameter("montant1"));
            int    montant2 = Integer.parseInt(req.getParameter("montant2"));
            String pays1 = req.getParameter("pays1");
            String pays2 = req.getParameter("pays2");
            String action   = req.getParameter("action");

            try {
                if ("modifier".equals(action)) {
                    tauxDao.modifier(idtaux, montant1, montant2, pays1, pays2);
                } else {
                    tauxDao.ajouter(idtaux, montant1, montant2, pays1, pays2);
                }
                res.sendRedirect(req.getContextPath() + "/taux/list?success=" + action);
            } catch (SQLException e) {
                req.setAttribute("error", e.getMessage());
                req.getRequestDispatcher("/WEB-INF/views/taux/form.jsp").forward(req, res);
            }
        }
    }

    private void handleList(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            List<Taux> liste = tauxDao.lister();
            req.setAttribute("liste", liste);
        } catch (SQLException e) {
            req.setAttribute("error", e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/taux/list.jsp").forward(req, res);
    }
}