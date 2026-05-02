<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <aside
        class="lg:sticky lg:top-8 h-fit rounded-3xl bg-ink text-white p-6 shadow-[0_20px_60px_-20px_rgba(0,0,0,0.45)]">
        <div class="flex items-center gap-2 mb-10">
            <div class="h-10 w-10 rounded-xl bg-accent flex items-center justify-center">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#0B0B0B"
                    stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" class="h-5 w-5">
                    <path d="M12 2v20M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6" />
                </svg>
            </div>
            <div>
                <div class="font-display text-lg leading-none">MoneyFlow</div>
                <div class="text-[10px] uppercase p-4 tracking-[0.25em] text-white/50">Opérateur</div>
            </div>
        </div>

        <nav class="flex flex-col gap-1">
            <a href="${ctx}/index.jsp" class="nav-btn ${pageActive == 'accueil' ? 'active' : ''}">
                <span class="nav-icon">◐</span> Accueil
            </a>
            <a href="${ctx}/clients/list" class="nav-btn ${pageActive == 'clients' ? 'active' : ''}">
                <span class="nav-icon">◆</span> Clients
            </a>
            <a href="${ctx}/envois/list" class="nav-btn ${pageActive == 'envois' ? 'active' : ''}">
                <span class="nav-icon">↗</span> Envois
            </a>
            <a href="${ctx}/taux/list" class="nav-btn ${pageActive == 'taux' ? 'active' : ''}">
                <span class="nav-icon">⇌</span> Taux de change
            </a>
            <a href="${ctx}/frais/list" class="nav-btn ${pageActive == 'frais' ? 'active' : ''}">
                <span class="nav-icon">%</span> Frais d'envoi
            </a>
        </nav>

        <div class="mt-10 pt-6 border-t border-white/10 text-center">
            <span class="text-xs text-white/40 font-mono tracking-wider">OUTILS</span>
            <a href="${ctx}/releve/form" class="nav-btn ${pageActive == 'releve' ? 'active' : ''}">
                <span class="nav-icon">▤</span> Relevés PDF
            </a>
            <a href="${ctx}/recette" class="nav-btn ${pageActive == 'recette' ? 'active' : ''}">
                <span class="nav-icon">$</span> Recette
            </a>
            <a href="${ctx}/clients/search" class="nav-btn ${pageActive == 'search' ? 'active' : ''}">
                <span class="nav-icon">🔍</span> Recherche de clients
            </a>
        </div>
    </aside>