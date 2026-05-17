<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page import="com.model.Customer" %>

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
            <li><a href="${pageContext.request.contextPath}/rentalDeals" class="${activePage == 'rentalDeals' ? 'active' : ''}">Rental Deals</a></li>
            <li><a href="${pageContext.request.contextPath}/about" class="${activePage == 'about' ? 'active' : ''}">About</a></li>
            <li><a href="${pageContext.request.contextPath}/contact" class="${activePage == 'contact' ? 'active' : ''}">Contact Us</a></li>
        </ul>

        <div class="nav_buttons">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <input type="checkbox" id="userDropdownToggle" class="user-dropdown-toggle">
                    <div class="user_avatar_wrap">
                        <label for="userDropdownToggle" style="cursor: pointer; display: flex; align-items: center; gap: 0.6rem;">
                        <div class="user_avatar">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user.customer_image}">
                                    <img src="${pageContext.request.contextPath}/Assets/Profiles/${sessionScope.user.customer_image}" alt="${sessionScope.user.customer_username}" />
                                </c:when>
                                <c:otherwise>
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
                        </label>

                        <div class="user_dropdown">
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
                    <a href="${pageContext.request.contextPath}/login" class="button button_outline">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="button">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
</header>