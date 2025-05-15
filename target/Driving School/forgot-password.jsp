<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Driving School</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Montserrat', sans-serif;
        }
        
        body {
            background: linear-gradient(to right, #e2e2e2, #c9d6ff);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        
        .container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 400px;
            padding: 30px;
            text-align: center;
        }
        
        h1 {
            color: #2c3e50;
            font-size: 24px;
            margin-bottom: 20px;
        }
        
        p {
            color: #7f8c8d;
            font-size: 14px;
            margin-bottom: 25px;
            line-height: 1.5;
        }
        
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #2c3e50;
            font-weight: 500;
        }
        
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .btn {
            background-color: #2c3e50;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            width: 100%;
            transition: background-color 0.3s;
        }
        
        .btn:hover {
            background-color: #1a252f;
        }
        
        .back-link {
            display: block;
            margin-top: 20px;
            color: #3498db;
            text-decoration: none;
            font-size: 14px;
        }
        
        .back-link:hover {
            text-decoration: underline;
        }
        
        .alert {
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Forgot Password</h1>
        
        <% 
            String action = request.getParameter("action");
            String email = request.getParameter("email");
            String error = request.getParameter("error");
            String success = request.getParameter("success");
            String otp = request.getParameter("otp");
        %>
        
        <% if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-error">
                <%= error %>
            </div>
        <% } %>
        
        <% if (success != null && !success.isEmpty()) { %>
            <div class="alert alert-success">
                <%= success %>
            </div>
        <% } %>
        
        <% if (action == null || !action.equals("verify") && !action.equals("reset")) { %>
            <!-- Step 1: Request OTP -->
            <p>Enter your email address and we'll send you an OTP to reset your password.</p>
            
            <form action="forgot-password-servlet" method="post">
                <input type="hidden" name="action" value="request">
                
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <button type="submit" class="btn">Send OTP</button>
            </form>
        <% } else if (action.equals("verify")) { %>
            <!-- Step 2: Verify OTP -->
            <p>Enter the OTP sent to your email address (check console).</p>
            
            <form action="forgot-password-servlet" method="post">
                <input type="hidden" name="action" value="verify">
                <input type="hidden" name="email" value="<%= email %>">
                
                <div class="form-group">
                    <label for="otp">OTP</label>
                    <input type="text" id="otp" name="otp" required>
                </div>
                
                <button type="submit" class="btn">Verify OTP</button>
            </form>
        <% } else if (action.equals("reset")) { %>
            <!-- Step 3: Reset Password -->
            <p>Create a new password for your account.</p>
            
            <form action="forgot-password-servlet" method="post" onsubmit="return validatePasswords()">
                <input type="hidden" name="action" value="reset">
                <input type="hidden" name="email" value="<%= email %>">
                <input type="hidden" name="otp" value="<%= otp %>">
                
                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" required>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
                
                <button type="submit" class="btn">Reset Password</button>
            </form>
        <% } %>
        
        <a href="Login/login.jsp" class="back-link">Back to Login</a>
    </div>
    
    <script>
        function validatePasswords() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                alert('Passwords do not match');
                return false;
            }
            
            if (newPassword.length < 6) {
                alert('Password must be at least 6 characters long');
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>
