document.addEventListener("DOMContentLoaded", function () {
    // Testimonial slider functionality
    const testimonials = document.querySelectorAll(".testimonial-card");
    const prevBtn = document.querySelector(".prev-btn");
    const nextBtn = document.querySelector(".next-btn");
    let index = 0;

    function showTestimonial(i) {
        testimonials.forEach((testimonial, idx) => {
            testimonial.classList.remove("active");
            if (idx === i) {
                testimonial.classList.add("active");
            }
        });
    }

    prevBtn.addEventListener("click", function () {
        index = (index === 0) ? testimonials.length - 1 : index - 1;
        showTestimonial(index);
    });

    nextBtn.addEventListener("click", function () {
        index = (index === testimonials.length - 1) ? 0 : index + 1;
        showTestimonial(index);
    });

    showTestimonial(index);

    // Intersection Observer for scroll animations
    const observerOptions = {
        root: null,
        threshold: 0.2,
    };

    function handleIntersection(entries, observer) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = 1;
                entry.target.style.transform = "translateX(0)";
                observer.unobserve(entry.target);
            }
        });
    }

    const observer = new IntersectionObserver(handleIntersection, observerOptions);

    // Observe elements for scrolling animations
    document.querySelectorAll(".courses, .instructor-info").forEach(section => {
        observer.observe(section);
    });

    document.querySelectorAll(".course-card").forEach((card, i) => {
        setTimeout(() => {
            observer.observe(card);
        }, i * 300);
    });

    // Inquiry Form Functionality
    const inquiryBtn = document.getElementById("inquiryBtn");
    const inquiryOverlay = document.getElementById("inquiryOverlay");
    const closeInquiry = document.getElementById("closeInquiry");
    const inquiryForm = document.getElementById("inquiryForm");
    const formMessage = document.getElementById("formMessage");

    // Open inquiry form
    inquiryBtn.addEventListener("click", function() {
        inquiryOverlay.classList.add("active");
        document.body.style.overflow = "hidden"; // Prevent scrolling when overlay is open
    });

    // Close inquiry form
    closeInquiry.addEventListener("click", function() {
        inquiryOverlay.classList.remove("active");
        document.body.style.overflow = ""; // Re-enable scrolling
    });

    // Close overlay when clicking outside the form
    inquiryOverlay.addEventListener("click", function(e) {
        if (e.target === inquiryOverlay) {
            inquiryOverlay.classList.remove("active");
            document.body.style.overflow = ""; // Re-enable scrolling
        }
    });

    // Handle form submission
    inquiryForm.addEventListener("submit", function(e) {
        // Don't prevent default - allow form to submit normally if fetch fails
        // This provides a fallback method

        // Show loading state
        const submitBtn = inquiryForm.querySelector(".submit-btn");
        submitBtn.textContent = "Submitting...";
        submitBtn.disabled = true;

        console.log("Form submitted, attempting to send via fetch API");

        // Try to submit via fetch first
        try {
            // Get form data
            const formData = new FormData(inquiryForm);

            // Send form data to server
            fetch("../inquiry", {
                method: "POST",
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: formData
            })
            .then(response => {
                console.log("Response received:", response);
                return response.json();
            })
            .then(data => {
                console.log("Data received:", data);

                // Reset button
                submitBtn.textContent = "Submit Inquiry";
                submitBtn.disabled = false;

                // Show message
                formMessage.textContent = data.message;
                formMessage.className = "form-message " + (data.success ? "success" : "error");
                formMessage.style.display = "block";

                // If successful, reset form
                if (data.success) {
                    inquiryForm.reset();

                    // Close overlay after 3 seconds
                    setTimeout(() => {
                        inquiryOverlay.classList.remove("active");
                        document.body.style.overflow = ""; // Re-enable scrolling
                        formMessage.style.display = "none";
                    }, 3000);
                }

                // Prevent the default form submission since we handled it via fetch
                e.preventDefault();
            })
            .catch(error => {
                console.error("Error in fetch:", error);
                // Let the form submit normally as fallback
                console.log("Falling back to normal form submission");
                return true; // Allow form to submit normally
            });
        } catch (error) {
            console.error("Error in try/catch:", error);
            // Let the form submit normally as fallback
            console.log("Falling back to normal form submission due to exception");
            return true; // Allow form to submit normally
        }
    });
});
