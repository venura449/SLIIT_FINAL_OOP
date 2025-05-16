// Profile Picture Upload with Smooth Preview Effect
document.getElementById('uploadPic').addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            let profileImage = document.getElementById('profileImage');
            profileImage.style.opacity = "0"; // Fade-out effect
            setTimeout(() => {
                profileImage.src = e.target.result;
                profileImage.style.opacity = "1"; // Fade-in effect
            }, 300);
        }
        reader.readAsDataURL(file);
    }
});

// Delete Booked Lessons with a Fade-Out Effect
document.querySelectorAll('.delete-btn').forEach(button => {
    button.addEventListener('click', function() {
        let lessonItem = this.parentElement;
        lessonItem.style.transition = "opacity 0.5s ease, transform 0.5s ease";
        lessonItem.style.opacity = "0";
        lessonItem.style.transform = "translateX(-50px)";
        setTimeout(() => {
            lessonItem.remove();
        }, 500);
    });
});

// Smooth Hover Effect on Booked Lessons
document.querySelectorAll('.lessons-container li').forEach(item => {
    item.addEventListener('mouseenter', () => {
        item.style.backgroundColor = "#f8f9fa";
        item.style.transform = "scale(1.03)";
    });

    item.addEventListener('mouseleave', () => {
        item.style.backgroundColor = "white";
        item.style.transform = "scale(1)";
    });
});

// Profile Container Animation on Load
document.addEventListener("DOMContentLoaded", () => {
    let profileContainer = document.querySelector(".profile-container");
    profileContainer.style.opacity = "0";
    profileContainer.style.transform = "translateY(-30px)";
    
    setTimeout(() => {
        profileContainer.style.transition = "opacity 0.7s ease, transform 0.7s ease";
        profileContainer.style.opacity = "1";
        profileContainer.style.transform = "translateY(0)";
    }, 200);
});
