<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Clear only user management authentication
    session.removeAttribute("userManagementAuthenticated");

    // Redirect back to admin dashboard
    response.sendRedirect("Home page/AdminDash.jsp?message=Logged out of user management area");
%>
