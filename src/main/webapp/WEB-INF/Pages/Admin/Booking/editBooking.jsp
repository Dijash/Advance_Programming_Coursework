<%-- Edit Booking Status page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%-- Set active page for sidebar highlighting --%>
    <c:set var="activePage" value="bookings" scope="request" />
    <!doctype html>
    <html lang="en">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/Booking/EditBooking.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
      <title>RentAll | Edit Booking</title>
      <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">

    </head>

    <body>
      <%-- Include admin sidebar navigation --%>
      <jsp:include page="/WEB-INF/Pages/Includes/adminSidebar.jsp" />

      <main>
        <%-- Page container with header --%>
        <div class="page-container">
          <%-- Page header with title and cancel button --%>
          <div class="page-header">
            <h2>Edit Booking</h2>
            <a href="${pageContext.request.contextPath}/manageBooking" class="btn-back">Cancel</a>
          </div>

          <%-- Content box containing edit form --%>
          <div class="content-box">
            <%-- Booking summary displaying current booking info --%>
            <div class="booking-summary">
              <p><strong>Booking ID:</strong> #${booking.bookingId}</p>
              <p><strong>Customer:</strong> ${booking.customerName}</p>
              <p><strong>Vehicle:</strong> ${booking.vehicleDetails}</p>
            </div>

            <%-- Form to update booking status --%>
            <form action="${pageContext.request.contextPath}/updateBooking" method="POST">
              <%-- Hidden field for booking ID --%>
              <input type="hidden" name="booking_id" value="${booking.bookingId}">

              <%-- Status update form group --%>
              <div class="form-group">
                <label class="form-label">Update Booking Status</label>
                <%-- Status dropdown select --%>
                <select name="status">
                  <option value="On Track" ${booking.status=='On Track' ? 'selected' : '' }>On Track</option>
                  <option value="Completed" ${booking.status=='Completed' ? 'selected' : '' }>Completed</option>
                  <option value="Cancelled" ${booking.status=='Cancelled' ? 'selected' : '' }>Cancelled</option>
                  <option value="Extended" ${booking.status=='Extended' ? 'selected' : '' }>Extended</option>
                </select>
              </div>

              <%-- Submit button for saving changes --%>
              <button type="submit" class="save-btn">Save Changes</button>
            </form>
          </div>
        </div>
      </main>
    </body>

    </html>