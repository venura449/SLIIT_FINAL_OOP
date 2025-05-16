<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="forgotpassword.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
</head>
<body>
    <div class="forgot-password-container">
        <h2>Forgot Your Password?</h2>
        <p>Enter your email address below and we'll send you a link to reset your password.</p>
        
        <form id="forgotPasswordForm" >
            <label for="email">Email Address</label>
            <input type="email" id="email" placeholder="Enter your email" required>
            <button type="submit"  name="submit" class="btn">Reset Password</button>
        </form>

        <a href="../Login/login.jsp" class="back-link">Back to Login</a>
    </div>
</body>
</html>
