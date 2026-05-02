<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <c:set var="ctx" value="${pageContext.request.contextPath}" />
        <div class="modal-backdrop">
            <div class="modal-panel">
                <section class="card relative">

                    <a href="${ctx}/frais/list"
                        class="absolute top-6 right-6 text-gray-400 hover:text-black text-2xl no-underline">&times;</a>

                    <div class="mb-8">
                        <div class="text-[10px] uppercase tracking-[0.2em] text-gray-400 font-bold">Paramétrage</div>
                        <h1 class="font-display text-3xl text-ink font-black">
                            ${empty frais ? 'Nouvelle tranche' : 'Modifier la tranche'}
                        </h1>
                        <p class="text-sm text-gray-500">Définissez les paliers de taxation pour les transferts.</p>
                    </div>

                    <form action="${ctx}/frais/save" method="post" class="space-y-5">
                        <input type="hidden" name="action" value="${not empty frais ? 'modifier' : 'ajouter'}">

                        <div>
                            <label class="label">Identifiant de la Tranche (ID)</label>
                            <input type="text" name="idfrais" value="${frais.idfrais}" required
                                class="input ${not empty frais ? 'bg-gray-100 text-gray-400' : ''}" placeholder="Ex: T1"
                                ${not empty frais ? 'readonly' : '' }>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
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

                        <div>
                            <label class="label">Frais à appliquer (€)</label>
                            <input type="number" step="0.01" name="frais" value="${frais.frais}" required
                                class="input text-xl font-bold" placeholder="5.00">
                            <p class="text-[10px] text-gray-400 mt-2 italic">Ce montant sera ajouté au transfert.</p>
                        </div>

                        <div class="flex items-center justify-between pt-6">
                            <a href="${ctx}/frais/list" class="text-gray-400 font-bold text-sm no-underline">Annuler</a>
                            <button type="submit" class="btn btn-accent shadow-lg shadow-yellow-200">
                                Enregistrer la tranche
                            </button>
                        </div>
                    </form>
                </section>
            </div>
        </div>