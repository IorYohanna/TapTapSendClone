<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <c:set var="ctx" value="${pageContext.request.contextPath}" />
        <div class="modal-backdrop">
            <div class="modal-panel">
                <section class="card relative">

                    <a href="${ctx}/envois/list"
                        class="absolute top-6 right-6 text-gray-400 hover:text-black text-2xl no-underline">&times;</a>

                    <div class="mb-8">
                        <div class="text-[10px] uppercase tracking-[0.2em] text-gray-400 font-bold">Transaction</div>
                        <h1 class="font-display text-3xl text-ink font-black">
                            ${empty envoi ? 'Effectuer un envoi' : 'Modifier l\'envoi'}
                        </h1>
                        <p class="text-sm text-gray-500">Veuillez remplir les informations de transfert.</p>
                    </div>

                    <form action="${ctx}/envois/save" method="post" class="space-y-5">
                        <input type="hidden" name="action" value="${not empty envoyer ? 'modifier' : 'ajouter'}">

                        <div>
                            <label class="label">ID de la transaction</label>
                            <input type="text" name="idEnv" value="${envoyer.idEnv}" required
                                class="input ${not empty envoyer ? 'bg-gray-100 text-gray-400' : ''}"
                                placeholder="Ex: ENV-2024-001" ${not empty envoyer ? 'readonly' : '' }>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="label">Numéro Envoyeur</label>
                                <select name="numEnvoyeur" class="select" required>
                                    <option value="">-- Choisir envoyeur --</option>
                                    <c:forEach var="c" items="${clients}">
                                        <option value="${c.numtel}" ${envoyer.numEnvoyeur == c.numtel ? 'selected' : '' }>
                                            ${c.nom} (${c.numtel}) - ${c.pays}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="label">Numéro Récepteur</label>
                                <select name="numRecepteur" class="select" required>
                                    <option value="">-- Choisir récepteur --</option>
                                    <c:forEach var="c" items="${clients}">
                                        <option value="${c.numtel}" ${envoyer.numRecepteur==c.numtel ? 'selected' : '' }>
                                            ${c.nom} (${c.numtel}) - ${c.pays}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div>
                            <label class="label">Montant à envoyer (€)</label>
                            <input type="number" name="montant" value="${envoyer.montant}" required
                                class="input text-xl font-bold" placeholder="0.00">
                        </div>

                        <div>
                            <label class="label">Raison du transfert</label>
                            <textarea name="raison" rows="2" class="textarea"
                                placeholder="Ex: Cadeau, Factures...">${envoyer.raison}</textarea>
                        </div>

                        <div class="flex items-center justify-between pt-6">
                            <a href="${ctx}/envois/list"
                                class="text-gray-400 font-bold text-sm no-underline">Annuler</a>
                            <button type="submit" class="btn btn-accent shadow-lg shadow-yellow-200">
                                ${empty envoyer ? 'Confirmer l\'envoi' : 'Enregistrer'}
                            </button>
                        </div>
                    </form>
                </section>
            </div>
        </div>