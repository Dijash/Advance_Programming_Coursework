<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page import="com.model.Customer" %>
<%@ page isELIgnored="false" %>
<%-- Rental Deals page --%>
<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Root/RentalDeals.Css">
  <title>RentAll - Vehicle Fleet & Deals</title>

</head>

<c:set var="activePage" value="rentalDeals" scope="request" />

<%-- Error alert display --%>
<c:if test="${not empty error}">
  <script>
    alert("${error}");
  </script>
</c:if>

<body>
  <%-- Navigation bar --%>
  <jsp:include page="/WEB-INF/Pages/Includes/navbar.jsp" />

  <%-- Main catalog section --%>
  <main class="section_container">
    <div class="catalog_wrapper">
      <%-- Filter sidebar --%>
      <aside class="filter_sidebar">
        <h3>Filter Options</h3>
        <%-- Filter form --%>
        <form action="${pageContext.request.contextPath}/rentalDeals" method="GET">
          <%-- Vehicle type filter --%>
          <div class="filter_group">
            <label for="type">Vehicle Type</label>
            <select name="type" id="type">
              <option value="All" ${filterType=='All' ? 'selected' : '' }>All Types</option>
              <option value="SUV" ${filterType=='SUV' ? 'selected' : '' }>SUV</option>
              <option value="Sedan" ${filterType=='Sedan' ? 'selected' : '' }>Sedan</option>
              <option value="Hatchback" ${filterType=='Hatchback' ? 'selected' : '' }>Hatchback</option>
            </select>
          </div>

          <%-- Color filter --%>
          <div class="filter_group">
            <label for="color">Color</label>
            <select name="color" id="color">
              <option value="All" ${filterColor=='All' ? 'selected' : '' }>All Colors</option>
              <option value="Black" ${filterColor=='Black' ? 'selected' : '' }>Black</option>
              <option value="White" ${filterColor=='White' ? 'selected' : '' }>White</option>
              <option value="Silver" ${filterColor=='Silver' ? 'selected' : '' }>Silver</option>
              <option value="Red" ${filterColor=='Red' ? 'selected' : '' }>Red</option>
              <option value="Blue" ${filterColor=='Blue' ? 'selected' : '' }>Blue</option>
              <option value="blue" ${filterColor=='blue' ? 'selected' : '' }>Blue (lowercase)</option>
              <option value="Slate Grey" ${filterColor=='Slate Grey' ? 'selected' : '' }>Slate Grey</option>
              <option value="Orange" ${filterColor=='Orange' ? 'selected' : '' }>Orange</option>
            </select>
          </div>

          <%-- Condition filter --%>
          <div class="filter_group">
            <label for="condition">Condition</label>
            <select name="condition" id="condition">
              <option value="All" ${filterCondition=='All' ? 'selected' : '' }>All Conditions</option>
              <option value="Excellent" ${filterCondition=='Excellent' ? 'selected' : '' }>Excellent
              </option>
              <option value="Good" ${filterCondition=='Good' ? 'selected' : '' }>Good</option>
              <option value="Fair" ${filterCondition=='Fair' ? 'selected' : '' }>Fair</option>
            </select>
          </div>

          <%-- Availability filter --%>
          <div class="filter_group">
            <label for="status">Availability</label>
            <select name="status" id="status">
              <option value="Available" ${filterStatus=='Available' ? 'selected' : '' }>Available Only
              </option>
              <option value="Rented" ${filterStatus=='Rented' ? 'selected' : '' }>Rented</option>
              <option value="Maintenance" ${filterStatus=='Maintenance' ? 'selected' : '' }>Maintenance
              </option>
              <option value="All" ${filterStatus=='All' ? 'selected' : '' }>Show All</option>
            </select>
          </div>

          <%-- Filter buttons --%>
          <div class="filter_btn_group">
            <button type="submit" class="button" style="width: 100%;">Apply Filters</button>
            <a href="${pageContext.request.contextPath}/rentalDeals" class="button button_outline"
              style="padding: 0.7rem; display: flex; align-items: center; justify-content: center;"
              title="Reset Filters">
              <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"
                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                stroke-linejoin="round">
                <path d="M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"></path>
                <polyline points="3 3 3 8 8 8"></polyline>
              </svg>
            </a>
          </div>
        </form>
      </aside>


      <%-- Vehicle grid section --%>
      <div class="vehicle_content">
        <%-- Vehicle header with count --%>
        <div class="vehicle_header">
          <div>
            <h1>Vehicle Catalog</h1>
            <p>
              <c:choose>
                <c:when test="${not empty vehicleList}">
                  Showing <strong>${fn:length(vehicleList)}</strong> vehicle(s)
                  <%-- Filter status indicator --%>
                  <c:if
                    test="${not empty searchParam or filterType != 'All' or filterColor != 'All' or filterCondition != 'All' or filterStatus != 'All'}">
                    &mdash; filtered results
                    <a href="${pageContext.request.contextPath}/rentalDeals"
                      style="font-size:0.85rem; margin-left:0.4rem;">Clear filters</a>
                  </c:if>
                </c:when>
                <c:otherwise>
                  Browse and filter our complete fleet.
                </c:otherwise>
              </c:choose>
            </p>
          </div>
        </div>

        <%-- Vehicle cards grid --%>
        <div class="vehicle_grid">

          <%-- Vehicle list iteration --%>
          <c:choose>
            <c:when test="${not empty vehicleList}">
              <c:forEach var="v" items="${vehicleList}">
                <%-- Individual vehicle card --%>
                <div class="horizontal_card" id="vehicle-card-${v.vehicle_id}">
                  <%-- Vehicle image wrapper --%>
                  <div class="hc_image_wrapper">
                    <%-- Status badge --%>
                    <span class="hc_badge ${v.vehicle_status != 'Available' ? 'unavailable' : ''}">
                      ${v.vehicle_status}
                    </span>
                    <img src="${pageContext.request.contextPath}/Assets/${v.vehicle_image}"
                      alt="${v.vehicle_brand}"
                      onerror="this.src='https://placehold.co/600x400/f1f5f9/94a3b8?text=Vehicle+Image'" />
                  </div>
                  <div class="hc_content">
                    <%-- Favorite toggle: guest redirected to login, logged in user posts to toggleFavorite --%>
                    <c:choose>
                      <c:when test="${empty sessionScope.user}">
                        <button class="fav_btn"
                          onclick="window.location.href='${pageContext.request.contextPath}/login'"
                          aria-label="Add to favorites">
                          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                            <path
                              d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z" />
                          </svg>
                        </button>
                      </c:when>
                      <c:otherwise>
                        <%-- Logged in user favorite toggle form --%>
                        <form action="${pageContext.request.contextPath}/toggleFavorite" method="POST"
                          style="margin:0; padding:0; position:absolute; top:2rem; right:2rem;">
                          <input type="hidden" name="vehicleId" value="${v.vehicle_id}">
                          <button type="submit"
                            class="fav_btn <c:forEach var='fId' items='${favoriteIds}'><c:if test='${fId == v.vehicle_id}'>active</c:if></c:forEach>"
                            style="position:static; top:auto; right:auto;" aria-label="Add to favorites">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                              <path
                                d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z" />
                            </svg>
                          </button>
                        </form>
                      </c:otherwise>
                    </c:choose>

                    <%-- Vehicle header with title and tagline --%>
                    <div class="hc_header">
                      <h2>${v.vehicle_brand} ${v.vehicle_type}</h2>
                      <p>Premium quality ${v.vehicle_type} — reliable and well-maintained</p>
                    </div>

                    <%-- 3x2 specifications grid populated from database --%>
                    <div class="hc_specs_grid">
                      <%-- Type spec box --%>
                      <div class="spec_box">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                          stroke="currentColor" stroke-width="2" stroke-linecap="round"
                          stroke-linejoin="round">
                          <path
                            d="M5 17H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h1l2-4h10l2 4h1a2 2 0 0 1 2 2v6a2 2 0 0 1-2 2h-2" />
                          <circle cx="7.5" cy="17" r="2.5" />
                          <circle cx="16.5" cy="17" r="2.5" />
                        </svg>
                        <strong>${v.vehicle_type}</strong>
                        <span>Class</span>
                      </div>
                      <%-- Brand spec box --%>
                      <div class="spec_box">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                          stroke="currentColor" stroke-width="2" stroke-linecap="round"
                          stroke-linejoin="round">
                          <polygon
                            points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
                          </polygon>
                        </svg>
                        <strong>${v.vehicle_brand}</strong>
                        <span>Brand</span>
                      </div>
                      <%-- Color spec box --%>
                      <div class="spec_box">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                          stroke="currentColor" stroke-width="2" stroke-linecap="round"
                          stroke-linejoin="round">
                          <path d="M12 2.69l5.66 5.66a8 8 0 1 1-11.31 0z" />
                        </svg>
                        <strong>${v.vehicle_color}</strong>
                        <span>Color</span>
                      </div>
                      <%-- Condition spec box --%>
                      <div class="spec_box">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                          stroke="currentColor" stroke-width="2" stroke-linecap="round"
                          stroke-linejoin="round">
                          <path d="M12 2L15 8.5L22 9.3L17 14L18.2 21L12 17.8L5.8 21L7 14L2 9.3L9 8.5L12 2Z" />
                        </svg>
                        <strong>${v.vehicle_condition}</strong>
                        <span>Condition</span>
                      </div>
                      <%-- Plate number spec box --%>
                      <div class="spec_box">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                          stroke="currentColor" stroke-width="2" stroke-linecap="round"
                          stroke-linejoin="round">
                          <rect x="3" y="8" width="18" height="8" rx="2" ry="2"></rect>
                          <line x1="7" y1="12" x2="7.01" y2="12"></line>
                        </svg>
                        <strong>${v.vehicle_numberPlate}</strong>
                        <span>Plate No.</span>
                      </div>
                      <%-- Status spec box --%>
                      <div class="spec_box">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                          stroke="currentColor" stroke-width="2" stroke-linecap="round"
                          stroke-linejoin="round">
                          <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                          <polyline points="22 4 12 14.01 9 11.01"></polyline>
                        </svg>
                        <strong>${v.vehicle_status}</strong>
                        <span>Status</span>
                      </div>
                    </div>

                    <%-- Price and booking footer --%>
                    <div class="hc_footer">
                      <%-- Daily price --%>
                      <div class="hc_price">NPR ${v.vehicle_price} <span>/ day</span></div>
                      <%-- Book now button --%>
                      <a href="${pageContext.request.contextPath}/viewVehicleDetails?id=${v.vehicle_id}"
                        class="button" ${v.vehicle_status !='Available'
                        ? 'style="pointer-events: none; opacity: 0.6;"' : '' }>
                        Book Now
                      </a>
                    </div>
                  </div>
                </div>

              </c:forEach>
            </c:when>

            <%-- No vehicles found message --%>
            <c:otherwise>
              <div class="no_results">
                <h2>No Vehicles Found</h2>
                <p>It looks like we don't have any vehicles matching your criteria right now.</p>
                <a href="${pageContext.request.contextPath}/rentalDeals" class="button"
                  style="margin-top: 1rem;">View All Vehicles</a>
              </div>
            </c:otherwise>
          </c:choose>

        </div>
      </div>
    </div>
  </main>

  <%-- Footer include --%>
  <jsp:include page="/WEB-INF/Pages/Includes/footer.jsp" />

  <script>
    const menuBtn = document.querySelector('.nav_menu_button');
    const navLinks = document.getElementById('nav-links');
    if (menuBtn && navLinks) {
      menuBtn.addEventListener('click', () => navLinks.classList.toggle('active'));
    }
  </script>
</body>

</html>