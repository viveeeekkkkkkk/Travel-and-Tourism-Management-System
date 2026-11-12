# Travel and Tourism Management System

A web-based application built using **Java Servlets, JSP, JDBC, and MySQL 8.0** to simplify how travel agencies manage tour packages and how customers plan and book their trips.

Instead of handling tour schedules, hotel assignments, and customer bookings manually, this system brings everything into one place with separate, easy-to-use dashboards for **Administrators** and **Clients**.

---

## Key Features

### For Administrators
* **Tour Management:** Add new multi-stop tour packages, view existing tours, and update or delete schedules and pricing anytime.
* **Hotel Directory:** Maintain a clean record of partner hotels along with their locations.
* **Stop-Wise Hotel Linking:** Assign specific hotels to each stop (Stop 1, Stop 2, and Stop 3) of a tour itinerary, automatically replacing older assignments if updated.

### For Clients
* **Explore Packages:** Browse all available tours along with the exact hotels linked to every stop on the itinerary.
* **Easy Trip Booking:** Select a tour, pick a travel date, choose the number of travelers and rooms, and pick between AC or Non-AC accommodation.
* **Instant Fare Calculation:** Automatically computes the total trip cost based on per-person tour pricing and AC room charges, generating a unique Booking ID upon confirmation.
* **Manage Reservations:** View personal booking history, look up any reservation by its Booking ID, or cancel a trip securely.

---

## Built With

* **Backend:** Java, Servlets, JSP, JDBC
* **Frontend:** HTML5, CSS3
* **Database:** MySQL 8.0
* **Server & Tools:** Apache Tomcat 9.0, Eclipse IDE

---

## Project Layout

```text
TravelTourism/
├── src/main/java/com/travel/
│   ├── DBConnect.java          # Manages MySQL database connections
│   ├── LoginServlet.java       # Handles user login & role-based redirection
│   ├── RegisterServlet.java    # Registers new client accounts
│   ├── LogoutServlet.java      # Safely ends user sessions
│   ├── TourServlet.java        # Adds, updates, and deletes tour packages
│   ├── HotelServlet.java       # Adds, updates, and deletes hotel records
│   ├── TourHotelServlet.java   # Links hotels to specific stops in a tour
│   └── BookingServlet.java     # Processes bookings, fare calculation, lookup & cancellation
└── src/main/webapp/
    ├── index.jsp               # Home page
    ├── login.jsp / register.jsp
    ├── admin_dashboard.jsp     # Admin control panel
    ├── tour.jsp / tourupd.jsp / tourdel.jsp
    ├── hotel.jsp / hotelupd.jsp / hoteldel.jsp
    ├── tourhotel.jsp           # Tour-to-hotel mapping screen
    ├── client_dashboard.jsp    # Client home screen
    ├── searchtour.jsp          # Browse tours and linked hotels
    ├── booking.jsp             # Trip booking form
    ├── booking_details.jsp     # View and cancel personal bookings
    ├── searchbooking.jsp       # Search reservation by Booking ID
    └── style.css               # Shared styling across all pages
```

---

## Database Overview (`travel_tourism`)
The application uses a relational MySQL database with 7 tables designed to keep data consistent and accurate:

users — Stores login credentials, contact details, and user roles (ADMIN or CLIENT).

tours — Holds tour package details, up to three destination stops, start dates, and per-person pricing.

hotels — Stores hotel names and their respective cities/locations.

tour_hotel_link — Connects tours to hotels for each itinerary stop (place_no 1, 2, or 3).

bookings — Records customer reservations, selected hotels, room preferences, traveler counts, and total fares.

booking_members & booking_persons — Stores additional passenger details associated with bookings.

How to Run Locally
1. Set Up the Database
Open MySQL Workbench (or MySQL Command Line) and create the database:

SQL
CREATE DATABASE travel_tourism;
USE travel_tourism;
Import or run the SQL table creation script to set up the 7 tables, and add an ADMIN account in the users table.

Open src/main/java/com/travel/DBConnect.java and update the database URL, username, and password to match your local MySQL setup.

2. Run on Apache Tomcat
Clone this repository:

Bash
git clone [https://github.com/viveeeekkkkkkk/Travel-and-Tourism-Management-System.git](https://github.com/viveeeekkkkkkk/Travel-and-Tourism-Management-System.git)
Open Eclipse IDE, select File → Import → Existing Projects into Workspace, and choose the TravelTourism folder.

Right-click the project, select Run As → Run on Server, and choose Apache Tomcat v9.0.

Visit http://localhost:8080/TravelTourism/ in your browser.
