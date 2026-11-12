<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.travel.DBConnect" %>

<%
    String role = (String) session.getAttribute("role");

    if (!"ADMIN".equalsIgnoreCase(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    String msg = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String id = request.getParameter("tour_id");
        String date = request.getParameter("startdt");
        String price = request.getParameter("price");

        if (id == null || date == null || price == null ||
            id.trim().isEmpty() || date.trim().isEmpty() ||
            price.trim().isEmpty()) {

            msg = "Please fill all fields.";

        } else {

            try {

                Connection con = DBConnect.getConnection();

                String sql = "UPDATE tours SET startdt=?, price=? " +
                             "WHERE tour_id=?";

                PreparedStatement ps = con.prepareStatement(sql);

                ps.setDate(1, Date.valueOf(date));
                ps.setDouble(2, Double.parseDouble(price));
                ps.setInt(3, Integer.parseInt(id));

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    msg = "Tour updated successfully.";
                } else {
                    msg = "Tour ID not found.";
                }

                ps.close();
                con.close();

            } catch (Exception e) {

                msg = "Unable to update tour.";
                e.printStackTrace();
            }
        }
    }
%>


<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Update Tour</title>

    <link rel="stylesheet" href="style.css">

</head>

<body>

    <nav class="navbar">

        <div class="navbar-inner">

            <a href="admin_dashboard.jsp" class="logo">
                Travel & Tourism
            </a>

            <div class="nav-links">

                <a href="admin_dashboard.jsp">Dashboard</a>
                <a href="tour.jsp">Add Tour</a>
                <a href="tourupd.jsp">Update Tour</a>
                <a href="tourdel.jsp">Delete Tour</a>
                <a href="logout.jsp">Logout</a>

            </div>

        </div>

    </nav>


    <main class="container">

        <div class="form-container">

            <h2>Update Tour</h2>

            <% if (!msg.isEmpty()) { %>

                <div class="success-message">
                    <%= msg %>
                </div>

            <% } %>


            <form method="post">

                <div class="form-group">

                    <label>Tour ID</label>

                    <input type="number"
                           name="tour_id"
                           class="form-control"
                           required>

                </div>


                <div class="form-group">

                    <label>New Start Date</label>

                    <input type="date"
                           name="startdt"
                           class="form-control"
                           required>

                </div>


                <div class="form-group">

                    <label>New Price</label>

                    <input type="number"
                           name="price"
                           step="0.01"
                           class="form-control"
                           required>

                </div>


                <button type="submit" class="btn btn-primary">
                    Update Tour
                </button>

                <a href="admin_dashboard.jsp"
                   class="btn btn-secondary">
                    Back
                </a>

            </form>

        </div>

    </main>

</body>

</html>