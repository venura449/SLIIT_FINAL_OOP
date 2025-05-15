<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link rel="stylesheet" href="reset-ptassword-page.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
</head>
<body>
    <div class="reset-password-container">
        <h2>Reset Your Password</h2>
        <p>Enter your new password below.</p>

        <form id="resetPasswordForm">
            <label for="new-password">New Password</label>
            <div class="password-wrapper">
                <input type="password" id="new-password" placeholder="Enter new password" required>
                <span class="toggle-password" onclick="togglePassword('new-password')">👁</span>
            </div>

            <label for="confirm-password">Confirm Password</label>
            <div class="password-wrapper">
                <input type="password" id="confirm-password" placeholder="Confirm new password" required>
                <span class="toggle-password" onclick="togglePassword('confirm-password')">👁</span>
            </div>

            <button type="submit" class="btn">Reset Password</button>
        </form>

        <a href="../Login/login.jsp" class="back-link">Back to Login</a>
    </div>

    <script src="reset-ptassword-page.js"></script>
</body>
</html>
