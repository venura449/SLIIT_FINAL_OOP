package com.services;

import com.config.DBConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.util.*;

/**
 * Servlet to handle service management (add, edit, delete services)
 */
public class ServiceManagementServlet extends HttpServlet {
    private static final String SERVICES_FILE = DBConfig.SERVICES_FILE;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is admin
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("user");

        if (userEmail == null || !userEmail.endsWith("@admin.com")) {
            response.sendRedirect("Login/login.jsp?error=You must be an admin to access this page");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            // Default action: list all services
            List<String[]> services = getAllServices();
            request.setAttribute("services", services);
            request.getRequestDispatcher("Admin/manage-services.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            // Delete a service
            String id = request.getParameter("id");
            boolean success = deleteService(id);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/service-management?success=Service deleted successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/service-management?error=Failed to delete service");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is admin
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("user");

        if (userEmail == null || !userEmail.endsWith("@admin.com")) {
            response.sendRedirect("Login/login.jsp?error=You must be an admin to access this page");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/service-management?error=Invalid action");
            return;
        }

        if (action.equals("add")) {
            // Add a new service
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            String duration = request.getParameter("duration");
            String category = request.getParameter("category");

            if (name == null || description == null || price == null || duration == null || category == null) {
                response.sendRedirect(request.getContextPath() + "/service-management?error=All fields are required");
                return;
            }

            boolean success = addService(name, description, price, duration, category);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/service-management?success=Service added successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/service-management?error=Failed to add service");
            }
        } else if (action.equals("edit")) {
            // Edit a service
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            String duration = request.getParameter("duration");
            String category = request.getParameter("category");

            if (id == null || name == null || description == null || price == null || duration == null || category == null) {
                response.sendRedirect(request.getContextPath() + "/service-management?error=All fields are required");
                return;
            }

            boolean success = updateService(id, name, description, price, duration, category);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/service-management?success=Service updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/service-management?error=Failed to update service");
            }
        }
    }

    /**
     * Get all services from the file
     */
    private List<String[]> getAllServices() {
        List<String[]> services = new ArrayList<>();

        // Create the file if it doesn't exist
        File file = new File(SERVICES_FILE);
        if (!file.exists()) {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(SERVICES_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 6) {
                    services.add(parts);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return services;
    }

    /**
     * Get a specific service by ID
     */
    private String[] getServiceById(String id) {
        try (BufferedReader reader = new BufferedReader(new FileReader(SERVICES_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 6 && parts[0].equals(id)) {
                    return parts;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Delete a service by ID
     */
    private boolean deleteService(String id) {
        List<String> updatedServices = new ArrayList<>();
        boolean found = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(SERVICES_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 6 && parts[0].equals(id)) {
                    found = true;
                    continue; // Skip this line (delete it)
                }
                updatedServices.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (!found) {
            return false;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(SERVICES_FILE))) {
            for (String service : updatedServices) {
                writer.write(service);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    /**
     * Update a service
     */
    private boolean updateService(String id, String name, String description, String price, String duration, String category) {
        List<String> updatedServices = new ArrayList<>();
        boolean found = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(SERVICES_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 6 && parts[0].equals(id)) {
                    // Update the service
                    updatedServices.add(id + "|" + name + "|" + description + "|" + price + "|" + duration + "|" + category);
                    found = true;
                } else {
                    updatedServices.add(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (!found) {
            return false;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(SERVICES_FILE))) {
            for (String service : updatedServices) {
                writer.write(service);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    /**
     * Add a new service
     */
    private boolean addService(String name, String description, String price, String duration, String category) {
        // Generate a unique ID
        String id = UUID.randomUUID().toString().substring(0, 8);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(SERVICES_FILE, true))) {
            String newService = id + "|" + name + "|" + description + "|" + price + "|" + duration + "|" + category;
            writer.write(newService);
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }
}
