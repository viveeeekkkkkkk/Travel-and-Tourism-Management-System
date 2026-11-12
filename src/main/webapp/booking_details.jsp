<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.travel.DBConnect" %>
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
    <title>My Bookings</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="navbar">
        <span class="brand">Travel & Tourism</span>
        <div>
            <a href="client_dashboard.jsp">Dashboard</a>
            <a href="BookingServlet?action=loadForm">New Booking</a>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert-success"><%= request.getAttribute("success") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>

        <div class="card">
            <h2>My Reservation History</h2>
            <table>
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Tour</th>
                        <th>Travel Date</th>
                        <th>Persons</th>
                        <th>Rooms</th>
                        <th>Type</th>
                        <th>Total (₹)</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try (Connection conn = DBConnect.getConnection();
                         PreparedStatement ps = conn.prepareStatement(
                             "SELECT b.*, t.tour_nm FROM bookings b " +
                             "JOIN tours t ON b.tour_id = t.tour_id " +
                             "WHERE b.username = ? ORDER BY b.book_id DESC")) {
                        ps.setString(1, username);
                        ResultSet rs = ps.executeQuery();
                        boolean hasData = false;
                        while (rs.next()) {
                            hasData = true;
                            int bookId = rs.getInt("book_id");
                %>
                    <tr>
                        <td>#<%= bookId %></td>
                        <td><%= rs.getString("tour_nm") %></td>
                        <td><%= rs.getDate("bookdt") %></td>
                        <td><%= rs.getInt("persons") %></td>
                        <td><%= rs.getInt("rooms") %></td>
                        <td><%= rs.getString("room_type") %></td>
                        <td><strong>₹<%= rs.getDouble("total_price") %></strong></td>
                        <td>
                            <a href="BookingServlet?action=cancel&book_id=<%= bookId %>" 
                               class="btn btn-sm btn-danger" 
                               onclick="return confirm('Are you sure you want to cancel Booking #<%= bookId %>?');">
                               Cancel
                            </a>
                        </td>
                    </tr>
                <%
                        }
                        if (!hasData) {
                %>
                    <tr><td colspan="8" style="text-align: center; color: #64748b;">No bookings placed yet.</td></tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>