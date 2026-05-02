<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | My Bookings</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        :root {
            --primary: #0f172a;
            --sidebar-active: #334155;
            --accent: #3b82f6;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --bg-main: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --radius-lg: 12px;
            --radius-md: 8px;
            --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: "Poppins", sans-serif; background-color: var(--bg-main); display: flex; min-height: 100vh; }

        .sidebar { width: 260px; background: var(--primary); color: white; padding: 2rem 1.5rem; position: fixed; height: 100vh; display: flex; flex-direction: column; }
        .sidebar h2 { font-size: 1.5rem; margin-bottom: 2.5rem; }
        .sidebar nav a { text-decoration: none; color: #94a3b8; padding: 0.8rem 1rem; display: block; border-radius: var(--radius-md); margin-bottom: 0.5rem; transition: 0.3s; }
        .sidebar nav a:hover, .sidebar nav a.active { background: var(--sidebar-active); color: white; }
        .logout { margin-top: auto; background: var(--danger); color: white !important; text-align: center; padding: 0.8rem 1rem; border-radius: var(--radius-md); text-decoration: none; }

        main { flex: 1; margin-left: 260px; }
        .top-navbar { display: flex; justify-content: space-between; align-items: center; padding: 1.5rem 2.5rem; border-bottom: 1px solid var(--border); }

        .dashboard-content { padding: 2.5rem; }
        .content-box { background: var(--card-bg); border-radius: var(--radius-lg); padding: 1.5rem; border: 1px solid var(--border); box-shadow: var(--shadow); }

        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 1rem; font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; border-bottom: 2px solid var(--bg-main); }
        td { padding: 1.25rem 1rem; font-size: 0.9rem; border-bottom: 1px solid var(--bg-main); }

        .status-container { display: inline-flex; align-items: center; gap: 8px; font-weight: 600; }
        .status-dot { width: 8px; height: 8px; border-radius: 50%; }

        .btn-action { text-decoration: none; background: var(--bg-main); color: var(--primary); padding: 8px 16px; border-radius: var(--radius-md); font-size: 0.85rem; font-weight: 600; border: 1px solid var(--border); cursor: pointer; transition: 0.2s; }
        .btn-action:hover { background: var(--primary); color: white; }
    </style>
</head>
<body>
    <aside class="sidebar">
        <h2>RentAll</h2>
        <nav>
            <a href="${pageContext.request.contextPath}/userDashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/myBookings" class="active">My Bookings</a>
            <a href="${pageContext.request.contextPath}/myFavorites">My Favorites</a>
            <a href="${pageContext.request.contextPath}/settings">Settings</a>
        </nav>
        <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
    </aside>

    <main>
        <header class="top-navbar">
            <div class="welcome-text">
                <h1>Booking History</h1>
                <p>Review all your past and active reservations.</p>
            </div>
            <a href="${pageContext.request.contextPath}/home" class="btn-action">Return to Home</a>
        </header>

        <div class="dashboard-content">
            <section class="content-box">
                <h3>All Reservations</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Vehicle</th>
                            <th>License Plate</th>
                            <th>Rental Period</th>
                            <th>Fare</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="booking" items="${userAllBookings}">
                            <tr>
                                <td><strong>${booking.vehicleDetails}</strong></td>
                                <td style="font-family: monospace;">${booking.numberPlate}</td>
                                <td>${booking.startDate} - ${booking.endDate}</td>
                                <td>₹ ${booking.totalPrice}</td>
                                <td>
                                    <div class="status-container" style="color: ${booking.status == 'On Track' ? '#10b981' : (booking.status == 'Pending' ? '#f59e0b' : (booking.status == 'Cancelled' ? '#ef4444' : '#64748b'))};">
                                        <span class="status-dot" style="background-color: ${booking.status == 'On Track' ? '#10b981' : (booking.status == 'Pending' ? '#f59e0b' : (booking.status == 'Cancelled' ? '#ef4444' : '#64748b'))};"></span>
                                        ${booking.status}
                                    </div>
                                </td>
                                <td>
                                    <div style="display: flex; gap: 8px; align-items: center;">
                                        <a href="${pageContext.request.contextPath}/viewUserBooking?id=${booking.bookingId}" class="btn-action">Details</a>
                                        <c:if test="${booking.status == 'Pending'}">
                                            <form action="${pageContext.request.contextPath}/cancelBooking" method="POST" onsubmit="return confirm('Cancel this booking?')">
                                                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                                <button type="submit" class="btn-action" style="color: var(--danger); border-color: #fca5a5; background: #fff1f1;">Cancel</button>
                                            </form>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>
        </div>
    </main>
</body>
</html>