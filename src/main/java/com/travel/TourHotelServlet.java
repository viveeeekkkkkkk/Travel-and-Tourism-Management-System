package com.travel;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/TourHotelServlet")
public class TourHotelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            int tourId = Integer.parseInt(request.getParameter("tour_id"));
            int hotelId = Integer.parseInt(request.getParameter("hotel_id"));
            int placeNo = Integer.parseInt(request.getParameter("place_no"));

            try (Connection conn = DBConnect.getConnection();
                 PreparedStatement ps = conn.prepareStatement(
                     "DELETE FROM tour_hotel_link WHERE tour_id=? AND hotel_id=? AND place_no=?")) {
                ps.setInt(1, tourId);
                ps.setInt(2, hotelId);
                ps.setInt(3, placeNo);
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        request.getRequestDispatcher("tourhotel.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int tourId = Integer.parseInt(request.getParameter("tour_id"));
        int hotelId = Integer.parseInt(request.getParameter("hotel_id"));
        int placeNo = Integer.parseInt(request.getParameter("place_no"));

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "INSERT INTO tour_hotel_link (tour_id, hotel_id, place_no) VALUES (?, ?, ?)")) {
            ps.setInt(1, tourId);
            ps.setInt(2, hotelId);
            ps.setInt(3, placeNo);
            ps.executeUpdate();

            request.setAttribute("success", "Hotel successfully linked to Tour!");
        } catch (SQLIntegrityConstraintViolationException e) {
            request.setAttribute("error", "This Hotel is already linked to Tour " + tourId + " for Stop " + placeNo + ".");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Link error: " + e.getMessage());
        }
        request.getRequestDispatcher("tourhotel.jsp").forward(request, response);
    }
}