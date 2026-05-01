<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <title>MoneyFlow - ${not empty taux ? 'Modifier' : 'Nouveau'} Taux</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body style="background: #F4F2EC; padding: 2rem;">

            <div class="max-w-xl mx-auto">
                <section class="card">
                    <div class="mb-8">
                        <div class="label">Formulaire</div>
                        <h1 style="font-size: 2rem; font-weight: 800; color: #0B0B0B;">
                            <c:choose>
                                <c:when test="${not empty taux}">Modifier le taux</c:when>
                                <c:otherwise>Nouveau taux</c:otherwise>
                            </c:choose>
                        </h1>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="toast error" style="margin-bottom: 1.5rem; position: static; max-width: 100%;">
                            ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/taux/save" method="post">
                        <input type="hidden" name="action" value="${not empty taux ? 'modifier' : 'ajouter'}">

                        <div style="margin-bottom: 1.5rem;">
                            <label class="label">Identifiant du Taux (ID)</label>
                            <input type="text" name="idtaux" value="${taux.idtaux}" required class="input"
                                placeholder="Ex: EUR_MGA" <c:if test="${not empty taux}">readonly style="background:
                            rgba(0,0,0,0.03); color: rgba(0,0,0,0.5);"</c:if>>
                            <c:if test="${not empty taux}">
                                <p style="font-size: 0.75rem; color: rgba(0,0,0,0.4); margin-top: 4px;">L'identifiant ne
                                    peut pas être modifié.</p>
                            </c:if>
                        </div>

                        <div class="grid grid-cols-2 gap-4" style="margin-bottom: 2rem;">
                            <div>
                                <label class="label">Montant 1 (Unité)</label>
                                <input type="number" name="montant1"
                                    value="${taux.montant1 != null ? taux.montant1 : 1}" required class="input">
                            </div>
                            <div>
                                <label class="label">Montant 2 (Valeur)</label>
                                <input type="number" name="montant2" value="${taux.montant2}" required class="input">
                            </div>
                        </div>

                        <div style="display: flex; gap: 12px;">
                            <button type="submit" class="btn btn-primary" style="flex: 2; justify-content: center;">
                                Enregistrer les modifications
                            </button>
                            <a href="${pageContext.request.contextPath}/taux/list" class="btn btn-ghost"
                                style="flex: 1; justify-content: center;">
                                Annuler
                            </a>
                        </div>
                    </form>
                </section>
            </div>

        </body>

        </html>