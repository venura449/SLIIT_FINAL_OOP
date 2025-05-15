package com.auth;



import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;


public class LoginServlet extends HttpServlet {
    private static final String USERS_FILE = "C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\users.txt"; // Relative path

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (UserUtils.validateUser(email, password, USERS_FILE)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", email);
            String username = UserUtils.getUsernameByEmail(email, USERS_FILE);
            session.setAttribute("username", username);

            // Check if email ends with admin.com
            if (email.endsWith("@admin.com")) {
                session.setAttribute("role", "admin");
                response.sendRedirect("Home%20page/AdminDash.jsp");
            } else {
                session.setAttribute("role", "user");
                response.sendRedirect("Home%20page/homepage.jsp");
            }
        } else {
            response.sendRedirect("Login/login.jsp?error=Invalid credentials");
        }
    }
}

