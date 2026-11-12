<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Travel & Tourism Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
        }
        .hero-section {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background: linear-gradient(rgba(15, 23, 42, 0.58), rgba(15, 23, 42, 0.58)),
                        url('https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1600&q=80') center/cover no-repeat;
            color: #ffffff;
            text-align: center;
            padding: 60px 20px;
        }
        .hero-section h1 {
            color: #ffffff;
            font-size: 40px;
            margin-bottom: 14px;
            letter-spacing: -0.5px;
        }
        .hero-section p {
            color: #e2e8f0;
            font-size: 16px;
            max-width: 600px;
            margin: 0 auto 28px auto;
        }
    </style>
</head>
<body>

    <div class="navbar">
        <span class="brand">Travel & Tourism</span>
        <div>
            <a href="index.jsp">Home</a>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
        </div>
    </div>

    <div class="hero-section">
        <h1>Discover Your Next Destination</h1>
        <p>
            Explore curated tour packages across scenic mountains, heritage cities, and coastal getaways with verified hotel stays and instant booking.
        </p>
        <a href="login.jsp" class="btn" style="padding: 12px 28px; font-size: 15px;">Explore Tour Packages</a>
    </div>

</body>
</html>