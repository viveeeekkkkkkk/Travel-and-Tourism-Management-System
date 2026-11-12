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
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="navbar">
        <span class="brand">Admin Portal</span>
        <div>
            <span style="color: #94a3b8; margin-right: 15px;">Welcome, <%= session.getAttribute("name") %></span>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>System Administration</h2>
        <div class="form-grid" style="grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));">
            <div class="card">
                <h3>Tour Management</h3>
                <p style="color: #64748b; font-size: 14px; margin-bottom: 14px;">Create, update, or remove travel destinations.</p>
                <a href="tour.jsp" class="btn btn-sm">Add Tour</a>
                <a href="tourupd.jsp" class="btn btn-sm" style="background:#475569;">Update</a>
                <a href="tourdel.jsp" class="btn btn-sm btn-danger">Delete</a>
            </div>

            <div class="card">
                <h3>Hotel Management</h3>
                <p style="color: #64748b; font-size: 14px; margin-bottom: 14px;">Maintain hotel listings across destinations.</p>
                <a href="hotel.jsp" class="btn btn-sm">Add Hotel</a>
                <a href="hotelupd.jsp" class="btn btn-sm" style="background:#475569;">Update</a>
                <a href="hoteldel.jsp" class="btn btn-sm btn-danger">Delete</a>
            </div>

            <div class="card">
                <h3>Tour-Hotel Link</h3>
                <p style="color: #64748b; font-size: 14px; margin-bottom: 14px;">Map available hotels to specific tour stops.</p>
                <a href="TourHotelServlet?action=list" class="btn btn-sm">Manage Links</a>
            </div>

            <div class="card">
                <h3>Customer Bookings</h3>
                <p style="color: #64748b; font-size: 14px; margin-bottom: 14px;">Search and inspect customer reservation records.</p>
                <a href="searchbooking.jsp" class="btn btn-sm">Search Bookings</a>
            </div>
        </div>
    </div>

</body>
</html>