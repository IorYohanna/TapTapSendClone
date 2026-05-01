package com.example.controller;

import com.example.DAO.ClientDao;
import com.example.DAO.EnvoyerDao;
import com.example.model.Client;
import com.example.model.Envoyer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@WebServlet("/envois/*")
public class EnvoyerController extends HttpServlet {

    private EnvoyerDao envoyerDao;
    private ClientDao clientDao;
    public void init() {
        envoyerDao = new EnvoyerDao();
        clientDao = new ClientDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();

        if (path == null || path.equals("/") || path.equals("/list")) {
            handleList(req, res);

        } else if (path.equals("/form")) {

            try {
                List<Client> clients = clientDao.lister();
                req.setAttribute("clients", clients);
            } catch (SQLException e) {
                req.setAttribute("error", e.getMessage());
            }

            String idEnv = req.getParameter("idEnv");

            if (idEnv != null) {
                try {
                    Envoyer env = envoyerDao.findById(idEnv);
                    req.setAttribute("envoyer", env);
                } catch (SQLException e) {
                    req.setAttribute("error", e.getMessage());
                }
            }

            req.getRequestDispatcher("/WEB-INF/views/envoyer/form.jsp").forward(req, res);
        } else if (path.equals("/delete")) {

            try {
                envoyerDao.supprimer(req.getParameter("idEnv"));
                res.sendRedirect(req.getContextPath() + "/envois/list?success=delete");
            } catch (SQLException e) {
                res.sendRedirect(req.getContextPath() + "/envois/list?error=" + e.getMessage());
            }

        } else if (path.equals("/search")) {

            try {
                List<Envoyer> list = envoyerDao.rechercherParDate(req.getParameter("date"));
                req.setAttribute("envoyers", list);
            } catch (SQLException e) {
                req.setAttribute("error", e.getMessage());
            }

            req.getRequestDispatcher("/WEB-INF/views/envoyer/list.jsp").forward(req, res);

        } else {
            res.sendError(404);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        String path = req.getPathInfo();

        if (path.equals("/save")) {

            String idEnv = req.getParameter("idEnv");
            if (idEnv == null || idEnv.isEmpty()) {
                idEnv = UUID.randomUUID().toString();
            }
            Envoyer env = new Envoyer(
                    idEnv,
                    req.getParameter("numEnvoyeur"),
                    req.getParameter("numRecepteur"),
                    Integer.parseInt(req.getParameter("montant")),
                    Timestamp.valueOf(LocalDateTime.now()),
                    req.getParameter("raison"));

            try {
                envoyerDao.envoyerArgent(env);
                res.sendRedirect(req.getContextPath() + "/envois/list?success=add");

            } catch (Exception e) {
                req.setAttribute("error", e.getMessage());
                req.setAttribute("envoyer", env);
                req.getRequestDispatcher("/WEB-INF/views/envoyer/form.jsp").forward(req, res);
            }
        }
    }

    private void handleList(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            req.setAttribute("envoyers", envoyerDao.lister());
        } catch (SQLException e) {
            req.setAttribute("error", e.getMessage());
        }

        req.getRequestDispatcher("/WEB-INF/views/envoyer/list.jsp").forward(req, res);
    }
}