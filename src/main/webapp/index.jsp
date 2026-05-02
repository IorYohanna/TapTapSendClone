<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>MoneyFlow - Accueil Administrateur</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
            </head>

            <body class="min-h-screen bg-cream font-sans text-ink antialiased overflow-x-hidden">
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <c:set var="pageActive" value="accueil" />

                <div
                    class="pointer-events-none fixed -bottom-40 -right-40 h-[520px] w-[520px] rounded-full bg-accent blur-3xl opacity-60 z-0">
                </div>
                <div
                    class="pointer-events-none fixed -top-32 -left-32 h-[380px] w-[380px] rounded-full bg-accentSoft blur-3xl opacity-70 z-0">
                </div>

                <div class="relative z-10 mx-auto max-w-[1480px] px-6 py-6 lg:px-10 lg:py-10">
                    <div class="grid grid-cols-1 lg:grid-cols-[280px_1fr] gap-8">

                        <%@ include file="/WEB-INF/views/fragments/sidebar.jsp" %>

                            <main class="min-h-[700px]">

                                <div class="mb-10">
                                    <div class="text-xs uppercase tracking-[0.25em] text-ink/60 font-bold mb-2">Tableau
                                        de
                                        bord</div>
                                    <h1 class="font-display text-4xl lg:text-5xl tracking-tight text-ink mb-3">Bienvenue
                                        sur
                                        MoneyFlow</h1>
                                    <p class="text-ink/70 max-w-xl text-sm md:text-base">
                                        Portail de gestion de l'opérateur de transfert d'argent. Sélectionnez un module
                                        ci-dessous pour administrer votre activité.
                                    </p>
                                </div>

                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                                    <div class="card-module flex flex-col justify-between">
                                        <div>
                                            <div class="flex items-center justify-between mb-6">
                                                <div
                                                    class="h-12 w-12 rounded-2xl bg-accentSoft/40 text-ink flex items-center justify-center text-xl">
                                                    ◆</div>
                                                <span
                                                    class="text-[10px] bg-ink/5 text-ink/60 px-2.5 py-1 rounded-full uppercase font-bold tracking-widest font-mono">Module
                                                    01</span>
                                            </div>
                                            <h3 class="font-display text-xl text-ink mb-2">Gestion des Clients</h3>
                                            <p class="text-sm text-ink/60 mb-6 leading-relaxed">
                                                Consultez la liste des clients inscrits, modifiez leurs informations ou
                                                créez de nouveaux comptes.
                                            </p>
                                        </div>
                                        <a href="${ctx}/clients/list"
                                            class="mt-4 flex items-center justify-between w-full bg-ink text-white text-sm font-semibold hover:bg-accent hover:text-ink px-5 py-3 rounded-2xl transition-all font-sans">
                                            Accéder aux clients <span class="text-lg">→</span>
                                        </a>
                                    </div>

                                    <div class="card-module flex flex-col justify-between">
                                        <div>
                                            <div class="flex items-center justify-between mb-6">
                                                <div
                                                    class="h-12 w-12 rounded-2xl bg-accentSoft/40 text-ink flex items-center justify-center text-xl">
                                                    ⇌</div>
                                                <span
                                                    class="text-[10px] bg-ink/5 text-ink/60 px-2.5 py-1 rounded-full uppercase font-bold tracking-widest font-mono">Module
                                                    02</span>
                                            </div>
                                            <h3 class="font-display text-xl text-ink mb-2">Gestion des Taux</h3>
                                            <p class="text-sm text-ink/60 mb-6 leading-relaxed">
                                                Ajustez les taux de conversion en temps réel pour optimiser les
                                                transactions
                                                de devises.
                                            </p>
                                        </div>
                                        <a href="${ctx}/taux/list"
                                            class="mt-4 flex items-center justify-between w-full bg-ink text-white text-sm font-semibold hover:bg-accent hover:text-ink px-5 py-3 rounded-2xl transition-all font-sans">
                                            Ajuster les taux <span class="text-lg">→</span>
                                        </a>
                                    </div>

                                    <div class="card-module flex flex-col justify-between">
                                        <div>
                                            <div class="flex items-center justify-between mb-6">
                                                <div
                                                    class="h-12 w-12 rounded-2xl bg-accentSoft/40 text-ink flex items-center justify-center text-xl">
                                                    ↗</div>
                                                <span
                                                    class="text-[10px] bg-ink/5 text-ink/60 px-2.5 py-1 rounded-full uppercase font-bold tracking-widest font-mono">Module
                                                    03</span>
                                            </div>
                                            <h3 class="font-display text-xl text-ink mb-2">Gestion des Envois</h3>
                                            <p class="text-sm text-ink/60 mb-6 leading-relaxed">
                                                Suivez l'historique complet des transferts d'argent effectués, ou
                                                réalisez
                                                un nouvel envoi.
                                            </p>
                                        </div>
                                        <a href="${ctx}/envois/list"
                                            class="mt-4 flex items-center justify-between w-full bg-ink text-white text-sm font-semibold hover:bg-accent hover:text-ink px-5 py-3 rounded-2xl transition-all font-sans">
                                            Historique des envois <span class="text-lg">→</span>
                                        </a>
                                    </div>

                                    <div class="card-module flex flex-col justify-between">
                                        <div>
                                            <div class="flex items-center justify-between mb-6">
                                                <div
                                                    class="h-12 w-12 rounded-2xl bg-accentSoft/40 text-ink flex items-center justify-center text-xl">
                                                    %</div>
                                                <span
                                                    class="text-[10px] bg-ink/5 text-ink/60 px-2.5 py-1 rounded-full uppercase font-bold tracking-widest font-mono">Module
                                                    04</span>
                                            </div>
                                            <h3 class="font-display text-xl text-ink mb-2">Gestion des Frais</h3>
                                            <p class="text-sm text-ink/60 mb-6 leading-relaxed">
                                                Configurez les frais d'envoi et les paliers de taxation pour l'ensemble
                                                des
                                                opérations.
                                            </p>
                                        </div>
                                        <a href="${ctx}/frais/list"
                                            class="mt-4 flex items-center justify-between w-full bg-ink text-white text-sm font-semibold hover:bg-accent hover:text-ink px-5 py-3 rounded-2xl transition-all font-sans">
                                            Configurer les frais <span class="text-lg">→</span>
                                        </a>
                                    </div>

                                </div>
                            </main>
                    </div>

                    <footer class="mt-12 text-center text-xs text-ink/40 tracking-wide">
                        MoneyFlow · Portail Administration · Démo CRUD & JSP
                    </footer>
                </div>
            </body>

            </html>