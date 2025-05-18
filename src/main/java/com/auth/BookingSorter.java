package com.auth;

import java.io.*;
import java.util.*;

/**
 * Utility class for sorting bookings by date and time using bubble sort algorithm
 * and storing them in a queue for efficient retrieval.
 */
public class BookingSorter {
    private static final String BOOKINGS_FILE = "C:\\Users\\User\\Desktop\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\bookings.txt";
    private static final String SORTED_FILE = "C:\\Users\\User\\Desktop\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\sorted_bookings.txt";

    /**
     * Reads bookings from the file, sorts them by date and time using bubble sort,
     * and returns them as a queue.
     *
     * @return Queue containing sorted booking data
     */
    public static Queue<String[]> getSortedBookings() {
        // Read all bookings from file
        List<String[]> bookings = readBookingsFromFile();

        // Sort using Bubble Sort (by date & time)
        bubbleSort(bookings);

        // Write sorted bookings to the sorted file
        writeSortedBookingsToFile(bookings);

        // Convert to queue and return
        Queue<String[]> bookingQueue = new LinkedList<>();
        for (String[] booking : bookings) {
            String bookingId = booking[0];      // Booking ID
            String lessonName = booking[2];     // Lesson Name
            String location = booking[2];       // Using lesson name as location
            String vehicleType = booking[3];    // Vehicle Type
            String instructor = booking[4];     // Instructor
            String date = booking[5];           // Date
            String time = booking[6];           // Time

            // Check if the booking has a flag field
            String flagged = booking.length >= 8 ? booking[7] : "0"; // Default to not flagged

            bookingQueue.add(new String[]{bookingId, lessonName, location, vehicleType, instructor, date, time, flagged});
        }

        return bookingQueue;
    }

    /**
     * Reads all bookings from the bookings.txt file
     *
     * @return List of booking data arrays
     */
    private static List<String[]> readBookingsFromFile() {
        List<String[]> bookings = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(BOOKINGS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                bookings.add(line.split(","));
            }
        } catch (IOException e) {
            System.out.println("Error reading bookings file: " + e.getMessage());
        }

        return bookings;
    }

    /**
     * Writes the sorted bookings to the sorted_bookings.txt file
     *
     * @param bookings List of sorted booking data arrays
     */
    private static void writeSortedBookingsToFile(List<String[]> bookings) {
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

    /**
     * Sorts the bookings list using bubble sort algorithm based on date and time
     *
     * @param arr List of booking data arrays to sort
     */
    private static void bubbleSort(List<String[]> arr) {
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

    /**
     * Compares two booking entries by their date and time
     *
     * @param a First booking data array
     * @param b Second booking data array
     * @return Negative if a is earlier, positive if a is later, 0 if equal
     */
    private static int compareDateTime(String[] a, String[] b) {
        // Convert date and time into a single comparable string
        String dateTimeA = a[5] + " " + a[6]; // Date + Time
        String dateTimeB = b[5] + " " + b[6];

        return dateTimeA.compareTo(dateTimeB);
    }
}
