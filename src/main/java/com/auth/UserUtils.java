package com.auth;

import java.io.*;
import java.util.*;

public class UserUtils {

    // Validate user login credentials
    public static boolean validateUser(String email, String password, String filePath) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 3 && data[1].equals(email) && data[2].equals(password)) {
                    return true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Check if the user already exists in the file
    public static boolean userExists(String email, String filePath) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 2 && data[1].equals(email)) {
                    return true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Save a new user to the file
    public static void saveUser(String name, String email, String password, String filePath) {
        try (FileWriter writer = new FileWriter(filePath, true)) {
            // Writing the user's data to the file (comma-separated)
            writer.write(name + "," + email + "," + password + "\n"); // Adding a newline after the entry
            writer.flush(); // Ensure the data is written to the file
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public static String[] getUserDetails(String email, String filePath) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 6 && data[0].equals(email)) {
                    // Return the user details as an array
                    return data;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null; // Return null if user is not found
    }
    public static String getUsernameByEmail(String email, String filePath) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 2 && data[1].equals(email)) {
                    return data[0]; // return the username
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null; // return null if email not found
    }

    public static List<String[]> getBookings(String userEmail, String filePath) {
        List<String[]> userBookings = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", 7);  // Split into ID, Email, Lesson, Date, Time, Instructor, VehicleType

                // Ensure proper formatting and filter bookings by user email
                if (parts.length >= 7 && parts[1].trim().equalsIgnoreCase(userEmail)) {
                    String bookingId = parts[0];      // Booking ID
                    String lessonName = parts[2];     // Lesson Name
                    String date = parts[3];           // Date
                    String time = parts[4];           // Time
                    String instructor = parts[5];     // Instructor
                    String vehicleType = parts[6];    // Vehicle Type

                    userBookings.add(new String[]{bookingId, lessonName, date, time, instructor, vehicleType});
                }
            }
        } catch (IOException e) {
            e.printStackTrace();  // Log error if file reading fails
        }

        return userBookings;
    }

    /**
     * Gets all bookings from the file, sorts them by date using bubble sort,
     * and returns them as a queue.
     *
     * @param filePath Path to the bookings file
     * @return Queue containing sorted booking data
     */
    public static Queue<String[]> getBookings(String filePath) {
        // Use BookingSorter to get sorted bookings
        Queue<String[]> allBookings = BookingSorter.getSortedBookings();

        // Log for debugging
        System.out.println("All bookings: " + allBookings);
        return allBookings;
    }

    /**
     * Gets a specific booking by ID
     *
     * @param bookingId ID of the booking to retrieve
     * @return Booking data as a String array, or null if not found
     */
    public static String[] getBookingById(String bookingId) {
        String filePath = "C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\bookings.txt";
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 7 && parts[0].equals(bookingId)) {
                    String email = parts[1];
                    String name = parts[2];
                    String vehicle = parts[3];
                    String instructor = parts[4];
                    String date = parts[5];
                    String time = parts[6];
                    String flagged = parts.length >= 8 ? parts[7] : "0";

                    return new String[]{bookingId, email, name, vehicle, instructor, date, time, flagged};
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


}
