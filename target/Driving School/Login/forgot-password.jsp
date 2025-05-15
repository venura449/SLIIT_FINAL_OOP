<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Driving School</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
        
        .logo {
            margin-bottom: 20px;
        }
        
        .logo img {
            max-width: 150px;
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
        
        .steps {
            display: flex;
            justify-content: center;
            margin-bottom: 25px;
        }
        
        .step {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: #e9ecef;
            color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            margin: 0 5px;
            position: relative;
        }
        
        .step.active {
            background-color: #2c3e50;
            color: white;
        }
        
        .step:not(:last-child):after {
            content: '';
            position: absolute;
            width: 20px;
            height: 2px;
            background-color: #e9ecef;
            right: -15px;
            top: 50%;
            transform: translateY(-50%);
        }
        
        .step.active:not(:last-child):after {
            background-color: #2c3e50;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <!-- Replace with your logo -->
            <i class="fas fa-car-side" style="font-size: 48px; color: #2c3e50;"></i>
        </div>
        
        <% 
            String action = request.getParameter("action");
            String email = request.getParameter("email");
            String error = request.getParameter("error");
            String message = request.getParameter("message");
            
            // Default to step 1
            int currentStep = 1;
            
            if (action != null && action.equals("verify")) {
                currentStep = 2;
            } else if (action != null && action.equals("reset")) {
                currentStep = 3;
            }
        %>
        
        <div class="steps">
            <div class="step <%= currentStep >= 1 ? "active" : "" %>">1</div>
            <div class="step <%= currentStep >= 2 ? "active" : "" %>">2</div>
            <div class="step <%= currentStep >= 3 ? "active" : "" %>">3</div>
        </div>
        
        <% if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-error">
                <%= error %>
            </div>
        <% } %>
        
        <% if (message != null && !message.isEmpty()) { %>
            <div class="alert alert-success">
                <%= message %>
            </div>
        <% } %>
        
        <% if (action == null || !action.equals("verify")) { %>
            <!-- Step 1: Request OTP -->
            <h1>Forgot Password</h1>
            <p>Enter your email address and we'll send you an OTP to reset your password.</p>
            
            <form action="../forgot-password" method="post">
                <input type="hidden" name="action" value="request">
                
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <button type="submit" class="btn">Send OTP</button>
            </form>
        <% } else if (action.equals("verify")) { %>
            <!-- Step 2: Verify OTP -->
            <h1>Verify OTP</h1>
            <p>Enter the OTP sent to your email address.</p>
            
            <form action="../forgot-password" method="post">
                <input type="hidden" name="action" value="verify">
                <input type="hidden" name="email" value="<%= email %>">
                
                <div class="form-group">
                    <label for="otp">OTP</label>
                    <input type="text" id="otp" name="otp" required>
                </div>
                
                <button type="submit" class="btn">Verify OTP</button>
            </form>
        <% } %>
        
        <a href="login.jsp" class="back-link">Back to Login</a>
    </div>
</body>
</html>
