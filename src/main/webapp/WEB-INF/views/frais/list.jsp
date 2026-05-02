<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <title>MoneyFlow - Frais d'envoi</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body style="background: #F4F2EC; padding: 2rem;">
            <c:set var="ctx" value="${pageContext.request.contextPath}" />
            <div class="max-w-5xl mx-auto">
                <section class="card">
                    <div class="flex flex-wrap items-end justify-between gap-4 mb-8">
                        <div>
                            <div class="label" style="margin-bottom: 0;">Configuration</div>
                            <h1 style="font-size: 2.5rem; font-weight: 800; color: #0B0B0B; line-height: 1;">Frais
                                d'envoi</h1>
                            <p style="margin-top: 0.5rem; color: rgba(0,0,0,0.6); font-size: 0.9rem;">
                                Grille des tranches de frais appliquées aux transferts.
                            </p>
                        </div>
                        <a href="${pageContext.request.contextPath}/frais/form" class="btn btn-accent">
                            <span>+</span> Nouvelle tranche
                        </a>
                    </div>

                    <%-- Notification de succès ou d'erreur --%>
                        <c:if test="${not empty param.success}">
                            <div class="toast success"
                                style="margin-bottom: 1.5rem; position: static; max-width: 100%;">
                                Mise à jour réussie : La grille des frais a été modifiée.
                            </div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="toast error" style="margin-bottom: 1.5rem; position: static; max-width: 100%;">
                                Erreur : ${error}
                            </div>
                        </c:if>

                        <div class="table-wrap scroll-x">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Montant Min (€)</th>
                                        <th>Montant Max (€)</th>
                                        <th>Frais Fixe (€)</th>
                                        <th style="text-align: right;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="f" items="${liste}">
                                        <tr>
                                            <td><span class="badge badge-gray">${f.idfrais}</span></td>
                                            <td style="font-weight: 600;">${f.montant1} €</td>
                                            <td style="font-weight: 600;">${f.montant2} €</td>
                                            <td><span class="badge badge-yellow" style="font-size: 0.9rem;">${f.frais}
                                                    €</span></td>
                                            <td style="text-align: right;">
                                                <div style="display: flex; gap: 8px; justify-content: flex-end;">
                                                    <a href="${pageContext.request.contextPath}/frais/form?idfrais=${f.idfrais}"
                                                        class="btn btn-ghost"
                                                        style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Modifier</a>
                                                    <a href="${pageContext.request.contextPath}/frais/delete?idfrais=${f.idfrais}"
                                                        class="btn btn-danger"
                                                        style="padding: 0.4rem 0.8rem; font-size: 0.8rem;"
                                                        onclick="return confirm('Supprimer cette tranche de frais ?')">Supprimer</a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty liste}">
                                        <tr>
                                            <td colspan="5"
                                                style="text-align: center; padding: 3rem; color: rgba(0,0,0,0.4);">
                                                Aucune tranche de frais définie.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <div
                            style="margin-top: 1.5rem; padding: 1.25rem; border-radius: 18px; background: rgba(255,221,0,0.1); font-size: 0.85rem; color: #0B0B0B;">
                            <span class="font-bold">Exemple :</span> Entre 1 € et 100 € → frais = 5 € (L'utilisateur
                            paiera 105 € au total).
                        </div>

                        <a href="${ctx}/index.jsp"
                            style="font-size: 0.8rem; color: rgba(0,0,0,0.4); text-decoration: none;">←
                            Retour à l'accueil
                        </a>
                </section>
            </div>

        </body>

        </html>