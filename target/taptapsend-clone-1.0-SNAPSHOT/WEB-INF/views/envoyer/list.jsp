<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <title>MoneyFlow - Historique des envois</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body style="background: #F4F2EC; padding: 2rem;">
                 <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <div class="max-w-6xl mx-auto">
                    <section class="card">
                        <%-- Header avec Statistiques et Filtre --%>
                            <div class="flex flex-wrap items-end justify-between gap-4 mb-8">
                                <div>
                                    <div class="label" style="margin-bottom: 0;">Opérations</div>
                                    <h1 style="font-size: 2.5rem; font-weight: 800; color: #0B0B0B; line-height: 1;">
                                        Envois d'argent</h1>
                                    <p style="margin-top: 0.5rem; color: rgba(0,0,0,0.6); font-size: 0.9rem;">
                                        <span class="font-semibold text-ink">${liste != null ? liste.size() : 0}</span>
                                        opérations enregistrées
                                    </p>
                                </div>

                                <div class="flex gap-3 items-center flex-wrap">
                                    <%-- Filtre par date --%>
                                        <form action="${pageContext.request.contextPath}/envois/search" method="get"
                                            class="flex gap-2">
                                            <input type="date" name="date" value="${dateRecherche}" class="input"
                                                style="border-radius: 999px; padding: 0.5rem 1rem;">
                                            <button type="submit" class="btn btn-ghost">Filtrer</button>
                                            <c:if test="${not empty dateRecherche}">
                                                <a href="${pageContext.request.contextPath}/envois/list"
                                                    class="btn btn-danger" style="padding: 0.7rem;">✕</a>
                                            </c:if>
                                        </form>
                                        <a href="${pageContext.request.contextPath}/envois/form" class="btn btn-accent">
                                            <span>+</span> Nouvel envoi
                                        </a>
                                </div>
                            </div>

                            <%-- Notifications --%>
                                <c:if test="${not empty param.success}">
                                    <div class="toast success"
                                        style="margin-bottom: 1.5rem; position: static; max-width: 100%;">
                                        Transaction traitée avec succès.
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
                                                <th>ID</th>
                                                <th>Envoyeur</th>
                                                <th>Récepteur</th>
                                                <th>Montant</th>
                                                <th>Date & Raison</th>
                                                <th style="text-align: right;">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="e" items="${envoyers}">
                                                <tr>
                                                    <td><span class="badge badge-gray">${e.idEnv}</span></td>
                                                    <td>
                                                        <div class="font-bold text-ink">${e.numEnvoyeur}</div>
                                                    </td>
                                                    <td>
                                                        <div class="font-bold text-ink">${e.numRecepteur}</div>
                                                    </td>
                                                    <td>
                                                        <div
                                                            style="font-size: 1.1rem; font-weight: 800; color: #0B0B0B;">
                                                            ${e.montant} €</div>
                                                    </td>
                                                    <td>
                                                        <div style="font-size: 0.8rem; font-weight: 600;">
                                                            <fmt:formatDate value="${e.date}"
                                                                pattern="dd/MM/yyyy HH:mm" />
                                                        </div>
                                                        <div
                                                            style="font-size: 0.75rem; color: rgba(0,0,0,0.5); font-style: italic;">
                                                            ${e.raison}
                                                        </div>
                                                    </td>
                                                    <td style="text-align: right;">
                                                        <div
                                                            style="display: flex; gap: 8px; justify-content: flex-end;">
                                                            <a href="${pageContext.request.contextPath}/envois/form?idEnv=${e.idEnv}"
                                                                class="btn btn-ghost"
                                                                style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Détails</a>
                                                            <a href="${pageContext.request.contextPath}/envois/delete?idEnv=${e.idEnv}"
                                                                onclick="return confirm('Annuler cet envoi ?')"
                                                                class="btn btn-danger"
                                                                style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Supprimer</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty liste}">
                                                <tr>
                                                    <td colspan="6"
                                                        style="text-align: center; padding: 4rem; color: rgba(0,0,0,0.4);">
                                                        <div class="text-3xl mb-2">💸</div>
                                                        Aucun envoi trouvé pour cette sélection.
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>

                                    <a href="${ctx}/index.jsp"
                                        style="font-size: 0.8rem; color: rgba(0,0,0,0.4); text-decoration: none;">←
                                        Retour à l'accueil
                                    </a>
                                </div>
                    </section>
                </div>

            </body>

            </html>