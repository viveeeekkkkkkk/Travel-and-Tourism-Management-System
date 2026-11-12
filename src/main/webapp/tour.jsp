<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Tour</title>
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

    <div class="container" style="max-width: 600px;">
        <div class="card">
            <h2>Add New Tour Package</h2>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert-success"><%= request.getAttribute("success") %></div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="TourServlet" method="post">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label>Tour ID (Integer)</label>
                    <input type="number" name="tour_id" required>
                </div>
                <div class="form-group">
                    <label>Tour Name</label>
                    <input type="text" name="tour_nm" required>
                </div>
                <div class="form-group">
                    <label>Destination Stop 1</label>
                    <input type="text" name="tplace1" required>
                </div>
                <div class="form-group">
                    <label>Destination Stop 2</label>
                    <input type="text" name="tplace2">
                </div>
                <div class="form-group">
                    <label>Destination Stop 3</label>
                    <input type="text" name="tplace3">
                </div>
                <div class="form-group">
                    <label>Start Date</label>
                    <input type="date" name="startdt" required>
                </div>
                <div class="form-group">
                    <label>Price (₹)</label>
                    <input type="number" step="0.01" name="price" required>
                </div>
                <button type="submit" class="btn" style="width: 100%;">Create Tour</button>
            </form>
        </div>
    </div>

</body>
</html>