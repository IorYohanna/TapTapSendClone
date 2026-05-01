<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <title>MoneyFlow - Taux de change</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body style="background: #F4F2EC; padding: 2rem;">

            <div class="max-w-5xl mx-auto">
                <section class="card">
                    <div class="flex flex-wrap items-end justify-between gap-4 mb-8">
                        <div>
                            <div class="label" style="margin-bottom: 0;">Configuration</div>
                            <h1 style="font-size: 2.5rem; font-weight: 800; color: #0B0B0B; line-height: 1;">Taux de
                                change</h1>
                            <p style="margin-top: 0.5rem; color: rgba(0,0,0,0.6); font-size: 0.9rem;">
                                Gestion des taux de conversion pour les transferts internationaux.
                            </p>
                        </div>
                        <a href="${pageContext.request.contextPath}/taux/form" class="btn btn-accent">
                            <span>+</span> Nouveau taux
                        </a>
                    </div>

                    <c:if test="${not empty param.success}">
                        <div class="toast success" style="margin-bottom: 1.5rem; position: static; max-width: 100%;">
                            Action réussie : L'opération a été effectuée avec succès.
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
                                    <th>ID Taux</th>
                                    <th>Montant 1 (Réf)</th>
                                    <th>Montant 2 (Destination)</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="t" items="${liste}">
                                    <tr>
                                        <td><span class="badge badge-gray">${t.idtaux}</span></td>
                                        <td style="font-weight: 600;">${t.montant1}</td>
                                        <td style="font-weight: 600;">${t.montant2}</td>
                                        <td style="text-align: right;">
                                            <div style="display: flex; gap: 8px; justify-content: flex-end;">
                                                <a href="${pageContext.request.contextPath}/taux/form?idtaux=${t.idtaux}"
                                                    class="btn btn-ghost"
                                                    style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Modifier</a>
                                                <a href="${pageContext.request.contextPath}/taux/delete?idtaux=${t.idtaux}"
                                                    class="btn btn-danger"
                                                    style="padding: 0.4rem 0.8rem; font-size: 0.8rem;"
                                                    onclick="return confirm('Supprimer ce taux ?')">Supprimer</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty liste}">
                                    <tr>
                                        <td colspan="4"
                                            style="text-align: center; padding: 3rem; color: rgba(0,0,0,0.4);">
                                            Aucun taux de change configuré.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <div
                        style="margin-top: 1.5rem; padding: 1.25rem; border-radius: 18px; background: rgba(255,221,0,0.15); font-size: 0.85rem; color: #0B0B0B;">
                        <strong>Aide :</strong> Pour un taux EUR vers MGA, montant1 = 1 et montant2 = 4800 (1€ = 4800
                        Ar).
                    </div>
                </section>
            </div>

        </body>

        </html>