<%-- Admin Dashboard page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ page isELIgnored="false" %>
      <%-- Set active page for sidebar highlighting --%>
      <c:set var="activePage" value="dashboard" scope="request" />

      <!doctype html>
      <html lang="en">

      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>RentAll | Admin Dashboard</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Dashboard/Admin.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
      </head>

      <body>
        <%-- Include admin sidebar navigation --%>
        <jsp:include page="/WEB-INF/Pages/Includes/adminSidebar.jsp" />

        <main>
          <%-- Statistics cards container --%>
          <section class="stats-container">
            <%-- Total bookings stat card --%>
            <div class="stat-card">
              <h3>Total Bookings</h3>
              <div class="value">
                <c:out value="${totalBookings}" default="0" />
              </div>
            </div>

            <%-- Active fleet stat card --%>
            <div class="stat-card">
              <h3>Active Fleet</h3>
              <div class="value">
                <c:out value="${totalVehicles}" default="0" />
              </div>
            </div>

            <%-- Total revenue stat card --%>
            <div class="stat-card">
              <h3>Total Revenue</h3>
              <div class="value" style="color: #22c55e;">₹
                <c:out value="${totalRevenue}" default="0" />
              </div>
            </div>

            <%-- Active rentals stat card --%>
            <div class="stat-card">
              <h3>Active Rentals</h3>
              <div class="value">
                <c:out value="${activeRentalsCount}" default="0" />
              </div>
            </div>

            <%-- Total notifications stat card --%>
            <div class="stat-card">
              <h3>Total Notifications</h3>
              <div class="value">
                <c:out value="${totalNotifCount}" default="0" />
              </div>
            </div>
          </section>

          <%-- Dashboard grid layout --%>
          <div class="dashboard-grid">
            <%-- Left column with notifications and upcoming returns --%>
            <section class="left-col">
              <%-- Latest notification content box --%>
              <div class="content-box">
                <h3>Latest Notification</h3>
                <div class="promo-banner">
                  <c:choose>
                    <%-- Display latest notification if available --%>
                    <c:when test="${not empty latestNotif}">
                      <p>
                        <strong>
                          <c:out value="${latestNotif.type}" />:
                        </strong>
                        <c:out value="${latestNotif.description}" />
                      </p>
                      <small style="color: #64748b; display: block; margin-top: 12px; font-weight: 600;">
                        Posted on:
                        <c:out value="${latestNotif.date}" />
                      </small>
                    </c:when>
                    <%-- Empty state when no notifications exist --%>
                    <c:otherwise>
                      <p>No active notifications found in the system.</p>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>

              <%-- Upcoming returns content box --%>
              <div class="content-box">
                <h3>Upcoming Returns</h3>
                <%-- Responsive table wrapper --%>
                <div class="table-responsive">
                  <table>
                    <%-- Table header row --%>
                    <thead>
                      <tr>
                        <th>Customer</th>
                        <th>Vehicle</th>
                        <th>End Date</th>
                        <th>Status</th>
                      </tr>
                    </thead>
                    <%-- Table body with upcoming returns data --%>
                    <tbody>
                      <%-- Upcoming returns loop --%>
                      <c:forEach var="booking" items="${upcomingReturns}">
                        <tr>
                          <%-- Customer name column --%>
                          <td><strong>
                              <c:out value="${booking.customerName}" />
                            </strong></td>
                          <%-- Vehicle details column --%>
                          <td>
                            <c:out value="${booking.vehicleDetails}" />
                          </td>
                          <%-- End date column --%>
                          <td>
                            <c:out value="${booking.endDate}" />
                          </td>
                          <%-- Status column with dynamic color --%>
                          <td style="color: ${booking.status == 'Extended' ? '#f39c12' : '#27ae60'}; font-weight: 600">
                            <c:out value="${booking.status}" />
                          </td>
                        </tr>
                      </c:forEach>

                      <%-- Empty state when no upcoming returns --%>
                      <c:if test="${empty upcomingReturns}">
                        <tr>
                          <td colspan="4" style="text-align: center; color: #7f8c8d;">No upcoming returns scheduled.
                          </td>
                        </tr>
                      </c:if>
                    </tbody>
                  </table>
                </div>
              </div>
            </section>

            <%-- Right column with vehicle of the month --%>
            <section class="right-col">
              <%-- Vehicle of the month highlight card --%>
              <div class="content-box car-highlight">
                <h3>Vehicle of the Month</h3>
                <c:choose>
                  <%-- Display top vehicle if available --%>
                  <c:when test="${not empty topVehicle}">
                    <%-- Top vehicle image --%>
                    <img src="${pageContext.request.contextPath}/Assets/${topVehicle.image}" alt="Top Vehicle" />
                    <%-- Top vehicle info --%>
                    <div class="car-info">
                      <%-- Most requested badge --%>
                      <span class="badge">Most Requested</span>
                      <strong>
                        <c:out value="${topVehicle.brand} ${topVehicle.type}" />
                      </strong>

                      <p>
                        Based on recent analytics, this vehicle has the highest demand in your fleet,
                        consistently maintaining high utilization rates.
                      </p>
                    </div>
                  </c:when>
                  <%-- Empty state when no vehicle data --%>
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