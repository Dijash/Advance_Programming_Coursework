<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%-- Booking Details page --%>
<c:set var="activePage" value="myBookings" scope="request" />

<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/User/sidebar.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/User/Booking/bookingdetails.css">
  <title>RentAll | Booking Details</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
    rel="stylesheet" />

</head>

<body>
  <%-- User sidebar navigation --%>
  <jsp:include page="/WEB-INF/Pages/Includes/sidebar.jsp" />

  <main>
    <%-- Top navigation bar with user actions --%>
    <header class="top-navbar">
      <%-- Welcome heading --%>
      <div class="welcome-text">
        <h1>Booking Summary</h1>
        <p>Full breakdown of your reservation details.</p>
      </div>

      <%-- User action buttons --%>
      <div class="user-actions">
        <a href="${pageContext.request.contextPath}/home" class="btn-home">Return to Home</a>

        <%-- Notification dropdown --%>
        <div class="dropdown-wrapper">
          <input type="checkbox" id="notifToggle" class="notif-toggle-input">
          <label for="notifToggle" class="btn-notif">
            Notifications <span class="notif-badge">
              <c:out value="${totalNotifCount}" default="0" />
            </span>
          </label>
          <%-- Notification list --%>
          <div class="notif-dropdown">
            <div class="notif-header">Recent Broadcasts</div>
            <div class="notif-list">
              <c:forEach var="n" items="${recentNotifs}">
                <%-- Individual notification item --%>
                <div class="notif-item">
                  <strong>
                    <c:out value="${n.type}" />
                  </strong>
                  <p>
                    <c:out value="${n.description}" />
                  </p>
                  <small>Date:
                    <c:out value="${n.date}" />
                  </small>
                </div>
              </c:forEach>
              <%-- No notifications placeholder --%>
              <c:if test="${empty recentNotifs}">
                <div class="notif-item" style="text-align: center; color: var(--text-muted)">No active system
                  alerts.</div>
              </c:if>
            </div>
          </div>
        </div>

        <%-- User profile avatar --%>
        <div class="user-profile">
          <c:choose>
            <c:when test="${not empty sessionScope.user.customer_image}">
              <img src="${pageContext.request.contextPath}/Assets/Profiles/${sessionScope.user.customer_image}"
                alt="Profile Photo" class="profile-avatar" />
            </c:when>
            <c:otherwise>
              <%-- Default avatar fallback --%>
              <div class="profile-avatar default-avatar">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                  <path
                    d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" />
                </svg>
              </div>
            </c:otherwise>
          </c:choose>
          <span>
            <c:out value="${sessionScope.user.customer_username}" default="Profile" />
          </span>
        </div>
      </div>
    </header>

    <%-- Main dashboard content --%>
    <div class="dashboard-content">

      <%-- Success message display --%>
      <c:if test="${not empty sessionScope.successMsg}">
        <div class="alert alert-success">${sessionScope.successMsg}</div>
        <c:remove var="successMsg" scope="session" />
      </c:if>
      <%-- Error message display --%>
      <c:if test="${not empty sessionScope.errorMsg}">
        <div class="alert alert-danger">${sessionScope.errorMsg}</div>
        <c:remove var="errorMsg" scope="session" />
      </c:if>

      <%-- Back to dashboard link --%>
      <div class="header-actions">
        <a href="${pageContext.request.contextPath}/userDashboard" class="btn-back-dashboard">Back to
          Dashboard</a>
      </div>

      <%-- Two column layout for booking details --%>
      <div class="booking-layout-grid">

        <%-- Left column: booking details --%>
        <div class="left-column">
          <section class="content-box">
            <%-- Booking header with reference and status --%>
            <div class="booking-header">
              <div class="booking-title">
                <h2>Booking Details</h2>
                <p>REF ID: #
                  <c:out value="${bookingDetails.bookingId}" />
                </p>
              </div>

              <%-- Booking status indicator --%>
              <div class="status-text"
                style="color: ${bookingDetails.status == 'On Track' || bookingDetails.status == 'Completed' ? '#10b981' : (bookingDetails.status == 'Cancelled' ? '#ef4444' : '#f59e0b')}; text-shadow: 0 0 15px ${bookingDetails.status == 'On Track' || bookingDetails.status == 'Completed' ? 'rgba(16,185,129,0.2)' : 'transparent'};">
                <c:out value="${bookingDetails.status}" />
              </div>
            </div>

            <%-- Trip schedule details --%>
            <div class="details-section">
              <h3>Trip Schedule</h3>
              <div class="detail-row">
                <span class="detail-label">Pickup Date</span>
                <span class="detail-value">
                  <c:out value="${bookingDetails.startDate}" />
                </span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Return Date</span>
                <span class="detail-value">
                  <c:out value="${bookingDetails.endDate}" />
                </span>
              </div>
            </div>

            <%-- Customer information section --%>
            <div class="details-section" style="margin-bottom: 0;">
              <h3>Customer Info</h3>
              <div class="detail-row">
                <span class="detail-label">Renter Name</span>
                <span class="detail-value">
                  <c:out value="${sessionScope.user.first_name} ${sessionScope.user.last_name}" />
                </span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Email</span>
                <span class="detail-value">
                  <c:out value="${sessionScope.user.customer_email}" />
                </span>
              </div>
            </div>

            <%-- Grand total payment row --%>
            <div class="total-row">
              <span class="detail-label">Grand Total Paid</span>
              <span class="detail-value">NPR
                <c:out value="${bookingDetails.totalPrice}" />
              </span>
            </div>

            <%-- Cancel reservation button (only for pending bookings) --%>
            <c:if test="${bookingDetails.status == 'Pending'}">
              <div class="danger-zone">
                <form action="${pageContext.request.contextPath}/cancelBooking" method="POST"
                  onsubmit="return confirm('WARNING: Are you sure you want to cancel this reservation?')">
                  <input type="hidden" name="bookingId" value="${bookingDetails.bookingId}">
                  <button type="submit" class="btn-cancel-large">
                    Cancel Reservation
                  </button>
                </form>
              </div>
            </c:if>
          </section>
        </div>

        <%-- Right column: vehicle preview and review --%>
        <div class="right-column">
          <%-- Vehicle image and info preview --%>
          <div class="vehicle-preview-card">
            <img
              src="${pageContext.request.contextPath}/Assets/${not empty vehicleImage ? vehicleImage : 'mustang.jpg'}"
              alt="Vehicle Image" class="vehicle-preview-img" />
            <h3 class="vehicle-preview-title">
              <c:out value="${bookingDetails.vehicleDetails}" />
            </h3>
            <span class="vehicle-preview-plate">
              <c:out value="${bookingDetails.numberPlate}" />
            </span>
          </div>

          <%-- Review submission (only for completed bookings) --%>
          <c:if test="${bookingDetails.status == 'Completed'}">
            <div class="review-box">
              <h3>Leave a Review</h3>
              <form action="${pageContext.request.contextPath}/submitReview" method="POST">
                <input type="hidden" name="bookingId" value="${bookingDetails.bookingId}" />
                <input type="hidden" name="vehicleId" value="${vehicleId}" />

                <div class="form-group">
                  <label for="comment">Your Feedback</label>
                  <textarea id="comment" name="comment" rows="4"
                    placeholder="Tell us about the car and your trip..." required></textarea>
                </div>

                <button type="submit" class="btn-submit-review">Submit Review</button>
              </form>
            </div>
          </c:if>
        </div>

      </div>

    </div>
  </main>


</body>

</html>