<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <title>MoneyFlow - ${not empty frais ? 'Modifier' : 'Nouvelle'} Tranche</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body style="background: #F4F2EC; padding: 2rem;">

            <div class="max-w-xl mx-auto">
                <section class="card">
                    <div class="mb-8">
                        <div class="label">Paramétrage</div>
                        <h1 style="font-size: 2rem; font-weight: 800; color: #0B0B0B;">
                            <c:choose>
                                <c:when test="${not empty frais}">Modifier la tranche</c:when>
                                <c:otherwise>Nouvelle tranche</c:otherwise>
                            </c:choose>
                        </h1>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="toast error" style="margin-bottom: 1.5rem; position: static; max-width: 100%;">
                            ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/frais/save" method="post">
                        <input type="hidden" name="action" value="${not empty frais ? 'modifier' : 'ajouter'}">

                        <div style="margin-bottom: 1.5rem;">
                            <label class="label">Identifiant de la Tranche (ID)</label>
                            <input type="text" name="idfrais" value="${frais.idfrais}" required class="input"
                                placeholder="Ex: T1, TRANCHE_BASSE..." <c:if test="${not empty frais}">readonly
                            style="background: rgba(0,0,0,0.03); color: rgba(0,0,0,0.4);"</c:if>>
                        </div>

                        <div class="grid grid-cols-2 gap-4" style="margin-bottom: 1.5rem;">
                            <div>
                                <label class="label">Montant Minimum (€)</label>
                                <input type="number" name="montant1" value="${frais.montant1}" required class="input"
                                    placeholder="0">
                            </div>
                            <div>
                                <label class="label">Montant Maximum (€)</label>
                                <input type="number" name="montant2" value="${frais.montant2}" required class="input"
                                    placeholder="100">
                            </div>
                        </div>

                        <div style="margin-bottom: 2rem;">
                            <label class="label">Frais à appliquer (€)</label>
                            <input type="number" step="0.01" name="frais" value="${frais.frais}" required class="input"
                                placeholder="5.00">
                            <p style="font-size: 0.75rem; color: rgba(0,0,0,0.4); margin-top: 6px;">Ce montant sera
                                ajouté au transfert de l'utilisateur.</p>
                        </div>

                        <div style="display: flex; gap: 12px;">
                            <button type="submit" class="btn btn-primary" style="flex: 2; justify-content: center;">
                                Enregistrer la tranche
                            </button>
                            <a href="${pageContext.request.contextPath}/frais/list" class="btn btn-ghost"
                                style="flex: 1; justify-content: center;">
                                Annuler
                            </a>
                        </div>
                    </form>
                </section>
            </div>

        </body>

        </html>