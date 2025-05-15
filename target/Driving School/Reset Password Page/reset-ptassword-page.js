document.addEventListener("DOMContentLoaded", function () {
    const resetPasswordForm = document.getElementById("resetPasswordForm");

    resetPasswordForm.addEventListener("submit", function (event) {
        event.preventDefault();

        const newPassword = document.getElementById("new-password").value;
        const confirmPassword = document.getElementById("confirm-password").value;

        if (newPassword.length < 6) {
            alert("Password must be at least 6 characters long.");
            return;
        }

        if (newPassword !== confirmPassword) {
            alert("Passwords do not match. Please try again.");
            return;
        }

        alert("Your password has been reset successfully!");
        resetPasswordForm.reset();
    });
});

/* Toggle Password Visibility */
function togglePassword(id) {
    const passwordField = document.getElementById(id);
    if (passwordField.type === "password") {
        passwordField.type = "text";
    } else {
        passwordField.type = "password";
    }
}
