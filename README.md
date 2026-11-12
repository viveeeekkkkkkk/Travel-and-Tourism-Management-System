# Travel and Tourism Management System

A full-stack web application built with **Java Servlets, JSP, JDBC, and MySQL 8.0** that streamlines tour package management, stop-wise hotel assignments, and customer trip bookings through role-based **Admin** and **Client** portals.



## Features

### Admin Module
* **Tour Package Management (CRUD):** Add, view, update, and delete multi-stop tour packages with start dates and per-person pricing.
* **Hotel Management (CRUD):** Register, edit, and remove hotels mapped to specific destinations.
* **Stop-Wise Tour-Hotel Linking:** Assign hotels to up to three itinerary stops (`place_no` 1, 2, and 3) per tour, with automatic replacement when updating an existing stop link.

### Client Module
* **Browse Tours & Linked Hotels:** View all available tour packages alongside their assigned stop-wise hotels.
* **Automated Trip Booking & Fare Calculation:** Select tours, travel dates, number of persons, rooms, and AC/Non-AC preferences with automatic total cost computation:
  $$\text{Total Price} = (\text{Base Price} \times \text{Persons}) + (\text{₹500} \times \text{Rooms, if AC})$$
* **Booking History & Lookup:** View personal reservation history, search any reservation by its auto-generated Booking ID, and cancel bookings securely.

### Authentication & Security
* **Role-Based Access Control:** Separate dashboards and workflows for `ADMIN` and `CLIENT` accounts using `HttpSession`.
* **SQL Injection Protection:** Parameterized JDBC queries (`PreparedStatement`) across all database operations.



## Tech Stack

* **Backend:** Java (JDK 17+), Jakarta/Javax Servlets, JSP, JDBC
* **Frontend:** HTML5, CSS3 (`style.css`)
* **Database:** MySQL 8.0 (`InnoDB`, Foreign Key constraints with `ON DELETE CASCADE` & `ON DELETE RESTRICT`)
* **Server & IDE:** Apache Tomcat 9.0, Eclipse IDE for Enterprise Java



## Project Structure

```text
TravelTourism/
├── src/main/java/com/travel/
│   ├── DBConnect.java          # Central MySQL JDBC connection utility
│   ├── LoginServlet.java       # Role-based authentication & session creation
│   ├── RegisterServlet.java    # Client account registration
│   ├── LogoutServlet.java      # Session invalidation
│   ├── TourServlet.java        # Admin CRUD operations for tours
│   ├── HotelServlet.java       # Admin CRUD operations for hotels
│   ├── TourHotelServlet.java   # Links/replaces hotels for tour stops (place_no 1..3)
│   └── BookingServlet.java     # Client booking creation, lookup, and cancellation
└── src/main/webapp/
    ├── WEB-INF/
    │   ├── lib/mysql-connector-j-8.0.33.jar
    │   └── web.xml
    ├── index.jsp               # Public landing page
    ├── login.jsp / register.jsp / logout.jsp
    ├── admin_dashboard.jsp     # Admin control panel
    ├── tour.jsp / tourupd.jsp / tourdel.jsp
    ├── hotel.jsp / hotelupd.jsp / hoteldel.jsp
    ├── tourhotel.jsp           # Tour-to-hotel linking interface
    ├── client_dashboard.jsp    # Client control panel
    ├── searchtour.jsp          # Available tours with linked hotels
    ├── booking.jsp             # Tour reservation form
    ├── booking_details.jsp     # User booking history & cancellation
    ├── searchbooking.jsp       # Search booking by ID
    └── style.css               # Application stylesheet
