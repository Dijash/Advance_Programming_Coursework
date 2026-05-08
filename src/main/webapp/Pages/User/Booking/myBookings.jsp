<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
     <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/User/Booking/myBookings.css">
    <title>RentAll | My Bookings</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

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