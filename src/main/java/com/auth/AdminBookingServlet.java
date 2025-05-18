package com.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.util.*;

/**
 * Servlet for handling admin operations on bookings (edit, delete, flag)
 */
public class AdminBookingServlet extends HttpServlet {
    private static final String BOOKINGS_FILE = "C:\\Users\\User\\Desktop\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\bookings.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String bookingId = request.getParameter("bookingId");

        if ("getBooking".equals(action) && bookingId != null) {
            getBookingDetails(bookingId, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request parameters");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String bookingId = request.getParameter("bookingId");

        if (bookingId == null || action == null) {
            response.sendRedirect("Home%20page/AdminDash.jsp?error=Invalid request");
            return;
        }

        switch (action) {
            case "delete":
                deleteBooking(bookingId, response);
                break;
            case "edit":
                editBooking(request, response);
                break;
            case "flag":
                toggleFlag(bookingId, response);
                break;
            default:
                response.sendRedirect("Home%20page/AdminDash.jsp?error=Invalid action");
        }
    }

    /**
     * Get booking details and return as JSON
     */
    private void getBookingDetails(String bookingId, HttpServletResponse response) throws IOException {
        String[] booking = UserUtils.getBookingById(bookingId);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (booking != null) {
            // Create JSON response
            String json = "{" +
                "\"bookingId\":\"" + booking[0] + "\"," +
                "\"email\":\"" + booking[1] + "\"," +
                "\"name\":\"" + booking[2] + "\"," +
                "\"vehicle\":\"" + booking[3] + "\"," +
                "\"instructor\":\"" + booking[4] + "\"," +
                "\"date\":\"" + booking[5] + "\"," +
                "\"time\":\"" + booking[6] + "\"," +
                "\"flagged\":\"" + (booking.length >= 8 ? booking[7] : "0") + "\"" +
                "}";

            response.getWriter().write(json);
        } else {
            // Return empty object if booking not found
            response.getWriter().write("{}");
        }
    }

    /**
     * Delete a booking by ID
     */
    private void deleteBooking(String bookingId, HttpServletResponse response) throws IOException {
        List<String> updatedBookings = new ArrayList<>();
        boolean isDeleted = false;

        // Read and filter bookings
        try (BufferedReader reader = new BufferedReader(new FileReader(BOOKINGS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 1 && parts[0].equals(bookingId)) {
                    isDeleted = true; // Mark as deleted
                    continue; // Skip this line (delete it)
                }
                updatedBookings.add(line); // Keep other bookings
            }
        }

        // Write back the updated list if something was deleted
        if (isDeleted) {
            writeBookingsToFile(updatedBookings);
            // Update sorted file
            sortBookings();
            response.sendRedirect("Home%20page/AdminDash.jsp?success=Booking deleted");
        } else {
            response.sendRedirect("Home%20page/AdminDash.jsp?error=Booking not found");
        }
    }

    /**
     * Edit a booking's details
     */
    private void editBooking(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String bookingId = request.getParameter("bookingId");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String vehicle = request.getParameter("vehicle");
        String instructor = request.getParameter("instructor");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String flagged = request.getParameter("flagged") != null ? "1" : "0"; // 1 for flagged, 0 for not flagged

        List<String> updatedBookings = new ArrayList<>();
        boolean isUpdated = false;

        // Read and update bookings
        try (BufferedReader reader = new BufferedReader(new FileReader(BOOKINGS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 1 && parts[0].equals(bookingId)) {
                    // Create updated booking entry
                    String updatedEntry = bookingId + "," + email + "," + name + "," + vehicle + "," +
                                         instructor + "," + date + "," + time + "," + flagged;
                    updatedBookings.add(updatedEntry);
                    isUpdated = true;
                } else {
                    updatedBookings.add(line); // Keep other bookings unchanged
                }
            }
        }

        // Write back the updated list if something was updated
        if (isUpdated) {
            writeBookingsToFile(updatedBookings);
            // Update sorted file
            sortBookings();
            response.sendRedirect("Home%20page/AdminDash.jsp?success=Booking updated");
        } else {
            // If booking not found, add it as a new booking
            String newEntry = bookingId + "," + email + "," + name + "," + vehicle + "," +
                             instructor + "," + date + "," + time + "," + flagged;
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(BOOKINGS_FILE, true))) {
                writer.write(newEntry);
                writer.newLine();
            }
            sortBookings();
            response.sendRedirect("Home%20page/AdminDash.jsp?success=New booking added");
        }
    }

    /**
     * Toggle the flag status of a booking
     */
    private void toggleFlag(String bookingId, HttpServletResponse response) throws IOException {
        List<String> updatedBookings = new ArrayList<>();
        boolean isUpdated = false;

        // Read and update bookings
        try (BufferedReader reader = new BufferedReader(new FileReader(BOOKINGS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 1 && parts[0].equals(bookingId)) {
                    // Check if the booking has a flag field
                    String flagged = "1"; // Default to flagged
                    if (parts.length >= 8) {
                        // Toggle the existing flag (0 -> 1, 1 -> 0)
                        flagged = parts[7].equals("1") ? "0" : "1";
                    }

                    // Reconstruct the booking with the updated flag
                    StringBuilder updatedEntry = new StringBuilder();
                    for (int i = 0; i < parts.length; i++) {
                        if (i > 0) updatedEntry.append(",");
                        if (i == 7 && parts.length >= 8) {
                            updatedEntry.append(flagged);
                        } else if (i < 7) {
                            updatedEntry.append(parts[i]);
                        }
                    }

                    // If the original entry didn't have a flag field, add it
                    if (parts.length < 8) {
                        updatedEntry.append(",").append(flagged);
                    }

                    updatedBookings.add(updatedEntry.toString());
                    isUpdated = true;
                } else {
                    updatedBookings.add(line); // Keep other bookings unchanged
                }
            }
        }

        // Write back the updated list if something was updated
        if (isUpdated) {
            writeBookingsToFile(updatedBookings);
            // Update sorted file
            sortBookings();
            response.sendRedirect("Home%20page/AdminDash.jsp?success=Flag status updated");
        } else {
            response.sendRedirect("Home%20page/AdminDash.jsp?error=Booking not found");
        }
    }

    /**
     * Write bookings to the bookings file
     */
    private void writeBookingsToFile(List<String> bookings) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(BOOKINGS_FILE))) {
            for (String booking : bookings) {
                writer.write(booking);
                writer.newLine();
            }
        }
    }

    /**
     * Sort bookings and write to sorted_bookings.txt
     */
    private void sortBookings() {
        // Use BookingSorter to sort the bookings
        BookingSorter.getSortedBookings();
    }
}
