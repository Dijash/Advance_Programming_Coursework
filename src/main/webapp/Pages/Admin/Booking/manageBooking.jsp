<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Bookings</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Dashboard/Admin.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Booking/ManageBooking.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li><a href="${pageContext.request.contextPath}/admin"><span>Dashboard</span></a></li>
          <li><a href="${pageContext.request.contextPath}/manageBooking" class="active"><span>Bookings</span></a></li>
          <li><a href="${pageContext.request.contextPath}/manageVehicles"><span>Manage Vehicles</span></a></li>
          <li><a href="${pageContext.request.contextPath}/manageCustomers"><span>Customers</span></a></li>
          <li><a href="${pageContext.request.contextPath}/manageReviews"><span>Reviews</span></a></li>
          <li><a href="${pageContext.request.contextPath}/manageNotification"><span>Notifications</span></a></li>
          <li><a href="${pageContext.request.contextPath}/report"><span>Reports</span></a></li>
          <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Booking/ManageBooking.css">

        </ul>
      </nav>
      <a href="${pageContext.request.contextPath}/logout" class="logout"><span>Logout</span></a>
    </aside>

    <main>
      <div class="page-header">
        <h2>All Bookings</h2>
      </div>

      <div class="content-box">
        <div class="table-responsive">
          <table>
            <thead>
              <tr>
                <th>Booking ID</th>
                <th>Customer</th>
                <th>Vehicle</th>
                <th>Number Plate</th>
                <th>Dates</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="booking" items="${bookings}">
                <tr>
                  <td><strong>#<c:out value="${booking.bookingId}" /></strong></td>
                  <td><c:out value="${booking.customerName}" /></td>
                  <td><c:out value="${booking.vehicleDetails}" /></td>
                  <td><c:out value="${booking.numberPlate}" /></td>
                  <td><c:out value="${booking.startDate} to ${booking.endDate}" /></td>

                  <td style="font-weight: 600; color:
                      <c:choose>
                          <c:when test="${booking.status == 'Active' || booking.status == 'On Track'}">#3498db</c:when>
                          <c:when test="${booking.status == 'Completed'}">#27ae60</c:when>
                          <c:otherwise>#e74c3c</c:otherwise>
                      </c:choose>;">
                      <c:out value="${booking.status}" />
                  </td>

                  <td>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/viewBooking?id=${booking.bookingId}" class="action-btn action-btn-view">View</a>

                        <a href="${pageContext.request.contextPath}/editBooking?id=${booking.bookingId}" class="action-btn action-btn-edit">Edit</a>

                        <form action="${pageContext.request.contextPath}/deleteBooking" method="POST" style="display: contents;">
                            <input type="hidden" name="booking_id" value="${booking.bookingId}">
                            <button type="submit" class="action-btn action-btn-delete" onclick="return confirm('Are you sure you want to delete this booking?');">Delete</button>
                        </form>
                    </div>
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${empty bookings}">
                 <tr>
                    <td colspan="7" style="text-align: center; color: #7f8c8d; padding: 30px;">No bookings found.</td>
                 </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </main>
  </body>
</html>