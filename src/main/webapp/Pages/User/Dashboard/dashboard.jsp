<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
     <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/User/Dashboard/Dashboard.css">
    <title>RentAll | User Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

  </head>
  <body>
    <aside class="sidebar">
      <h2><a href="${pageContext.request.contextPath}/home" class= "main-thing">RentAll</a></h2>
      <nav>
        <ul>
          <li><a href="${pageContext.request.contextPath}/userDashboard" class="active">Dashboard</a></li>
          <li><a href="${pageContext.request.contextPath}/myBookings">My Bookings</a></li>
          <li><a href="${pageContext.request.contextPath}/myFavorites" >My Favorites</a></li>
          <li><a href="${pageContext.request.contextPath}/settings">Settings</a></li>
        </ul>
      </nav>
      <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
    </aside>

    <main>
      <header class="top-navbar">
        <div class="welcome-text">
          <h1>
            Hello, <c:out value="${sessionScope.user.customer_username}" default="Driver" />
          </h1>
          <p>Ready for your next journey?</p>
        </div>

        <div class="user-actions">
          <a href="${pageContext.request.contextPath}/home" class="btn-home">Return to Home</a>

          <div class="dropdown-wrapper">
            <input type="checkbox" id="notifToggle" class="notif-toggle-input">
            <label for="notifToggle" class="btn-notif">
              Notifications
              <span class="notif-badge"><c:out value="${totalNotifCount}" default="0" /></span>
            </label>

            <div class="notif-dropdown">
              <div class="notif-header">
                Recent Broadcasts
              </div>
              <div class="notif-list">
                <c:forEach var="n" items="${recentNotifs}">
                  <div class="notif-item">
                    <strong><c:out value="${n.type}"/></strong>
                    <p><c:out value="${n.description}"/></p>
                    <small>Date: <c:out value="${n.date}"/></small>
                  </div>
                </c:forEach>

                <c:if test="${empty recentNotifs}">
                  <div class="notif-item" style="text-align: center; color: var(--text-muted);">
                    No active system alerts.
                  </div>
                </c:if>
              </div>
            </div>
          </div>

          <div class="user-profile">
            <c:choose>
                <%-- If user has an image saved in the DB, point to the Assets/Profiles folder --%>
                <c:when test="${not empty sessionScope.user.customer_image}">
                    <img src="${pageContext.request.contextPath}/Assets/Profiles/${sessionScope.user.customer_image}" alt="Profile Photo" class="profile-avatar" />
                </c:when>

                <%-- Fallback generic vector icon --%>
                <c:otherwise>
                    <div class="profile-avatar default-avatar">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                        </svg>
                    </div>
                </c:otherwise>
            </c:choose>

            <span><c:out value="${sessionScope.user.customer_username}" default="Profile" /></span>
          </div>
          </div>
      </header>

      <div class="dashboard-content">
        <section class="stats-container">
          <div class="stat-card">
            <h3>Active Bookings</h3>
            <div class="value" style="color: var(--accent)">
              <c:out value="${activeBookingsCount}" default="0" />
            </div>
          </div>
          <div class="stat-card">
            <h3>Completed Trips</h3>
            <div class="value">
              <c:out value="${completedTripsCount}" default="0" />
            </div>
          </div>
          <div class="stat-card">
            <h3>Total Spent</h3>
            <div class="value" style="color: var(--success)">
              ₹ <c:out value="${totalSpent}" default="0.00" />
            </div>
          </div>
        </section>

        <section class="content-box">
          <h3>
            Recent Bookings
            <a href="${pageContext.request.contextPath}/myBookings" class="view-all-link">View All</a>
          </h3>
          <div class="table-responsive">
            <table>
              <thead>
                <tr>
                  <th>Vehicle</th>
                  <th>Rental Period</th>
                  <th>Total Fare</th>
                  <th>Status</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="booking" items="${userRecentBookings}">
                  <tr>
                    <td>
                      <span style="font-weight: 600"><c:out value="${booking.vehicleDetails}" /></span>
                    </td>
                    <td style="color: var(--text-muted)">
                      <c:out value="${booking.startDate}" /> - <c:out value="${booking.endDate}" />
                    </td>
                    <td style="font-weight: 500">
                      ₹ <c:out value="${booking.totalPrice}" />
                    </td>
                    <td>
                      <div class="status-container"
                           style="color: ${booking.status == 'On Track' ? '#10b981' : (booking.status == 'Pending' ? '#f59e0b' : (booking.status == 'Cancelled' ? '#ef4444' : '#64748b'))};">
                        <span class="status-dot"
                              style="background-color: ${booking.status == 'On Track' ? '#10b981' : (booking.status == 'Pending' ? '#f59e0b' : (booking.status == 'Cancelled' ? '#ef4444' : '#64748b'))};
                                     box-shadow: 0 0 8px ${booking.status == 'On Track' ? 'rgba(16,185,129,0.4)' : (booking.status == 'Pending' ? 'rgba(245,158,11,0.4)' : (booking.status == 'Cancelled' ? 'rgba(239,68,68,0.4)' : 'rgba(100,116,139,0.3)'))};">
                        </span>
                        <c:out value="${booking.status}" />
                      </div>
                    </td>
                    <td>
                      <div style="display: flex; gap: 8px; align-items: center;">
                        <a href="${pageContext.request.contextPath}/viewUserBooking?id=${booking.bookingId}" class="btn-action">Details</a>

                        <%-- ONLY show cancel button if status is Pending --%>
                        <c:if test="${booking.status == 'Pending'}">
                          <form action="${pageContext.request.contextPath}/cancelBooking" method="POST" style="margin: 0;" onsubmit="return confirm('Cancel this booking?')">
                            <input type="hidden" name="bookingId" value="${booking.bookingId}">
                            <button type="submit" class="btn-action" style="color: var(--danger); border-color: #fca5a5; background: #fff1f1; cursor: pointer;">
                              Cancel
                            </button>
                          </form>
                        </c:if>
                      </div>
                    </td>
                  </tr>
                </c:forEach>

                <c:if test="${empty userRecentBookings}">
                  <tr>
                    <td colspan="5" style="text-align: center; padding: 2rem; color: var(--text-muted);">
                      You have no recent bookings recorded.
                    </td>
                  </tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </section>
      </div>
    </main>

    
  </body>
</html>