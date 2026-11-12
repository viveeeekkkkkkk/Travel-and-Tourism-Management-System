<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.travel.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Tours</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="navbar">
        <span class="brand">Travel & Tourism</span>
        <div>
            <a href="client_dashboard.jsp">Dashboard</a>
            <a href="BookingServlet?action=loadForm">Book</a>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="card">
            <h2>Available Tour Packages</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tour Name</th>
                        <th>Destinations</th>
                        <th>Linked Hotels</th>
                        <th>Start Date</th>
                        <th>Price (₹)</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try (Connection conn = DBConnect.getConnection();
                         Statement st = conn.createStatement();
                         ResultSet rs = st.executeQuery("SELECT * FROM tours")) {
                        boolean hasData = false;
                        while (rs.next()) {
                            hasData = true;
                            int tourId = rs.getInt("tour_id");
                %>
                    <tr>
                        <td><%= tourId %></td>
                        <td><strong><%= rs.getString("tour_nm") %></strong></td>
                        <td>
                            <%= rs.getString("tplace1") %>
                            <%= rs.getString("tplace2") != null && !rs.getString("tplace2").isEmpty() ? " &rarr; " + rs.getString("tplace2") : "" %>
                            <%= rs.getString("tplace3") != null && !rs.getString("tplace3").isEmpty() ? " &rarr; " + rs.getString("tplace3") : "" %>
                        </td>
                        <td style="font-size: 13px; color: #475569;">
                            <%
                                try (PreparedStatement psH = conn.prepareStatement(
                                    "SELECT l.place_no, h.hotel_name FROM tour_hotel_link l " +
                                    "JOIN hotels h ON l.hotel_id = h.hotel_id WHERE l.tour_id = ? ORDER BY l.place_no")) {
                                    psH.setInt(1, tourId);
                                    ResultSet rsH = psH.executeQuery();
                                    boolean hasHotels = false;
                                    while (rsH.next()) {
                                        hasHotels = true;
                            %>
                                        <div>Stop <%= rsH.getInt("place_no") %>: <%= rsH.getString("hotel_name") %></div>
                            <%
                                    }
                                    if (!hasHotels) {
                                        out.print("<span style='color:#94a3b8;'>Not assigned</span>");
                                    }
                                }
                            %>
                        </td>
                        <td><%= rs.getDate("startdt") %></td>
                        <td>₹<%= rs.getDouble("price") %></td>
                        <td>
                            <a href="BookingServlet?action=loadForm&tour_id=<%= tourId %>" class="btn btn-sm">Book</a>
                        </td>
                    </tr>
                <%
                        }
                        if (!hasData) {
                %>
                    <tr><td colspan="7" style="text-align: center; color: #64748b;">No tours scheduled currently.</td></tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>