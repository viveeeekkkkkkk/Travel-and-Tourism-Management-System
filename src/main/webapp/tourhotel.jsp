<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.travel.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tour & Hotel Link</title>
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

    <div class="container">
        <div class="card">
            <h2>Link Hotel to Tour Stop</h2>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert-success"><%= request.getAttribute("success") %></div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="TourHotelServlet" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Select Tour</label>
                        <select name="tour_id" required>
                            <option value="">-- Choose Tour --</option>
                            <%
                                try (Connection conn = DBConnect.getConnection();
                                     ResultSet rsT = conn.createStatement().executeQuery("SELECT tour_id, tour_nm FROM tours")) {
                                    while (rsT.next()) {
                            %>
                                <option value="<%= rsT.getInt("tour_id") %>"><%= rsT.getInt("tour_id") %> - <%= rsT.getString("tour_nm") %></option>
                            <%      }
                                } catch(Exception e){}
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Select Hotel</label>
                        <select name="hotel_id" required>
                            <option value="">-- Choose Hotel --</option>
                            <%
                                try (Connection conn = DBConnect.getConnection();
                                     ResultSet rsH = conn.createStatement().executeQuery("SELECT hotel_id, hotel_name, tplace FROM hotels")) {
                                    while (rsH.next()) {
                            %>
                                <option value="<%= rsH.getInt("hotel_id") %>"><%= rsH.getInt("hotel_id") %> - <%= rsH.getString("hotel_name") %> (<%= rsH.getString("tplace") %>)</option>
                            <%      }
                                } catch(Exception e){}
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Place Number</label>
                        <select name="place_no" required>
                            <option value="1">1 (First Stop)</option>
                            <option value="2">2 (Second Stop)</option>
                            <option value="3">3 (Third Stop)</option>
                        </select>
                    </div>
                </div>
                <button type="submit" class="btn" style="margin-top: 10px;">Create Link</button>
            </form>
        </div>

        <div class="card">
            <h2>Active Tour-Hotel Linkages</h2>
            <table>
                <thead>
                    <tr>
                        <th>Tour</th>
                        <th>Hotel</th>
                        <th>Stop #</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try (Connection conn = DBConnect.getConnection();
                         Statement st = conn.createStatement();
                         ResultSet rs = st.executeQuery(
                             "SELECT l.tour_id, t.tour_nm, l.hotel_id, h.hotel_name, l.place_no " +
                             "FROM tour_hotel_link l " +
                             "JOIN tours t ON l.tour_id = t.tour_id " +
                             "JOIN hotels h ON l.hotel_id = h.hotel_id ORDER BY l.tour_id, l.place_no")) {
                        while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getInt("tour_id") %> - <%= rs.getString("tour_nm") %></td>
                        <td><%= rs.getInt("hotel_id") %> - <%= rs.getString("hotel_name") %></td>
                        <td>Stop <%= rs.getInt("place_no") %></td>
                        <td>
                            <a href="TourHotelServlet?action=delete&tour_id=<%= rs.getInt("tour_id") %>&hotel_id=<%= rs.getInt("hotel_id") %>&place_no=<%= rs.getInt("place_no") %>" class="btn btn-sm btn-danger">Remove</a>
                        </td>
                    </tr>
                <%
                        }
                    } catch (Exception e) {}
                %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>