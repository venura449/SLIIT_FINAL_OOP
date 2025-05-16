package com.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Servlet to handle inquiry form submissions
 */
public class InquiryServlet extends HttpServlet {
    private static final String INQUIRY_FILE = "C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\inquiry.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("InquiryServlet: doPost method called");

        // Set CORS headers for development
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setHeader("Access-Control-Max-Age", "86400");
        // Extract inquiry details from form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Debug log
        System.out.println("Received inquiry from: " + name);
        System.out.println("Email: " + email);
        System.out.println("Phone: " + phone);
        System.out.println("Subject: " + subject);
        System.out.println("Message: " + message);

        // Validate required fields
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Please fill in all required fields.\"}");
            return;
        }

        // Generate timestamp
        LocalDateTime now = LocalDateTime.now();
        String timestamp = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        // Format the inquiry entry
        String inquiryEntry = timestamp + "," +
                              name + "," +
                              email + "," +
                              (phone != null ? phone : "N/A") + "," +
                              (subject != null ? subject : "General Inquiry") + "," +
                              message.replace(",", ";;").replace("\n", " ");

        // Write the inquiry to the file
        try {
            // Get the absolute path for debugging
            String contextPath = getServletContext().getRealPath("/");
            System.out.println("Context Path: " + contextPath);

            // Try to use a more reliable path
            String filePath = "C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\inquiry.txt";
            System.out.println("Attempting to write to: " + filePath);

            // Create the file if it doesn't exist
            File file = new File(filePath);
            if (!file.exists()) {
                System.out.println("File doesn't exist, creating new file");
                file.createNewFile();
            }

            // Append the inquiry to the file
            try (FileWriter writer = new FileWriter(filePath, true)) {
                writer.write(inquiryEntry + "\n");
                writer.flush();
                System.out.println("Successfully wrote to file: " + filePath);
            }

            // Check if this is an AJAX request or a regular form submission
            String requestedWith = request.getHeader("X-Requested-With");
            boolean isAjax = "XMLHttpRequest".equals(requestedWith);

            System.out.println("Is AJAX request: " + isAjax);

            if (isAjax) {
                // Return JSON response for AJAX requests
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Your inquiry has been submitted successfully!\"}");
                System.out.println("Sent JSON success response to client");
            } else {
                // Redirect to success page for regular form submissions
                response.sendRedirect(request.getContextPath() + "/inquiry-success.jsp");
                System.out.println("Redirected to success page");
            }
        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
            e.printStackTrace();

            // Check if this is an AJAX request or a regular form submission
            String requestedWith = request.getHeader("X-Requested-With");
            boolean isAjax = "XMLHttpRequest".equals(requestedWith);

            if (isAjax) {
                // Return JSON error response for AJAX requests
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"An error occurred while submitting your inquiry. Please try again later.\"}");
                System.out.println("Sent JSON error response to client");
            } else {
                // For regular form submissions, still try to save the data to a different location
                try {
                    // Try to write to a file in the user's home directory
                    String userHome = System.getProperty("user.home");
                    String backupPath = userHome + "/inquiry_backup.txt";
                    System.out.println("Attempting to write to backup location: " + backupPath);

                    try (FileWriter writer = new FileWriter(backupPath, true)) {
                        writer.write(inquiryEntry + "\n");
                        writer.flush();
                        System.out.println("Successfully wrote to backup file: " + backupPath);

                        // Redirect to success page
                        response.sendRedirect(request.getContextPath() + "/inquiry-success.jsp");
                        return;
                    }
                } catch (Exception ex) {
                    System.out.println("Error writing to backup file: " + ex.getMessage());
                    ex.printStackTrace();
                }

                // If we get here, both attempts failed, show an error page
                request.setAttribute("errorMessage", "An error occurred while submitting your inquiry. Please try again later.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        }
    }
}
