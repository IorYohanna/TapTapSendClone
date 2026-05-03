function filterFees() {
    const query = document.getElementById('feeSearch').value.toLowerCase();
    const rows = document.querySelectorAll('#feeTableBody tr');
    rows.forEach(row => {
        row.style.display = row.innerText.toLowerCase().includes(query) ? "" : "none";
    });
}