package com.config;

import java.io.File;

/**
 * Configuration class that centralizes all file paths used in the application.
 * This makes it easier to manage and update file paths in a single location.
 */
public class DBConfig {
    
    // Base directory path - change this to match your deployment environment
    private static final String BASE_DIR = "C:\\Users\\Chanitha Lakwan\\Desktop\\DrivingSchool";
    
    // User authentication files
    public static final String USERS_FILE = BASE_DIR + "\\src\\main\\java\\com\\auth\\users.txt";
    
    // Service management files
    public static final String SERVICES_FILE = BASE_DIR + "\\src\\main\\java\\com\\services\\services.txt";
    
    // Booking management files
    public static final String BOOKINGS_FILE = BASE_DIR + "\\src\\main\\java\\com\\bookings\\bookings.txt";
    
    // Inquiry management files
    public static final String INQUIRIES_FILE = BASE_DIR + "\\src\\main\\java\\com\\inquiries\\inquiries.txt";
    
    // Instructor management files
    public static final String INSTRUCTORS_FILE = BASE_DIR + "\\src\\main\\java\\com\\instructors\\instructors.txt";
    
    // Vehicle management files
    public static final String VEHICLES_FILE = BASE_DIR + "\\src\\main\\java\\com\\vehicles\\vehicles.txt";
    
    // Student management files
    public static final String STUDENTS_FILE = BASE_DIR + "\\src\\main\\java\\com\\students\\students.txt";
    
    /**
     * Ensures that all necessary directories exist.
     * Call this method during application startup to create any missing directories.
     */
    public static void ensureDirectoriesExist() {
        createDirectoryIfNotExists(new File(USERS_FILE).getParent());
        createDirectoryIfNotExists(new File(SERVICES_FILE).getParent());
        createDirectoryIfNotExists(new File(BOOKINGS_FILE).getParent());
        createDirectoryIfNotExists(new File(INQUIRIES_FILE).getParent());
        createDirectoryIfNotExists(new File(INSTRUCTORS_FILE).getParent());
        createDirectoryIfNotExists(new File(VEHICLES_FILE).getParent());
        createDirectoryIfNotExists(new File(STUDENTS_FILE).getParent());
    }
    
    /**
     * Creates a directory if it doesn't already exist.
     * 
     * @param directoryPath The path of the directory to create
     * @return true if the directory was created or already exists, false otherwise
     */
    private static boolean createDirectoryIfNotExists(String directoryPath) {
        File directory = new File(directoryPath);
        if (!directory.exists()) {
            return directory.mkdirs();
        }
        return true;
    }
    
    /**
     * Checks if a file exists, and creates it (along with its parent directories) if it doesn't.
     * 
     * @param filePath The path of the file to check/create
     * @return true if the file exists or was created successfully, false otherwise
     */
    public static boolean ensureFileExists(String filePath) {
        File file = new File(filePath);
        
        // Create parent directories if they don't exist
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        
        // Create the file if it doesn't exist
        if (!file.exists()) {
            try {
                return file.createNewFile();
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }
        
        return true;
    }
    
    /**
     * Utility method to get the relative path from the base directory.
     * Useful for logging and display purposes.
     * 
     * @param absolutePath The absolute file path
     * @return The relative path from the base directory
     */
    public static String getRelativePath(String absolutePath) {
        if (absolutePath.startsWith(BASE_DIR)) {
            return absolutePath.substring(BASE_DIR.length());
        }
        return absolutePath;
    }
}
