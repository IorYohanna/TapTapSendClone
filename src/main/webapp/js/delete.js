function openDeleteModal(url, message) {
    const modal = document.getElementById('deleteModal');
    const confirmBtn = document.getElementById('confirmDeleteBtn');
    const msgElement = document.getElementById('deleteModalMessage');

    if (message) {
        msgElement.textContent = message;
    } else {
        msgElement.textContent = "Voulez-vous vraiment supprimer cet élément ? Cette action est irréversible.";
    }

    confirmBtn.href = url;

    modal.classList.remove('hidden');
    setTimeout(() => {
        modal.classList.remove('opacity-0');
        modal.querySelector('.modal-panel').classList.remove('scale-95');
    }, 10);
}


function closeDeleteModal() {
    const modal = document.getElementById('deleteModal');
    modal.classList.add('opacity-0');
    modal.querySelector('.modal-panel').classList.add('scale-95');

    setTimeout(() => {
        modal.classList.add('hidden');
    }, 300);
}

window.onclick = function (event) {
    const modal = document.getElementById('deleteModal');
    if (event.target == modal) {
        closeDeleteModal();
    }
}