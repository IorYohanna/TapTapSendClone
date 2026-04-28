package com.example.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.example.DAO.ClientDao;
import com.example.model.Client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/clients/*")
public class ClientController extends HttpServlet {

    private ClientDao clientDao;

    public void init() {
        clientDao = new ClientDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        String path = req.getPathInfo();

        if (path == null || path.equals("/") || path.equals("/list")) {
            handleList(req, res);

        } else if (path.equals("/form")) {
            String numtel = req.getParameter("numtel");
            if (numtel != null && !numtel.isEmpty()) {
                try {
                    Client client = clientDao.findByNumtel(numtel);
                    req.setAttribute("client", client);

                } catch (SQLException e) {
                    req.setAttribute("error", "Client Introuvable" + e.getMessage());
                }
            }

            req.getRequestDispatcher("/WEB-INF/views/client/form.jsp").forward(req, res);

        } else if (path.equals("/delete")) {
            String numtel = req.getParameter("numtel");

            try {
                clientDao.supprimer(numtel);
                res.sendRedirect(req.getContextPath() + "/clients/list?success=supprime");

            } catch (SQLException e) {
                res.sendRedirect(req.getContextPath() + "/clients/list?error=" + e.getMessage());
            }

        } else if (path.equals("/search")) {
            String keyword = req.getParameter("q");
            try {
                List<Client> results = clientDao.rechercherGlobal(keyword);
                req.setAttribute("clients", results);
                req.setAttribute("keyword", keyword);

            } catch (SQLException e) {
                req.setAttribute("error", e.getMessage());
            }

            req.getRequestDispatcher("/WEB-INF/views/client/list.jsp").forward(req, res);
        } else {
            res.sendError(HttpServletResponse.SC_NOT_FOUND);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String path = req.getPathInfo();

        if (path.equals("/save")) {
            String numtel = req.getParameter("numtel");
            String nom = req.getParameter("nom");
            String sexe = req.getParameter("sexe");
            String pays = req.getParameter("pays");
            int solde = Integer.parseInt(req.getParameter("solde"));
            String email = req.getParameter("email");
            String action = req.getParameter("action");

            Client client = new Client(numtel, nom, sexe, pays, solde, email);

            try {
                if ("modifier".equals(action)) {
                    clientDao.modifier(client);
                } else {
                    clientDao.ajouter(client);
                }
                res.sendRedirect(req.getContextPath() + "/clients/list?success=" + action);
            } catch (SQLException e) {
                req.setAttribute("error", e.getMessage());
                req.setAttribute("client", client);
                req.getRequestDispatcher("/WEB-INF/views/client/form.jsp").forward(req, res);
            }

        }

    }

    private void handleList (HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            List<Client> clients = clientDao.lister();
            req.setAttribute("clients", clients);
        } catch (SQLException e) {
            req.setAttribute("error", e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/client/list.jsp").forward(req, res);
     }

}
