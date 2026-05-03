<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <title>Recettes - MoneyFlow</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
            </head>

            <body class="bg-[#F4F2EC] min-h-screen p-4 lg:p-8">
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <c:set var="pageActive" value="recette" />

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

                    <main class="flex-1 min-w-0 space-y-6">
                        <section class="card">
                            <div class="mb-10">
                                <div class="text-[10px] uppercase tracking-[0.2em] text-gray-400 font-bold">Indicateur
                                    de performance</div>
                                <h1 class="text-4xl lg:text-5xl font-black text-[#0B0B0B] mt-1 leading-[0.95]">Recette
                                    totale</h1>
                                <p class="mt-4 text-sm text-gray-500 max-w-xl">
                                    Somme globale des frais d'envoi encaissés par l'opérateur. Ce montant représente le
                                    chiffre d'affaires généré par les commissions de transfert.
                                </p>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                                <div class="stat-card card-yellow h-40 flex flex-col justify-center">
                                    <div class="text-[10px] uppercase tracking-widest opacity-70 mb-2 font-bold">Recette
                                        totale</div>
                                    <div class="font-display text-5xl font-black">${totalFrais} €</div>
                                    <div class="text-xs mt-2 opacity-70">Σ frais d'envoi perçus</div>
                                </div>

                                <div class="stat-card card-black h-40 flex flex-col justify-center">
                                    <div class="text-[10px] uppercase tracking-widest opacity-60 mb-2 font-bold">Volume
                                        transféré</div>
                                    <div class="font-display text-5xl font-black text-accent">${totalVolume} €</div>
                                    <div class="text-xs mt-2 opacity-60">Total des sommes envoyées</div>
                                </div>

                                <div
                                    class="stat-card bg-white border border-gray-100 shadow-sm h-40 flex flex-col justify-center">
                                    <div class="text-[10px] uppercase tracking-widest text-gray-400 mb-2 font-bold">
                                        Opérations</div>
                                    <div class="font-display text-5xl font-black text-ink">${totalTransactions}</div>
                                    <div class="text-xs mt-2 text-gray-400">Nombre d'envois réalisés</div>
                                </div>
                            </div>
                        </section>

                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                            <div class="card bg-black text-white">
                                <div class="text-[10px] uppercase tracking-widest text-white/50 mb-2 font-bold">Panier
                                    Moyen</div>
                                <div class="font-display text-4xl font-black text-accent mb-2">
                                    ${totalVolume / totalTransactions} €
                                </div>
                                <p class="text-xs text-white/40 leading-relaxed">
                                    C'est le montant moyen envoyé par transaction sur l'ensemble de vos opérations.
                                </p>
                                <div class="mt-6 pt-6 border-t border-white/10 flex justify-between">
                                    <span class="text-[10px] font-bold text-white/30 uppercase">Rentabilité</span>
                                    <span class="text-[10px] font-bold text-accent uppercase">+12% ce mois</span>
                                </div>
                            </div>
                            <div class="card">
                                <div class="text-[10px] uppercase tracking-widest text-gray-400 mb-2 font-bold">Top
                                    Clients</div>
                                <div class="font-display text-xl font-bold mb-4">Meilleurs envoyeurs</div>
                                <div class="space-y-3">
                                    <div class="flex justify-between text-sm border-b border-gray-50 pb-2">
                                        <span class="text-gray-500">Client Premium #1</span>
                                        <span class="font-bold">120 € de frais</span>
                                    </div>
                                    <div class="flex justify-between text-sm">
                                        <span class="text-gray-500">Client Fidèle #2</span>
                                        <span class="font-bold">85 € de frais</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </body>

            </html>