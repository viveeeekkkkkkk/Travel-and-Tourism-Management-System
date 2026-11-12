package com.travel;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/TourServlet")
public class TourServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("fetchForUpdate".equalsIgnoreCase(action)) {
            int tourId = Integer.parseInt(request.getParameter("tour_id"));
            try (Connection conn = DBConnect.getConnection();
                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM tours WHERE tour_id = ?")) {
                ps.setInt(1, tourId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    request.setAttribute("tour_id", rs.getInt("tour_id"));
                    request.setAttribute("tour_nm", rs.getString("tour_nm"));
                    request.setAttribute("tplace1", rs.getString("tplace1"));
                    request.setAttribute("tplace2", rs.getString("tplace2"));
                    request.setAttribute("tplace3", rs.getString("tplace3"));
                    request.setAttribute("startdt", rs.getDate("startdt"));
                    request.setAttribute("price", rs.getDouble("price"));
                    request.setAttribute("found", true);
                } else {
                    request.setAttribute("error", "No tour found with ID " + tourId);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("tourupd.jsp").forward(request, response);
            return;
        }

        if ("clientSearch".equalsIgnoreCase(action)) {
            request.getRequestDispatcher("searchtour.jsp").forward(request, response);
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
                int tourId = Integer.parseInt(request.getParameter("tour_id"));
                String tourNm = request.getParameter("tour_nm");
                String tplace1 = request.getParameter("tplace1");
                String tplace2 = request.getParameter("tplace2");
                String tplace3 = request.getParameter("tplace3");
                String startdt = request.getParameter("startdt");
                double price = Double.parseDouble(request.getParameter("price"));

                PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO tours (tour_id, tour_nm, tplace1, tplace2, tplace3, startdt, price) VALUES (?, ?, ?, ?, ?, ?, ?)");
                ps.setInt(1, tourId);
                ps.setString(2, tourNm);
                ps.setString(3, tplace1);
                ps.setString(4, tplace2);
                ps.setString(5, tplace3);
                ps.setDate(6, java.sql.Date.valueOf(startdt));
                ps.setDouble(7, price);
                ps.executeUpdate();

                request.setAttribute("success", "Tour package created successfully!");
                request.getRequestDispatcher("tour.jsp").forward(request, response);

            } else if ("update".equalsIgnoreCase(action)) {
                int tourId = Integer.parseInt(request.getParameter("tour_id"));
                String tourNm = request.getParameter("tour_nm");
                String tplace1 = request.getParameter("tplace1");
                String tplace2 = request.getParameter("tplace2");
                String tplace3 = request.getParameter("tplace3");
                String startdt = request.getParameter("startdt");
                double price = Double.parseDouble(request.getParameter("price"));

                PreparedStatement ps = conn.prepareStatement(
                    "UPDATE tours SET tour_nm=?, tplace1=?, tplace2=?, tplace3=?, startdt=?, price=? WHERE tour_id=?");
                ps.setString(1, tourNm);
                ps.setString(2, tplace1);
                ps.setString(3, tplace2);
                ps.setString(4, tplace3);
                ps.setDate(5, java.sql.Date.valueOf(startdt));
                ps.setDouble(6, price);
                ps.setInt(7, tourId);
                ps.executeUpdate();

                request.setAttribute("success", "Tour updated successfully!");
                request.getRequestDispatcher("tourupd.jsp").forward(request, response);

            } else if ("delete".equalsIgnoreCase(action)) {
                int tourId = Integer.parseInt(request.getParameter("tour_id"));
                PreparedStatement ps = conn.prepareStatement("DELETE FROM tours WHERE tour_id = ?");
                ps.setInt(1, tourId);
                int rows = ps.executeUpdate();

                if (rows > 0) {
                    request.setAttribute("success", "Tour deleted successfully!");
                } else {
                    request.setAttribute("error", "Tour ID not found!");
                }
                request.getRequestDispatcher("tourdel.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
        }
    }
}