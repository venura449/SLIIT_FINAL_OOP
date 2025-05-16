package com.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.util.*;

/**
 * Servlet to handle user management (view, edit, delete users)
 */
public class UserManagementServlet extends HttpServlet {
    private static final String USERS_FILE = "C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\users.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is admin
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("role");
        
        if (userRole == null || !userRole.equals("admin")) {
            response.sendRedirect("Login/login.jsp?error=You must be an admin to access this page");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            // Default action: list all users
            List<String[]> users = getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("Admin/manage-users.jsp").forward(request, response);
        } else if (action.equals("view")) {
            // View a specific user
            String email = request.getParameter("email");
            String[] user = getUserByEmail(email);
            
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("Admin/view-user.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/user-management?error=User not found");
            }
        } else if (action.equals("delete")) {
            // Delete a user
            String email = request.getParameter("email");
            boolean success = deleteUser(email);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/user-management?success=User deleted successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/user-management?error=Failed to delete user");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is admin
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("role");
        
        if (userRole == null || !userRole.equals("admin")) {
            response.sendRedirect("Login/login.jsp?error=You must be an admin to access this page");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/user-management?error=Invalid action");
            return;
        }
        
        if (action.equals("edit")) {
            // Edit a user
            String originalEmail = request.getParameter("originalEmail");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            if (originalEmail == null || name == null || email == null) {
                response.sendRedirect(request.getContextPath() + "/user-management?error=Invalid user data");
                return;
            }
            
            boolean success = updateUser(originalEmail, name, email, password);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "user-management?success=User updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "user-management?error=Failed to update user");
            }
        } else if (action.equals("add")) {
            // Add a new user
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            if (name == null || email == null || password == null) {
                response.sendRedirect(request.getContextPath() + "/user-management?error=Invalid user data");
                return;
            }
            
            // Check if user already exists
            if (getUserByEmail(email) != null) {
                response.sendRedirect(request.getContextPath() + "/user-management?error=User with this email already exists");
                return;
            }
            
            boolean success = addUser(name, email, password);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/user-management?success=User added successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/user-management?error=Failed to add user");
            }
        }
    }
    
    /**
     * Get all users from the file
     */
    private List<String[]> getAllUsers() {
        List<String[]> users = new ArrayList<>();
        
        try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3) {
                    users.add(parts);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return users;
    }
    
    /**
     * Get a specific user by email
     */
    private String[] getUserByEmail(String email) {
        try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3 && parts[1].equalsIgnoreCase(email)) {
                    return parts;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Delete a user by email
     */
    private boolean deleteUser(String email) {
        List<String> updatedUsers = new ArrayList<>();
        boolean found = false;
        
        try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3 && parts[1].equalsIgnoreCase(email)) {
                    found = true;
                    continue; // Skip this line (delete it)
                }
                updatedUsers.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        
        if (!found) {
            return false;
        }
        
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USERS_FILE))) {
            for (String user : updatedUsers) {
                writer.write(user);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        
        return true;
    }
    
    /**
     * Update a user
     */
    private boolean updateUser(String originalEmail, String name, String email, String password) {
        List<String> updatedUsers = new ArrayList<>();
        boolean found = false;
        
        try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3 && parts[1].equalsIgnoreCase(originalEmail)) {
                    // Update the user
                    String updatedUser = name + "," + email + ",";
                    
                    // If password is provided, update it; otherwise, keep the old one
                    if (password != null && !password.trim().isEmpty()) {
                        updatedUser += password;
                    } else {
                        updatedUser += parts[2];
                    }
                    
                    updatedUsers.add(updatedUser);
                    found = true;
                } else {
                    updatedUsers.add(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        
        if (!found) {
            return false;
        }
        
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USERS_FILE))) {
            for (String user : updatedUsers) {
                writer.write(user);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        
        return true;
    }
    
    /**
     * Add a new user
     */
    private boolean addUser(String name, String email, String password) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USERS_FILE, true))) {
            String newUser = name + "," + email + "," + password;
            writer.write(newUser);
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        
        return true;
    }
}
