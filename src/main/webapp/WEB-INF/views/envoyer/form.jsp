<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <title>MoneyFlow - ${not empty envoi ? 'Modifier' : 'Nouvel'} Envoi</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body style="background: #F4F2EC; padding: 2rem;">

            <div class="max-w-2xl mx-auto">
                <section class="card">
                    <div class="mb-8">
                        <div class="label">Transaction</div>
                        <h1 style="font-size: 2rem; font-weight: 800; color: #0B0B0B;">
                            <c:choose>
                                <c:when test="${not empty envoi}">Modifier l'envoi</c:when>
                                <c:otherwise>Effectuer un envoi</c:otherwise>
                            </c:choose>
                        </h1>
                        <p class="text-sm text-ink/60">Veuillez remplir les informations de transfert.</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="toast error" style="margin-bottom: 1.5rem; position: static; max-width: 100%;">
                            ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/envois/save" method="post">
                        <input type="hidden" name="action" value="${not empty envoi ? 'modifier' : 'ajouter'}">

                        <div style="margin-bottom: 1.5rem;">
                            <label class="label">ID de la transaction</label>
                            <input type="text" name="idEnv" value="${envoi.idEnv}" required class="input"
                                placeholder="Ex: ENV-2024-001" <c:if test="${not empty envoi}">readonly
                            style="background: rgba(0,0,0,0.03); color: rgba(0,0,0,0.4);"</c:if>>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6" style="margin-bottom: 1.5rem;">
                            <c:if test="${c.numtel != envoyer.numEnvoyeur}"></c:if>
                            <div>
                                <label class="label">Numéro Envoyeur</label>
                                <select name="numEnvoyeur" class="input" required>
                                    <option value="">-- Choisir envoyeur --</option>
                                    <c:forEach var="c" items="${clients}">
                                        <option value="${c.numtel}" <c:if test="${envoyer.numEnvoyeur == c.numtel}">
                                            selected</c:if>>
                                            ${c.nom} (${c.numtel}) - ${c.pays}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="label">Numéro Récepteur</label>
                                <select name="numRecepteur" class="input" required>
                                    <option value="">-- Choisir recepteur --</option>
                                    <c:forEach var="c" items="${clients}">
                                        <option value="${c.numtel}" <c:if test="${envoyer.numRecepteur == c.numtel}">
                                            selected</c:if>>
                                            ${c.nom} (${c.numtel}) - ${c.pays}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div style="margin-bottom: 1.5rem;">
                            <label class="label">Montant à envoyer (€)</label>
                            <input type="number" name="montant" value="${envoi.montant}" required class="input"
                                style="font-size: 1.25rem; font-weight: 700;">
                        </div>

                        <div style="margin-bottom: 2rem;">
                            <label class="label">Raison du transfert</label>
                            <textarea name="raison" rows="3" class="input"
                                placeholder="Ex: Cadeau familial, Factures...">${envoi.raison}</textarea>
                        </div>

                        <div style="display: flex; gap: 12px;">
                            <button type="submit" class="btn btn-primary"
                                style="flex: 2; justify-content: center; padding: 1rem;">
                                Confirmer l'opération
                            </button>
                            <a href="${pageContext.request.contextPath}/envois/list" class="btn btn-ghost"
                                style="flex: 1; justify-content: center;">
                                Annuler
                            </a>
                        </div>
                    </form>
                </section>

                <div style="margin-top: 1.5rem; text-align: center;">
                    <p style="font-size: 0.8rem; color: rgba(0,0,0,0.4);">
                        Note : Les frais de transfert seront calculés automatiquement lors de la validation.
                    </p>
                </div>
            </div>

        </body>

        </html>