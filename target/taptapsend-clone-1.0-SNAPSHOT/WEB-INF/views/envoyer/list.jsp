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

                <div class="max-w-[1400px] mx-auto flex flex-col lg:flex-row gap-8">

                    <!-- Sidebar -->
                    <div class="lg:w-72 flex-shrink-0">
                        <%@ include file="/WEB-INF/views/fragments/sidebar.jsp" %>
                    </div>

                    <main class="flex-1 min-w-0">
                        <section class="custom-card">

                            <!-- Header -->
                            <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-10">
                                <div>
                                    <span
                                        class="text-[10px] uppercase tracking-[0.2em] text-gray-400 font-bold">Opérations</span>
                                    <h1 class="text-4xl font-black text-[#0B0B0B] mt-1">Envois d'argent</h1>
                                    <p class="text-gray-500 mt-2 text-sm">
                                        Historique des transferts ·
                                        <span class="bg-yellow-100 text-yellow-700 px-2 py-0.5 rounded-full font-bold">
                                            ${envoyers != null ? envoyers.size() : 0} transactions
                                        </span>
                                    </p>
                                </div>

                                <div class="flex flex-wrap gap-3">
                                    <form action="${ctx}/envois/search" method="get" class="flex gap-2">
                                        <input type="date" name="date" value="${dateRecherche}"
                                            class="input py-2 rounded-full border-none bg-gray-100">
                                        <button type="submit" class="btn btn-ghost !p-2 px-4">Filtrer</button>
                                    </form>
                                    <a href="${ctx}/envois/form"
                                        class="btn btn-accent px-6 py-3 rounded-full font-bold hover:scale-105 transition-transform flex items-center gap-2">
                                        <span class="text-xl leading-none">+</span> Nouvel envoi
                                    </a>
                                </div>
                            </div>

                            <c:if test="${not empty param.success}">
                                <div class="toast success flex items-center gap-3 mb-6">
                                    <span>✅</span> Transaction traitée avec succès !
                                </div>
                            </c:if>

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
                                    <tbody>
                                        <c:forEach var="e" items="${envoyers}">
                                            <tr class="group hover:bg-gray-50 transition-colors">
                                                <td class="px-4 py-4"><span class="badge badge-gray">${e.idEnv}</span>
                                                </td>
                                                <td class="px-4 py-4 font-bold text-gray-900">${e.numEnvoyeur}</td>
                                                <td class="px-4 py-4 font-bold text-gray-900">${e.numRecepteur}</td>
                                                <td class="px-4 py-4 text-lg font-black text-ink">${e.montant} €</td>
                                                <td class="px-4 py-4">
                                                    <div class="text-xs font-bold uppercase text-gray-400">
                                                        ${e.formattedDate}</div>
                                                    <div class="text-sm text-gray-500 italic truncate max-w-[150px]">
                                                        ${e.raison}</div>
                                                </td>
                                                <td class="px-4 py-4 text-right">
                                                    <div class="flex justify-end gap-2">
                                                        <a href="${ctx}/envois/form?idEnv=${e.idEnv}"
                                                            class="btn btn-ghost py-1 px-3 text-xs">Détails</a>
                                                        <a href="${ctx}/envois/delete?idEnv=${e.idEnv}"
                                                            onclick="return confirm('Annuler?')"
                                                            class="btn btn-danger py-1 px-3 text-xs">Annuler</a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                        </section>
                    </main>
                </div>

                <c:if test="${showForm}">
                    <jsp:include page="form.jsp" />
                </c:if>

            </body>

            </html>