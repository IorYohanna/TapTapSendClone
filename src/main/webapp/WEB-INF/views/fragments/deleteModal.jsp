<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <div id="deleteModal" class="modal-backdrop hidden opacity-0 transition-opacity duration-300"
        style="z-index: 1000;">
        <div class="modal-panel max-w-sm transform scale-95 transition-transform duration-300">
            <section class="card text-center p-8">
                <div
                    class="w-16 h-16 bg-red-50 text-red-500 rounded-2xl flex items-center justify-center mx-auto mb-6 text-2xl">
                    ⚠️
                </div>

                <h2 class="font-display text-2xl text-ink mb-2">Confirmation</h2>
                <p id="deleteModalMessage" class="text-sm text-gray-500 mb-8 leading-relaxed">
                    Voulez-vous vraiment supprimer cet élément ? cette action est irréversible.
                </p>

                <div class="flex gap-3">
                    <button onclick="closeDeleteModal()" class="btn btn-ghost flex-1 justify-center">
                        Annuler
                    </button>
                    <a id="confirmDeleteBtn" href="#" class="btn btn-danger flex-1 justify-center">
                        Supprimer
                    </a>
                </div>
            </section>
        </div>
    </div>
    <script src="/src/main/webapp/WEB-INF/js/delete.js"></script>