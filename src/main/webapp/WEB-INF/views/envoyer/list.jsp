<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <title>Envois - MoneyFlow</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <script src="https://unpkg.com/htmx.org@1.9.10"></script>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
            </head>

            <body class="bg-[#F4F2EC] min-h-screen p-4 lg:p-8">
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <c:set var="pageActive" value="envois" />

                <div
                    class="pointer-events-none fixed -bottom-40 -right-40 h-[520px] w-[520px] rounded-full bg-accent blur-3xl opacity-60 z-0">
                </div>
                <div
                    class="pointer-events-none fixed -top-32 -left-32 h-[380px] w-[380px] rounded-full bg-accentSoft blur-3xl opacity-70 z-0">
                </div>

                <div class="max-w-[1400px] mx-auto flex flex-col lg:flex-row gap-8">
                    <div class="lg:w-72 flex-shrink-0">
                        <%@ include file="/WEB-INF/views/fragments/sidebar.jsp" %>
                    </div>

                    <main class="flex-1 min-w-0">
                        <section class="custom-card">

                            <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-10">
                                <div>
                                    <span
                                        class="text-[10px] uppercase tracking-[0.2em] text-gray-400 font-bold">Opérations</span>
                                    <h1 class="text-4xl font-black text-[#0B0B0B] mt-1">Envois d'argent</h1>
                                    <p class="text-gray-500 mt-2 text-sm">
                                        Historique des transferts ·
                                        <span id="txCount"
                                            class="bg-yellow-100 text-yellow-700 px-2 py-0.5 rounded-full font-bold">
                                            ${envoyers != null ? envoyers.size() : 0} transactions
                                        </span>
                                    </p>
                                </div>

                                <div class="flex flex-wrap gap-3 items-center">

                                    <%-- Filtre date dynamique — plus de form ni de bouton "Filtrer" --%>
                                        <div class="flex items-center gap-2 bg-gray-100 rounded-full px-4 py-2">
                                            <svg xmlns="http://www.w3.org/2000/svg"
                                                class="h-4 w-4 text-gray-400 flex-shrink-0" fill="none"
                                                viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                            </svg>
                                            <input type="date" id="dateFilter" value="${dateRecherche}"
                                                class="bg-transparent text-sm text-gray-600 outline-none cursor-pointer">
                                            <button id="clearDate" title="Effacer le filtre"
                                                class="text-gray-400 hover:text-red-400 transition-colors hidden text-xl leading-none font-light">
                                                &times;
                                            </button>
                                        </div>

                                        <a href="${ctx}/envois/form"
                                            class="btn btn-accent px-6 py-3 rounded-full font-bold hover:scale-105 transition-transform flex items-center gap-2">
                                            <span class="text-xl leading-none">+</span> Nouvel envoi
                                        </a>
                                </div>
                            </div>

                            <div class="table-wrap overflow-hidden">
                                <table class="w-full text-left">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Envoyeur</th>
                                            <th>Récepteur</th>
                                            <th>Montant</th>
                                            <th>Date & Raison</th>
                                            <th class="text-right">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="envoisTableBody">
                                        <c:forEach var="e" items="${envoyers}">
                                            <%-- data-date doit être au format ISO yyyy-MM-dd (getter isoDate dans le
                                                bean) --%>
                                                <tr class="group hover:bg-gray-50 transition-colors"
                                                    data-date="${e.isoDate}">
                                                    <td class="px-4 py-4"><span
                                                            class="badge badge-gray">${e.idEnv}</span></td>
                                                    <td class="px-4 py-4 font-bold text-gray-900">${e.numEnvoyeur}</td>
                                                    <td class="px-4 py-4 font-bold text-gray-900">${e.numRecepteur}</td>
                                                    <td class="px-4 py-4 text-lg font-black text-ink">${e.montant} €
                                                    </td>
                                                    <td class="px-4 py-4">
                                                        <div class="text-xs font-bold uppercase text-gray-400">
                                                            ${e.formattedDate}</div>
                                                        <div
                                                            class="text-sm text-gray-500 italic truncate max-w-[150px]">
                                                            ${e.raison}</div>
                                                    </td>
                                                    <td class="px-4 py-4 text-center">
                                                        <div class="flex justify-center items-center gap-2">
                                                            <a href="${ctx}/envois/form?idEnv=${e.idEnv}"
                                                                class="btn btn-ghost py-1 px-3 text-xs">Détails</a>
                                                            <button type="button"
                                                                onclick="openDeleteModal('${ctx}/envois/delete?idEnv=${e.idEnv}', 'Supprimer l\'envoi ${e.idEnv} ?')"
                                                                class="btn btn-danger !p-2 px-4 text-xs">
                                                                Supprimer
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <%-- Message "Aucun résultat" affiché si aucune ligne ne correspond --%>
                                    <div id="emptyState" class="hidden text-center py-16 text-gray-400">
                                        <svg xmlns="http://www.w3.org/2000/svg"
                                            class="h-12 w-12 mx-auto mb-3 opacity-40" fill="none" viewBox="0 0 24 24"
                                            stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                                d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                        </svg>
                                        <p class="font-semibold">Aucun envoi pour cette date</p>
                                        <button id="clearDateEmpty"
                                            class="mt-3 text-sm text-yellow-600 hover:underline font-medium">
                                            Effacer le filtre
                                        </button>
                                    </div>
                            </div>

                        </section>
                    </main>
                </div>

                <c:if test="${showForm}">
                    <jsp:include page="form.jsp" />
                </c:if>

                <script src="${pageContext.request.contextPath}/js/delete.js"></script>
                <%@ include file="/WEB-INF/views/fragments/toast.jsp" %>
                    <%@ include file="/WEB-INF/views/fragments/deleteModal.jsp" %>

                        <script>
                            (function () {
                                const input = document.getElementById('dateFilter');
                                const clearBtn = document.getElementById('clearDate');
                                const clearEmpty = document.getElementById('clearDateEmpty');
                                const rows = document.querySelectorAll('#envoisTableBody tr[data-date]');
                                const counter = document.getElementById('txCount');
                                const emptyState = document.getElementById('emptyState');

                                function applyFilter() {
                                    const val = input.value; 
                                    let visible = 0;

                                    rows.forEach(function (row) {
                                        const match = !val || row.dataset.date === val;
                                        row.style.display = match ? '' : 'none';
                                        if (match) visible++;
                                    });

                                    clearBtn.classList.toggle('hidden', !val);

                                    emptyState.classList.toggle('hidden', visible > 0);

                                    if (counter) {
                                        counter.textContent = visible + ' transaction' + (visible > 1 ? 's' : '');
                                    }
                                }

                                input.addEventListener('input', applyFilter);

                                clearBtn.addEventListener('click', function () {
                                    input.value = '';
                                    applyFilter();
                                });

                                if (clearEmpty) {
                                    clearEmpty.addEventListener('click', function () {
                                        input.value = '';
                                        applyFilter();
                                    });
                                }
                                if (input.value) applyFilter();
                            })();
                        </script>

            </body>

            </html>