<%-- Manage Bookings listing page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%-- Set active page for sidebar highlighting --%>
    <c:set var="activePage" value="bookings" scope="request" />

    <!doctype html>
    <html lang="en">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>RentAll | Bookings</title>
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Dashboard/Admin.css">
      <link rel="stylesheet" type="text/css"
        href="${pageContext.request.contextPath}/CSS/Admin/Booking/ManageBooking.css">
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Modal.css">
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
      <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    </head>

    <body>
      <%-- Include admin sidebar navigation --%>
      <jsp:include page="/WEB-INF/Pages/Includes/adminSidebar.jsp" />

      <main>
        <%-- Page header with title --%>
        <div class="page-header">
          <h2>All Bookings</h2>
        </div>

        <%-- Content box containing bookings table --%>
        <div class="content-box">
          <%-- Responsive table wrapper --%>
          <div class="table-responsive">
            <table>
              <%-- Table header row --%>
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
              <%-- Table body with bookings data --%>
              <tbody>
                <%-- Bookings loop to display each booking row --%>
                <c:forEach var="booking" items="${bookings}">
                  <tr>
                    <%-- Booking ID column --%>
                    <td><strong>#
                        <c:out value="${booking.bookingId}" />
                      </strong></td>
                    <%-- Customer name column --%>
                    <td>
                      <c:out value="${booking.customerName}" />
                    </td>
                    <%-- Vehicle details column --%>
                    <td>
                      <c:out value="${booking.vehicleDetails}" />
                    </td>
                    <%-- Number plate column --%>
                    <td>
                      <c:out value="${booking.numberPlate}" />
                    </td>
                    <%-- Rental dates column --%>
                    <td>
                      <c:out value="${booking.startDate} to ${booking.endDate}" />
                    </td>

                    <%-- Status column with dynamic color --%>
                    <td style="font-weight: 600; color:
                      <c:choose>
                          <c:when test=" ${booking.status=='Active' || booking.status=='On Track' }">#3498db</c:when>
                      <c:when test="${booking.status == 'Completed'}">#27ae60</c:when>
                      <c:otherwise>#e74c3c</c:otherwise>
                      </c:choose>;">
                      <c:out value="${booking.status}" />
                    </td>

                    <%-- Actions column with view, edit, and delete buttons --%>
                    <td>
                      <%-- Action buttons container --%>
                      <div class="action-buttons">
                        <%-- View booking button --%>
                        <a href="${pageContext.request.contextPath}/viewBooking?id=${booking.bookingId}"
                          class="action-btn action-btn-view">View</a>
                        <%-- Edit booking button --%>
                        <a href="${pageContext.request.contextPath}/editBooking?id=${booking.bookingId}"
                          class="action-btn action-btn-edit">Edit</a>

                        <%-- Delete booking button with modal confirmation --%>
                        <a href="#deleteModal-${booking.bookingId}" class="action-btn action-btn-delete">Delete</a>

                        <%-- Delete confirmation modal --%>
                        <div id="deleteModal-${booking.bookingId}" class="modal-overlay">
                          <div class="modal-content">
                            <%-- Modal header --%>
                            <div class="modal-header">
                              <h3>Delete Booking</h3>
                            </div>
                            <%-- Modal body with confirmation message --%>
                            <div class="modal-body">
                              <p>Are you sure you want to delete booking <strong>#${booking.bookingId}</strong>? This
                                action cannot be undone.</p>
                            </div>
                            <%-- Modal footer with cancel and confirm buttons --%>
                            <div class="modal-footer">
                              <%-- Cancel button --%>
                              <a href="#" class="btn-cancel"
                                style="text-decoration: none; display: inline-flex; align-items: center; justify-content: center;">Cancel</a>

                              <%-- Confirm delete form --%>
                              <form action="${pageContext.request.contextPath}/deleteBooking" method="POST"
                                style="margin: 0; display: inline-block;">
                                <input type="hidden" name="booking_id" value="${booking.bookingId}">
                                <button type="submit" class="btn-delete-confirm"
                                  style="border: none; cursor: pointer;">Yes, Delete</button>
                              </form>
                            </div>
                          </div>
                        </div>

                      </div>
                    </td>
                  </tr>
                </c:forEach>

                <%-- Empty state message when no bookings exist --%>
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