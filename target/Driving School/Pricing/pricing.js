const container = document.getElementById('container');
const registerBtn = document.getElementById('register');
const loginBtn = document.getElementById('login');
const toggleContainer = document.querySelector('.toggle-container');

// When "Go Back" is clicked (e.g., from Pricing to Login/SignUp)
registerBtn.addEventListener('click', () => {
    // Hide the pricing container with animation
    container.style.transform = 'translateX(-100%)'; // Slide out
    setTimeout(() => {
        // After slide-out, show login/register toggle container
        toggleContainer.classList.add('show');
        toggleContainer.style.opacity = 1;
        toggleContainer.style.transform = 'translateX(0)';
    }, 600); // Delay to match the slide transition
});

loginBtn.addEventListener('click', () => {
    // When 'Sign In' is clicked, hide the login/signup container and show pricing
    toggleContainer.style.transform = 'translateX(100%)';
    setTimeout(() => {
        toggleContainer.classList.remove('show');
        container.style.transform = 'translateX(0)';
    }, 600); // Match the time with the slide transition
});
