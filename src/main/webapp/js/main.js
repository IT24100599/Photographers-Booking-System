document.addEventListener('DOMContentLoaded', function() {

    // Password visibility toggle
    const passwordField = document.getElementById('password');
    const showPasswordToggle = document.getElementById('show-password');

    if (passwordField && showPasswordToggle) {
        showPasswordToggle.addEventListener('click', function() {
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                this.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                passwordField.type = 'password';
                this.classList.replace('fa-eye-slash', 'fa-eye');
            }
            // Force redraw to prevent rendering glitches
            passwordField.style.display = 'none';
            passwordField.offsetHeight; // Trigger reflow
            passwordField.style.display = 'block';
        });
    }

    document.querySelector('form').onsubmit = function (e) {
        const password = document.getElementById('password-input').value;
        const confirmPassword = document.getElementById('confirm-password-input').value;
        const passwordError = document.getElementById('password-error');

        if (password !== confirmPassword) {
            passwordError.style.display = 'block';
            e.preventDefault();
            return false;
        } else {
            passwordError.style.display = 'none';
            return true;
        }
    };

    // Real-time validation
    document.getElementById('confirm-password-input').addEventListener('input', function () {
        const password = document.getElementById('password-input').value;
        const confirmPassword = this.value;
        const passwordError = document.getElementById('password-error');

        if (confirmPassword && password !== confirmPassword) {
            passwordError.style.display = 'block';
        } else {
            passwordError.style.display = 'none';
        }
    });
});