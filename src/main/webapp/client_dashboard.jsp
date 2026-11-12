<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Client Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="navbar">
        <span class="brand">Travel & Tourism</span>
        <div>
            <span style="color: #94a3b8; margin-right: 15px;">User: <%= session.getAttribute("name") %></span>
            <a href="client_dashboard.jsp">Dashboard</a>
            <a href="BookingServlet?action=mybookings">My Bookings</a>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Customer Portal</h2>
        <div class="form-grid" style="grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));">
            <div class="card">
                <h3>Explore Tours</h3>
                <p style="color: #64748b; font-size: 14px; margin-bottom: 14px;">Browse travel packages, itineraries, and prices.</p>
                <a href="TourServlet?action=clientSearch" class="btn">Search Tours</a>
            </div>

            <div class="card">
                <h3>Reserve a Trip</h3>
                <p style="color: #64748b; font-size: 14px; margin-bottom: 14px;">Book an itinerary with preferred hotel options.</p>
                <a href="BookingServlet?action=loadForm" class="btn">Book Now</a>
            </div>

            <div class="card">
                <h3>My Reservations</h3>
                <p style="color: #64748b; font-size: 14px; margin-bottom: 14px;">View your confirmed bookings and totals.</p>
                <a href="BookingServlet?action=mybookings" class="btn">View Bookings</a>
            </div>
        </div>
    </div>

</body>
</html>