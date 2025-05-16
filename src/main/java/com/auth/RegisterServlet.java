package com.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    private static final String USERS_FILE = "C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\users.txt"; // Update path

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (UserUtils.userExists(email, USERS_FILE)) {
            response.sendRedirect("Login/login.jsp?error=User already exists");
        } else {
            UserUtils.saveUser(name, email, password, USERS_FILE);
            response.sendRedirect("Login/login.jsp?success=Account created");
        }
    }
}
