package com.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Application initialization listener.
 * This class is responsible for initializing application resources at startup.
 */
@WebListener
public class AppInitListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Application starting up...");
        
        // Ensure all necessary directories exist
        DBConfig.ensureDirectoriesExist();
        
        // Ensure all data files exist
        DBConfig.ensureFileExists(DBConfig.USERS_FILE);
        DBConfig.ensureFileExists(DBConfig.SERVICES_FILE);
        DBConfig.ensureFileExists(DBConfig.BOOKINGS_FILE);
        DBConfig.ensureFileExists(DBConfig.INQUIRIES_FILE);
        DBConfig.ensureFileExists(DBConfig.INSTRUCTORS_FILE);
        DBConfig.ensureFileExists(DBConfig.VEHICLES_FILE);
        DBConfig.ensureFileExists(DBConfig.STUDENTS_FILE);
        
        System.out.println("Application initialized successfully.");
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Application shutting down...");
    }
}
