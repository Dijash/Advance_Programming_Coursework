<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/User/Booking/bookingdetails.css">
  <title>RentAll | Booking Details</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

</head>

<body>
  <aside class="sidebar">
    <h2>RentAll</h2>
    <nav>
      <ul>
        <li><a href="${pageContext.request.contextPath}/userDashboard">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/myBookings" class="active">My Bookings</a></li>
        <li><a href="${pageContext.request.contextPath}/myFavorites" >My Favorites</a></li>
        <li><a href="${pageContext.request.contextPath}/settings">Settings</a></li>
      </ul>
    </nav>
    <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
  </aside>

  <main>
    <header class="top-navbar">
      <div class="welcome-text">
        <h1>Booking Summary</h1>
        <p>Full breakdown of your reservation details.</p>
      </div>

      <div class="user-actions">
        <a href="${pageContext.request.contextPath}/home" class="btn-home">Return to Home</a>

        <div class="dropdown-wrapper">
          <input type="checkbox" id="notifToggle" class="notif-toggle-input">
          <label for="notifToggle" class="btn-notif">
            Notifications <span class="notif-badge"><c:out value="${totalNotifCount}" default="0" /></span>
          </label>
          <div class="notif-dropdown">
            <div class="notif-header">Recent Broadcasts</div>
            <div class="notif-list">
              <c:forEach var="n" items="${recentNotifs}">
                <div class="notif-item">
                  <strong><c:out value="${n.type}" /></strong>
                  <p><c:out value="${n.description}" /></p>
                  <small>Date: <c:out value="${n.date}" /></small>
                </div>
              </c:forEach>
              <c:if test="${empty recentNotifs}">
                <div class="notif-item" style="text-align: center; color: var(--text-muted)">No active system alerts.</div>
              </c:if>
            </div>
          </div>
        </div>

        <div class="user-profile">
          <c:choose>
            <c:when test="${not empty sessionScope.user.customer_image}">
              <img src="${pageContext.request.contextPath}/Assets/Profiles/${sessionScope.user.customer_image}" alt="Profile Photo" class="profile-avatar" />
            </c:when>
            <c:otherwise>
              <div class="profile-avatar default-avatar">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" /></svg>
              </div>
            </c:otherwise>
          </c:choose>
          <span><c:out value="${sessionScope.user.customer_username}" default="Profile" /></span>
        </div>
      </div>
    </header>

    <div class="dashboard-content">

      <c:if test="${not empty sessionScope.successMsg}">
          <div class="alert alert-success">${sessionScope.successMsg}</div>
          <c:remove var="successMsg" scope="session"/>
      </c:if>
      <c:if test="${not empty sessionScope.errorMsg}">
          <div class="alert alert-danger">${sessionScope.errorMsg}</div>
          <c:remove var="errorMsg" scope="session"/>
      </c:if>

      <div class="header-actions">
        <a href="${pageContext.request.contextPath}/userDashboard" class="btn-back-dashboard">Back to Dashboard</a>
      </div>

      <div class="booking-layout-grid">

        <div class="left-column">
          <section class="content-box">
            <div class="booking-header">
              <div class="booking-title">
                <h2>Booking Details</h2>
                <p>REF ID: #<c:out value="${bookingDetails.bookingId}" /></p>
              </div>

              <div class="status-text" style="color: ${bookingDetails.status == 'On Track' || bookingDetails.status == 'Completed' ? '#10b981' : (bookingDetails.status == 'Cancelled' ? '#ef4444' : '#f59e0b')}; text-shadow: 0 0 15px ${bookingDetails.status == 'On Track' || bookingDetails.status == 'Completed' ? 'rgba(16,185,129,0.2)' : 'transparent'};">
                <c:out value="${bookingDetails.status}" />
              </div>
            </div>

            <div class="details-section">
              <h3>Trip Schedule</h3>
              <div class="detail-row">
                <span class="detail-label">Pickup Date</span>
                <span class="detail-value"><c:out value="${bookingDetails.startDate}" /></span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Return Date</span>
                <span class="detail-value"><c:out value="${bookingDetails.endDate}" /></span>
              </div>
            </div>

            <div class="details-section" style="margin-bottom: 0;">
              <h3>Customer Info</h3>
              <div class="detail-row">
                <span class="detail-label">Renter Name</span>
                <span class="detail-value"><c:out value="${sessionScope.user.first_name} ${sessionScope.user.last_name}" /></span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Email</span>
                <span class="detail-value"><c:out value="${sessionScope.user.customer_email}" /></span>
              </div>
            </div>

            <div class="total-row">
              <span class="detail-label">Grand Total Paid</span>
              <span class="detail-value">NPR <c:out value="${bookingDetails.totalPrice}" /></span>
            </div>

            <%-- ONLY show cancel button if status is Pending --%>
            <c:if test="${bookingDetails.status == 'Pending'}">
              <div class="danger-zone">
                <form action="${pageContext.request.contextPath}/cancelBooking" method="POST" onsubmit="return confirm('WARNING: Are you sure you want to cancel this reservation?')">
                  <input type="hidden" name="bookingId" value="${bookingDetails.bookingId}">
                  <button type="submit" class="btn-cancel-large">
                    Cancel Reservation
                  </button>
                </form>
              </div>
            </c:if>
          </section>
        </div>

        <div class="right-column">
          <div class="vehicle-preview-card">
            <img src="${pageContext.request.contextPath}/Assets/${not empty vehicleImage ? vehicleImage : 'images.jpeg'}" alt="Vehicle Image" class="vehicle-preview-img" />
            <h3 class="vehicle-preview-title"><c:out value="${bookingDetails.vehicleDetails}" /></h3>
            <span class="vehicle-preview-plate"><c:out value="${bookingDetails.numberPlate}" /></span>
          </div>

          <c:if test="${bookingDetails.status == 'Completed'}">
                      <div class="review-box">
                        <h3>Leave a Review</h3>
                        <form action="${pageContext.request.contextPath}/submitReview" method="POST">
                          <input type="hidden" name="bookingId" value="${bookingDetails.bookingId}" />
                          <input type="hidden" name="vehicleId" value="${vehicleId}" />

                          <div class="form-group">
                            <label for="comment">Your Feedback</label>
                            <textarea id="comment" name="comment" rows="4" placeholder="Tell us about the car and your trip..." required></textarea>
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