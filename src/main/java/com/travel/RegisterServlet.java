package com.travel;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        try (Connection conn = DBConnect.getConnection()) {
            // Check if username or email is already registered
            PreparedStatement checkPs = conn.prepareStatement(
                "SELECT username FROM users WHERE username = ? OR email = ?");
            checkPs.setString(1, username);
            checkPs.setString(2, email);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                request.setAttribute("error", "Username or Email already taken!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Insert new customer (default role CLIENT)
            PreparedStatement insertPs = conn.prepareStatement(
                "INSERT INTO users (username, password, name, email, phone, role) VALUES (?, ?, ?, ?, ?, 'CLIENT')");
            insertPs.setString(1, username);
            insertPs.setString(2, password);
            insertPs.setString(3, name);
            insertPs.setString(4, email);
            insertPs.setString(5, phone);
            insertPs.executeUpdate();

            request.setAttribute("success", "Registration complete! Please sign in.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Registration error: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}