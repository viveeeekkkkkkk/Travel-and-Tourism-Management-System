<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.travel.DBConnect" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String selectedTourId = request.getParameter("tour_id");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Tour</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="navbar">
        <span class="brand">Travel & Tourism</span>
        <div>
            <a href="client_dashboard.jsp">Dashboard</a>
            <a href="BookingServlet?action=mybookings">My Bookings</a>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container" style="max-width: 540px;">
        <div class="card">
            <h2>Book a Tour Package</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="BookingServlet" method="post">
                <div class="form-group">
                    <label>Select Tour</label>
                    <select name="tour_id" required>
                        <option value="">-- Choose Tour --</option>
                        <%
                            try (Connection conn = DBConnect.getConnection();
                                 ResultSet rs = conn.createStatement().executeQuery("SELECT tour_id, tour_nm, price FROM tours")) {
                                while (rs.next()) {
                                    int tid = rs.getInt("tour_id");
                                    boolean sel = (selectedTourId != null && selectedTourId.equals(String.valueOf(tid)));
                        %>
                            <option value="<%= tid %>" <%= sel ? "selected" : "" %>>
                                <%= rs.getString("tour_nm") %> (₹<%= rs.getDouble("price") %>/person)
                            </option>
                        <%      }
                            } catch(Exception e){}
                        %>
                    </select>
                </div>

                <div class="form-grid">
                    <div class="form-group">
                        <label>Room Preference</label>
                        <select name="room_type">
                            <option value="NON AC">NON AC</option>
                            <option value="AC">AC (+₹500/room)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Travel Date</label>
                        <input type="date" name="bookdt" required>
                    </div>

                    <div class="form-group">
                        <label>Number of Persons</label>
                        <input type="number" name="persons" min="1" value="1" required>
                    </div>

                    <div class="form-group">
                        <label>Number of Rooms</label>
                        <input type="number" name="rooms" min="1" value="1" required>
                    </div>
                </div>

                <button type="submit" class="btn" style="width: 100%; margin-top: 12px;">Confirm & Book</button>
            </form>
        </div>
    </div>

</body>
</html>