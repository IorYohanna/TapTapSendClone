<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Clients - TapTapSend</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 p-6">
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="max-w-5xl mx-auto">
    <div class="flex items-center justify-between mb-6">
        <h1 class="text-2xl font-bold text-blue-600">Gestion des Clients</h1>
        <a href="${ctx}/clients/form"
           class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded shadow text-sm">
            + Nouveau client
        </a>
    </div>

    <%-- Alertes --%>
    <c:if test="${not empty param.success}">
        <div class="bg-green-100 border border-green-400 text-green-800 px-4 py-2 rounded mb-4 text-sm">
            Opération réussie : ${param.success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="bg-red-100 border border-red-400 text-red-800 px-4 py-2 rounded mb-4 text-sm">
            Erreur : ${error}
        </div>
    </c:if>

    <%-- Recherche --%>
    <form method="get" action="${ctx}/clients/search" class="flex gap-2 mb-6">
        <input type="text" name="q" value="${keyword}" placeholder="Rechercher par nom..."
               class="border rounded px-3 py-2 text-sm flex-1 focus:outline-none focus:ring-2 focus:ring-blue-300"/>
        <button type="submit"
                class="bg-gray-700 hover:bg-gray-800 text-white px-4 py-2 rounded text-sm">
            Rechercher
        </button>
        <a href="${ctx}/clients/list"
           class="bg-gray-200 hover:bg-gray-300 text-gray-700 px-4 py-2 rounded text-sm">
            Reset
        </a>
    </form>

    <%-- Tableau --%>
    <div class="overflow-x-auto shadow rounded-lg">
        <table class="min-w-full bg-white text-sm">
            <thead class="bg-blue-600 text-white">
                <tr>
                    <th class="px-4 py-3 text-left">Numéro tél.</th>
                    <th class="px-4 py-3 text-left">Nom</th>
                    <th class="px-4 py-3 text-left">Sexe</th>
                    <th class="px-4 py-3 text-left">Pays</th>
                    <th class="px-4 py-3 text-right">Solde (€)</th>
                    <th class="px-4 py-3 text-left">Email</th>
                    <th class="px-4 py-3 text-center">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty clients}">
                        <tr>
                            <td colspan="7" class="text-center py-6 text-gray-400">
                                Aucun client trouvé.
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="c" items="${clients}" varStatus="st">
                            <tr class="${st.index % 2 == 0 ? 'bg-white' : 'bg-gray-50'} hover:bg-blue-50">
                                <td class="px-4 py-2 font-mono">${c.numtel}</td>
                                <td class="px-4 py-2 font-medium">${c.nom}</td>
                                <td class="px-4 py-2">${c.sexe}</td>
                                <td class="px-4 py-2">${c.pays}</td>
                                <td class="px-4 py-2 text-right">${c.solde}</td>
                                <td class="px-4 py-2 text-gray-500">${c.email}</td>
                                <td class="px-4 py-2 text-center space-x-2">
                                    <a href="${ctx}/clients/form?numtel=${c.numtel}"
                                       class="text-blue-600 hover:underline">Modifier</a>
                                    <a href="${ctx}/clients/delete?numtel=${c.numtel}"
                                       onclick="return confirm('Supprimer ce client ?')"
                                       class="text-red-500 hover:underline">Supprimer</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <div class="mt-4 text-right">
        <a href="${ctx}/index.jsp" class="text-sm text-gray-400 hover:text-gray-600">← Accueil</a>
    </div>
</div>
</body>
</html>