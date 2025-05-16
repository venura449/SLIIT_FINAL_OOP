package com.auth;

import java.io.*;
import java.util.*;

//testing purpose only
public class SortAppointments {
    private static final String BOOKINGS_FILE = "C:\\Users\\User\\Downloads\\DrivingSchool1234\\DrivingSchool\\src\\main\\java\\com\\auth\\bookings.txt";
    private static final String SORTED_FILE = "C:\\Users\\User\\Downloads\\DrivingSchool1234\\DrivingSchool\\src\\main\\java\\com\\auth\\sorted_bookings.txt";

    public static void main(String[] args) {
        UserUtils.getBookings("./../sorted_bookings.txt");
    }

    public static void bubbleSort(List<String[]> arr) {
        int n = arr.size();
        boolean swapped;

        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - i - 1; j++) {
                if (compareDateTime(arr.get(j), arr.get(j + 1)) > 0) {
                    // Swap if current appointment is later than next
                    Collections.swap(arr, j, j + 1);
                    swapped = true;
                }
            }
            if (!swapped) break; // Stop if already sorted
        }
    }

    // Compare appointments by date and time
    private static int compareDateTime(String[] a, String[] b) {
        String dateTimeA = a[5] + " " + a[6]; // Date + Time
        String dateTimeB = b[5] + " " + b[6];

        return dateTimeA.compareTo(dateTimeB);
    }
}
