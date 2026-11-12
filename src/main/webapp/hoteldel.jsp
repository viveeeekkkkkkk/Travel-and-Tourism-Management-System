<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Hotel</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="navbar">
        <span class="brand">Admin Portal</span>
        <div>
            <a href="admin_dashboard.jsp">Dashboard</a>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container" style="max-width: 500px;">
        <div class="card">
            <h2>Delete Hotel</h2>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert-success"><%= request.getAttribute("success") %></div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="HotelServlet" method="post" onsubmit="return confirm('Delete this hotel?');">
                <input type="hidden" name="action" value="delete">
                <div class="form-group">
                    <label>Hotel ID</label>
                    <input type="number" name="hotel_id" required>
                </div>
                <button type="submit" class="btn btn-danger" style="width: 100%;">Delete Hotel</button>
            </form>
        </div>
    </div>

</body>
</html>