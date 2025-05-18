package com.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.security.SecureRandom;

/**
 * Servlet to handle forgot password functionality with OTP verification
 */
public class ForgotPasswordServlet extends HttpServlet {
    private static final String USERS_FILE = "C:\\Users\\dulak\\Desktop\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\users.txt";

    // Store OTPs with email as key (in-memory storage)
    private static final Map<String, OtpData> otpMap = new ConcurrentHashMap<>();

    // OTP validity period in milliseconds (5 minutes)
    private static final long OTP_VALIDITY_PERIOD = 5 * 60 * 1000;

    // OTP length
    private static final int OTP_LENGTH = 6;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("reset")) {
            // Show reset password form
            String email = request.getParameter("email");
            String otp = request.getParameter("otp");

            if (email != null && otp != null) {
                // Validate OTP
                if (validateOtp(email, otp)) {
                    request.setAttribute("email", email);
                    request.setAttribute("otp", otp);
                    request.getRequestDispatcher("Forgot Password/reset-password.jsp").forward(request, response);
                    return;
                } else {
                    response.sendRedirect("Forgot Password/forgotpassword.jsp?error=Invalid or expired OTP");
                    return;
                }
            }
        }

        // Default: show forgot password form
        request.getRequestDispatcher("Forgot Password/forgotpassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("ForgotPasswordServlet doPost method called");

        // Print all request parameters for debugging
        System.out.println("Request parameters:");
        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            String paramValue = request.getParameter(paramName);
            System.out.println(paramName + " = " + paramValue);
        }

        String action = request.getParameter("action");

        if (action == null) {
            System.out.println("No action parameter provided in POST request");
            response.sendRedirect("Forgot Password/forgotpassword.jsp?error=Invalid action");
            return;
        }

        System.out.println("POST request with action: " + action);

        if (action.equals("request")) {
            // Handle OTP request
            String email = request.getParameter("email");

            if (email == null || email.trim().isEmpty()) {
                response.sendRedirect("Forgot Password/forgotpassword.jsp?error=Email is required");
                return;
            }

            // Check if email exists in the system
            if (!emailExists(email)) {
                response.sendRedirect("Forgot Password/forgotpassword.jsp?error=Email not found");
                return;
            }

            // Generate and store OTP
            String otp = generateOtp();
            System.out.println("Generated OTP: " + otp + " for email: " + email);
            storeOtp(email, otp);

            // In a real application, send OTP via email
            // For this example, we'll just print it to the console
            System.out.println("========================================");
            System.out.println("OTP for " + email + ": " + otp);
            System.out.println("========================================");

            // Print all stored OTPs for debugging
            System.out.println("Currently stored OTPs:");
            for (Map.Entry<String, OtpData> entry : otpMap.entrySet()) {
                System.out.println("Email: " + entry.getKey() + ", OTP: " + entry.getValue().otp);
            }

            // Redirect to OTP verification page
            response.sendRedirect("Forgot Password/forgotpassword.jsp?action=verify&email=" + email + "&message=OTP sent to console");

        } else if (action.equals("verify")) {
            // Handle OTP verification
            String email = request.getParameter("email");
            String otp = request.getParameter("otp");

            if (email == null || otp == null) {
                response.sendRedirect("Forgot Password/forgotpassword.jsp?error=Email and OTP are required");
                return;
            }

            // Validate OTP
            if (validateOtp(email, otp)) {
                // Redirect to reset password page
                response.sendRedirect("forgot-password?action=reset&email=" + email + "&otp=" + otp);
            } else {
                response.sendRedirect("Forgot Password/forgotpassword.jsp?action=verify&email=" + email + "&error=Invalid or expired OTP");
            }

        } else if (action.equals("reset")) {
            // Handle password reset
            String email = request.getParameter("email");
            String otp = request.getParameter("otp");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (email == null || otp == null || newPassword == null || confirmPassword == null) {
                response.sendRedirect("Forgot Password/forgotpassword.jsp?error=All fields are required");
                return;
            }

            // Validate OTP again
            if (!validateOtp(email, otp)) {
                response.sendRedirect("Forgot Password/forgotpassword.jsp?error=Invalid or expired OTP");
                return;
            }

            // Validate passwords match
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("email", email);
                request.setAttribute("otp", otp);
                request.setAttribute("error", "Passwords do not match");
                request.getRequestDispatcher("Login/reset-password.jsp").forward(request, response);
                return;
            }

            // Update password
            if (updatePassword(email, newPassword)) {
                // Remove OTP from map
                otpMap.remove(email);

                // Redirect to login with success message
                response.sendRedirect("Login/login.jsp?success=Password reset successful. Please login with your new password.");
            } else {
                request.setAttribute("email", email);
                request.setAttribute("otp", otp);
                request.setAttribute("error", "Failed to update password");
                request.getRequestDispatcher("Login/reset-password.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("forgot-password?error=Invalid action");
        }
    }

    /**
     * Check if email exists in the system
     */
    private boolean emailExists(String email) {
        try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3 && parts[1].equalsIgnoreCase(email)) {
                    return true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Generate a random OTP
     */
    private String generateOtp() {
        SecureRandom random = new SecureRandom();
        StringBuilder otp = new StringBuilder();

        for (int i = 0; i < OTP_LENGTH; i++) {
            otp.append(random.nextInt(10));
        }

        return otp.toString();
    }

    /**
     * Store OTP with timestamp
     */
    private void storeOtp(String email, String otp) {
        OtpData otpData = new OtpData(otp, System.currentTimeMillis());
        otpMap.put(email.toLowerCase(), otpData);
    }

    /**
     * Validate OTP
     */
    private boolean validateOtp(String email, String otp) {
        System.out.println("Validating OTP: " + otp + " for email: " + email);

        // Print all stored OTPs for debugging
        System.out.println("Currently stored OTPs:");
        for (Map.Entry<String, OtpData> entry : otpMap.entrySet()) {
            System.out.println("Email: " + entry.getKey() + ", OTP: " + entry.getValue().otp);
        }

        OtpData otpData = otpMap.get(email.toLowerCase());

        if (otpData == null) {
            System.out.println("No OTP found for email: " + email);
            return false;
        }

        System.out.println("Found OTP: " + otpData.otp + " for email: " + email);

        // Check if OTP is expired
        long currentTime = System.currentTimeMillis();
        long timeDiff = currentTime - otpData.timestamp;
        System.out.println("OTP age: " + (timeDiff / 1000) + " seconds (expires after " + (OTP_VALIDITY_PERIOD / 1000) + " seconds)");

        if (timeDiff > OTP_VALIDITY_PERIOD) {
            System.out.println("OTP expired for email: " + email);
            // Remove expired OTP
            otpMap.remove(email.toLowerCase());
            return false;
        }

        // Check if OTP matches
        boolean matches = otpData.otp.equals(otp);
        System.out.println("OTP match result: " + matches);
        return matches;
    }

    /**
     * Update user password
     */
    private boolean updatePassword(String email, String newPassword) {
        List<String> updatedUsers = new ArrayList<>();
        boolean found = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3 && parts[1].equalsIgnoreCase(email)) {
                    // Update password
                    updatedUsers.add(parts[0] + "," + parts[1] + "," + newPassword);
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
     * Inner class to store OTP data
     */
    private static class OtpData {
        String otp;
        long timestamp;

        OtpData(String otp, long timestamp) {
            this.otp = otp;
            this.timestamp = timestamp;
        }
    }
}
