package com.travel;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/HotelServlet")
public class HotelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("fetchForUpdate".equalsIgnoreCase(action)) {
            int hotelId = Integer.parseInt(request.getParameter("hotel_id"));
            try (Connection conn = DBConnect.getConnection();
                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM hotels WHERE hotel_id = ?")) {
                ps.setInt(1, hotelId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    request.setAttribute("hotel_id", rs.getInt("hotel_id"));
                    request.setAttribute("hotel_name", rs.getString("hotel_name"));
                    request.setAttribute("tplace", rs.getString("tplace"));
                    request.setAttribute("found", true);
                } else {
                    request.setAttribute("error", "No hotel found with ID " + hotelId);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("hotelupd.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("admin_dashboard.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try (Connection conn = DBConnect.getConnection()) {
            if ("add".equalsIgnoreCase(action)) {
                int hotelId = Integer.parseInt(request.getParameter("hotel_id"));
                String hotelName = request.getParameter("hotel_name");
                String tplace = request.getParameter("tplace");

                PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO hotels (hotel_id, hotel_name, tplace) VALUES (?, ?, ?)");
                ps.setInt(1, hotelId);
                ps.setString(2, hotelName);
                ps.setString(3, tplace);
                ps.executeUpdate();

                request.setAttribute("success", "Hotel added successfully!");
                request.getRequestDispatcher("hotel.jsp").forward(request, response);

            } else if ("update".equalsIgnoreCase(action)) {
                int hotelId = Integer.parseInt(request.getParameter("hotel_id"));
                String hotelName = request.getParameter("hotel_name");
                String tplace = request.getParameter("tplace");

                PreparedStatement ps = conn.prepareStatement(
                    "UPDATE hotels SET hotel_name=?, tplace=? WHERE hotel_id=?");
                ps.setString(1, hotelName);
                ps.setString(2, tplace);
                ps.setInt(3, hotelId);
                ps.executeUpdate();

                request.setAttribute("success", "Hotel updated successfully!");
                request.getRequestDispatcher("hotelupd.jsp").forward(request, response);

            } else if ("delete".equalsIgnoreCase(action)) {
                int hotelId = Integer.parseInt(request.getParameter("hotel_id"));
                PreparedStatement ps = conn.prepareStatement("DELETE FROM hotels WHERE hotel_id = ?");
                ps.setInt(1, hotelId);
                int rows = ps.executeUpdate();

                if (rows > 0) {
                    request.setAttribute("success", "Hotel deleted successfully!");
                } else {
                    request.setAttribute("error", "Hotel ID not found!");
                }
                request.getRequestDispatcher("hoteldel.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
        }
    }
}