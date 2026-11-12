<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Hotel</title>
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
            <h2>Search Hotel to Update</h2>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert-success"><%= request.getAttribute("success") %></div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="HotelServlet" method="get">
                <input type="hidden" name="action" value="fetchForUpdate">
                <div class="form-group">
                    <label>Enter Hotel ID</label>
                    <input type="number" name="hotel_id" required>
                </div>
                <button type="submit" class="btn">Search</button>
            </form>
        </div>

        <% if (request.getAttribute("found") != null) { %>
        <div class="card">
            <h2>Update Hotel Details</h2>
            <form action="HotelServlet" method="post">
                <input type="hidden" name="action" value="update">
                <div class="form-group">
                    <label>Hotel ID</label>
                    <input type="number" name="hotel_id" value="<%= request.getAttribute("hotel_id") %>" readonly style="background:#f1f5f9;">
                </div>
                <div class="form-group">
                    <label>Hotel Name</label>
                    <input type="text" name="hotel_name" value="<%= request.getAttribute("hotel_name") %>" required>
                </div>
                <div class="form-group">
                    <label>Location / City</label>
                    <input type="text" name="tplace" value="<%= request.getAttribute("tplace") %>" required>
                </div>
                <button type="submit" class="btn">Update Hotel</button>
            </form>
        </div>
        <% } %>
    </div>

</body>
</html>