package com.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class DeleteBookingServlet extends HttpServlet {
    private static final String BOOKINGS_FILE = "C:\\Users\\User\\Desktop\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\bookings.txt"; // Update the path

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("user");
        String bookingId = request.getParameter("bookingId"); // Get booking ID

        if (userEmail == null || bookingId == null) {
            response.sendRedirect("User%20Profile/userprofile.jsp?error=Invalid request");
            return;
        }

        List<String> updatedBookings = new ArrayList<>();
        boolean isDeleted = false;

        // Read and filter bookings
        try (BufferedReader reader = new BufferedReader(new FileReader(BOOKINGS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", 3); // Split into ID, Email, Lesson
                if (parts.length == 3 && parts[0].equals(bookingId)) {
                    isDeleted = true; // Mark as deleted
                    continue; // Skip this line (delete it)
                }
                updatedBookings.add(line); // Keep other bookings
            }
        }

        // Write back the updated list if something was deleted
        if (isDeleted) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(BOOKINGS_FILE))) {
                for (String booking : updatedBookings) {
                    writer.write(booking);
                    writer.newLine();
                }
            }
            response.sendRedirect("User%20Profile/userprofile.jsp?success=Lesson deleted");
        } else {
            response.sendRedirect("User%20Profile/userprofile.jsp?error=Booking not found");
        }
    }
}
