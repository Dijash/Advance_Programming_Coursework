<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="activePage" value="bookings" scope="request" />
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
     <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/Booking/EditBooking.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
    <title>RentAll | Edit Booking</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  </head>
  <body>
    <jsp:include page="/WEB-INF/Pages/Includes/adminSidebar.jsp" />

    <main>
      <div class="page-container">
        <div class="page-header">
          <h2>Edit Booking</h2>
          <a href="${pageContext.request.contextPath}/manageBooking" class="btn-back">Cancel</a>
        </div>

        <div class="content-box">
          <div class="booking-summary">
            <p><strong>Booking ID:</strong> #${booking.bookingId}</p>
            <p><strong>Customer:</strong> ${booking.customerName}</p>
            <p><strong>Vehicle:</strong> ${booking.vehicleDetails}</p>
          </div>

          <form action="${pageContext.request.contextPath}/updateBooking" method="POST">
            <input type="hidden" name="booking_id" value="${booking.bookingId}">

            <div class="form-group">
              <label class="form-label">Update Booking Status</label>
              <select name="status">
                <option value="On Track" ${booking.status == 'On Track' ? 'selected' : ''}>On Track</option>
                <option value="Completed" ${booking.status == 'Completed' ? 'selected' : ''}>Completed</option>
                <option value="Cancelled" ${booking.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                <option value="Extended" ${booking.status == 'Extended' ? 'selected' : ''}>Extended</option>
              </select>
            </div>

            <button type="submit" class="save-btn">Save Changes</button>
          </form>
        </div>
      </div>
    </main>
  </body>
</html>