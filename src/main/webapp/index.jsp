<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <title>MoneyFlow - Dashboard</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
        </head>

        <body class="min-h-screen bg-cream font-sans text-ink antialiased">
            <c:set var="ctx" value="${pageContext.request.contextPath}" />
            <c:set var="pageActive" value="accueil" />

            <div class="relative z-10 mx-auto max-w-[1480px] px-6 py-6 lg:px-10 lg:py-10">
                <div
                    class="pointer-events-none fixed -bottom-40 -right-40 h-[520px] w-[520px] rounded-full bg-accent blur-3xl opacity-60 z-0">
                </div>
                <div
                    class="pointer-events-none fixed -top-32 -left-32 h-[380px] w-[380px] rounded-full bg-accentSoft blur-3xl opacity-70 z-0">
                </div>
                <div class="grid grid-cols-1 lg:grid-cols-[280px_1fr] gap-8">
                    <%@ include file="/WEB-INF/views/fragments/sidebar.jsp" %>
                        <main>
                            <div class="grid grid-cols-1 xl:grid-cols-[1fr_360px] gap-8 mt-">
                                <section class="space-y-8">
                                    <div>
                                        <div class="text-xs uppercase tracking-[0.25em] text-ink/50 font-bold mb-2">
                                            Bonjour, Admin</div>
                                        <h1 class="font-display text-5xl lg:text-6xl leading-[0.95] text-ink">Tableau de
                                            Bord
                                        </h1>
                                    </div>
                                    <div class="grid grid-cols-2 lg:grid-cols-4 gap-4">
                                        <div class="stat-card card-yellow shadow-lg shadow-yellow-200/20">
                                            <div
                                                class="text-[10px] uppercase tracking-widest mb-1 opacity-70 font-bold">
                                                Aujourd'hui</div>
                                            <div class="font-display text-3xl font-black">${stats_aujourdhui_vol} €
                                            </div>
                                            <div class="text-[10px] mt-1 opacity-60">${stats_aujourdhui_count} envois
                                            </div>
                                        </div>
                                        <div class="stat-card card-black">
                                            <div
                                                class="text-[10px] uppercase tracking-widest mb-1 opacity-50 font-bold">
                                                Volume Total</div>
                                            <div class="font-display text-3xl font-black text-accent">${stats_total_vol}
                                                €</div>
                                            <div class="text-[10px] mt-1 opacity-40">Flux historique</div>
                                        </div>
                                        <div class="stat-card badge-soft border border-ink/5 shadow-sm">
                                            <div
                                                class="text-[10px] uppercase tracking-widest mb-1 text-ink/40 font-bold">
                                                Recette</div>
                                            <div class="font-display text-3xl font-black">${stats_total_recette} €</div>
                                            <div class="text-[10px] mt-1 text-ink/40">Total des frais</div>
                                        </div>
                                        <div class="stat-card badge-gray border border-accentSoft/50 shadow-sm">
                                            <div
                                                class="text-[10px] uppercase tracking-widest mb-1 text-ink/50 font-bold">
                                                Clients</div>
                                            <div class="font-display text-3xl font-black">${stats_total_clients}</div>
                                            <div class="text-[10px] mt-1 text-ink/40">Inscrits</div>
                                        </div>
                                    </div>

                                    <div class="card bg-white border border-ink/5 shadow-sm p-6">
                                        <div class="flex items-center justify-between mb-6">
                                            <h3 class="font-display text-xl">Opérations récentes</h3>
                                            <a href="${ctx}/envois/form" class="btn btn-accent !py-2 !px-4 text-xs">+
                                                Nouvel envoi</a>
                                        </div>
                                        <div class="table-wrap !border-none">
                                            <table class="w-full text-left">
                                                <thead>
                                                    <tr class="text-ink/30 text-[10px] uppercase">
                                                        <th class="pb-4">Destinataire</th>
                                                        <th class="pb-4">Montant</th>
                                                        <th class="pb-4 text-right">Raison</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="e" items="${recentEnvois}">
                                                        <tr class="border-t border-ink/5">
                                                            <td class="py-4 font-bold text-sm">${e.numRecepteur}</td>
                                                            <td class="py-4 font-black text-ink">${e.montant} €</td>
                                                            <td class="py-4 text-center text-xs text-ink/40">${ not
                                                                empty e.raison ? e.raison : 'Vide' }
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </section>

                                <aside class="space-y-6 mt-24">
                                    <div class="card bg-white border border-ink/5 p-6">
                                        <div class="text-[10px] uppercase tracking-widest text-ink/40 font-bold mb-4">
                                            Date Actuelle</div>
                                        <div class="felx items-center">
                                            <div id="today-date" class="font-display text-6xl font-black text-ink">
                                            </div>
                                            <div id="today-month" class="text-xs uppercase font-bold text-ink/40 mt-1">
                                            </div>

                                        </div>
                                    </div>

                                    <div class="card card-black p-6">
                                        <div class="text-[10px] uppercase tracking-widest text-accent/70 font-bold">
                                            Total Transactions</div>
                                        <div class="font-display text-6xl text-accent mt-2 font-black">
                                            ${stats_total_envois}</div>
                                    </div>

                                    <div class="grid grid-cols-2 gap-3">
                                        <a href="${ctx}/taux/list"
                                            class="bg-white border border-ink/5 p-4 rounded-3xl flex flex-col items-center gap-2 hover:bg-accent transition-all group">
                                            <span class="text-xl">⇌</span>
                                            <span
                                                class="text-[10px] font-bold uppercase text-ink/40 group-hover:text-ink">Taux
                                                de Change</span>
                                        </a>
                                        <a href="${ctx}/frais/list"
                                            class="bg-white border border-ink/5 p-4 rounded-3xl flex flex-col items-center gap-2 hover:bg-accent transition-all group">
                                            <span class="text-xl">%</span>
                                            <span
                                                class="text-[10px] font-bold uppercase text-ink/40 group-hover:text-ink">Frais
                                                d'envoi</span>
                                        </a>
                                    </div>
                                </aside>
                            </div>
                        </main>
                </div>
            </div>

            <script>
                (function () {
                    const d = new Date();
                    document.getElementById('today-date').textContent = d.getDate();
                    document.getElementById('today-month').textContent = d.toLocaleDateString('fr-FR', { month: 'long', year: 'numeric' });
                })();
            </script>
        </body>

        </html>