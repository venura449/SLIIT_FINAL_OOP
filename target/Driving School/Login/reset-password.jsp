<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - Driving School</title>
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
        
        .password-strength {
            height: 5px;
            margin-top: 5px;
            border-radius: 3px;
            background-color: #e9ecef;
            position: relative;
            overflow: hidden;
        }
        
        .password-strength-meter {
            height: 100%;
            width: 0;
            border-radius: 3px;
            transition: width 0.3s, background-color 0.3s;
        }
        
        .password-strength-text {
            font-size: 12px;
            margin-top: 5px;
            text-align: right;
        }
        
        .password-match {
            font-size: 12px;
            margin-top: 5px;
            color: #155724;
            display: none;
        }
        
        .password-mismatch {
            font-size: 12px;
            margin-top: 5px;
            color: #721c24;
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <!-- Replace with your logo -->
            <i class="fas fa-car-side" style="font-size: 48px; color: #2c3e50;"></i>
        </div>
        
        <div class="steps">
            <div class="step active">1</div>
            <div class="step active">2</div>
            <div class="step active">3</div>
        </div>
        
        <% 
            String email = (String) request.getAttribute("email");
            String otp = (String) request.getAttribute("otp");
            String error = (String) request.getAttribute("error");
            
            if (error != null && !error.isEmpty()) {
        %>
            <div class="alert alert-error">
                <%= error %>
            </div>
        <% } %>
        
        <h1>Reset Password</h1>
        <p>Create a new password for your account.</p>
        
        <form action="../forgot-password" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="action" value="reset">
            <input type="hidden" name="email" value="<%= email %>">
            <input type="hidden" name="otp" value="<%= otp %>">
            
            <div class="form-group">
                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword" required onkeyup="checkPasswordStrength(); checkPasswordMatch();">
                <div class="password-strength">
                    <div class="password-strength-meter" id="passwordStrengthMeter"></div>
                </div>
                <div class="password-strength-text" id="passwordStrengthText"></div>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required onkeyup="checkPasswordMatch();">
                <div class="password-match" id="passwordMatch">Passwords match</div>
                <div class="password-mismatch" id="passwordMismatch">Passwords do not match</div>
            </div>
            
            <button type="submit" class="btn">Reset Password</button>
        </form>
        
        <a href="login.jsp" class="back-link">Back to Login</a>
    </div>
    
    <script>
        function checkPasswordStrength() {
            const password = document.getElementById('newPassword').value;
            const meter = document.getElementById('passwordStrengthMeter');
            const text = document.getElementById('passwordStrengthText');
            
            // Reset
            meter.style.width = '0';
            meter.style.backgroundColor = '#e9ecef';
            text.textContent = '';
            
            if (password.length === 0) {
                return;
            }
            
            // Check strength
            let strength = 0;
            
            // Length check
            if (password.length >= 8) {
                strength += 25;
            }
            
            // Contains lowercase
            if (/[a-z]/.test(password)) {
                strength += 25;
            }
            
            // Contains uppercase
            if (/[A-Z]/.test(password)) {
                strength += 25;
            }
            
            // Contains number or special char
            if (/[0-9!@#$%^&*(),.?":{}|<>]/.test(password)) {
                strength += 25;
            }
            
            // Update meter
            meter.style.width = strength + '%';
            
            // Set color and text based on strength
            if (strength < 25) {
                meter.style.backgroundColor = '#dc3545';
                text.textContent = 'Very Weak';
                text.style.color = '#dc3545';
            } else if (strength < 50) {
                meter.style.backgroundColor = '#ffc107';
                text.textContent = 'Weak';
                text.style.color = '#ffc107';
            } else if (strength < 75) {
                meter.style.backgroundColor = '#fd7e14';
                text.textContent = 'Medium';
                text.style.color = '#fd7e14';
            } else if (strength < 100) {
                meter.style.backgroundColor = '#20c997';
                text.textContent = 'Strong';
                text.style.color = '#20c997';
            } else {
                meter.style.backgroundColor = '#28a745';
                text.textContent = 'Very Strong';
                text.style.color = '#28a745';
            }
        }
        
        function checkPasswordMatch() {
            const password = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const matchText = document.getElementById('passwordMatch');
            const mismatchText = document.getElementById('passwordMismatch');
            
            if (confirmPassword.length === 0) {
                matchText.style.display = 'none';
                mismatchText.style.display = 'none';
                return;
            }
            
            if (password === confirmPassword) {
                matchText.style.display = 'block';
                mismatchText.style.display = 'none';
            } else {
                matchText.style.display = 'none';
                mismatchText.style.display = 'block';
            }
        }
        
        function validateForm() {
            const password = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                alert('Passwords do not match');
                return false;
            }
            
            if (password.length < 6) {
                alert('Password must be at least 6 characters long');
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>
