<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <title>Clients - MoneyFlow</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
        </head>

        <body class="min-h-screen bg-cream font-sans text-ink antialiased p-4 lg:p-8">
            <c:set var="ctx" value="${pageContext.request.contextPath}" />
            <c:set var="pageActive" value="clients" />

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
                                    class="text-[10px] uppercase tracking-[0.2em] text-gray-400 font-bold">Administration</span>
                                <h1 class="text-4xl font-black text-[#0B0B0B] mt-1">Répertoire Clients</h1>
                                <p class="text-gray-500 mt-2 text-sm">Liste complète des utilisateurs enregistrés.</p>
                            </div>

                            <div class="flex flex-wrap gap-3">
                                <a href="${ctx}/clients/form"
                                    class="badge-yellow px-6 py-3 rounded-full font-bold hover:scale-105 transition-transform flex items-center gap-2">
                                    <span class="text-xl leading-none">+</span> Nouveau Client
                                </a>
                            </div>
                        </div>

                        <div class="overflow-x-auto table-wrap">
                            <table class="w-full text-left border-separate border-spacing-y-2">
                                <thead>
                                    <tr class="text-gray-400 text-[11px] uppercase tracking-widest font-bold">
                                        <th class="px-4 pb-4">Contact</th>
                                        <th class="px-4 pb-4">Nom</th>
                                        <th class="px-4 pb-4">Pays</th>
                                        <th class="px-4 pb-4 text-right">Solde</th>
                                        <th class="px-4 pb-4 text-right">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${clients}">
                                        <tr class="group hover:bg-gray-50 transition-colors">
                                            <td class="bg-gray-50 group-hover:bg-gray-100/50 rounded-l-2xl px-4 py-4">
                                                <span class="badge badge-gray">${c.numtel}</span>
                                            </td>
                                            <td class="px-4 py-4 font-bold">${c.nom}</td>
                                            <td class="px-4 py-4 text-sm text-gray-500">${c.pays}</td>
                                            <td class="px-4 py-4 text-right font-black">${c.solde}</td>
                                            <td class="px-4 py-4 text-right rounded-r-2xl">
                                                <a href="${ctx}/clients/form?numtel=${c.numtel}"
                                                    class="btn btn-ghost !p-2 px-4 text-xs">Modifier</a>
                                                <a href="${ctx}/clients/delete?numtel=${c.numtel}"
                                                    onclick="return confirm('Supprimer ?')"
                                                    class="btn btn-danger !p-2 px-4 text-xs">Supprimer</a>
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