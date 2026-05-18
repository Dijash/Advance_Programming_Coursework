<%-- View Booking Details page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%-- Set active page for sidebar highlighting --%>
    <c:set var="activePage" value="bookings" scope="request" />
    <!doctype html>
    <html lang="en">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/Booking/ViewBooking.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
      <title>RentAll | Booking Details</title>
      <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">

    </head>

    <body>
      <%-- Include admin sidebar navigation --%>
      <jsp:include page="/WEB-INF/Pages/Includes/adminSidebar.jsp" />

      <main>
        <%-- Page container with header --%>
        <div class="page-container">
          <%-- Page header with title and action buttons --%>
          <div class="page-header">
            <h2>Booking Record</h2>
            <div style="display: flex; gap: 10px;">
              <a href="${pageContext.request.contextPath}/manageBooking" class="btn-back">Back to List</a>
              <a href="${pageContext.request.contextPath}/editBooking?id=${booking.bookingId}" class="btn-back"
                style="background: var(--primary); color: white;">Edit Status</a>
            </div>
          </div>

<%-- Content box for booking details --%>
          <div class="content-box">
            <%-- Booking top section with ID, customer name, and status --%>
            <div class="booking-top">
              <%-- Booking icon --%>
              <div class="booking-icon">BK</div>
              <%-- Main booking info --%>
              <div class="booking-info-main">
                <h1>Booking #${booking.bookingId}</h1>
                <p>Requested by <strong>${booking.customerName}</strong></p>
              </div>
              <%-- Status badge with dynamic color based on status --%>
              <span class="status-badge" style="background:
                <c:choose>
                    <c:when test=" ${booking.status=='On Track' }">#3498db</c:when>
                <c:when test="${booking.status == 'Completed'}">#10b981</c:when>
                <c:otherwise>#ef4444</c:otherwise>
                </c:choose>;">
                ${booking.status}
              </span>
            </div>

            <%-- Detail grid displaying booking information --%>
            <div class="detail-grid">
              <%-- Customer name field --%>
              <div class="detail-card">
                <span class="label">Customer Name</span>
                <div class="value">${booking.customerName}</div>
              </div>

              <%-- Assigned vehicle field --%>
              <div class="detail-card">
                <span class="label">Assigned Vehicle</span>
                <div class="value">${booking.vehicleDetails}</div>
              </div>

              <%-- License plate field --%>
              <div class="detail-card">
                <span class="label">License Plate</span>
                <div class="value">${booking.numberPlate}</div>
              </div>

              <%-- Rental period field --%>
              <div class="detail-card">
                <span class="label">Rental Period</span>
                <div class="value">${booking.startDate} - ${booking.endDate}</div>
              </div>

              <%-- Financial summary spanning two columns --%>
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