package com.travel;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("mybookings".equalsIgnoreCase(action)) {
            request.getRequestDispatcher("booking_details.jsp").forward(request, response);
            return;
        }

        if ("loadForm".equalsIgnoreCase(action)) {
            request.getRequestDispatcher("booking.jsp").forward(request, response);
            return;
        }

        if ("search".equalsIgnoreCase(action)) {
            int bookId = Integer.parseInt(request.getParameter("book_id"));
            try (Connection conn = DBConnect.getConnection();
                 PreparedStatement ps = conn.prepareStatement(
                     "SELECT b.*, t.tour_nm FROM bookings b JOIN tours t ON b.tour_id = t.tour_id WHERE b.book_id = ?")) {
                ps.setInt(1, bookId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    request.setAttribute("found", true);
                    request.setAttribute("book_id", rs.getInt("book_id"));
                    request.setAttribute("tour_nm", rs.getString("tour_nm"));
                    request.setAttribute("username", rs.getString("username"));
                    request.setAttribute("bookdt", rs.getDate("bookdt"));
                    request.setAttribute("persons", rs.getInt("persons"));
                    request.setAttribute("rooms", rs.getInt("rooms"));
                    request.setAttribute("room_type", rs.getString("room_type"));
                    request.setAttribute("total_price", rs.getDouble("total_price"));
                } else {
                    request.setAttribute("error", "No reservation found with Booking ID #" + bookId);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("searchbooking.jsp").forward(request, response);
            return;
        }

        if ("cancel".equalsIgnoreCase(action)) {
            HttpSession session = request.getSession(false);
            String username = (session != null) ? (String) session.getAttribute("username") : null;

            if (username == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int bookId = Integer.parseInt(request.getParameter("book_id"));
            try (Connection conn = DBConnect.getConnection();
                 PreparedStatement ps = conn.prepareStatement(
                     "DELETE FROM bookings WHERE book_id = ? AND username = ?")) {
                ps.setInt(1, bookId);
                ps.setString(2, username);
                int rows = ps.executeUpdate();

                if (rows > 0) {
                    request.setAttribute("success", "Booking #" + bookId + " has been cancelled.");
                } else {
                    request.setAttribute("error", "Unable to cancel booking #" + bookId + ".");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Cancellation error: " + e.getMessage());
            }
            request.getRequestDispatcher("booking_details.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("client_dashboard.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = DBConnect.getConnection()) {
            int tourId = Integer.parseInt(request.getParameter("tour_id"));
            String roomType = request.getParameter("room_type");
            int persons = Integer.parseInt(request.getParameter("persons"));
            int rooms = Integer.parseInt(request.getParameter("rooms"));
            String bookdt = request.getParameter("bookdt");

            // Fetch tour price
            PreparedStatement psPrice = conn.prepareStatement("SELECT price FROM tours WHERE tour_id = ?");
            psPrice.setInt(1, tourId);
            ResultSet rsP = psPrice.executeQuery();
            double pricePerPerson = 0;
            if (rsP.next()) {
                pricePerPerson = rsP.getDouble("price");
            }

            // Total price calculation: (price * persons) + extra if AC
            double total = pricePerPerson * persons;
            if ("AC".equalsIgnoreCase(roomType)) {
                total += (500 * rooms); // ₹500 extra per AC room
            }

            // Fetch up to 3 hotels linked to this tour for places 1, 2, 3
            Integer h1 = null, h2 = null, h3 = null;
            PreparedStatement psH = conn.prepareStatement("SELECT hotel_id, place_no FROM tour_hotel_link WHERE tour_id = ?");
            psH.setInt(1, tourId);
            ResultSet rsH = psH.executeQuery();
            while (rsH.next()) {
                int pNo = rsH.getInt("place_no");
                if (pNo == 1) h1 = rsH.getInt("hotel_id");
                else if (pNo == 2) h2 = rsH.getInt("hotel_id");
                else if (pNo == 3) h3 = rsH.getInt("hotel_id");
            }

            String insertSQL = "INSERT INTO bookings (tour_id, hotel_id1, hotel_id2, hotel_id3, room_type, bookdt, username, persons, rooms, price_per_person, total_price) " +
                               "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, tourId);
            if (h1 != null) ps.setInt(2, h1); else ps.setNull(2, java.sql.Types.INTEGER);
            if (h2 != null) ps.setInt(3, h2); else ps.setNull(3, java.sql.Types.INTEGER);
            if (h3 != null) ps.setInt(4, h3); else ps.setNull(4, java.sql.Types.INTEGER);
            ps.setString(5, roomType);
            ps.setDate(6, java.sql.Date.valueOf(bookdt));
            ps.setString(7, username);
            ps.setInt(8, persons);
            ps.setInt(9, rooms);
            ps.setDouble(10, pricePerPerson);
            ps.setDouble(11, total);
            ps.executeUpdate();

            ResultSet genKeys = ps.getGeneratedKeys();
            int newBookId = 0;
            if (genKeys.next()) {
                newBookId = genKeys.getInt(1);
            }

            request.setAttribute("success", "Trip booked! Your Booking ID is #" + newBookId);
            request.getRequestDispatcher("booking_details.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Booking failed: " + e.getMessage());
            request.getRequestDispatcher("booking.jsp").forward(request, response);
        }
    }
}