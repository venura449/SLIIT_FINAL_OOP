package com.auth;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;


public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("Login/login.jsp");
    }
}
