<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <c:set var="ctx" value="${pageContext.request.contextPath}" />
        <div class="modal-backdrop">
            <div class="modal-panel">
                <section class="card relative">
                    <a href="${ctx}/taux/list"
                        class="absolute top-6 right-6 text-gray-400 hover:text-black text-2xl no-underline">&times;</a>

                    <div class="mb-8">
                        <div class="text-[10px] uppercase tracking-[0.2em] text-gray-400 font-bold">Configuration</div>
                        <h1 class="font-display text-3xl text-ink font-black">
                            ${empty taux ? 'Nouveau taux' : 'Modifier le taux'}
                        </h1>
                        <p class="text-sm text-gray-500">Ajustez les valeurs de conversion entre les devises.</p>
                    </div>

                    <form action="${ctx}/taux/save" method="post" class="space-y-5">
                        <input type="hidden" name="action" value="${not empty taux ? 'modifier' : 'ajouter'}">

                        <div>
                            <label class="label">Identifiant du Taux (ID)</label>
                            <input type="text" name="idtaux" value="${taux.idtaux}" required
                                class="input ${not empty taux ? 'bg-gray-100 text-gray-400' : ''}"
                                placeholder="Ex: EUR_MGA" ${not empty taux ? 'readonly' : '' }>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="label">Montant 1 (Référence)</label>
                                <input type="number" name="montant1"
                                    value="${taux.montant1 != null ? taux.montant1 : 1}" required class="input"
                                    placeholder="1">
                            </div>
                            <div>
                                <label class="label">Montant 2 (Valeur cible)</label>
                                <input type="number" name="montant2" value="${taux.montant2}" required class="input"
                                    placeholder="4800">
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="label">Pays d'origine (Réf)</label>
                                <select name="pays1" class="select" required>
                                    <jsp:include page="/WEB-INF/views/fragments/pays.jsp">
                                        <jsp:param name="selected" value="${taux.pays1}" />
                                    </jsp:include>
                                </select>
                            </div>
                            <div>
                                <label class="label">Pays de destination</label>
                                <select name="pays2" class="select" required>
                                    <jsp:include page="/WEB-INF/views/fragments/pays.jsp">
                                        <jsp:param name="selected" value="${taux.pays2}" />
                                    </jsp:include>
                                </select>
                            </div>
                        </div>

                        <div class="flex items-center justify-between pt-6">
                            <a href="${ctx}/taux/list" class="text-gray-400 font-bold text-sm no-underline">Annuler</a>
                            <button type="submit" class="btn btn-accent shadow-lg shadow-yellow-200">
                                Enregistrer le taux
                            </button>
                        </div>
                    </form>
                </section>
            </div>
        </div>