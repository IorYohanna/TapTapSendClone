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