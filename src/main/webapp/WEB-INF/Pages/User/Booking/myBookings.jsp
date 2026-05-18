<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.model.Customer" %>
<%-- My Bookings page --%>
<c:set var="activePage" value="myBookings" scope="request" %>
<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/User/Booking/myBookings.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/User/Dashboard/Dashboard.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/User/sidebar.css">
  <title>RentAll | My Bookings</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
    rel="stylesheet" />

</head>

<body>
  <%-- User sidebar navigation --%>
  <jsp:include page="/WEB-INF/Pages/Includes/sidebar.jsp" />

  <main>
    <%-- Top navigation bar with user actions --%>
    <header class="top-navbar">
      <%-- Welcome heading with user name --%>
      <div class="welcome-text">
        <h1>
          Hello,
          <c:out
            value="${not empty sessionScope.user.first_name ? sessionScope.user.first_name : sessionScope.user.customer_username}"
            default="Driver" />
        </h1>
        <p>Vehicles you have saved for later.</p>
      </div>

      <%-- User action buttons --%>
      <div class="user-actions">
        <a href="${pageContext.request.contextPath}/rentalDeals" class="btn-home">Browse Fleet</a>

        <%-- User profile avatar --%>
        <div class="user-profile">
          <c:choose>
            <c:when test="${not empty sessionScope.user.customer_image}">
              <img
                src="${pageContext.request.contextPath}/Assets/Profiles/${sessionScope.user.customer_image}"
                alt="Profile Photo" class="profile-avatar" />
            </c:when>
            <c:otherwise>
              <%-- Default avatar with initial letter --%>
              <div class="profile-avatar"
                style="background: #3b82f6; color: white; display: flex; align-items: center; justify-content: center; font-weight: bold; text-transform: uppercase;">
                <c:out
                  value="${fn:substring(not empty sessionScope.user.first_name ? sessionScope.user.first_name : sessionScope.user.customer_username, 0, 1)}"
                  default="U" />
              </div>
            </c:otherwise>
          </c:choose>
          <span>
            <c:out value="${sessionScope.user.customer_username}" />
          </span>
        </div>
      </div>
    </header>

    <%-- Main dashboard content --%>
    <div class="dashboard-content">
      <section class="content-box">
        <h3>All Reservations</h3>
        <%-- Bookings table --%>
        <table>
          <%-- Table header --%>
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
          <%-- Table body with booking rows --%>
          <tbody>
            <c:forEach var="booking" items="${userAllBookings}">
              <%-- Individual booking row --%>
              <tr>
                <td><strong>${booking.vehicleDetails}</strong></td>
                <td style="font-family: monospace;">${booking.numberPlate}</td>
                <td>${booking.startDate} - ${booking.endDate}</td>
                <td>₹ ${booking.totalPrice}</td>
                <td>
                  <%-- Status indicator with color coding --%>
                  <div class="status-container"
                    style="color: ${booking.status == 'On Track' ? '#10b981' : (booking.status == 'Pending' ? '#f59e0b' : (booking.status == 'Cancelled' ? '#ef4444' : '#64748b'))};">
                    <span class="status-dot"
                      style="background-color: ${booking.status == 'On Track' ? '#10b981' : (booking.status == 'Pending' ? '#f59e0b' : (booking.status == 'Cancelled' ? '#ef4444' : '#64748b'))};"></span>
                    ${booking.status}
                  </div>
                </td>
                <td>
                  <%-- Action buttons --%>
                  <div style="display: flex; gap: 8px; align-items: center;">
                    <a href="${pageContext.request.contextPath}/viewUserBooking?id=${booking.bookingId}"
                      class="btn-action">Details</a>
                    <%-- Cancel button (only for pending bookings) --%>
                    <c:if test="${booking.status == 'Pending'}">
                      <a href="#cancelModal-${booking.bookingId}" class="btn-action"
                        style="color: var(--danger); border-color: #fca5a5; background: #fff1f1;">Cancel</a>

                      <%-- Cancel confirmation modal --%>
                      <div id="cancelModal-${booking.bookingId}" class="modal-overlay">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h3>Cancel Booking</h3>
                          </div>
                          <div class="modal-body">
                            <p>Are you sure you want to cancel this booking? This action cannot be undone and
                              you may be charged a cancellation fee.</p>
                          </div>
                          <div class="modal-footer">
                            <a href="#" class="btn-cancel">Cancel</a>
                            <form action="${pageContext.request.contextPath}/cancelBooking" method="POST"
                              style="display: inline;">
                              <input type="hidden" name="bookingId" value="${booking.bookingId}">
                              <button type="submit" class="btn-cancel-confirm">Yes, Cancel</button>
                            </form>
                          </div>
                        </div>
                      </div>
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