<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Driving School</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #e2e2e2, #c9d6ff);
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        
        .error-container {
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.35);
            max-width: 600px;
            width: 90%;
        }
        
        h1 {
            color: #e74c3c;
            margin-bottom: 20px;
        }
        
        p {
            color: #34495e;
            font-size: 18px;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-weight: 600;
            background-color: #2c3e50;
            color: white;
        }
        
        .btn:hover {
            background-color: #1a252f;
            transform: scale(1.05);
        }
        
        .error-icon {
            font-size: 60px;
            color: #e74c3c;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">✗</div>
        <h1>Oops! Something went wrong</h1>
        <p>
            <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage == null || errorMessage.isEmpty()) {
                    errorMessage = "An unexpected error occurred. Please try again later.";
                }
                out.println(errorMessage);
            %>
        </p>
        <a href="Home page/homepage.jsp" class="btn">Return to Homepage</a>
    </div>
</body>
</html>
