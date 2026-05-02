<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <title>Taux de change - MoneyFlow</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
        </head>

        <body class="min-h-screen bg-cream font-sans text-ink antialiased p-4 lg:p-8 overflow-x-hidden">
            <c:set var="ctx" value="${pageContext.request.contextPath}" />
            <c:set var="pageActive" value="taux" />

            <div
                class="pointer-events-none fixed -bottom-40 -right-40 h-[520px] w-[520px] rounded-full bg-accent blur-3xl opacity-60 z-0">
            </div>
            <div
                class="pointer-events-none fixed -top-32 -left-32 h-[380px] w-[380px] rounded-full bg-accentSoft blur-3xl opacity-70 z-0">
            </div>

            <div class="max-w-[1400px] mx-auto flex flex-col lg:flex-row gap-8 relative z-10">

                <div class="lg:w-72 flex-shrink-0">
                    <%@ include file="/WEB-INF/views/fragments/sidebar.jsp" %>
                </div>

                <main class="flex-1 min-w-0">
                    <section class="custom-card">

                        <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-10">
                            <div>
                                <span
                                    class="text-[10px] uppercase tracking-[0.2em] text-gray-400 font-bold">Configuration</span>
                                <h1 class="text-4xl font-black text-[#0B0B0B] mt-1">Taux de change</h1>
                                <p class="text-gray-500 mt-2 text-sm">
                                    Conversion de devises ·
                                    <span class="bg-yellow-100 text-yellow-700 px-2 py-0.5 rounded-full font-bold">
                                        ${liste.size()} taux actifs
                                    </span>
                                </p>
                            </div>

                            <div class="flex flex-wrap gap-3">
                                <div class="relative group">
                                    <input id="rateSearch" onkeyup="filterRates()"
                                        class="pl-10 pr-4 py-3 bg-gray-100 border-none rounded-full focus:ring-2 focus:ring-accent w-full md:w-64 transition-all"
                                        placeholder="Chercher un pays...">
                                    <span class="absolute left-4 top-1/2 -translate-y-1/2 opacity-40">🔍</span>
                                </div>
                                <a href="${ctx}/taux/form"
                                    class="btn btn-accent px-6 py-3 rounded-full font-bold hover:scale-105 transition-transform flex items-center gap-2">
                                    <span class="text-xl leading-none">+</span> Nouveau Taux
                                </a>
                            </div>
                        </div>

                        <c:if test="${not empty param.success}">
                            <div class="toast success flex items-center gap-3 mb-6">
                                <span>✅</span> Paramètres de change mis à jour !
                            </div>
                        </c:if>

                        <div class="overflow-x-auto table-wrap">
                            <table class="w-full text-left border-separate border-spacing-y-2">
                                <thead>
                                    <tr class="text-gray-400 text-[11px] uppercase tracking-widest font-bold">
                                        <th class="px-4 pb-4">ID Taux</th>
                                        <th class="px-4 pb-4">Conversion</th>
                                        <th class="px-4 pb-4">Couloir (Origine → Dest)</th>
                                        <th class="px-4 pb-4 text-right">Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="rateTableBody">
                                    <c:forEach var="t" items="${liste}">
                                        <tr class="group hover:bg-gray-50 transition-colors">
                                            <td class="bg-gray-50 group-hover:bg-gray-100/50 rounded-l-2xl px-4 py-4">
                                                <span class="badge badge-gray font-mono">${t.idtaux}</span>
                                            </td>
                                            <td class="px-4 py-4">
                                                <div class="flex items-center gap-2">
                                                    <span class="font-bold text-gray-900">${t.montant1} unité</span>
                                                    <span class="text-gray-300">=</span>
                                                    <span
                                                        class="badge badge-yellow font-black text-sm">${t.montant2}</span>
                                                </div>
                                            </td>
                                            <td class="px-4 py-4">
                                                <div class="text-sm font-semibold text-gray-600">
                                                    ${t.pays1} <span class="text-gray-300 mx-1">→</span> ${t.pays2}
                                                </div>
                                            </td>
                                            <td class="px-4 py-4 text-right rounded-r-2xl">
                                                <div class="flex justify-center items-center gap-2">
                                                    <a href="${ctx}/taux/form?idtaux=${t.idtaux}"
                                                        class="btn btn-ghost !p-2 px-4 text-xs">Modifier</a>
                                                    <a href="${ctx}/taux/delete?idtaux=${t.idtaux}"
                                                        onclick="return confirm('Supprimer ?')"
                                                        class="btn btn-danger !p-2 px-4 text-xs">Supprimer</a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="mt-8 p-6 bg-accent/10 rounded-3xl border border-accent flex gap-4 items-center">
                            <div class="text-2xl">💡</div>
                            <p class="text-xs text-ink/70 leading-relaxed">
                                <span class="font-bold">Aide :</span> Pour un couloir Europe vers Madagascar, définissez
                                <span class="bg-white px-1 rounded">1</span> en Montant 1 et la valeur en Ariary (ex:
                                <span class="bg-white px-1 rounded">4800</span>) en Montant 2.
                            </p>
                        </div>
                    </section>
                </main>
            </div>

            <script>
                function filterRates() {
                    const query = document.getElementById('rateSearch').value.toLowerCase();
                    const rows = document.querySelectorAll('#rateTableBody tr');
                    rows.forEach(row => {
                        row.style.display = row.innerText.toLowerCase().includes(query) ? "" : "none";
                    });
                }
            </script>

            <c:if test="${showForm}">
                <jsp:include page="form.jsp" />
            </c:if>

        </body>

        </html>