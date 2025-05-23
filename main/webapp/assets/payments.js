document.addEventListener('DOMContentLoaded', function() {
    // Initialize the payments dashboard
    initPaymentDashboard();
    
    // Add event listeners
    addEventListeners();
});

function initPaymentDashboard() {
    // You could fetch payment data from an API here
    console.log('Payment dashboard initialized');
    
    // For demonstration, we'll use the hardcoded data in the HTML
    // But in a real application, you would fetch this data from a backend
    
    // Example of how you might update payment stats dynamically:
    /* 
    fetch('/api/payments/stats')
        .then(response => response.json())
        .then(data => {
            document.querySelector('.stat-card:nth-child(1) .stat-value').textContent = data.paidCount;
            document.querySelector('.stat-card:nth-child(2) .stat-value').textContent = data.pendingCount;
            document.querySelector('.stat-card:nth-child(3) .stat-value').textContent = '$' + data.totalSpent;
        });
    */
}

function addEventListeners() {
    // View all payments button
    const viewAllBtn = document.querySelector('.view-all-btn');
    if (viewAllBtn) {
        viewAllBtn.addEventListener('click', function() {
            alert('This would navigate to a full payment history page.');
            // In a real application:
            // window.location.href = 'payment-history.html';
        });
    }
    
    // Add payment method button
    const addPaymentBtn = document.querySelector('.add-payment-btn');
    if (addPaymentBtn) {
        addPaymentBtn.addEventListener('click', function() {
            showAddPaymentModal();
        });
    }
    
    // Edit card buttons
    const editCardBtns = document.querySelectorAll('.edit-card');
    editCardBtns.forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.stopPropagation();
            const cardElement = this.closest('.payment-card');
            editPaymentCard(cardElement);
        });
    });
    
    // Delete card buttons
    const deleteCardBtns = document.querySelectorAll('.delete-card');
    deleteCardBtns.forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.stopPropagation();
            const cardElement = this.closest('.payment-card');
            deletePaymentCard(cardElement);
        });
    });
}

function showAddPaymentModal() {
    // In a real application, you would display a modal for adding a new payment method
    alert('This would show a form to add a new payment method.');
    
    /* Example of a modal implementation:
    const modal = document.createElement('div');
    modal.className = 'payment-modal';
    modal.innerHTML = `
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Add Payment Method</h2>
            <form id="payment-form">
                <div class="form-group">
                    <label for="card-number">Card Number</label>
                    <input type="text" id="card-number" placeholder="1234 5678 9012 3456" required>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="expiry-date">Expiry Date</label>
                        <input type="text" id="expiry-date" placeholder="MM/YY" required>
                    </div>
                    <div class="form-group">
                        <label for="cvv">CVV</label>
                        <input type="text" id="cvv" placeholder="123" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="card-name">Name on Card</label>
                    <input type="text" id="card-name" required>
                </div>
                <button type="submit" class="submit-btn">Add Card</button>
            </form>
        </div>
    `;
    document.body.appendChild(modal);
    
    // Close the modal when clicking the X
    modal.querySelector('.close').addEventListener('click', function() {
        document.body.removeChild(modal);
    });
    
    // Handle form submission
    modal.querySelector('#payment-form').addEventListener('submit', function(e) {
        e.preventDefault();
        // Process the form data, typically sending to a backend
        document.body.removeChild(modal);
    });
    */
}

function editPaymentCard(cardElement) {
    // In a real application, you would populate a form with the card details
    const cardNumber = cardElement.querySelector('.card-number').textContent;
    alert(`This would open a form to edit card: ${cardNumber}`);
}

function deletePaymentCard(cardElement) {
    // Confirm deletion
    if (confirm('Are you sure you want to delete this payment method?')) {
        // In a real application, you would send a request to delete the card
        // For demo purposes, we'll just remove it from the DOM
        cardElement.remove();
    }
}
