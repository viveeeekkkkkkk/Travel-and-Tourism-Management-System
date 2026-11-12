<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Travel & Tourism</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="navbar">
        <span class="brand">Travel & Tourism</span>
        <div>
            <a href="index.jsp">Home</a>
            <a href="register.jsp">Register</a>
        </div>
    </div>

    <div class="container" style="max-width: 400px; margin-top: 60px;">
        <div class="card">
            <h2>Sign In</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="login" method="post">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>
                <button type="submit" class="btn" style="width: 100%; margin-top: 10px;">Login</button>
            </form>
            <p style="margin-top: 16px; font-size: 13px; text-align: center;">
                Need an account? <a href="register.jsp">Register here</a>
            </p>
        </div>
    </div>

</body>
</html>