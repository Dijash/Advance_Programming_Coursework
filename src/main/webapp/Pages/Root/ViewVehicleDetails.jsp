<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.model.Customer" %>
<%@ page isELIgnored="false" %>

<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Root/ViewVehicleDetails.Css">
  <title>RentAll | ${vehicle.vehicle_brand} ${vehicle.vehicle_type}</title>
</head>

<body>

  <jsp:include page="/Pages/Includes/navbar.jsp" />

  <div style="background: var(--bg);">
    <main class="container">

      <div style="margin-bottom: 2rem; color: #64748b; font-size: 0.9rem; font-weight: 500;">
        <a href="${pageContext.request.contextPath}/rentalDeals" style="color: #2563eb; text-decoration: none;">Fleet & Deals</a>
        <span style="margin: 0 0.5rem;">/</span>
        <span style="color: #0f172a;">${vehicle.vehicle_brand} ${vehicle.vehicle_type}</span>
      </div>

      <c:if test="${not empty vehicle}">
        <div class="layout">

          <div class="vehicle_details">
            <div class="image_card">
              <div class="image_container">
                <span class="status_badge ${vehicle.vehicle_status != 'Available' ? 'unavailable' : ''}">
                  ${vehicle.vehicle_status}
                </span>
                <img src="${pageContext.request.contextPath}/Assets/${vehicle.vehicle_image}" alt="${vehicle.vehicle_brand} ${vehicle.vehicle_type}" />
              </div>
              <div class="content_padding">
                <span class="brand_tag">${vehicle.vehicle_brand}</span>
                <h1 class="title">${vehicle.vehicle_type}</h1>

                <div class="specs_list">
                  <div class="spec_row">
                    <span class="spec_label">
                      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M5 17H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h1l2-4h10l2 4h1a2 2 0 0 1 2 2v6a2 2 0 0 1-2 2h-2" />
                        <circle cx="7.5" cy="17" r="2.5" />
                        <circle cx="16.5" cy="17" r="2.5" />
                      </svg>
                      Class
                    </span>
                    <span class="spec_value">${vehicle.vehicle_type}</span>
                  </div>
                  <div class="spec_row">
                    <span class="spec_label">
                      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M12 2.69l5.66 5.66a8 8 0 1 1-11.31 0z" />
                      </svg>
                      Color
                    </span>
                    <span class="spec_value">${vehicle.vehicle_color}</span>
                  </div>
                  <div class="spec_row">
                    <span class="spec_label">
                      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M12 2L15 8.5L22 9.3L17 14L18.2 21L12 17.8L5.8 21L7 14L2 9.3L9 8.5L12 2Z" />
                      </svg>
                      Condition
                    </span>
                    <span class="spec_value">${vehicle.vehicle_condition}</span>
                  </div>
                  <div class="spec_row">
                    <span class="spec_label">
                      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="8" width="18" height="8" rx="2" ry="2"></rect>
                        <line x1="7" y1="12" x2="7.01" y2="12"></line>
                      </svg>
                      Plate No.
                    </span>
                    <span class="spec_value">${vehicle.vehicle_numberPlate}</span>
                  </div>
                </div>

                <h3 style="margin-bottom: 1.5rem;">Included Features</h3>
                <div class="features_list">
                  <div class="feature_item">
                    <svg fill="currentColor" viewBox="0 0 20 20">
                      <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                    </svg>
                    Insurance Coverage
                  </div>
                  <div class="feature_item">
                    <svg fill="currentColor" viewBox="0 0 20 20">
                      <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                    </svg>
                    24/7 Roadside Assistance
                  </div>
                  <div class="feature_item">
                    <svg fill="currentColor" viewBox="0 0 20 20">
                      <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                    </svg>
                    Free Cancellation
                  </div>
                  <div class="feature_item">
                    <svg fill="currentColor" viewBox="0 0 20 20">
                      <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                    </svg>
                    Sanitized Interior
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="booking_container">
            <div class="booking_card">

              <c:if test="${not empty dateError}">
                <div style="background: #fee2e2; color: #b91c1c; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; border: 1px solid #f87171; font-weight: 600; font-size: 0.9rem;">
                  ${dateError}
                </div>
              </c:if>

              <div class="price_display">
                <h2>NPR <c:out value="${vehicle.vehicle_price}" /></h2>
                <span>/ day</span>
              </div>

              <form action="${pageContext.request.contextPath}/submitBooking" method="POST">
                <input type="hidden" name="vehicle_id" value="${vehicle.vehicle_id}">

                <label class="form_label" for="pickupDate">Start Date</label>
                <input type="date" id="pickupDate" name="booking_startDate" required class="input_field" onchange="calcTotal()">

                <label class="form_label" for="returnDate">End Date</label>
                <input type="date" id="returnDate" name="booking_endDate" required class="input_field" onchange="calcTotal()">

                <div class="summary_box">
                  <div class="summary_row">
                    <span>Duration</span>
                    <span><span id="daysCount">0</span> Days</span>
                  </div>
                  <div class="summary_row">
                    <span>Rate per day</span>
                    <span>NPR <c:out value="${vehicle.vehicle_price}" /></span>
                  </div>
                  <div class="total_row">
                    <span>Total Price</span>
                    <span id="totalPrice">NPR 0</span>
                  </div>
                </div>

                <c:choose>
                  <c:when test="${vehicle.vehicle_status == 'Available'}">
                    <button type="submit" class="book_btn">Confirm Reservation</button>
                  </c:when>
                  <c:otherwise>
                    <button type="button" class="book_btn" disabled>Currently Rented</button>
                  </c:otherwise>
                </c:choose>
              </form>

            </div>
          </div>
        </div>
      </c:if>
    </main>
  </div>

  <jsp:include page="/Pages/Includes/footer.jsp" />

  <script>
    document.addEventListener("DOMContentLoaded", () => {
      // Set minimum date to today to prevent past bookings
      const today = new Date().toISOString().split('T')[0];
      document.getElementById("pickupDate").min = today;
      document.getElementById("returnDate").min = today;
    });

    // Dynamically calculate total booking cost
    function calcTotal() {
      const start = document.getElementById('pickupDate').value;
      const end = document.getElementById('returnDate').value;
      const dailyRate = parseFloat("${vehicle.vehicle_price}");

      if (start && end) {
        const s = new Date(start);
        const e = new Date(end);
        let diff = Math.ceil((e - s) / (1000 * 60 * 60 * 24));

        if (diff < 0) {
          document.getElementById('daysCount').innerText = "0";
          document.getElementById('totalPrice').innerText = "NPR 0";
        } else {
          if (diff === 0) diff = 1; // Same day counts as 1 day minimum
          document.getElementById('daysCount').innerText = diff;
          document.getElementById('totalPrice').innerText = "NPR " + (diff * dailyRate).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        }
      }
    }
  </script>
</body>
</html>