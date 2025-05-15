package com.auth;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

public class AppointmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filePath = getServletContext().getRealPath("C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\sorted_bookings.txt");

        // Get all bookings (no email filtering)
        Queue<String[]> allBookings = getBookings(filePath);

        // Set the bookings as an attribute for JSP access
        request.setAttribute("appointments", allBookings);

        // Forward the request to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/dashboard.jsp");
        dispatcher.forward(request, response);
    }

    // Fetch all bookings and return them as a Queue
    public static Queue<String[]> getBookings(String filePath) {
        Queue<String[]> allBookings = new LinkedList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", 7);

                // Ensure proper formatting before adding the booking to the queue
                if (parts.length >= 7) {
                    String bookingId = parts[0];      // Booking ID
                    String lessonName = parts[2];     // Lesson Name
                    String date = parts[5];           // Date
                    String time = parts[6];           // Time
                    String instructor = parts[4];     // Instructor
                    String vehicleType = parts[3];    // Vehicle Type

                    // Add appointment data to the queue
                    allBookings.add(new String[]{bookingId, lessonName, date, time, instructor, vehicleType});
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return allBookings;
    }
}
