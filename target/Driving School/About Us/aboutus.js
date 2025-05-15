// Wait for the DOM to fully load
document.addEventListener('DOMContentLoaded', function () {
    // Fade in the container
    const container = document.querySelector('.container');
    container.style.transition = 'opacity 2s ease';
    container.style.opacity = 1;

    // Fade in content sections sequentially
    const content = document.querySelector('.content');
    const ownerDetails = document.querySelector('.owner-details');

    setTimeout(function () {
        content.style.transition = 'opacity 2s ease';
        content.style.opacity = 1;
    }, 500); // Delay content fade in

    setTimeout(function () {
        ownerDetails.style.transition = 'opacity 2s ease';
        ownerDetails.style.opacity = 1;
    }, 1500); // Delay owner details fade in
});
