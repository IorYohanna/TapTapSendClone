<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <title>Clients - TapTapSend</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body style="background: #F4F2EC; padding: 2rem;">
            <c:set var="ctx" value="${pageContext.request.contextPath}" />

            <div class="max-w-6xl mx-auto">
                <section class="card">
                        <div class="flex flex-wrap items-end justify-between gap-4 mb-8">
                            <div>
                                <div class="label" style="margin-bottom: 0;">Administration</div>
                                <h1 style="font-size: 2.5rem; font-weight: 800; color: #0B0B0B; line-height: 1;">Clients
                                </h1>
                                <p style="margin-top: 0.5rem; color: rgba(0,0,0,0.6); font-size: 0.9rem;">
                                    Gestion des envoyeurs et récepteurs ·
                                    <span class="badge badge-yellow">${clients != null ? clients.size() : 0} au
                                        total</span>
                                </p>
                            </div>

                            <div class="flex gap-3 items-center">
                                    <form action="${ctx}/clients/search" method="get" class="flex gap-2">
                                        <input name="q" value="${keyword}" class="input"
                                            style="border-radius: 999px; min-width: 250px;"
                                            placeholder="Rechercher nom, pays…">
                                        <button type="submit" class="btn btn-ghost" style="padding: 0.7rem 1rem;">
                                            🔍
                                        </button>
                                    </form>
                                    <a href="${ctx}/clients/form" class="btn btn-accent">
                                        <span>+</span> Nouveau Client
                                    </a>
                            </div>
                        </div>

                            <c:if test="${not empty param.success}">
                                <div class="toast success"
                                    style="margin-bottom: 1.5rem; position: static; max-width: 100%;">
                                    Opération réussie.
                                </div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="toast error"
                                    style="margin-bottom: 1.5rem; position: static; max-width: 100%;">
                                    Erreur : ${error}
                                </div>
                            </c:if>

                                <div class="table-wrap scroll-x">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Téléphone</th>
                                                <th>Nom Complet</th>
                                                <th>Sexe</th>
                                                <th>Pays</th>
                                                <th>Email</th>
                                                <th style="text-align: right;">Solde</th>
                                                <th style="text-align: right;">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${empty clients}">
                                                    <tr>
                                                        <td colspan="7"
                                                            style="text-align: center; padding: 3rem; color: rgba(0,0,0,0.4);">
                                                            Aucun client trouvé.
                                                        </td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach var="c" items="${clients}">
                                                        <tr>
                                                            <td><span class="badge badge-gray"
                                                                    style="font-family: monospace;">${c.numtel}</span>
                                                            </td>
                                                            <td style="font-weight: 700; color: #0B0B0B;">${c.nom}</td>
                                                            <td><span class="badge badge-soft">${c.sexe}</span></td>
                                                            <td>${c.pays}</td>
                                                            <td style="color: rgba(0,0,0,0.5);">${c.email}</td>
                                                            <td style="text-align: right; font-weight: 800;">${c.solde} (devise étrangère)</td>
                                                            <td style="text-align: right;">
                                                                <div
                                                                    style="display: flex; gap: 8px; justify-content: flex-end;">
                                                                    <a href="${ctx}/clients/form?numtel=${c.numtel}"
                                                                        class="btn btn-ghost"
                                                                        style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Modifier</a>
                                                                    <a href="${ctx}/clients/delete?numtel=${c.numtel}"
                                                                        onclick="return confirm('Supprimer ce client ?')"
                                                                        class="btn btn-danger"
                                                                        style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Supprimer</a>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="mt-8 flex justify-between items-center border-t pt-6"
                                    style="border-color: rgba(0,0,0,0.05);">
                                    <a href="${ctx}/index.jsp"
                                        style="font-size: 0.8rem; color: rgba(0,0,0,0.4); text-decoration: none;">←
                                        Retour à l'accueil
                                    </a>
                                    <c:if test="${not empty keyword}">
                                        <a href="${ctx}/clients/list"
                                            style="font-size: 0.8rem; color: #3b82f6; font-weight: 600;">Réinitialiser
                                            la recherche</a>
                                    </c:if>
                                </div>
                </section>
            </div>
        </body>

        </html>