<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.model.Customer" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
     <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Root/ViewVehicleDetails.css">
    <title>RentAll — ${vehicle.vehicle_brand} ${vehicle.vehicle_type}</title>

</head>

<body>

    <header>
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
                        <!-- Authenticated User Dropdown -->
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

    <div style="background: var(--bg);">
        <main class="container">
            <div style="margin-bottom: 2rem; color: #64748b; font-size: 0.9rem; font-weight: 500;">
                <a href="${pageContext.request.contextPath}/rentalDeals" style="color: #2563eb; text-decoration: none;">Fleet & Deals</a>
                <span style="margin: 0 0.5rem;">/</span> <span style="color: #0f172a;">${vehicle.vehicle_brand} ${vehicle.vehicle_type}</span>
            </div>

            <c:if test="${not empty vehicle}">
                <div class="layout">
                    <!-- LEFT: Vehicle Info -->
                    <div class="vehicle_details">
                        <div class="image_card">
                            <div class="image_container">
                                <span class="status_badge ${vehicle.vehicle_status != 'Available' ? 'unavailable' : ''}">
                                    ${vehicle.vehicle_status}
                                </span>
                                <img src="${pageContext.request.contextPath}/Assets/${vehicle.vehicle_image}" alt="Car View" />
                            </div>
                            <div class="content_padding">
                                <span class="brand_tag">${vehicle.vehicle_brand}</span>
                                <h1 class="title">${vehicle.vehicle_type}</h1>

                                <!-- Sleek Minimalist Spec List -->
                                <div class="specs_list">
                                    <div class="spec_row">
                                        <span class="spec_label">
                                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 17H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h1l2-4h10l2 4h1a2 2 0 0 1 2 2v6a2 2 0 0 1-2 2h-2"/><circle cx="7.5" cy="17" r="2.5"/><circle cx="16.5" cy="17" r="2.5"/></svg>
                                            Class
                                        </span>
                                        <span class="spec_value">${vehicle.vehicle_type}</span>
                                    </div>
                                    <div class="spec_row">
                                        <span class="spec_label">
                                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2.69l5.66 5.66a8 8 0 1 1-11.31 0z"/></svg>
                                            Color
                                        </span>
                                        <span class="spec_value">${vehicle.vehicle_color}</span>
                                    </div>
                                    <div class="spec_row">
                                        <span class="spec_label">
                                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2L15 8.5L22 9.3L17 14L18.2 21L12 17.8L5.8 21L7 14L2 9.3L9 8.5L12 2Z"/></svg>
                                            Condition
                                        </span>
                                        <span class="spec_value">${vehicle.vehicle_condition}</span>
                                    </div>
                                    <div class="spec_row">
                                        <span class="spec_label">
                                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="8" width="18" height="8" rx="2" ry="2"></rect><line x1="7" y1="12" x2="7.01" y2="12"></line></svg>
                                            Plate No.
                                        </span>
                                        <span class="spec_value">${vehicle.vehicle_numberPlate}</span>
                                    </div>
                                </div>

                                <h3 style="margin-bottom: 1.5rem;">Included Features</h3>
                                <div class="features_list">
                                    <div class="feature_item">
                                        <svg fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                                        Insurance Coverage
                                    </div>
                                    <div class="feature_item">
                                        <svg fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                                        24/7 Roadside Assistance
                                    </div>
                                    <div class="feature_item">
                                        <svg fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                                        Free Cancellation
                                    </div>
                                    <div class="feature_item">
                                        <svg fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                                        Sanitized Interior
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- RIGHT: Booking Card -->
                    <div class="booking_container">
                        <div class="booking_card">

                            <!-- Server Side JSTL Error Box -->
                            <c:if test="${not empty dateError}">
                                <div style="background: #fee2e2; color: #b91c1c; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; border: 1px solid #f87171; font-weight: 600; font-size: 0.9rem;">
                                    ${dateError}
                                </div>
                            </c:if>

                            <div class="price_display">
                                <h2>NPR 4,500</h2>
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
                                        <span>NPR 4,500</span>
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

    <!-- Target Footer -->
    <footer class="footer">
        <div class="section_container footer_container">
            <div class="footer_col">
                <div class="footer_logo">
                    <a href="#" class="logo">
                        <img src="https://placehold.co/60x60/ffffff/0f172a?text=R" alt="RentAll logo" />
                        <span>RentAll</span>
                    </a>
                </div>
                <p>We're here to provide you with the best vehicles and a seamless rental experience.</p>
                <div class="footer_socials">
                    <a href="#" aria-label="Facebook">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/></svg>
                    </a>
                    <a href="#" aria-label="Instagram">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"/><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"/><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"/></svg>
                    </a>
                    <a href="#" aria-label="Twitter / X">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg>
                    </a>
                </div>
            </div>

            <div class="footer_col">
                <h4>Our Services</h4>
                <ul class="footer_links">
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/rentalDeals">Rental Deals</a></li>
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
                        <a href="tel:+9779818162494">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M6.62 10.79a15.05 15.05 0 0 0 6.59 6.59l2.2-2.2a1 1 0 0 1 1.02-.24 11.44 11.44 0 0 0 3.58.57 1 1 0 0 1 1 1V20a1 1 0 0 1-1 1A17 17 0 0 1 3 4a1 1 0 0 1 1-1h3.5a1 1 0 0 1 1 1c0 1.25.2 2.45.57 3.58a1 1 0 0 1-.25 1.01z"/></svg>
                            +977 9818162494
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z"/></svg>
                            Kathmandu, Nepal
                        </a>
                    </li>
                    <li>
                        <a href="mailto:kushal@gmail.com">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                            kushal@gmail.com
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </footer>

    <!-- JS for Calculator and Mobile Menu -->
    <script>
        // Calendar Restrictions
        document.addEventListener("DOMContentLoaded", () => {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById("pickupDate").min = today;
            document.getElementById("returnDate").min = today;

            // Mobile menu toggle
            const menuBtn = document.querySelector('.nav_menu_button');
            const navLinks = document.querySelector('.nav_links');
            if(menuBtn) {
                menuBtn.addEventListener('click', () => {
                    navLinks.classList.toggle('active');
                });
            }

            // User dropdown toggle
            const avatarWrap = document.getElementById('userAvatarWrap');
            const dropdown   = document.getElementById('userDropdown');
            if (avatarWrap && dropdown) {
                avatarWrap.addEventListener('click', function(e) {
                    e.stopPropagation();
                    dropdown.classList.toggle('open');
                });
                document.addEventListener('click', function() {
                    dropdown.classList.remove('open');
                });
            }
        });

        // Price Calculator
        function calcTotal() {
            const start = document.getElementById('pickupDate').value;
            const end = document.getElementById('returnDate').value;
            const dailyRate = 4500;

            if (start && end) {
                const s = new Date(start);
                const e = new Date(end);
                let diff = Math.ceil((e - s) / (1000 * 60 * 60 * 24));

                if (diff < 0) {
                    document.getElementById('daysCount').innerText = "0";
                    document.getElementById('totalPrice').innerText = "NPR 0";
                } else {
                    if (diff === 0) diff = 1; // Same day counts as 1 day
                    document.getElementById('daysCount').innerText = diff;
                    document.getElementById('totalPrice').innerText = "NPR " + (diff * dailyRate).toLocaleString();
                }
            }
        }
    </script>
</body>
</html>