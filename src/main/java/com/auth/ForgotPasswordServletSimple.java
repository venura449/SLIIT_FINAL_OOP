package com.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.*;
import java.security.SecureRandom;

/**
 * Simplified servlet to handle forgot password functionality with OTP verification
 */
public class ForgotPasswordServletSimple extends HttpServlet {
    private static final String USERS_FILE = "src\\main\\java\\com\\auth\\users.txt";
    
    // Store OTPs with email as key (in-memory storage)
    private static final Map<String, String> otpMap = new HashMap<>();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect to the forgot password page
        response.sendRedirect("forgot-password.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("ForgotPasswordServletSimple doPost method called");
        
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
            response.sendRedirect("forgot-password.jsp?error=Invalid request");
            return;
        }
        
        if (action.equals("request")) {
            handleOtpRequest(request, response);
        } else if (action.equals("verify")) {
            handleOtpVerification(request, response);
        } else if (action.equals("reset")) {
            handlePasswordReset(request, response);
        } else {
            response.sendRedirect("forgot-password.jsp?error=Invalid action");
        }
    }
    
    private void handleOtpRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect("forgot-password.jsp?error=Email is required");
            return;
        }
        
        // Check if email exists
        if (!emailExists(email)) {
            response.sendRedirect("forgot-password.jsp?error=Email not found");
            return;
        }
        
        // Generate OTP
        String otp = generateOtp();
        
        // Store OTP
        otpMap.put(email.toLowerCase(), otp);
        
        // Print OTP to console
        System.out.println("========================================");
        System.out.println("OTP for " + email + ": " + otp);
        System.out.println("========================================");
        
        // Redirect to verification page
        response.sendRedirect("forgot-password.jsp?action=verify&email=" + email + "&success=OTP sent to console");
    }
    
    private void handleOtpVerification(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String otp = request.getParameter("otp");
        
        if (email == null || otp == null) {
            response.sendRedirect("forgot-password.jsp?error=Email and OTP are required");
            return;
        }
        
        // Verify OTP
        String storedOtp = otpMap.get(email.toLowerCase());
        
        if (storedOtp == null || !storedOtp.equals(otp)) {
            response.sendRedirect("forgot-password.jsp?action=verify&email=" + email + "&error=Invalid OTP");
            return;
        }
        
        // Redirect to reset password page
        response.sendRedirect("forgot-password.jsp?action=reset&email=" + email + "&otp=" + otp);
    }
    
    private void handlePasswordReset(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String otp = request.getParameter("otp");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (email == null || otp == null || newPassword == null || confirmPassword == null) {
            response.sendRedirect("forgot-password.jsp?error=All fields are required");
            return;
        }
        
        // Verify OTP again
        String storedOtp = otpMap.get(email.toLowerCase());
        
        if (storedOtp == null || !storedOtp.equals(otp)) {
            response.sendRedirect("forgot-password.jsp?error=Invalid OTP");
            return;
        }
        
        // Verify passwords match
        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("forgot-password.jsp?action=reset&email=" + email + "&otp=" + otp + "&error=Passwords do not match");
            return;
        }
        
        // Update password
        if (updatePassword(email, newPassword)) {
            // Remove OTP
            otpMap.remove(email.toLowerCase());
            
            // Redirect to login page
            response.sendRedirect("Login/login.jsp?success=Password reset successful. Please login with your new password.");
        } else {
            response.sendRedirect("forgot-password.jsp?action=reset&email=" + email + "&otp=" + otp + "&error=Failed to update password");
        }
    }
    
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
    
    private String generateOtp() {
        // Generate a 6-digit OTP
        SecureRandom random = new SecureRandom();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
    
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
}
