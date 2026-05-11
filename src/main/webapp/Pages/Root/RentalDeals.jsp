<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page import="com.model.Customer" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Root/RentalDeals.Css">
  <title>RentAll - Vehicle Fleet & Deals</title>

</head>

<c:if test="${not empty error}">
  <script>
      alert("${error}");
  </script>
</c:if>

<body>
  <header style="background: white; border-bottom: 1px solid #e2e8f0;">
    <nav>
        <div class="nav_header">
            <div class="nav_logo">
                <a href="${pageContext.request.contextPath}${not empty sessionScope.user ? '/home' : '/'}" class="logo">
                    <span>RentAll</span>
                </a>
            </div>
            <button class="nav_menu_button" aria-label="Toggle menu" id="menu-btn">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="3" y1="6" x2="21" y2="6"/>
                    <line x1="3" y1="12" x2="21" y2="12"/>
                    <line x1="3" y1="18" x2="21" y2="18"/>
                </svg>
            </button>
        </div>

        <ul class="nav_links" id="nav-links">
            <li><a href="${pageContext.request.contextPath}/rentalDeals">Rental Deals</a></li>
            <li><a href="${pageContext.request.contextPath}/about">About</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
        </ul>

        <div class="nav_buttons">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="user_avatar_wrap" id="userAvatarWrap">
                        <div class="user_avatar">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user.customer_image}">
                                    <img src="${pageContext.request.contextPath}/Assets/Profiles/${sessionScope.user.customer_image}" alt="${sessionScope.user.customer_username}" />
                                </c:when>
                                <c:otherwise>
                                    <!-- Fallback SVG if no profile image exists -->
                                    <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" style="color: white; width: 20px; height: 20px;">
                                        <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                                    </svg>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <span class="user_name_nav">
                            ${not empty sessionScope.user.customer_username ? sessionScope.user.customer_username : 'User'}
                        </span>
                        <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#64748b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width: 16px; height: 16px;"><polyline points="6 9 12 15 18 9"/></svg>

                        <div class="user_dropdown" id="userDropdown">
                            <div class="dropdown_header">
                                <p>${not empty sessionScope.user.first_name ? sessionScope.user.first_name : 'User'} ${sessionScope.user.last_name}</p>
                                <span>${sessionScope.user.customer_email}</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/userDashboard" class="dropdown_item">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
                                Dashboard
                            </a>
                            <a href="${pageContext.request.contextPath}/settings" class="dropdown_item">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                                My Profile
                            </a>
                            <a href="${pageContext.request.contextPath}/myBookings" class="dropdown_item">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
                                My Bookings
                            </a>
                            <a href="${pageContext.request.contextPath}/logout" class="dropdown_item danger">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
                                Log Out
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Guest User Logic -->
                    <a href="${pageContext.request.contextPath}/login" class="button button_outline">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="button">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
  </header>

  <main class="section_container">
    <div class="catalog_wrapper">
      <aside class="filter_sidebar">
        <h3>Filter Options</h3>
        <form action="${pageContext.request.contextPath}/rentalDeals" method="GET">
          <div class="filter_group">
            <label for="type">Vehicle Type</label>
            <select name="type" id="type">
              <option value="All"       ${filterType == 'All'       ? 'selected' : ''}>All Types</option>
              <option value="SUV"       ${filterType == 'SUV'       ? 'selected' : ''}>SUV</option>
              <option value="Sedan"     ${filterType == 'Sedan'     ? 'selected' : ''}>Sedan</option>
              <option value="Hatchback" ${filterType == 'Hatchback' ? 'selected' : ''}>Hatchback</option>
            </select>
          </div>

          <%-- Color filter --%>
          <div class="filter_group">
            <label for="color">Color</label>
            <select name="color" id="color">
              <option value="All"        ${filterColor == 'All'        ? 'selected' : ''}>All Colors</option>
              <option value="Black"      ${filterColor == 'Black'      ? 'selected' : ''}>Black</option>
              <option value="White"      ${filterColor == 'White'      ? 'selected' : ''}>White</option>
              <option value="Silver"     ${filterColor == 'Silver'     ? 'selected' : ''}>Silver</option>
              <option value="Red"        ${filterColor == 'Red'        ? 'selected' : ''}>Red</option>
              <option value="Blue"       ${filterColor == 'Blue'       ? 'selected' : ''}>Blue</option>
              <option value="blue"       ${filterColor == 'blue'       ? 'selected' : ''}>Blue (lowercase)</option>
              <option value="Slate Grey" ${filterColor == 'Slate Grey' ? 'selected' : ''}>Slate Grey</option>
              <option value="Orange"     ${filterColor == 'Orange'     ? 'selected' : ''}>Orange</option>
            </select>
          </div>

          <%-- Condition filter --%>
          <div class="filter_group">
            <label for="condition">Condition</label>
            <select name="condition" id="condition">
              <option value="All"       ${filterCondition == 'All'       ? 'selected' : ''}>All Conditions</option>
              <option value="Excellent" ${filterCondition == 'Excellent' ? 'selected' : ''}>Excellent</option>
              <option value="Good"      ${filterCondition == 'Good'      ? 'selected' : ''}>Good</option>
              <option value="Fair"      ${filterCondition == 'Fair'      ? 'selected' : ''}>Fair</option>
            </select>
          </div>

          <%-- Availability filter --%>
          <div class="filter_group">
            <label for="status">Availability</label>
            <select name="status" id="status">
              <option value="Available" ${filterStatus == 'Available' ? 'selected' : ''}>Available Only</option>
              <option value="All"       ${filterStatus == 'All'       ? 'selected' : ''}>Show All</option>
            </select>
          </div>

          <div class="filter_btn_group">
            <button type="submit" class="button" style="width: 100%;">Apply Filters</button>
            <a href="${pageContext.request.contextPath}/rentalDeals"
               class="button button_outline"
               style="padding: 0.7rem; display: flex; align-items: center; justify-content: center;"
               title="Reset Filters">
              <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"
                   fill="none" stroke="currentColor" stroke-width="2"
                   stroke-linecap="round" stroke-linejoin="round">
                <path d="M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"></path>
                <polyline points="3 3 3 8 8 8"></polyline>
              </svg>
            </a>
          </div>
        </form>
      </aside>


      <!-- RIGHT: Vehicle Grid -->
      <div class="vehicle_content">
        <div class="vehicle_header">
          <div>
            <h1>Vehicle Catalog</h1>
            <p>
              <c:choose>
                <c:when test="${not empty vehicleList}">
                  Showing <strong>${fn:length(vehicleList)}</strong> vehicle(s)
                  <c:if test="${not empty searchParam or filterType != 'All' or filterColor != 'All' or filterCondition != 'All' or filterStatus != 'All'}">
                    &mdash; filtered results
                    <a href="${pageContext.request.contextPath}/rentalDeals" style="font-size:0.85rem; margin-left:0.4rem;">Clear filters</a>
                  </c:if>
                </c:when>
                <c:otherwise>
                  Browse and filter our complete fleet.
                </c:otherwise>
              </c:choose>
            </p>
          </div>
        </div>

        <div class="vehicle_grid">

          <c:choose>
            <c:when test="${not empty vehicleList}">
              <c:forEach var="v" items="${vehicleList}">
                <div class="horizontal_card" id="vehicle-card-${v.vehicle_id}">
                  <div class="hc_image_wrapper">
                    <span class="hc_badge ${v.vehicle_status != 'Available' ? 'unavailable' : ''}">
                      ${v.vehicle_status}
                    </span>
                    <img src="${pageContext.request.contextPath}/Assets/${v.vehicle_image}" alt="${v.vehicle_brand}" onerror="this.src='https://placehold.co/600x400/f1f5f9/94a3b8?text=Vehicle+Image'" />
                  </div>
                  <div class="hc_content">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <button class="fav_btn" onclick="window.location.href='${pageContext.request.contextPath}/login'" aria-label="Add to favorites">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                    <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                                </svg>
                            </button>
                        </c:when>
                        <c:otherwise>
                            <!-- Logged In: Standard HTML Form Post -->
                            <form action="${pageContext.request.contextPath}/toggleFavorite" method="POST" style="margin:0; padding:0; position:absolute; top:2rem; right:2rem;">
                                <input type="hidden" name="vehicleId" value="${v.vehicle_id}">
                                <button type="submit" class="fav_btn <c:forEach var='fId' items='${favoriteIds}'><c:if test='${fId == v.vehicle_id}'>active</c:if></c:forEach>" style="position:static; top:auto; right:auto;" aria-label="Add to favorites">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                        <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                                    </svg>
                                </button>
                            </form>
                        </c:otherwise>
                    </c:choose>

                    <div class="hc_header">
                      <!-- Title fetching from database -->
                      <h2>${v.vehicle_brand} ${v.vehicle_type}</h2>
                      <p>Premium quality ${v.vehicle_type} — reliable and well-maintained</p>
                    </div>

                    <!-- 3x2 Specs Grid populated from Database -->
                    <div class="hc_specs_grid">
                      <div class="spec_box">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 17H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h1l2-4h10l2 4h1a2 2 0 0 1 2 2v6a2 2 0 0 1-2 2h-2"/><circle cx="7.5" cy="17" r="2.5"/><circle cx="16.5" cy="17" r="2.5"/></svg>
                        <strong>${v.vehicle_type}</strong>
                        <span>Class</span>
                      </div>
                      <div class="spec_box">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                        <strong>${v.vehicle_brand}</strong>
                        <span>Brand</span>
                      </div>
                      <div class="spec_box">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2.69l5.66 5.66a8 8 0 1 1-11.31 0z"/></svg>
                        <strong>${v.vehicle_color}</strong>
                        <span>Color</span>
                      </div>
                      <div class="spec_box">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L15 8.5L22 9.3L17 14L18.2 21L12 17.8L5.8 21L7 14L2 9.3L9 8.5L12 2Z"/></svg>
                        <strong>${v.vehicle_condition}</strong>
                        <span>Condition</span>
                      </div>
                      <div class="spec_box">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="8" width="18" height="8" rx="2" ry="2"></rect><line x1="7" y1="12" x2="7.01" y2="12"></line></svg>
                        <strong>${v.vehicle_numberPlate}</strong>
                        <span>Plate No.</span>
                      </div>
                      <div class="spec_box">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                        <strong>${v.vehicle_status}</strong>
                        <span>Status</span>
                      </div>
                    </div>

                    <div class="hc_footer">
                      <div class="hc_price">NPR ${v.vehicle_price} <span>/ day</span></div>
                      <a href="${pageContext.request.contextPath}/viewVehicleDetails?id=${v.vehicle_id}" class="button" ${v.vehicle_status != 'Available' ? 'style="pointer-events: none; opacity: 0.6;"' : ''}>
                        Book Now
                      </a>
                    </div>
                  </div>
                </div>

              </c:forEach>
            </c:when>

            <c:otherwise>
              <!-- Displays when there is no data in the database -->
              <div class="no_results">
                 <h2>No Vehicles Found</h2>
                 <p>It looks like we don't have any vehicles matching your criteria right now.</p>
                 <a href="${pageContext.request.contextPath}/rentalDeals" class="button" style="margin-top: 1rem;">View All Vehicles</a>
              </div>
            </c:otherwise>
          </c:choose>

        </div>
      </div>
    </div>
  </main>

  <footer class="footer">
    <div class="section_container footer_container">
      <div class="footer_col">
        <div class="footer_logo">
          <a href="#" class="logo">
            <img src="https://placehold.co/60x60/ffffff/0f172a?text=R" alt="RentAll logo" />
            <span>RentAll</span>
          </a>
        </div>
        <p>
          We're here to provide you with the best vehicles and a seamless
          rental experience.
        </p>
        <div class="footer_socials">
          <a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="1em" height="1em" fill="currentColor">
              <path d="M14 13.5H16.5L17.5 9.5H14V7.5C14 6.47062 14 5.5 16 5.5H17.5V2.1401C17.1743 2.09712 15.943 2 14.6429 2C11.9284 2 10 3.65686 10 6.69971V9.5H7V13.5H10V22H14V13.5Z"></path>
            </svg></a>
          <a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="1em" height="1em" fill="currentColor">
              <path d="M12 8.2688C9.93888 8.2688 8.2688 9.93888 8.2688 12C8.2688 14.0611 9.93888 15.7312 12 15.7312C14.0611 15.7312 15.7312 14.0611 15.7312 12C15.7312 9.93888 14.0611 8.2688 12 8.2688ZM6.2688 12C6.2688 8.83546 8.83546 6.2688 12 6.2688C15.1645 6.2688 17.7312 8.83546 17.7312 12C17.7312 15.1645 15.1645 17.7312 12 17.7312C8.83546 17.7312 6.2688 15.1645 6.2688 12ZM17.4734 5.1664C17.4734 5.92612 16.8575 6.54199 16.0978 6.54199C15.338 6.54199 14.7222 5.92612 14.7222 5.1664C14.7222 4.40669 15.338 3.79081 16.0978 3.79081C16.8575 3.79081 17.4734 4.40669 17.4734 5.1664ZM21.931 12C21.931 15.0116 21.6888 17.4103 20.3013 18.7978C18.9138 20.1852 16.5151 20.4275 13.5035 20.4275H10.4965C7.48491 20.4275 5.08616 20.1852 3.69871 18.7978C2.31126 17.4103 2.06897 15.0116 2.06897 12V8.99298C2.06897 5.98139 2.31126 3.58265 3.69871 2.1952C5.08616 0.807753 7.48491 0.56546 10.4965 0.56546H13.5035C16.5151 0.56546 18.9138 0.807753 20.3013 2.1952C21.6888 3.58265 21.931 5.98139 21.931 8.99298V12ZM20 12V8.99298C20 6.07925 19.7828 4.10398 18.8872 3.2084C17.9916 2.31281 16.0163 2.09562 13.1026 2.09562H10.8974C7.98369 2.09562 6.00842 2.31281 5.11284 3.2084C4.21725 4.10398 4 6.07925 4 8.99298V12C4 14.9137 4.21725 16.889 5.11284 17.7846C6.00842 18.6802 7.98369 18.8974 10.8974 18.8974H13.1026C16.0163 18.8974 17.9916 18.6802 18.8872 17.7846C19.7828 16.889 20 14.9137 20 12Z"></path>
            </svg></a>
          <a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="1em" height="1em" fill="currentColor">
              <path d="M10.4883 14.651L15.2594 21H22.25L14.2906 10.3699L21.472 2H19.9221L13.4886 9.48512L8.7406 2H1.75L9.70938 12.6301L2.52805 21H4.07788L10.4883 14.651ZM16.2275 19.5L5.51402 3.5H7.77253L18.486 19.5H16.2275Z"></path>
            </svg></a>
        </div>
      </div>
      <div class="footer_col">
        <h4>Our Services</h4>
        <ul class="footer_links">
          <li><a href="${pageContext.request.contextPath}/">Home</a></li>
          <li><a href="${pageContext.request.contextPath}/about">About</a></li>
          <li>
            <a href="${pageContext.request.contextPath}/#deals">Rental Deals</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/#choose">Why Choose Us</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/#client">Testimonials</a>
          </li>
        </ul>
      </div>
      <div class="footer_col">
        <h4>Vehicle Models</h4>
        <ul class="footer_links">
          <li><a href="#">Toyota Corolla</a></li>
          <li><a href="#">Toyota Noah</a></li>
          <li><a href="#">Mitsubishi Pajero</a></li>
          <li><a href="#">Suzuki Swift</a></li>
        </ul>
      </div>
      <div class="footer_col">
        <h4>Contact</h4>
        <ul class="footer_links">
          <li>
            <a href="tel:+9779818162494"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="1em" height="1em" fill="currentColor">
                <path d="M21 16.4217V19.9566C21 20.4796 20.6083 20.9161 20.0886 20.9538C19.742 20.9788 19.3879 20.9913 19.0259 20.9913C9.62002 20.9913 2 13.3713 2 3.96541C2 3.60341 2.01254 3.24928 2.03756 2.90263C2.07525 2.38299 2.5117 1.99121 3.03471 1.99121H6.56956C7.05436 1.99121 7.46824 2.34149 7.55172 2.82023C7.65342 3.40428 7.82276 3.97176 8.05527 4.51268C8.25704 4.98205 8.16335 5.52928 7.78841 5.90422L6.37762 7.31501C7.88295 10.3479 10.6433 13.1083 13.6762 14.6136L15.087 13.2028C15.462 12.8279 16.0092 12.7342 16.4785 12.9359C17.0195 13.1684 17.5869 13.3378 18.171 13.4395C18.6497 13.523 19 13.9369 19 14.4217V16.4217H21Z"></path>
              </svg> +977 9818162494</a>
          </li>
          <li>
            <a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="1em" height="1em" fill="currentColor">
                <path d="M18.364 17.364L12 23.7279L5.63604 17.364C2.12132 13.8492 2.12132 8.15076 5.63604 4.63604C9.15076 1.12132 14.8492 1.12132 18.364 4.63604C21.8787 8.15076 21.8787 13.8492 18.364 17.364ZM12 13C13.1046 13 14 12.1046 14 11C14 9.89543 13.1046 9 12 9C10.8954 9 10 9.89543 10 11C10 12.1046 10.8954 13 12 13Z"></path>
              </svg> Kathmandu, Nepal</a>
          </li>
          <li>
            <a href="mailto:support@rentall.com"> <svg width="22" height="22" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path d="M4 4h16v16H4z" />
                <path d="M22 6l-10 7L2 6" />
              </svg> support@rentall.com</a>
          </li>
        </ul>
      </div>
    </div>
  </footer>

  <script>
      // ── Hamburger menu toggle ──
      const menuBtn = document.querySelector('.nav_menu_button');
      const navLinks = document.getElementById('nav-links');
      if (menuBtn && navLinks) {
        menuBtn.addEventListener('click', () => navLinks.classList.toggle('active'));
      }

      // ── User dropdown toggle ──
      const avatarWrap = document.getElementById('userAvatarWrap');
      const dropdown   = document.getElementById('userDropdown');
      if (avatarWrap && dropdown) {
        avatarWrap.addEventListener('click', function(e) {
          e.stopPropagation();
          dropdown.classList.toggle('open');
        });
        // Close when clicking outside
        document.addEventListener('click', function() {
          dropdown.classList.remove('open');
        });
      }
  </script>
</body>
</html>