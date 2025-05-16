function enrollCourse(courseName) {
    const button = event.target;
    button.innerText = "Enrolled!";
    button.style.backgroundColor = "#28a745";
    button.style.transform = "scale(1.1)";
    setTimeout(() => {
        button.style.transform = "scale(1)";
    }, 300);
    alert("You have enrolled in the " + courseName + "!");
}

// Adding delay effect to each course card
document.addEventListener("DOMContentLoaded", function () {
    const cards = document.querySelectorAll(".course-card");
    cards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.2}s`;
        card.addEventListener("mouseenter", () => {
            card.style.transition = "transform 0.3s ease, box-shadow 0.3s ease";
            card.style.transform = "translateY(-10px) scale(1.05)";
            card.style.boxShadow = "0 8px 20px rgba(0, 0, 0, 0.2)";
        });
        card.addEventListener("mouseleave", () => {
            card.style.transform = "translateY(0) scale(1)";
            card.style.boxShadow = "0 4px 10px rgba(0, 0, 0, 0.1)";
        });
    });

    // Adding smooth appearance effect
    setTimeout(() => {
        cards.forEach(card => {
            card.style.opacity = "1";
            card.style.transform = "translateY(0)";
        });
    }, 200);
});
