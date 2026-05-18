<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <%@ page isELIgnored="false" %>
        <%-- Home page --%>
          <html lang="en">

          <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Root/HomeStyle.css">
            <title>RentAll - Car Rental</title>

          </head>

          <body>



            <%-- Navigation bar --%>
              <header>
                <nav>
                  <div class="nav_header">
                    <div class="nav_logo">
                      <a href="${pageContext.request.contextPath}/home" class="logo"><span>RentAll</span></a>
                    </div>
                  </div>

                  <%-- Navigation links --%>
                    <ul class="nav_links" id="nav-links">
                      <li><a href="${pageContext.request.contextPath}/rentalDeals">Rental Deals</a></li>
                      <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                      <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>

                      <%-- Mobile auth buttons (shown when user is not logged in) --%>
                        <c:if test="${empty sessionScope.user}">
                          <li class="mobile_auth">
                            <a href="${pageContext.request.contextPath}/login" class="button">Login</a>
                            <a href="${pageContext.request.contextPath}/register" class="button">Register</a>
                          </li>
                        </c:if>
                    </ul>

                    <%-- Authenticated user dropdown --%>
                      <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                          <!-- Authenticated User Dropdown (Visible on Desktop and Mobile) -->
                          <input type="checkbox" id="userDropdownToggle" class="user-dropdown-toggle">
                          <div class="user_avatar_wrap">
                            <label for="userDropdownToggle"
                              style="cursor: pointer; display: flex; align-items: center; gap: 0.6rem;">
                              <div class="user_avatar">
                                <img src="Assets/Profiles/${sessionScope.user.customer_image}"
                                  alt="${sessionScope.user.customer_username}" />
                              </div>
                              <span class="user_name_nav">
                                ${sessionScope.user.customer_username}
                              </span>
                              <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                stroke="#64748b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                style="width: 16px; height: 16px;">
                                <polyline points="6 9 12 15 18 9" />
                              </svg>
                            </label>

                            <div class="user_dropdown">
                              <div class="dropdown_header">
                                <p>${sessionScope.user.first_name} ${sessionScope.user.last_name}</p>
                                <span>${sessionScope.user.customer_email}</span>
                              </div>
                              <a href="${pageContext.request.contextPath}/userDashboard" class="dropdown_item">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                  stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                  <rect x="3" y="3" width="7" height="7" />
                                  <rect x="14" y="3" width="7" height="7" />
                                  <rect x="14" y="14" width="7" height="7" />
                                  <rect x="3" y="14" width="7" height="7" />
                                </svg>
                                Dashboard
                              </a>
                              <a href="${pageContext.request.contextPath}/settings" class="dropdown_item">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                  stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                  <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
                                  <circle cx="12" cy="7" r="4" />
                                </svg>
                                My Profile
                              </a>
                              <a href="${pageContext.request.contextPath}/myBookings" class="dropdown_item">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                  stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                  <rect x="3" y="4" width="18" height="18" rx="2" ry="2" />
                                  <line x1="16" y1="2" x2="16" y2="6" />
                                  <line x1="8" y1="2" x2="8" y2="6" />
                                  <line x1="3" y1="10" x2="21" y2="10" />
                                </svg>
                                My Bookings
                              </a>
                              <a href="${pageContext.request.contextPath}/logout" class="dropdown_item danger">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                  stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                  <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
                                  <polyline points="16 17 21 12 16 7" />
                                  <line x1="21" y1="12" x2="9" y2="12" />
                                </svg>
                                Log Out
                              </a>
                            </div>
                          </div>
                          </section>

                          <%-- Featured deal section --%>
                            <section class="deals" id="deals">
                              <div class="section_container deals_container">
                                <h2 class="section_header">Most popular car rental deals</h2>
                                <p class="section_description">
                                  Explore our top car rental deals, handpicked to give you the best value.
                                </p>
                                <%-- Featured deal card --%>
                                  <div class="deal_panel">
                                    <div class="deal_image">
                                      <img src="${pageContext.request.contextPath}/Assets/audi 6.jpg"
                                        alt="Toyota Corolla" />
                                    </div>
                                    <div class="deal_info">
                                      <%-- Vehicle title and tagline --%>
                                        <h3>Audi A6 Sedan</h3>
                                        <p class="deal_tagline">
                                          Comfortable sedan — ideal for city & highway
                                        </p>
                                        <%-- Vehicle specifications --%>
                                          <div class="deal_specs">
                                            <div class="spec">
                                              <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <path
                                                  d="M7.5 5.5C7.01665 5.5 6.60835 5.33335 6.275 5C5.94165 4.66666 5.775 4.25834 5.775 3.775C5.775 3.29167 5.94165 2.875 6.275 2.525C6.60835 2.175 7.01665 2 7.5 2C7.98335 2 8.4 2.175 8.75 2.525C9.1 2.875 9.275 3.29167 9.275 3.775C9.275 4.25834 9.1 4.66666 8.75 5C8.4 5.33335 7.98335 5.5 7.5 5.5ZM13.925 19.5H6.9C6.46665 19.5 6.09585 19.3584 5.7875 19.075C5.47915 18.7917 5.28335 18.4333 5.2 18L2.875 6.375H4.45L6.625 18H13.925V19.5ZM19.925 22L16.975 16.875H9.125C8.69165 16.875 8.30415 16.75 7.9625 16.5C7.62085 16.25 7.40835 15.9166 7.325 15.5L6.15 9.3C6 8.53335 6.19165 7.85415 6.725 7.2625C7.25835 6.67085 7.925 6.375 8.725 6.375C9.30835 6.375 9.80835 6.5625 10.225 6.9375C10.6417 7.3125 10.9083 7.78335 11.025 8.35L12.175 14.35H16.325C16.6584 14.35 16.95 14.45 17.2 14.65C17.45 14.85 17.6584 15.0917 17.825 15.375L21.25 21.25L19.925 22Z"
                                                  fill="black" />
                                              </svg>
                                              <span>5</span><small>Seats</small>
                                            </div>
                                            <div class="spec">
                                              <svg width="80" height="80" viewBox="0 0 80 80" fill="none"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <path
                                                  d="M3.5 80C1.5 80 -0.0833333 79.3056 -1.25 77.9167C-2.41667 76.5278 -3 74.8889 -3 73C-3 71.4333 -2.60267 70.0444 -1.808 68.8333C-1.01333 67.6222 0.0393333 66.8333 1.5 66.5V52.3333C0.0387 51.9444 -1.01467 51.1556 -1.809 49.9444C-2.60333 48.7333 -3.00067 47.3444 -3 45.7778C-3 43.8889 -2.41667 42.25 -1.25 40.8611C-0.0833333 39.4722 1.5 38.7778 3.5 38.7778C5.5 38.7778 7.08333 39.4722 8.25 40.8611C9.41667 42.25 10 43.8889 10 45.7778C10 47.3444 9.60333 48.7333 8.809 49.9444C8.01467 51.1556 6.96133 51.9444 5.5 52.3333V58.6667H18.5V52.3333C17.0387 51.9444 15.9853 51.1556 15.24 49.9444C14.4947 48.7333 14.1313 47.3444 14.5 45.7778C14.5 43.8889 15.0833 42.25 16.25 40.8611C17.4167 39.4722 19 38.7778 21 38.7778C23 38.7778 24.5833 39.4722 25.75 40.8611C26.9167 42.25 27.5 43.8889 27.5 45.7778C27.5 47.3444 27.1033 48.7333 26.309 49.9444C25.5147 51.1556 24.4613 51.9444 23 52.3333V58.6667H34.5C35.1667 58.6667 35.7167 58.4345 36.15 57.97C36.5833 57.5056 36.8333 56.9511 36.5 56.2222V52.3333C35.0387 51.9444 33.9853 51.1556 33.24 49.9444C32.4947 48.7333 32.1313 47.3444 32.5 45.7778C32.5 43.8889 33.0833 42.25 34.25 40.8611C35.4167 39.4722 37 38.7778 39 38.7778C41 38.7778 42.5833 39.4722 43.75 40.8611C44.9167 42.25 45.5 43.8889 45.5 45.7778C45.5 47.3444 45.1033 48.7333 44.309 49.9444C43.5147 51.1556 42.4613 51.9444 41 52.3333V56.2222C41 58.1111 40.4167 59.75 39.25 61.1389C38.0833 62.5278 36.5 63.2222 34.5 63.2222H23V66.5C24.4613 66.8889 25.5147 67.6778 26.309 68.8889C27.1033 70.1 27.5 71.4889 27.5 73C27.5 74.8889 26.9167 76.5278 25.75 77.9167C24.5833 79.3056 23 80 21 80C19 80 17.4167 79.3056 16.25 77.9167C15.0833 76.5278 14.5 74.8889 14.5 73C14.5 71.4333 14.8967 70.0444 15.691 68.8333C16.4853 67.6222 17.5387 66.8333 19 66.5V63.2222H5.5V66.5C6.96133 66.8889 8.01467 67.6778 8.809 68.8889C9.60333 70.1 10 71.4889 10 73C10 74.8889 9.41667 76.5278 8.25 77.9167C7.08333 79.3056 5.5 80 3.5 80Z"
                                                  fill="black" />
                                              </svg>
                                              <span>Auto</span><small>Transmission</small>
                                            </div>
                                            <div class="spec">
                                              <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <path
                                                  d="M3 2H6C6.28 2 6.53 2.11 6.71 2.29L8.79 4.38L9.59 3.59C10 3.2 10.5 3 11 3H17C17.5 3 18 3.2 18.41 3.59L19.41 4.59C19.8 5 20 5.5 20 6V19C20 19.5304 19.7893 20.0391 19.4142 20.4142C19.0391 20.7893 18.5304 21 18 21H8C7.46957 21 6.96086 20.7893 6.58579 20.4142C6.21071 20.0391 6 19.5304 6 19V8C6 7.5 6.2 7 6.59 6.59L7.38 5.79L5.59 4H3V2ZM11 5V7H17V5H11ZM11.41 11L9.41 9H8V10.41L10 12.41V15.59L8 17.59V19H9.41L11.41 17H14.59L16.59 19H18V17.59L16 15.59V12.41L18 10.41V9H16.59L14.59 11H11.41ZM12 13H14V15H12V13Z"
                                                  fill="black" />
                                              </svg>
                                              <span>Petrol</span><small>Fuel</small>
                                            </div>
                                            <div class="spec">
                                              <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <path
                                                  d="M9 20V15.85L5.75 19.05L4.35 17.65L9 13V11H7L2.35 15.65L0.95 14.25L4.15 11H0V9H4.15L0.95 5.75L2.35 4.35L7 9H9V7L4.35 2.35L5.75 0.95L9 4.15V0H11V4.15L14.25 0.95L15.65 2.35L11 7V9H13L17.65 4.35L19.05 5.75L15.85 9H20V11H15.85L19.05 14.25L17.65 15.65L13 11H11V13L15.65 17.65L14.25 19.05L11 15.85V20H9Z"
                                                  fill="black" />
                                              </svg>
                                              <span>AC</span><small>Climate</small>
                                            </div>
                                            <div class="spec">
                                              <svg width="27" height="27" viewBox="0 0 27 27" fill="none"
                                                xmlns="http://www.w3.org/2000/svg"
                                                xmlns:xlink="http://www.w3.org/1999/xlink">
                                                <rect width="27" height="27" fill="url(#pattern0_659_11)" />
                                                <defs>
                                                  <pattern id="pattern0_659_11" patternContentUnits="objectBoundingBox"
                                                    width="1" height="1">
                                                    <use xlink:href="#image0_659_11" transform="scale(0.0208333)" />
                                                  </pattern>
                                                  <image id="image0_659_11" width="48" height="48"
                                                    preserveAspectRatio="none"
                                                    xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAADhUlEQVR4AeyZP+hOURjH32QwGCiDwUBRBgPFhDIYDEwYhLARg7IYmFAkUUgmhBCFWGTAYEIooigUZaAMikHx+b6ve3s97/O+9/zuOee6ya/v9557n3PO85zvveffe37jOsP/JpG1Cz6G3+DPSL6g/mE4DSbDMAGziaCG7yGdCyfAWMjndpxIyCrSJPAE6M3fxvt0mAMTcXoBLoHR8ATsxGvSz4w/i/EYLsOZMAqegLVRHsMrT6HoDagvQlIPVoC6j/f2V+N+RgQXUPcttNC40JfQF7F5Qc+eAK/iFYxqQF0+pP4K+BVaLMOwH9aCFVDLSWClZ5RbAz3swFhrZrICpuLIwntrtkzo800K7oYeTmEc86C2Arz5/jOOU2Ivzs5DCw3mqxiVkoTBCgirFV9qMy6eQos5GE7AYFgBXhf6HuwtvKC6pfq8UltrHQYJJKmGFeB1oY/VbmqVeE2t9dDDQYyaYklGwwoYXTp97jVcHoAWGgfablSuD1aAVkfrLPezdrz3nSDaRFauD1aAlFtf760h8fMP/KnffyG10Pqw1Br7n62A/rziXgGK+1ypVvgtQ5xrfdAWx80OEeBWzGC8iE9vfdDe7Ah5LtokQA3U9Kmvoft+buBhORxA2wRoXdg00MqeQQvcwBhtmwA19S6X49BCXWlgVhqDAOsv67N+FXpdaStRNb2S9GAFVC4cvWrZr6O6kg4GygZYAfpMZebvm4WkmsoK6mfgHWwFX3H/JoI6/Sh8KdUvNMXSwP2EX4uV/QYrwNu4aY++kUoFNRvoRKGg8nWCUZfqEoUvpdrkFbG8nYEGsmLSpE7HCsi1cesGS3gpe4oVkDBGM67+C2jmPQ+PEvMFtHt8h+uCH7hvHHUEaHeq5X4yre2feTSwZmF7AhtDHQEnad1p6EE/E4ed/Xjlo211BOiUbVTgl6MyU+dZASHrwKKKRsyvyE+abQV4K7ENqCV+G0bvBEONP0teY7ACQgJrw3eUgt6/nR5gDzoOoVwSWAHe5ilJoFxOrABtY3PFyuLXCsgSJKdTK0Cra854yX3/cwKSv6HcDu0XCFnIqtuUv0Q5W1oBWsge5Y8fFUHjtNyuWAHyfEyXFlObSe2Iu030BJwj5xZsI57TKP2PjaQHT4DU6WTgTK9Ia656qTq1+GOx9QSoxSqko415POyDl+C9v8DrxDwEF0P9Q7wcvDx38QsAAP//tMOe8AAAAAZJREFUAwAgErz1jFVUaQAAAABJRU5ErkJggg==" />
                                                </defs>
                                              </svg>
                                              <span>4 Doors</span><small>Body</small>
                                            </div>
                                            <div class="spec">
                                              <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <g clip-path="url(#clip0_659_15)">
                                                  <path
                                                    d="M19 4H17V3C17 2.73478 16.8946 2.48043 16.7071 2.29289C16.5196 2.10536 16.2652 2 16 2C15.7348 2 15.4804 2.10536 15.2929 2.29289C15.1054 2.48043 15 2.73478 15 3V4H9V3C9 2.73478 8.89464 2.48043 8.70711 2.29289C8.51957 2.10536 8.26522 2 8 2C7.73478 2 7.48043 2.10536 7.29289 2.29289C7.10536 2.48043 7 2.73478 7 3V4H5C4.20435 4 3.44129 4.31607 2.87868 4.87868C2.31607 5.44129 2 6.20435 2 7V19C2 19.7956 2.31607 20.5587 2.87868 21.1213C3.44129 21.6839 4.20435 22 5 22H19C19.7956 22 20.5587 21.6839 21.1213 21.1213C21.6839 20.5587 22 19.7956 22 19V7C22 6.20435 21.6839 5.44129 21.1213 4.87868C20.5587 4.31607 19.7956 4 19 4ZM20 19C20 19.2652 19.8946 19.7071 19.7071C19.5196 19.8946 19.2652 20 19 20H5C4.73478 20 4.48043 19.8946 4.29289 19.7071C4.10536 19.5196 4 19.2652 4 19V12H20V19ZM20 10H4V7C4 6.73478 4.10536 6.48043 4.29289 6.29289C4.48043 6.10536 4.73478 6 5 6H7V7C7 7.26522 7.10536 7.51957 7.29289 7.70711C7.48043 7.89464 7.73478 8 8 8C8.26522 8 8.51957 7.89464 8.70711 7.70711C8.89464 7.51957 9 7.26522 9 7V6H15V7C15 7.26522 15.1054 7.51957 15.2929 7.70711C15.4804 7.89464 15.7348 8 16 8C16.2652 8 16.5196 7.89464 16.7071 7.70711C16.8946 7.51957 17 7.26522 17 7V6H19C19.2652 6 19.5196 6.10536 19.7071 6.29289C19.8946 6.48043 20 6.73478 20 7V10Z"
                                                    fill="black" />
                                                </g>
                                                <defs>
                                                  <clipPath id="clip0_659_15">
                                                    <rect width="24" height="24" fill="white" />
                                                  </clipPath>
                                                </defs>
                                              </svg>
                                              <span>2022</span><small>Year</small>
                                            </div>
                                          </div>
                                          <%-- Price and booking button --%>
                                            <div class="deal_price_row">
                                              <div class="deal_price">
                                                NPR 4,500 <small>/ day</small>
                                              </div>

                                              <a href="${pageContext.request.contextPath}/viewVehicleDetails?id=${v.vehicle_id}"
                                                class="button">
                                                Book Now
                                              </a>
                                            </div>

                                    </div>
                                  </div>
                              </div>

                              <%-- Why choose us section --%>
                                <section class="choose_container" id="choose">
                                  <div class="choose_image">
                                    <img src="${pageContext.request.contextPath}/Assets/why choosed us.jpeg"
                                      alt="Happy customer with car" />
                                  </div>
                                  <div class="choose_content">
                                    <h2 class="section_header">Why choose us</h2>
                                    <p class="section_description">
                                      Discover the difference with our car rental service. We offer reliable
                                      vehicles, exceptional customer service, and competitive pricing.
                                    </p>
                                    <%-- Benefits grid --%>
                                      <div class="choose_grid">
                                        <div class="choose_card">
                                          <span>
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                              xmlns="http://www.w3.org/2000/svg">
                                              <path
                                                d="M12 22.4998C19.25 22.4998 22 20.9998 22 15.4998M3.4015 17.8913C2.5595 17.6808 2 16.9123 2 16.0448V12.9558C2 12.0878 2.5595 11.3188 3.4015 11.1083C4.2145 10.9048 5.2825 10.6763 6.3325 10.5663C7.0515 10.4908 7.6845 10.9123 7.804 11.6248C7.909 12.2468 8 13.1703 8 14.4998C8 15.8298 7.9085 16.7533 7.804 17.3748C7.684 18.0873 7.0515 18.5088 6.3325 18.4338C5.2825 18.3238 4.2145 18.0948 3.4015 17.8913Z"
                                                stroke="black" stroke-width="1.5" stroke-linecap="round"
                                                stroke-linejoin="round" />
                                              <path
                                                d="M20.5985 17.8913C21.4405 17.6808 22 16.9123 22 16.0448V12.9558C22 12.0878 21.4405 11.3188 20.5985 11.1083C19.7855 10.9048 18.7175 10.6763 17.6675 10.5663C16.9485 10.4908 16.3155 10.9123 16.196 11.6248C16.091 12.2468 16 13.1703 16 14.4998C16 15.8298 16.0915 16.7533 16.196 17.3748C16.316 18.0873 16.9485 18.5088 17.6675 18.4338C18.7175 18.3238 19.7855 18.0948 20.5985 17.8913Z"
                                                stroke="black" stroke-width="1.5" stroke-linecap="round"
                                                stroke-linejoin="round" />
                                              <path
                                                d="M22 12.9555V11.5C22 5.977 17.523 1.5 12 1.5C6.477 1.5 2 5.977 2 11.5V12.9555M18.978 10.7565C18.693 7.255 15.678 4.5 12 4.5C8.322 4.5 5.307 7.255 5.022 10.7565"
                                                stroke="black" stroke-width="1.5" stroke-linecap="round"
                                                stroke-linejoin="round" />
                                            </svg>

                                          </span>
                                          <div>
                                            <h4>Customer Support</h4>
                                            <p>Our dedicated support team is available to assist you 24/7.</p>
                                          </div>
                                        </div>
                                        <div class="choose_card">
                                          <span>
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                              xmlns="http://www.w3.org/2000/svg">
                                              <path
                                                d="M12.0007 5.00003C13.6097 5.00003 15.1207 5.61403 16.2547 6.73003C17.3807 7.83703 18.0007 9.30903 18.0007 10.87C18.0007 12.431 17.3807 13.9 16.2557 15.009L12.0007 19.193L7.74668 15.007C6.62168 13.9 6.00168 12.431 6.00168 10.868C6.00168 9.30503 6.62168 7.83603 7.74668 6.72703C8.88208 5.61386 10.4106 4.99331 12.0007 5.00003ZM12.0007 3.00003C9.8852 2.99421 7.85266 3.82238 6.34368 5.30503C5.60181 6.02968 5.0123 6.89534 4.60982 7.85111C4.20734 8.80688 4 9.83347 4 10.8705C4 11.9076 4.20734 12.9342 4.60982 13.89C5.0123 14.8457 5.60181 15.7114 6.34368 16.436L12.0007 21.999L17.6577 16.434C18.3992 15.7094 18.9885 14.8439 19.3908 13.8883C19.7931 12.9327 20.0003 11.9063 20.0003 10.8695C20.0003 9.83271 19.7931 8.80635 19.3908 7.85077C18.9885 6.89518 18.3992 6.02965 17.6577 5.30503C16.1487 3.82238 14.1162 2.99421 12.0007 3.00003ZM12.0007 8.49903C12.6687 8.49903 13.2967 8.75903 13.7687 9.23003C14.001 9.4622 14.1854 9.73789 14.3111 10.0413C14.4369 10.3448 14.5016 10.6701 14.5016 10.9985C14.5016 11.327 14.4369 11.6523 14.3111 11.9557C14.1854 12.2592 14.001 12.5349 13.7687 12.767C13.2957 13.239 12.6687 13.498 12.0007 13.498C11.3327 13.498 10.7057 13.238 10.2327 12.767C10.0003 12.5349 9.81598 12.2592 9.69021 11.9557C9.56444 11.6523 9.49971 11.327 9.49971 10.9985C9.49971 10.6701 9.56444 10.3448 9.69021 10.0413C9.81598 9.73789 10.0003 9.4622 10.2327 9.23003C10.7018 8.76158 11.3377 8.49864 12.0007 8.49903ZM12.0007 7.49903C11.4247 7.49868 10.8576 7.64041 10.3496 7.91166C9.84153 8.18292 9.40825 8.57533 9.08813 9.0541C8.76802 9.53287 8.57096 10.0832 8.51443 10.6564C8.45789 11.2295 8.54362 11.8078 8.76403 12.3398C8.98443 12.8719 9.3327 13.3414 9.77796 13.7067C10.2232 14.072 10.7517 14.3218 11.3166 14.434C11.8815 14.5462 12.4654 14.5172 13.0164 14.3498C13.5675 14.1823 14.0687 13.8815 14.4757 13.474C15.1317 12.8172 15.5002 11.9269 15.5002 10.9985C15.5002 10.0702 15.1317 9.17985 14.4757 8.52303C13.8191 7.86704 12.9288 7.4987 12.0007 7.49903Z"
                                                fill="black" />
                                            </svg>
                                          </span>
                                          <div>
                                            <h4>Many Locations</h4>
                                            <p>Convenient pick-up and drop-off locations to suit your travel needs.</p>
                                          </div>
                                        </div>
                                        <div class="choose_card">
                                          <span>
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                              xmlns="http://www.w3.org/2000/svg">
                                              <path
                                                d="M19 4C19.5304 4 20.0391 4.21071 20.4142 4.58579C20.7893 4.96086 21 5.46957 21 6V8.268C21.304 8.44353 21.5565 8.696 21.732 9.00003C21.9076 9.30406 22 9.64894 22 10V14C22 14.3511 21.9076 14.6959 21.732 15C21.5565 15.304 21.304 15.5565 21 15.732V18C21 18.5304 20.7893 19.0391 20.4142 19.4142C20.0391 19.7893 19.5304 20 19 20H5C4.46957 20 3.96086 19.7893 3.58579 19.4142C3.21071 19.0391 3 18.5304 3 18V6C3 5.46957 3.21071 4.96086 3.58579 4.58579C3.96086 4.21071 4.46957 4 5 4H19ZM19 6H5V18H19V16H15C13.9564 16 12.9542 15.5922 12.2071 14.8636C11.46 14.135 11.0273 13.1433 11.0012 12.1C10.9751 11.0568 11.3577 10.0447 12.0674 9.27963C12.7772 8.51457 13.7578 8.05716 14.8 8.005L15 8H19V6ZM20 10H15C14.4696 10 13.9609 10.2107 13.5858 10.5858C13.2107 10.9609 13 11.4696 13 12C13 12.5304 13.2107 13.0391 13.5858 13.4142C13.9609 13.7893 14.4696 14 15 14H20V10ZM16 11C16.2652 11 16.5196 11.1054 16.7071 11.2929C16.8946 11.4804 17 11.7348 17 12C17 12.2652 16.8946 12.5196 16.7071 12.7071C16.5196 12.8946 16.2652 13 16 13C15.7348 13 15.4804 12.8946 15.2929 12.7071C15.1054 12.5196 15 12.2652 15 12C15 11.7348 15.1054 11.4804 15.2929 11.2929C15.4804 11.1054 15.7348 11 16 11Z"
                                                fill="black" />
                                            </svg>

                                          </span>
                                          <div>
                                            <h4>Best Price</h4>
                                            <p>Enjoy competitive rates and great value for every rental.</p>
                                          </div>
                                        </div>
                                        <div class="choose_card">
                                          <span>
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                              xmlns="http://www.w3.org/2000/svg">
                                              <path opacity="0.5" fill-rule="evenodd" clip-rule="evenodd"
                                                d="M7.25 6.258V6.5C7.25 6.69891 7.32902 6.88968 7.46967 7.03033C7.61032 7.17098 7.80109 7.25 8 7.25C8.19891 7.25 8.38968 7.17098 8.53033 7.03033C8.67098 6.88968 8.75 6.69891 8.75 6.5V6.25H15.25V6.5C15.25 6.69891 15.329 6.88968 15.4697 7.03033C15.6103 7.17098 15.8011 7.25 16 7.25C16.1989 7.25 16.3897 7.17098 16.5303 7.03033C16.671 6.88968 16.75 6.69891 16.75 6.5V6.258C16.8607 6.262 16.9613 6.26767 17.052 6.275C17.34 6.298 17.477 6.34 17.567 6.386C17.803 6.506 17.994 6.697 18.114 6.933C18.16 7.023 18.202 7.16 18.225 7.447C18.249 7.743 18.25 8.127 18.25 8.7V9.25H5.75V8.7C5.75 8.128 5.75 7.743 5.775 7.447C5.798 7.16 5.84 7.023 5.886 6.933C6.00591 6.69741 6.19741 6.50591 6.433 6.386C6.523 6.34 6.66 6.298 6.947 6.275C7.04784 6.26678 7.14887 6.26111 7.25 6.258ZM10.5 7C10.3011 7 10.1103 7.07902 9.96967 7.21967C9.82902 7.36032 9.75 7.55109 9.75 7.75C9.75 7.94891 9.82902 8.13968 9.96967 8.28033C10.1103 8.42098 10.3011 8.5 10.5 8.5H13.5C13.6989 8.5 13.8897 8.42098 14.0303 8.28033C14.171 8.13968 14.25 7.94891 14.25 7.75C14.25 7.55109 14.171 7.36032 14.0303 7.21967C13.8897 7.07902 13.6989 7 13.5 7H10.5Z"
                                                fill="black" />
                                              <path
                                                d="M8.5 14C8.83152 14 9.14946 13.8683 9.38388 13.6339C9.6183 13.3995 9.75 13.0815 9.75 12.75C9.75 12.4185 9.6183 12.1005 9.38388 11.8661C9.14946 11.6317 8.83152 11.5 8.5 11.5C8.16848 11.5 7.85054 11.6317 7.61612 11.8661C7.3817 12.1005 7.25 12.4185 7.25 12.75C7.25 13.0815 7.3817 13.3995 7.61612 13.6339C7.85054 13.8683 8.16848 14 8.5 14ZM8.5 17.5C8.83152 17.5 9.14946 17.3683 9.38388 17.1339C9.6183 16.8995 9.75 16.5815 9.75 16.25C9.75 15.9185 9.6183 15.6005 9.38388 15.3661C9.14946 15.1317 8.83152 15 8.5 15C8.16848 15 7.85054 15.1317 7.61612 15.3661C7.3817 15.6005 7.25 15.9185 7.25 16.25C7.25 16.5815 7.3817 16.8995 7.61612 17.1339C7.85054 17.3683 8.16848 17.5 8.5 17.5ZM13.25 12.75C13.25 13.0815 13.1183 13.3995 12.8839 13.6339C12.6495 13.8683 12.3315 14 12 14C11.6685 14 11.3505 13.8683 11.1161 13.6339C10.8817 13.3995 10.75 13.0815 10.75 12.75C10.75 12.4185 10.8817 12.1005 11.1161 11.8661C11.3505 11.6317 11.6685 11.5 12 11.5C12.3315 11.5 12.6495 11.6317 12.8839 11.8661C13.1183 12.1005 13.25 12.4185 13.25 12.75ZM12 17.5C12.3315 17.5 12.6495 17.3683 12.8839 17.1339C13.1183 16.8995 13.25 16.5815 13.25 16.25C13.25 15.9185 13.1183 15.6005 12.8839 15.3661C12.6495 15.1317 12.3315 15 12 15C11.6685 15 11.3505 15.1317 11.1161 15.3661C10.8817 15.6005 10.75 15.9185 10.75 16.25C10.75 16.5815 10.8817 16.8995 11.1161 17.1339C11.3505 17.3683 11.6685 17.5 12 17.5ZM16.75 12.75C16.75 13.0815 16.6183 13.3995 16.3839 13.6339C16.1495 13.8683 15.8315 14 15.5 14C15.1685 14 14.8505 13.8683 14.6161 13.6339C14.3817 13.3995 14.25 13.0815 14.25 12.75C14.25 12.4185 14.3817 12.1005 14.6161 11.8661C14.8505 11.6317 15.1685 11.5 15.5 11.5C15.8315 11.5 16.1495 11.6317 16.3839 11.8661C16.6183 12.1005 16.75 12.4185 16.75 12.75Z"
                                                fill="black" />
                                              <path fill-rule="evenodd" clip-rule="evenodd"
                                                d="M8 3.25C8.19891 3.25 8.38968 3.32902 8.53033 3.46967C8.67098 3.61032 8.75 3.80109 8.75 4V4.75H15.25V4C15.25 3.80109 15.329 3.61032 15.4697 3.46967C15.6103 3.32902 15.8011 3.25 16 3.25C16.1989 3.25 16.3897 3.32902 16.5303 3.46967C16.671 3.61032 16.75 3.80109 16.75 4V4.758C16.902 4.762 17.0437 4.76933 17.175 4.78C17.555 4.81 17.911 4.878 18.248 5.05C18.7656 5.31367 19.1863 5.73445 19.45 6.252C19.622 6.589 19.69 6.945 19.72 7.325C19.75 7.69 19.75 8.135 19.75 8.67V16.33C19.75 16.865 19.75 17.31 19.72 17.675C19.69 18.055 19.622 18.411 19.45 18.748C19.1866 19.2654 18.7662 19.6862 18.249 19.95C17.911 20.122 17.555 20.19 17.175 20.22C16.81 20.25 16.365 20.25 15.831 20.25H8.17C7.635 20.25 7.19 20.25 6.825 20.22C6.445 20.19 6.089 20.122 5.752 19.95C5.23475 19.6869 4.81401 19.2668 4.55 18.75C4.378 18.412 4.31 18.056 4.28 17.676C4.25 17.311 4.25 16.866 4.25 16.332V8.67C4.25 8.135 4.25 7.69 4.28 7.325C4.31 6.945 4.378 6.589 4.55 6.252C4.81367 5.73445 5.23445 5.31367 5.752 5.05C6.089 4.878 6.445 4.81 6.825 4.78C6.95633 4.76933 7.098 4.762 7.25 4.758V4C7.25 3.90151 7.2694 3.80398 7.30709 3.71299C7.34478 3.62199 7.40003 3.53931 7.46967 3.46967C7.53931 3.40003 7.62199 3.34478 7.71299 3.30709C7.80398 3.2694 7.90151 3.25 8 3.25ZM7.25 6.5V6.258C7.14887 6.26111 7.04784 6.26678 6.947 6.275C6.66 6.298 6.523 6.34 6.433 6.386C6.19741 6.50591 6.00591 6.69741 5.886 6.933C5.84 7.023 5.798 7.16 5.775 7.447C5.751 7.743 5.75 8.127 5.75 8.7V9.25H18.25V8.7C18.25 8.128 18.25 7.743 18.225 7.447C18.202 7.16 18.16 7.023 18.114 6.933C17.9941 6.69741 17.8026 6.50591 17.567 6.386C17.477 6.34 17.34 6.298 17.052 6.275C16.9515 6.2668 16.8508 6.26113 16.75 6.258V6.5C16.75 6.69891 16.671 6.88968 16.5303 7.03033C16.3897 7.17098 16.1989 7.25 16 7.25C15.8011 7.25 15.6103 7.17098 15.4697 7.03033C15.329 6.88968 15.25 6.69891 15.25 6.5V6.25H8.75V6.5C8.75 6.69891 8.67098 6.88968 8.53033 7.03033C8.38968 7.17098 8.19891 7.25 8 7.25C7.80109 7.25 7.61032 7.17098 7.46967 7.03033C7.32902 6.88968 7.25 6.69891 7.25 6.5ZM18.25 10.25H5.75V16.3C5.75 16.872 5.75 17.257 5.775 17.552C5.798 17.84 5.84 17.977 5.886 18.067C6.006 18.303 6.197 18.494 6.433 18.614C6.523 18.66 6.66 18.702 6.947 18.725C7.243 18.749 7.627 18.75 8.2 18.75H15.8C16.372 18.75 16.757 18.75 17.052 18.725C17.34 18.702 17.477 18.66 17.567 18.614C17.8026 18.4941 17.9941 18.3026 18.114 18.067C18.16 17.977 18.202 17.84 18.225 17.552C18.249 17.257 18.25 16.872 18.25 16.3V10.25Z"
                                                fill="black" />
                                            </svg>
                                          </span>
                                          <div>
                                            <h4>Free Cancellations</h4>
                                            <p>Flexible bookings with free cancellation options.</p>
                                          </div>
                                        </div>
                                      </div>
                                  </div>
                                </section>

                                <%-- Newsletter subscription section --%>
                                  <section class="subscribe_container" id="subscribe">
                                    <div class="subscribe_image">
                                      <img src="Assets/ford-raptor-r-concept-1.jpg" alt="Newsletter car" />
                                    </div>
                                    <div class="subscribe_content">
                                      <h2 class="section_header">Subscribe for the latest car rental updates</h2>
                                      <p class="section_description">
                                        Stay in the know! Subscribe to receive the latest car rental deals,
                                        exclusive offers, and updates right to your inbox.
                                      </p>

                                      <%-- Subscription status messages --%>
                                        <c:choose>
                                          <c:when test="${param.subscribeStatus == 'success'}">
                                            <p class="subscribe_flash subscribe_flash--success">
                                              You have been subscribed successfully. Welcome aboard!
                                            </p>
                                          </c:when>
                                          <c:when test="${param.subscribeStatus == 'unsubscribed'}">
                                            <p class="subscribe_flash subscribe_flash--warning">
                                              You have been unsubscribed. You can re-subscribe any time.
                                            </p>
                                          </c:when>
                                          <c:when test="${param.subscribeStatus == 'duplicate'}">
                                            <p class="subscribe_flash subscribe_flash--warning">
                                              That email is already subscribed. No action needed.
                                            </p>
                                          </c:when>
                                          <c:when test="${param.subscribeStatus == 'error'}">
                                            <p class="subscribe_flash subscribe_flash--error">
                                              Something went wrong. Please try again shortly.
                                            </p>
                                          </c:when>
                                        </c:choose>

                                        <%-- Subscribe or unsubscribe form based on current subscription status --%>
                                          <c:choose>
                                            <c:when
                                              test="${isSubscribed == true && param.subscribeStatus != 'unsubscribed'}">
                                              <%-- User is currently subscribed --%>
                                                <p class="subscribe_flash subscribe_flash--success"
                                                  style="margin-bottom: 0.75rem;">
                                                  You are subscribed to our newsletter.
                                                </p>
                                                <a href="#unsubscribeModal" class="button button_outline"
                                                  style="background:#fee2e2; color:#dc2626; border:1px solid #fca5a5; display:inline-block; text-decoration:none;">
                                                  Inactive (Unsubscribe)
                                                </a>
                                                <%-- Unsubscribe confirmation modal --%>
                                                  <div id="unsubscribeModal" class="modal-overlay">
                                                    <div class="modal-content">
                                                      <div class="modal-header">
                                                        <h3>Unsubscribe Newsletter</h3>
                                                      </div>
                                                      <div class="modal-body">
                                                        <p>Are you sure you want to unsubscribe from our newsletter? You
                                                          will no longer
                                                          receive updates and deals via email.</p>
                                                      </div>
                                                      <div class="modal-footer">
                                                        <a href="#" class="btn-cancel"
                                                          style="text-decoration: none;">Cancel</a>
                                                        <form action="${pageContext.request.contextPath}/subscribe"
                                                          method="post" style="margin:0;">
                                                          <input type="hidden" name="action" value="unsubscribe" />
                                                          <input type="hidden" name="email"
                                                            value="${sessionScope.user.customer_email}" />
                                                          <button type="submit" class="btn-delete-confirm"
                                                            style="border: none; cursor: pointer;">Yes,
                                                            Unsubscribe</button>
                                                        </form>
                                                      </div>
                                                    </div>
                                                  </div>
                                            </c:when>
                                            <c:otherwise>
                                              <%-- User is not subscribed --%>
                                                <form action="${pageContext.request.contextPath}/subscribe"
                                                  method="post" class="subscribe_form">
                                                  <input type="hidden" name="action" value="subscribe" />
                                                  <input type="email" name="email"
                                                    value="${sessionScope.user.customer_email}"
                                                    placeholder="Enter your email address" required />
                                                  <button type="submit" class="button">Subscribe</button>
                                                </form>
                                            </c:otherwise>
                                          </c:choose>
                                    </div>
                                  </section>

                                  <%-- Customer reviews section --%>
                                    <section class="section_container client_container" id="client">
                                      <h2 class="section_header">What people say about us</h2>
                                      <p class="section_description">Discover why our customers love renting with us!
                                      </p>
                                      <%-- Reviews grid --%>
                                        <div class="client_grid">

                                          <c:choose>
                                            <c:when test="${not empty latestReviews}">
                                              <c:forEach var="review" items="${latestReviews}">
                                                <%-- Individual review card --%>
                                                  <div class="client_card">
                                                    <div class="client_details">
                                                      <%-- Reviewer profile photo --%>
                                                        <c:choose>
                                                          <c:when test="${not empty review.customerImage}">
                                                            <img
                                                              src="${pageContext.request.contextPath}/Assets/Profiles/${review.customerImage}"
                                                              alt="<c:out value='${review.customerName}' />"
                                                              class="client_avatar" />
                                                          </c:when>
                                                          <c:otherwise>
                                                            <div class="client_avatar default-avatar">

                                                            </div>
                                                          </c:otherwise>
                                                        </c:choose>
                                                        <%-- Reviewer name and rating --%>
                                                          <div>
                                                            <h4>
                                                              <c:out value="${review.customerName}" />
                                                            </h4>
                                                            <%-- Star rating display --%>
                                                              <div class="client_rating">
                                                                <c:forEach begin="1" end="5">
                                                                  <svg class="star-fill"
                                                                    xmlns="http://www.w3.org/2000/svg"
                                                                    viewBox="0 0 24 24" fill="currentColor">
                                                                </c:forEach>
                                                              </div>
                                                              <small class="review-date">
                                                                <fmt:formatDate value="${review.reviewDate}"
                                                                  pattern="MMM dd, yyyy" />
                                                              </small>
                                                          </div>
                                                    </div>
                                                    <%-- Review text --%>
                                                      <p>
                                                        <c:out value="${review.reviewDescription}" />
                                                      </p>
                                                  </div>
                                              </c:forEach>
                                            </c:when>
                                          </c:choose>

                                        </div>
                                    </section>
                            </section>
                            <%-- Footer include --%>
                              <jsp:include page="/WEB-INF/Pages/Includes/footer.jsp" />
                              <script>
                                document.addEventListener("DOMContentLoaded", () => {
                                  const menuBtn = document.getElementById('menu-btn');
                                  const navLinks = document.getElementById('nav-links');

                                  if (menuBtn && navLinks) {
                                    menuBtn.addEventListener('click', () => {
                                      navLinks.classList.toggle('active');
                                    });
                                  }
                                });
                              </script>
          </body>

          </html>