<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/AdminStyle.css">
  </head>
  <body>
    <input type="checkbox" id="menu-toggle" style="display:none;" />
    <label for="menu-toggle" class="menu-btn" style="display:none;">MENU</label>

    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li><a href="<%= request.getContextPath() %>/admin" class="active"><span>Dashboard</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageBooking"><span>Bookings</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageVehicles"><span>Manage Vehicles</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageCustomers"><span>Customers</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageReviews"><span>Reviews</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageNotification"><span>Notifications</span></a></li>
          <li><a href="<%= request.getContextPath() %>/report"><span>Reports</span></a></li>
        </ul>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout"><span>Logout</span></a>
    </aside>

    <main>
     <section class="stats-container">
             <div class="stat-card">
               <h3>Total Bookings</h3>
               <div class="value"><c:out value="${totalBookings}" default="0" /></div>
             </div>

             <div class="stat-card">
               <h3>Active Fleet</h3>
               <div class="value"><c:out value="${totalVehicles}" default="0" /></div>
             </div>

             <div class="stat-card">
                 <h3>Total Revenue</h3>
                 <div class="value" style="color: #22c55e;">₹<c:out value="${totalRevenue}" default="0" /></div>
             </div>

             <div class="stat-card">
               <h3>Active Rentals</h3>
               <div class="value"><c:out value="${activeRentalsCount}" default="0" /></div>
             </div>

             <div class="stat-card">
               <h3>Total Notifications</h3>
               <div class="value"><c:out value="${totalNotifCount}" default="0" /></div>
             </div>
           </section>

      <div class="dashboard-grid">
        <section class="left-col">
          <div class="content-box">
            <h3>Latest Notification</h3>
            <div class="promo-banner">
              <c:choose>
                  <c:when test="${not empty latestNotif}">
                      <p>
                        <strong><c:out value="${latestNotif.type}"/>:</strong>
                        <c:out value="${latestNotif.description}"/>
                      </p>
                      <small style="color: #64748b; display: block; margin-top: 12px; font-weight: 600;">
                        Posted on: <c:out value="${latestNotif.date}"/>
                      </small>
                  </c:when>
                  <c:otherwise>
                      <p>No active notifications found in the system.</p>
                  </c:otherwise>
              </c:choose>
            </div>
          </div>

          <div class="content-box">
            <h3>Upcoming Returns</h3>
            <div class="table-responsive">
              <table>
                <thead>
                  <tr>
                    <th>Customer</th>
                    <th>Vehicle</th>
                    <th>End Date</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="booking" items="${upcomingReturns}">
                    <tr>
                      <td><strong><c:out value="${booking.customerName}" /></strong></td>
                      <td><c:out value="${booking.vehicleDetails}" /></td>
                      <td><c:out value="${booking.endDate}" /></td>
                      <td style="color: ${booking.status == 'Extended' ? '#f39c12' : '#27ae60'}; font-weight: 600">
                          <c:out value="${booking.status}" />
                      </td>
                    </tr>
                  </c:forEach>

                  <c:if test="${empty upcomingReturns}">
                     <tr>
                        <td colspan="4" style="text-align: center; color: #7f8c8d;">No upcoming returns scheduled.</td>
                     </tr>
                  </c:if>
                </tbody>
              </table>
            </div>
          </div>
        </section>

        <section class="right-col">
          <div class="content-box car-highlight">
            <h3>Vehicle of the Month</h3>
            <c:choose>
                <c:when test="${not empty topVehicle}">
                    <img src="<%= request.getContextPath() %>/Assets/${topVehicle.image}" alt="Top Vehicle" />
                    <div class="car-info">
                      <span class="badge">Most Requested</span>
                      <strong><c:out value="${topVehicle.brand} ${topVehicle.type}"/></strong>

                      <p>
                        Based on recent analytics, this vehicle has the highest demand in your fleet,
                        consistently maintaining high utilization rates.
                      </p>
                    </div>
                </c:when>
                <c:otherwise>
                    <p>No vehicle performance data available yet.</p>
                </c:otherwise>
            </c:choose>
          </div>
        </section>
      </div>
    </main>
  </body>
</html>