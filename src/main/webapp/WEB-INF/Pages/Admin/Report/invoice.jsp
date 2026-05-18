<%-- Invoice page for booking details --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>

    <!doctype html>
    <html lang="en">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>RentAll | Invoice #${booking.bookingId}</title>
      <link
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Fira+Code:wght@400;500&display=swap"
        rel="stylesheet" />
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Report/invoice.css">
    </head>

    <body>

      <%-- Page wrapper with back button --%>
      <div class="page-wrapper">
        <%-- Back to reports link --%>
        <a href="${pageContext.request.contextPath}/report" class="btn-back">
          <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
            stroke-linejoin="round" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="M19 12H5M12 19l-7-7 7-7" />
          </svg>
          Back to Reports
        </a>

        <%-- Invoice card containing booking details --%>
        <div class="invoice-card">
          <%-- Invoice header with title and status --%>
          <div class="invoice-header">
            <%-- Header title section --%>
            <div class="header-title">
              <h1>Booking Details</h1>
              <p>REF ID: #
                <c:out value="${booking.bookingId}" />
              </p>
            </div>

            <%-- Status badge with dynamic styling --%>
            <div class="status-badge
                    <c:choose>
                        <c:when test=" ${booking.status=='Completed' }">status-completed</c:when>
              <c:when test="${booking.status == 'Cancelled'}">status-cancelled</c:when>
              <c:otherwise>status-pending</c:otherwise>
              </c:choose>">
              <c:out value="${booking.status}" />
            </div>
          </div>

          <%-- Trip schedule detail section --%>
          <div class="detail-section">
            <h3>Trip Schedule</h3>
            <%-- Pickup date row --%>
            <div class="detail-row">
              <span class="detail-label">Pickup Date</span>
              <span class="detail-value">
                <c:out value="${booking.startDate}" />
              </span>
            </div>
            <%-- Return date row --%>
            <div class="detail-row">
              <span class="detail-label">Return Date</span>
              <span class="detail-value">
                <c:out value="${booking.endDate}" />
              </span>
            </div>
          </div>

          <%-- Rental info detail section --%>
          <div class="detail-section">
            <h3>Rental Info</h3>
            <%-- Renter name row --%>
            <div class="detail-row">
              <span class="detail-label">Renter Name</span>
              <span class="detail-value">
                <c:out value="${booking.customerName}" default="N/A" />
              </span>
            </div>
            <%-- Vehicle details row --%>
            <div class="detail-row">
              <span class="detail-label">Vehicle Details</span>
              <span class="detail-value">
                <c:out value="${booking.vehicleDetails}" default="N/A" />
              </span>
            </div>
          </div>

          <%-- Total amount box --%>
          <div class="total-box">
            <span class="total-label">Grand Total Paid</span>
            <span class="total-amount">NPR
              <c:out value="${booking.totalPrice}" />
            </span>
          </div>
        </div>
      </div>

    </body>

    </html>