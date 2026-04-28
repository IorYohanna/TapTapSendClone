<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>${empty client ? 'Nouveau client' : 'Modifier'} - TapTapSend</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 flex items-center justify-center min-h-screen p-6">
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="bg-white shadow-md rounded-lg p-8 w-full max-w-lg">
    <h2 class="text-xl font-bold text-blue-600 mb-6">
        ${empty client ? 'Ajouter un client' : 'Modifier le client'}
    </h2>

    <c:if test="${not empty error}">
        <div class="bg-red-100 text-red-700 border border-red-300 rounded px-4 py-2 mb-4 text-sm">
            ${error}
        </div>
    </c:if>

    <form method="post" action="${ctx}/clients/save" class="space-y-4">
        <input type="hidden" name="action" value="${empty client ? 'ajouter' : 'modifier'}"/>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Numéro de téléphone</label>
            <input type="text" name="numtel" value="${client.numtel}"
                   ${not empty client ? 'readonly' : ''}
                   required placeholder="ex: 0321234567"
                   class="w-full border rounded px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-300
                          ${not empty client ? 'bg-gray-100' : ''}"/>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Nom complet</label>
            <input type="text" name="nom" value="${client.nom}" required placeholder="ex: Rakoto Bernard"
                   class="w-full border rounded px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-300"/>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Sexe</label>
            <select name="sexe" class="w-full border rounded px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-300">
                <option value="M" ${client.sexe == 'M' ? 'selected' : ''}>Masculin</option>
                <option value="F" ${client.sexe == 'F' ? 'selected' : ''}>Féminin</option>
            </select>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Pays</label>
            <input type="text" name="pays" value="${client.pays}" required placeholder="ex: France"
                   class="w-full border rounded px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-300"/>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Solde (€)</label>
            <input type="number" name="solde" value="${client.solde}" required min="0"
                   class="w-full border rounded px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-300"/>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
            <input type="email" name="email" value="${client.email}" required placeholder="ex: rakoto@mail.com"
                   class="w-full border rounded px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-300"/>
        </div>

        <div class="flex justify-between pt-2">
            <a href="${ctx}/clients/list"
               class="text-gray-500 hover:text-gray-700 text-sm py-2">← Retour</a>
            <button type="submit"
                    class="bg-blue-500 hover:bg-blue-600 text-white px-6 py-2 rounded shadow text-sm">
                ${empty client ? 'Ajouter' : 'Enregistrer'}
            </button>
        </div>
    </form>
</div>
</body>
</html>