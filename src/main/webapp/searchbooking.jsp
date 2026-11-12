<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"ADMIN".equalsIgnoreCase(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Booking</title>
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
            <h2>Lookup Customer Booking</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="BookingServlet" method="get">
                <input type="hidden" name="action" value="search">
                <div class="form-group">
                    <label>Enter Booking ID</label>
                    <input type="number" name="book_id" placeholder="e.g. 1" required>
                </div>
                <button type="submit" class="btn">Search</button>
            </form>
        </div>

        <% if (request.getAttribute("found") != null) { %>
        <div class="card">
            <h2>Booking #<%= request.getAttribute("book_id") %> Details</h2>
            <table>
                <tr><th>Customer Username</th><td><%= request.getAttribute("username") %></td></tr>
                <tr><th>Tour Name</th><td><%= request.getAttribute("tour_nm") %></td></tr>
                <tr><th>Travel Date</th><td><%= request.getAttribute("bookdt") %></td></tr>
                <tr><th>Travelers</th><td><%= request.getAttribute("persons") %> Persons (<%= request.getAttribute("rooms") %> Rooms)</td></tr>
                <tr><th>Room Type</th><td><%= request.getAttribute("room_type") %></td></tr>
                <tr><th>Total Price</th><td><strong>₹<%= request.getAttribute("total_price") %></strong></td></tr>
            </table>
        </div>
        <% } %>
    </div>

</body>
</html>