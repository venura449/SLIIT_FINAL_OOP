package com.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.*;

public class BookingServlet extends HttpServlet {
    private static final String BOOKINGS_FILE = "C:\\Users\\User\\Desktop\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\bookings.txt";
    private static final String SORTED_FILE = "C:\\Users\\User\\Desktop\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\sorted_bookings.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Extract booking details from form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String instructor = request.getParameter("instructor");
        String vehicle = request.getParameter("vehicle");

        // Generate a unique booking ID
        String bookingId = generateBookingId();

        // Format the booking entry
        String bookingEntry = bookingId + "," + email + "," + name + "," + vehicle + "," + instructor + "," + date + "," + time;

        // Write the booking to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(BOOKINGS_FILE, true))) {
            writer.write(bookingEntry);
            writer.newLine();
        }

        // 🔹 Automatically sort bookings after adding a new one
        sortBookings();

        // Redirect to the confirmation page
        response.sendRedirect("Booking%20Page/bookingpage.jsp?success=Booking confirmed for " + name);
    }

    private String generateBookingId() {
        // Read the file to get the last booking ID
        String lastBookingId = "0";  // Default if file is empty
        try (BufferedReader reader = new BufferedReader(new FileReader(BOOKINGS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", 7);
                if (parts.length > 0) {
                    lastBookingId = parts[0]; // Get the latest booking ID
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Increment the last booking ID
        try {
            long newBookingId = Long.parseLong(lastBookingId) + 1;
            return String.valueOf(newBookingId);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return "1";  // Fallback if ID is invalid
        }
    }

    private void sortBookings() {
        List<String[]> bookings = new ArrayList<>();

        // Read all bookings from file
        try (BufferedReader reader = new BufferedReader(new FileReader(BOOKINGS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                bookings.add(line.split(","));
            }
        } catch (IOException e) {
            System.out.println("Error reading bookings file: " + e.getMessage());
            return;
        }

        // Sort using Bubble Sort (by date & time)
        bubbleSort(bookings);

        // Write sorted bookings to the sorted file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(SORTED_FILE))) {
            for (String[] booking : bookings) {
                writer.write(String.join(",", booking));
                writer.newLine();
            }
            System.out.println("Bookings sorted and saved to " + SORTED_FILE);
        } catch (IOException e) {
            System.out.println("Error writing sorted bookings file: " + e.getMessage());
        }
    }

    private void bubbleSort(List<String[]> arr) {
        int n = arr.size();
        boolean swapped;

        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - i - 1; j++) {
                if (compareDateTime(arr.get(j), arr.get(j + 1)) > 0) {
                    // Swap if current booking is later than next
                    Collections.swap(arr, j, j + 1);
                    swapped = true;
                }
            }
            if (!swapped) break; // Stop if already sorted
        }
    }

    private int compareDateTime(String[] a, String[] b) {
        // Convert date and time into a single comparable string
        String dateTimeA = a[5] + " " + a[6]; // Date + Time
        String dateTimeB = b[5] + " " + b[6];

        return dateTimeA.compareTo(dateTimeB);
    }
}
