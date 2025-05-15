package com.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.util.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Servlet to handle inquiry management (view, edit, delete, reply)
 */
public class InquiryManagementServlet extends HttpServlet {
    private static final String INQUIRY_FILE = "C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\inquiry.txt";
    private static final String REPLY_FILE = "C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\inquiry_replies.txt";

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
            // Default action: list all inquiries
            List<String[]> inquiries = getAllInquiries();
            request.setAttribute("inquiries", inquiries);
            request.getRequestDispatcher("Admin/manage-inquiries.jsp").forward(request, response);
        } else if (action.equals("view")) {
            // View a specific inquiry
            String id = request.getParameter("id");
            String[] inquiry = getInquiryById(id);
            String[] reply = getReplyById(id);

            if (inquiry != null) {
                request.setAttribute("inquiry", inquiry);
                request.setAttribute("reply", reply);
                request.getRequestDispatcher("Admin/view-inquiry.jsp").forward(request, response);
            } else {
                response.sendRedirect("inquiry-management?error=Inquiry not found");
            }
        } else if (action.equals("delete")) {
            // Delete an inquiry
            String id = request.getParameter("id");
            boolean success = deleteInquiry(id);

            if (success) {
                response.sendRedirect("inquiry-management?success=Inquiry deleted successfully");
            } else {
                response.sendRedirect("inquiry-management?error=Failed to delete inquiry");
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
            System.out.println("No action parameter provided in POST request");
            response.sendRedirect(request.getContextPath() + "/inquiry-management?error=Invalid action");
            return;
        }

        System.out.println("POST request with action: " + action);

        if (action.equals("reply")) {
            // Reply to an inquiry
            String id = request.getParameter("id");
            String replyText = request.getParameter("reply");

            System.out.println("Reply action received - ID: " + id + ", Reply text length: " + (replyText != null ? replyText.length() : "null"));

            if (id == null || replyText == null || replyText.trim().isEmpty()) {
                System.out.println("Invalid reply data - ID: " + id + ", Reply: " + replyText);
                response.sendRedirect(request.getContextPath() + "/inquiry-management?error=Invalid reply data");
                return;
            }

            boolean success = saveReply(id, replyText);
            System.out.println("Reply save result: " + success);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/inquiry-management?success=Reply sent successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/inquiry-management?error=Failed to send reply");
            }
        } else if (action.equals("edit")) {
            // Edit an inquiry
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");

            System.out.println("Edit action received - ID: " + id);
            System.out.println("Edit parameters - Name: " + name + ", Email: " + email + ", Subject: " + subject);

            if (id == null || name == null || email == null || message == null) {
                System.out.println("Invalid edit data - Missing required fields");
                response.sendRedirect(request.getContextPath() + "/inquiry-management?error=Invalid inquiry data");
                return;
            }

            boolean success = updateInquiry(id, name, email, phone, subject, message);
            System.out.println("Edit save result: " + success);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/inquiry-management?success=Inquiry updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/inquiry-management?error=Failed to update inquiry");
            }
        }
    }

    /**
     * Get all inquiries from the file
     */
    private List<String[]> getAllInquiries() {
        List<String[]> inquiries = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(INQUIRY_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 6) {
                    inquiries.add(parts);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Sort by timestamp (newest first)
        inquiries.sort((a, b) -> b[0].compareTo(a[0]));

        return inquiries;
    }

    /**
     * Get a specific inquiry by ID (timestamp)
     */
    private String[] getInquiryById(String id) {
        try (BufferedReader reader = new BufferedReader(new FileReader(INQUIRY_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
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
     * Delete an inquiry by ID (timestamp)
     */
    private boolean deleteInquiry(String id) {
        List<String> updatedInquiries = new ArrayList<>();
        boolean found = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(INQUIRY_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 6 && parts[0].equals(id)) {
                    found = true;
                    continue; // Skip this line (delete it)
                }
                updatedInquiries.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (!found) {
            return false;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(INQUIRY_FILE))) {
            for (String inquiry : updatedInquiries) {
                writer.write(inquiry);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        // Also delete any replies
        deleteReply(id);

        return true;
    }

    /**
     * Update an inquiry
     */
    private boolean updateInquiry(String id, String name, String email, String phone, String subject, String message) {
        System.out.println("updateInquiry called - ID: " + id);
        System.out.println("Update parameters - Name: " + name + ", Email: " + email + ", Subject: " + subject);

        List<String> updatedInquiries = new ArrayList<>();
        boolean found = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(INQUIRY_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 6 && parts[0].equals(id)) {
                    // Update the inquiry
                    String updatedInquiry = id + "," +
                                           email + "," +
                                           name + "," +
                                           (phone != null ? phone : "N/A") + "," +
                                           (subject != null ? subject : "General Inquiry") + "," +
                                           message.replace(",", ";;").replace("\n", " ");
                    updatedInquiries.add(updatedInquiry);
                    found = true;
                    System.out.println("Found matching inquiry, updated to: " + updatedInquiry);
                } else {
                    updatedInquiries.add(line);
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading inquiry file: " + e.getMessage());
            e.printStackTrace();
            return false;
        }

        if (!found) {
            System.out.println("No matching inquiry found with ID: " + id);
            return false;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(INQUIRY_FILE))) {
            for (String inquiry : updatedInquiries) {
                writer.write(inquiry);
                writer.newLine();
            }
            System.out.println("Successfully wrote updated inquiries to file");
        } catch (IOException e) {
            System.out.println("Error writing updated inquiries: " + e.getMessage());
            e.printStackTrace();
            return false;
        }

        return true;
    }

    /**
     * Save a reply to an inquiry
     */
    private boolean saveReply(String inquiryId, String replyText) {
        System.out.println("saveReply called - ID: " + inquiryId + ", Text length: " + replyText.length());

        // Check if a reply already exists
        String[] existingReply = getReplyById(inquiryId);

        if (existingReply != null) {
            System.out.println("Existing reply found, updating instead");
            // Update existing reply
            return updateReply(inquiryId, replyText);
        }

        // Generate timestamp
        LocalDateTime now = LocalDateTime.now();
        String timestamp = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        // Format the reply entry
        String replyEntry = inquiryId + "," +
                           timestamp + "," +
                           replyText.replace(",", ";;").replace("\n", " ");

        System.out.println("Formatted reply entry: " + replyEntry);
        System.out.println("Writing to file: " + REPLY_FILE);

        try {
            // Check if the directory exists
            File replyFileObj = new File(REPLY_FILE);
            File parentDir = replyFileObj.getParentFile();
            if (!parentDir.exists()) {
                System.out.println("Parent directory doesn't exist, creating: " + parentDir.getAbsolutePath());
                parentDir.mkdirs();
            }

            // Write to file
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(REPLY_FILE, true))) {
                writer.write(replyEntry);
                writer.newLine();
                System.out.println("Successfully wrote reply to file");
            }
        } catch (IOException e) {
            System.out.println("Error writing reply: " + e.getMessage());
            e.printStackTrace();
            return false;
        }

        return true;
    }

    /**
     * Update an existing reply
     */
    private boolean updateReply(String inquiryId, String replyText) {
        List<String> updatedReplies = new ArrayList<>();
        boolean found = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(REPLY_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3 && parts[0].equals(inquiryId)) {
                    // Generate new timestamp
                    LocalDateTime now = LocalDateTime.now();
                    String timestamp = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

                    // Update the reply
                    String updatedReply = inquiryId + "," +
                                         timestamp + "," +
                                         replyText.replace(",", ";;").replace("\n", " ");
                    updatedReplies.add(updatedReply);
                    found = true;
                } else {
                    updatedReplies.add(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (!found) {
            return false;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(REPLY_FILE))) {
            for (String reply : updatedReplies) {
                writer.write(reply);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    /**
     * Get a reply by inquiry ID
     */
    private String[] getReplyById(String inquiryId) {
        try (BufferedReader reader = new BufferedReader(new FileReader(REPLY_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3 && parts[0].equals(inquiryId)) {
                    return parts;
                }
            }
        } catch (IOException e) {
            // File might not exist yet, that's okay
        }

        return null;
    }

    /**
     * Delete a reply by inquiry ID
     */
    private boolean deleteReply(String inquiryId) {
        List<String> updatedReplies = new ArrayList<>();
        boolean found = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(REPLY_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3 && parts[0].equals(inquiryId)) {
                    found = true;
                    continue; // Skip this line (delete it)
                }
                updatedReplies.add(line);
            }
        } catch (IOException e) {
            // File might not exist yet, that's okay
            return true;
        }

        if (!found) {
            return true; // No reply to delete is still a success
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(REPLY_FILE))) {
            for (String reply : updatedReplies) {
                writer.write(reply);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }
}
