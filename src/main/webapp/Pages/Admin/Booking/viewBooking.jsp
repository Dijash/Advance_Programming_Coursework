<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="activePage" value="bookings" scope="request" />
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
     <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/Booking/ViewBooking.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
    <title>RentAll | Booking Details</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  </head>
  <body>
    <jsp:include page="/Pages/Includes/adminSidebar.jsp" />

    <main>
      <div class="page-container">
        <div class="page-header">
          <h2>Booking Record</h2>
          <div style="display: flex; gap: 10px;">
              <a href="${pageContext.request.contextPath}/manageBooking" class="btn-back">Back to List</a>
              <a href="${pageContext.request.contextPath}/editBooking?id=${booking.bookingId}" class="btn-back" style="background: var(--primary); color: white;">Edit Status</a>
          </div>
        </div>

        <div class="content-box">
          <div class="booking-top">
            <div class="booking-icon">BK</div>
            <div class="booking-info-main">
              <h1>Booking #${booking.bookingId}</h1>
              <p>Requested by <strong>${booking.customerName}</strong></p>
            </div>
            <span class="status-badge" style="background:
                <c:choose>
                    <c:when test="${booking.status == 'On Track'}">#3498db</c:when>
                    <c:when test="${booking.status == 'Completed'}">#10b981</c:when>
                    <c:otherwise>#ef4444</c:otherwise>
                </c:choose>;">
                ${booking.status}
            </span>
          </div>

          <div class="detail-grid">
            <div class="detail-card">
              <span class="label">Customer Name</span>
              <div class="value">${booking.customerName}</div>
            </div>

            <div class="detail-card">
              <span class="label">Assigned Vehicle</span>
              <div class="value">${booking.vehicleDetails}</div>
            </div>

            <div class="detail-card">
              <span class="label">License Plate</span>
              <div class="value">${booking.numberPlate}</div>
            </div>

            <div class="detail-card">
              <span class="label">Rental Period</span>
              <div class="value">${booking.startDate} &mdash; ${booking.endDate}</div>
            </div>

            <div class="detail-card" style="grid-column: span 2;">
              <span class="label">Financial Summary</span>
              <div class="value price-tag">₹${booking.totalPrice}</div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </body>
</html>