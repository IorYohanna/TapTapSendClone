<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <title>MoneyFlow - Relevé Mensuel</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body class="bg-[#F4F2EC] min-h-screen p-4 lg:p-8">
            <c:set var="ctx" value="${pageContext.request.contextPath}" />
            <c:set var="pageActive" value="releve" />

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
                        <div class="mb-8">
                            <div class="text-[10px] uppercase tracking-[0.2em] text-gray-400 font-bold">Rapport &
                                Statistiques</div>
                            <h1 class="text-4xl font-black text-[#0B0B0B] mt-1 leading-[0.95]">Relevé PDF mensuel</h1>
                            <p class="mt-2 text-sm text-gray-500">Génère un PDF complet des opérations d'un client pour
                                un mois donné.</p>
                        </div>

                        <form action="${ctx}/releve/generate" method="get"
                            class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
                            <div>
                                <label class="label">Client envoyeur</label>
                                <select name="numtel" class="select" required>
                                    <option value="">-- Choisir un client --</option>
                                    <c:forEach var="c" items="${clients}">
                                        <option value="${c.numtel}">
                                            ${c.nom} (${c.numtel}) - ${c.pays}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="label">Période (Mois)</label>
                                <input type="month" name="mois" class="input" required>
                            </div>
                            <div class="flex items-end gap-2">
                                <button type="submit" class="btn btn-primary flex-1 justify-center py-3">
                                    📄 Générer le PDF
                                </button>
                            </div>
                        </form>

                        <div class="rounded-3xl border border-dashed border-gray-200 bg-gray-50/50 p-12 text-center">
                            <h3 class="text-lg font-bold text-gray-400">Prêt à générer</h3>
                            <p class="text-sm text-gray-400 max-w-xs mx-auto">
                                Sélectionnez un client et un mois ci-dessus pour obtenir l'historique détaillé des
                                transactions.
                            </p>
                        </div>

                    </section>
                </main>
            </div>
        </body>

        </html>