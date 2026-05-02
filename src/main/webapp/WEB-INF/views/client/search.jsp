<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <title>Recherche Client - MoneyFlow</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
        </head>

        <body class="min-h-screen bg-cream font-sans text-ink antialiased p-4 lg:p-8">
            <c:set var="ctx" value="${pageContext.request.contextPath}" />
            <c:set var="pageActive" value="search" />

            <div class="max-w-[1400px] mx-auto flex flex-col lg:flex-row gap-8">
                <div class="lg:w-72 flex-shrink-0">
                    <%@ include file="/WEB-INF/views/fragments/sidebar.jsp" %>
                </div>

                <main class="flex-1 min-w-0">
                    <section class="card">
                        <div class="mb-8">
                            <div class="text-sm text-ink/50 tracking-wide uppercase font-bold">Outil</div>
                            <h1 class="font-display text-4xl lg:text-5xl leading-[0.95] font-black text-ink">Recherche
                                client</h1>
                            <p class="mt-2 text-sm text-ink/60">Retrouve un client par nom, numéro de téléphone, email
                                ou pays.</p>
                        </div>

                        <div class="flex gap-3 mb-6">
                            <div class="relative flex-1">
                                <span class="absolute left-4 top-1/2 -translate-y-1/2 opacity-30">🔍</span>
                                <input id="dynamicSearch" oninput="filterResults()"
                                    class="input !rounded-full !py-3 pl-10 text-base w-full"
                                    placeholder="Tape un nom, un numéro, un email…" autofocus>
                            </div>
                            <span class="badge badge-yellow self-center px-4 py-2">
                                <span id="sc-count">${clients.size()}</span> résultat(s)
                            </span>
                        </div>

                        <div id="sc-results" class="space-y-3">
                            <c:forEach var="c" items="${clients}">
                                <div
                                    class="client-card flex items-center justify-between p-4 bg-white border border-gray-100 rounded-2xl hover:shadow-md transition-all duration-200">
                                    <div class="flex items-center gap-4">
                                        <div
                                            class="h-10 w-10 rounded-full bg-accentSoft flex items-center justify-center font-bold text-ink uppercase">
                                            ${not empty c.nom ? c.nom.substring(0,1) : '?'}
                                        </div>
                                        <div>
                                            <div class="client-name font-bold text-ink">${c.nom}</div>
                                            <div class="client-info text-xs text-gray-400">${c.numtel} • ${c.email}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="flex items-center gap-4">
                                        <span class="client-country badge badge-soft">${c.pays}</span>
                                        <a href="${ctx}/clients/form?numtel=${c.numtel}"
                                            class="btn btn-ghost !p-2 hover:bg-accent hover:text-ink rounded-full">
                                            →
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>

                            <div id="no-results"
                                class="hidden py-12 text-center bg-gray-50 rounded-3xl border-2 border-dashed border-gray-200">
                                <p class="text-gray-400 font-medium">Aucun client ne correspond à votre recherche.</p>
                                <button onclick="resetSearch()"
                                    class="text-accent font-bold mt-2 hover:underline">Effacer la recherche</button>
                            </div>
                        </div>

                    </section>
                </main>
            </div>

            <script>
                function filterResults() {
                    const query = document.getElementById('dynamicSearch').value.toLowerCase();
                    const cards = document.querySelectorAll('.client-card');
                    const noResultsMsg = document.getElementById('no-results');
                    let visibleCount = 0;

                    cards.forEach(card => {
                        const content = card.innerText.toLowerCase();

                        if (content.includes(query)) {
                            card.style.display = "flex";
                            card.style.opacity = "1";
                            card.style.transform = "translateY(0)";
                            visibleCount++;
                        } else {
                            card.style.display = "none";
                            card.style.opacity = "0";
                        }
                    });

                    document.getElementById('sc-count').innerText = visibleCount;

                    if (visibleCount === 0) {
                        noResultsMsg.classList.remove('hidden');
                    } else {
                        noResultsMsg.classList.add('hidden');
                    }
                }

                function resetSearch() {
                    document.getElementById('dynamicSearch').value = '';
                    filterResults();
                }
            </script>
        </body>

        </html>