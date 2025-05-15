function enrollCourse(courseName) {
    alert("You have enrolled in the " + courseName + "/");
}

// Adding delay effect to each course card
document.addEventListener("DOMContentLoaded", function () {
    const cards = document.querySelectorAll(".course-card");
    cards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.2}s`;
    });
});
