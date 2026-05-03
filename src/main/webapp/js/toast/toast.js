/**
 * Gestionnaire de notifications MoneyFlow
 */
document.addEventListener('DOMContentLoaded', function() {
    const toasts = document.querySelectorAll('.toast');

    toasts.forEach(toast => {
        // 1. On définit la durée de vie du message (4000ms = 4 secondes)
        const displayTime = 4000;

        // 2. Lancement du compte à rebours pour la disparition
        setTimeout(() => {
            dismissToast(toast);
        }, displayTime);
    });
});

/**
 * Fonction pour faire disparaître un toast avec animation
 */
function dismissToast(toast) {
    if (!toast) return;

    // Ajout des styles de transition via JS (si pas déjà dans le CSS)
    toast.style.transition = "all 0.6s cubic-bezier(0.22, 1, 0.36, 1)";
    toast.style.opacity = "0";
    toast.style.transform = "translateX(50px) scale(0.9)";
    toast.style.marginBottom = `-${toast.offsetHeight}px`;

    // Suppression physique de l'élément après l'animation
    setTimeout(() => {
        toast.remove();
        
        // Si le container est vide, on peut le masquer
        const container = document.getElementById('toast-container');
        if (container && container.children.length === 0) {
            // Optionnel : logique supplémentaire ici
        }
    }, 600);
}