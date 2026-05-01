<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <title>${empty client ? 'Nouveau client' : 'Modifier'} - TapTapSend</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
        </head>

        <body class="bg-gray-50 min-h-screen flex items-center justify-center p-6">
            <c:set var="ctx" value="${pageContext.request.contextPath}" />

            <div class="w-full max-w-xl">
                <section class="card">
                    <div class="mb-8">
                        <div class="text-sm text-ink/50 tracking-wide uppercase">
                            ${empty client ? 'Création' : 'Modification'}
                        </div>
                        <h1 class="font-display text-3xl text-ink">
                            ${empty client ? 'Ajouter un client' : 'Editer le profil'}
                        </h1>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="bg-red-50 text-red-600 p-4 rounded-2xl mb-6 text-sm border border-red-100">
                            ${error}
                        </div>
                    </c:if>

                    <form method="post" action="${ctx}/clients/save" class="space-y-5">
                        <input type="hidden" name="action" value="${empty client ? 'ajouter' : 'modifier'}" />

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="md:col-span-1">
                                <label>Numéro de téléphone</label>
                                <input type="text" name="numtel" value="${client.numtel}" ${not empty client
                                    ? 'readonly' : '' } required placeholder="03XXXXXXXX"
                                    class="input ${not empty client ? 'bg-gray-50 text-gray-400' : ''}" />
                            </div>
                            <div class="md:col-span-1">
                                <label>Sexe</label>
                                <select name="sexe" class="input appearance-none">
                                    <option value="M" ${client.sexe=='M' ? 'selected' : '' }>Masculin</option>
                                    <option value="F" ${client.sexe=='F' ? 'selected' : '' }>Féminin</option>
                                </select>
                            </div>
                        </div>

                        <div>
                            <label>Nom complet</label>
                            <input type="text" name="nom" value="${client.nom}" required placeholder="ex: Jean Dupont"
                                class="input" />
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label>Pays</label>
                                <input type="text" name="pays" value="${client.pays}" required
                                    placeholder="ex: Madagascar" class="input" />
                            </div>
                            <div>
                                <label>Solde initial (€)</label>
                                <input type="number" name="solde" value="${client.solde}" required min="0"
                                    class="input" />
                            </div>
                        </div>

                        <div>
                            <label>Adresse Email</label>
                            <input type="email" name="email" value="${client.email}" required
                                placeholder="email@exemple.com" class="input" />
                        </div>

                        <div class="flex items-center justify-between pt-6">
                            <a href="${ctx}/clients/list" class="text-ink/40 hover:text-ink font-medium text-sm">
                                Annuler
                            </a>
                            <button type="submit" class="btn btn-accent shadow-lg shadow-blue-200">
                                ${empty client ? 'Créer le compte' : 'Enregistrer les modifications'}
                            </button>
                        </div>
                    </form>
                </section>
            </div>
        </body>

        </html>