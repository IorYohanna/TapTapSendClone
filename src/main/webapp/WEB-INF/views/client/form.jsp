<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <c:set var="ctx" value="${pageContext.request.contextPath}" />
        <div class="modal-backdrop">
            <div class="modal-panel">
                <section class="card relative">
                    <a href="${ctx}/clients/list"
                        class="absolute top-6 right-6 text-gray-400 hover:text-black text-2xl no-underline">&times;</a>

                    <div class="mb-8">
                        <div class="text-[10px] uppercase tracking-[0.2em] text-gray-400 font-bold">
                            ${empty client.numtel ? 'Création' : 'Modification'}
                        </div>
                        <h1 class="font-display text-3xl text-[#0B0B0B] font-black">
                            ${empty client.numtel ? 'Ajouter un client' : 'Éditer le profil'}
                        </h1>
                    </div>

                    <form method="post" action="${ctx}/clients/save" class="space-y-5">
                        <input type="hidden" name="action" value="${empty client.numtel ? 'ajouter' : 'modifier'}" />

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="label">Numéro de téléphone</label>
                                <input type="text" name="numtel" value="${client.numtel}" ${not empty client.numtel
                                    ? 'readonly' : '' } required placeholder="03XXXXXXXX"
                                    class="input ${not empty client.numtel ? 'bg-gray-100 text-gray-400' : ''}" />
                            </div>
                            <div>
                                <label class="label">Sexe</label>
                                <select name="sexe" class="select">
                                    <option value="M" ${client.sexe=='M' ? 'selected' : '' }>Masculin</option>
                                    <option value="F" ${client.sexe=='F' ? 'selected' : '' }>Féminin</option>
                                </select>
                            </div>
                        </div>

                        <div>
                            <label class="label">Nom complet</label>
                            <input type="text" name="nom" value="${client.nom}" required class="input" />
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="label">Pays</label>
                                <input type="text" name="pays" value="${client.pays}" required class="input" />
                            </div>
                            <div>
                                <label class="label">Solde</label>
                                <input type="number" name="solde" value="${client.solde}" required class="input" />
                            </div>
                        </div>

                        <div class="flex items-center justify-between pt-6">
                            <a href="${ctx}/clients/list"
                                class="text-gray-400 hover:text-black font-bold text-sm no-underline">
                                Annuler
                            </a>
                            <button type="submit" class="btn btn-accent">
                                ${empty client.numtel ? 'Créer le compte' : 'Enregistrer'}
                            </button>
                        </div>
                    </form>
                </section>
            </div>
        </div>