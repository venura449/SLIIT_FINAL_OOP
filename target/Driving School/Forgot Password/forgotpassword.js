document.addEventListener("DOMContentLoaded", function () {
    const forgotPasswordForm = document.getElementById("forgotPasswordForm");

    forgotPasswordForm.addEventListener("submit", function (event) {
        event.preventDefault();

        const email = document.getElementById("email").value;

        if (email) {
            forgotPasswordForm.reset();
        } else {
            alert("Please enter a valid email address.");
        }
    });
});
