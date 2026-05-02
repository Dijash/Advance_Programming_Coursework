<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.model.Customer" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RentAll - Vehicle Fleet & Deals</title>
  <style>
    @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap");

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: "Poppins", sans-serif;
      background-color: #f4f7f6;
      color: #1e293b;
      line-height: 1.6;
      overflow-x: hidden;
    }

    .icon { width: 1em; height: 1em; display: inline-block; vertical-align: middle; flex-shrink: 0; }

    .section_container {
      max-width: 1350px;
      margin: auto;
      padding: 3rem 2rem;
    }

    /* Standardized Buttons */
    .button {
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      background-color: #2563eb;
      color: white;
      padding: 0.7rem 1.8rem;
      border-radius: 90px;
      font-weight: 600;
      border: none;
      cursor: pointer;
      transition: all 0.2s ease;
      text-decoration: none;
      font-size: 0.9rem;
      font-family: 'Poppins', sans-serif;
      justify-content: center;
    }

    .button:hover {
      background-color: #1d4ed8;
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
    }

    .button_outline {
      background-color: transparent;
      color: #2563eb;
      border: 2px solid #2563eb;
    }

    .button_outline:hover {
      background-color: #2563eb;
      color: white;
    }

    /* ========================================
       NAVBAR
    ======================================== */
    nav {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1.2rem 2rem;
      max-width: 1350px;
      margin: 0 auto;
      flex-wrap: wrap;
      gap: 1rem;
    }

    .nav_header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      width: auto;
    }

    .nav_logo .logo {
      font-size: 1.8rem;
      font-weight: 800;
      text-decoration: none;
      background: linear-gradient(120deg, #1e40af, #3b82f6);
      background-clip: text;
      -webkit-background-clip: text;
      color: transparent;
    }

    .nav_links {
      display: flex;
      gap: 2rem;
      list-style: none;
    }

    .nav_links a {
      text-decoration: none;
      font-weight: 500;
      color: #1e293b;
      transition: color 0.2s;
      font-size: 0.95rem;
    }

    .nav_links a:hover,
    .nav_links a.active {
      color: #2563eb;
    }

    .nav_buttons {
      display: flex;
      gap: 0.8rem;
      align-items: center;
    }

    .nav_menu_button {
      display: none;
      font-size: 1.8rem;
      cursor: pointer;
      color: #1e293b;
      background: none;
      border: none;
      padding: 0;
      line-height: 1;
    }

    /* --- User Dropdown Nav Styles --- */
    .user_avatar_wrap {
        position: relative;
        display: flex;
        align-items: center;
        gap: 0.6rem;
        cursor: pointer;
        user-select: none;
    }

    .user_avatar {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background: linear-gradient(135deg, #2563eb, #1d4ed8);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        font-size: 0.85rem;
        flex-shrink: 0;
        letter-spacing: 0.5px;
        overflow: hidden;
    }

    .user_avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 50%;
    }

    .user_name_nav {
        font-size: 0.9rem;
        font-weight: 500;
        color: #1e293b;
    }

    .user_dropdown {
        display: none;
        position: absolute;
        top: calc(100% + 10px);
        right: 0;
        min-width: 220px;
        background: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        box-shadow: 0 12px 30px rgba(0, 0, 0, 0.12);
        z-index: 999;
        overflow: hidden;
    }

    .user_dropdown.open {
        display: block;
        animation: dropdownFade 0.15s ease;
    }

    @keyframes dropdownFade {
        from { opacity: 0; transform: translateY(-6px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    .dropdown_header {
        padding: 0.9rem 1rem;
        border-bottom: 1px solid #f8fafc;
        background: #f8fafc;
    }
    .dropdown_header p {
        font-weight: 600;
        font-size: 0.9rem;
        margin: 0 0 2px;
        color: #0f172a;
    }
    .dropdown_header span {
        font-size: 0.78rem;
        color: #64748b;
    }
    .dropdown_item {
        display: flex;
        align-items: center;
        gap: 0.6rem;
        padding: 0.7rem 1rem;
        font-size: 0.88rem;
        color: #0f172a;
        text-decoration: none;
        transition: background 0.15s;
        width: 100%;
        background: none;
        border: none;
        cursor: pointer;
        font-family: inherit;
        text-align: left;
    }
    .dropdown_item:hover {
        background: #f8fafc;
        color: #2563eb;
    }
    .dropdown_item.danger {
        color: #ef4444;
    }
    .dropdown_item.danger:hover {
        background: #fff1f1;
        color: #b91c1c;
    }


    /* ========================================
       CATALOG LAYOUT
    ======================================== */
    .catalog_wrapper {
      display: grid;
      grid-template-columns: 280px 1fr;
      gap: 2.5rem;
      align-items: start;
    }

    /* --- Filter Sidebar --- */
    .filter_sidebar {
      background: white;
      padding: 1.8rem;
      border-radius: 16px;
      border: 1px solid #e2e8f0;
      position: sticky;
      top: 2rem;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
    }

    .filter_sidebar h3 {
      font-size: 1.1rem;
      font-weight: 700;
      color: #0f172a;
      margin-bottom: 1.5rem;
      padding-bottom: 10px;
      border-bottom: 2px solid #f1f5f9;
    }

    .filter_group {
      margin-bottom: 1.2rem;
    }

    .filter_group label {
      display: block;
      font-size: 0.8rem;
      font-weight: 600;
      color: #475569;
      margin-bottom: 0.4rem;
    }

    .filter_group select,
    .filter_group input[type="text"] {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid #cbd5e1;
      border-radius: 8px;
      font-family: 'Poppins', sans-serif;
      font-size: 0.85rem;
      color: #1e293b;
      background: #f8fafc;
      outline: none;
      transition: all 0.2s ease;
    }

    .filter_group select:focus,
    .filter_group input[type="text"]:focus {
      border-color: #2563eb;
      background: white;
      box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    .filter_btn_group {
      display: flex;
      gap: 0.8rem;
      margin-top: 2rem;
    }

    .filter_btn_group .button {
       border-radius: 8px;
    }

    /* --- Vehicle Grid Header --- */
    .vehicle_header {
      display: flex;
      justify-content: space-between;
      align-items: flex-end;
      margin-bottom: 2rem;
      padding-bottom: 1rem;
      border-bottom: 1px solid #e2e8f0;
    }

    .vehicle_header h1 {
      font-size: 2rem;
      font-weight: 800;
      color: #0f172a;
      line-height: 1.2;
    }

    .vehicle_header p {
      color: #64748b;
      font-size: 0.95rem;
      margin-top: 5px;
    }

    /* --- MODERN HORIZONTAL CARD DESIGN --- */
    .vehicle_grid {
      display: grid;
      grid-template-columns: 1fr;
      gap: 2rem;
    }

    .horizontal_card {
      background: white;
      border-radius: 20px;
      border: 1px solid #e2e8f0;
      display: flex;
      padding: 0;
      overflow: hidden;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
      position: relative;
      transition: all 0.3s ease;
    }

    .horizontal_card:hover {
      box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
      transform: translateY(-4px);
    }

    /* The Photo Part */
    .hc_image_wrapper {
      position: relative;
      flex: 0 0 340px;
      min-height: 100%;
      background: #f1f5f9;
    }

    .hc_image_wrapper img {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .hc_badge {
      position: absolute;
      top: 15px;
      left: 15px;
      background: #10b981;
      color: white;
      font-size: 0.75rem;
      font-weight: 700;
      padding: 6px 12px;
      border-radius: 6px;
      z-index: 2;
      letter-spacing: 0.5px;
      text-transform: uppercase;
      box-shadow: 0 2px 5px rgba(0,0,0,0.15);
    }

    .hc_badge.unavailable {
        background: #ef4444;
    }

    /* Content Area */
    .hc_content {
      flex: 1;
      display: flex;
      flex-direction: column;
      padding: 2rem;
      position: relative;
    }

    /* Favorite Button Top Right of Content Area */
    .fav_btn {
      position: absolute;
      top: 2rem;
      right: 2rem;
      width: 40px;
      height: 40px;
      background: #f8fafc;
      border: 1px solid #e2e8f0;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      transition: all 0.2s ease;
      color: #94a3b8;
    }

    .fav_btn:hover {
      color: #ef4444;
      background: #fee2e2;
      border-color: #fca5a5;
      transform: scale(1.05);
    }

    .fav_btn.active {
      color: #ef4444;
      background: #fee2e2;
      border-color: #fca5a5;
    }

    .fav_btn svg {
      width: 20px;
      height: 20px;
      fill: currentColor;
    }

    .hc_header {
      margin-bottom: 1.5rem;
      padding-right: 3rem;
    }

    .hc_header h2 {
      font-size: 1.6rem;
      font-weight: 700;
      color: #0f172a;
      margin-bottom: 0.4rem;
      line-height: 1.2;
    }

    .hc_header p {
      color: #64748b;
      font-size: 0.95rem;
    }

    /* 3x2 Grid for Specs */
    .hc_specs_grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 12px;
      margin-bottom: 2rem;
    }

    .spec_box {
      border: 1px solid #e2e8f0;
      border-radius: 10px;
      padding: 12px 8px;
      text-align: center;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      background: #ffffff;
      transition: border-color 0.2s;
    }

    .spec_box:hover {
      border-color: #cbd5e1;
    }

    .spec_box svg {
      width: 22px;
      height: 22px;
      color: #3b82f6;
      margin-bottom: 8px;
    }

    .spec_box strong {
      font-size: 0.95rem;
      color: #0f172a;
      font-weight: 700;
      line-height: 1.2;
    }

    .spec_box span {
      font-size: 0.75rem;
      color: #94a3b8;
      margin-top: 2px;
    }

    .hc_footer {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding-top: 1.5rem;
      border-top: 1px solid #f1f5f9;
      margin-top: auto;
    }

    .hc_price {
      font-size: 1.6rem;
      font-weight: 800;
      color: #0f172a;
    }

    .hc_price span {
      font-size: 0.9rem;
      font-weight: 500;
      color: #64748b;
    }

    .no_results {
      text-align: center;
      padding: 4rem 2rem;
      background: white;
      border-radius: 12px;
      border: 1px solid #e2e8f0;
    }

    .no_results h2 {
      color: #0f172a;
      margin-bottom: 0.5rem;
    }

    .no_results p {
      color: #64748b;
    }

    /* ========================================
       FOOTER
    ======================================== */
    .footer {
      background: #0f172a;
      color: #cbd5e1;
      margin-top: 4rem;
    }

    .footer_container {
      display: flex;
      flex-wrap: wrap;
      gap: 2rem;
      justify-content: space-between;
      padding: 4rem 2rem 2rem;
      max-width: 1280px;
      margin: auto;
    }

    .footer_col {
      flex: 1;
      min-width: 180px;
    }

    .footer_logo .logo {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      text-decoration: none;
      font-size: 1.5rem;
      font-weight: 800;
      color: white;
      margin-bottom: 1rem;
    }

    .footer_logo img {
      width: 36px;
      height: 36px;
      object-fit: contain;
      filter: brightness(0) invert(1);
    }

    .footer_col>p {
      font-size: 0.88rem;
      line-height: 1.7;
      color: #94a3b8;
      margin-bottom: 1.2rem;
    }

    .footer_socials {
      display: flex;
      gap: 0.8rem;
      margin-top: 0.5rem;
    }

    .footer_socials a {
      width: 36px;
      height: 36px;
      background: #1e293b;
      color: #cbd5e1;
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1rem;
      text-decoration: none;
      transition: background 0.2s, color 0.2s;
    }

    .footer_socials a:hover {
      background: #2563eb;
      color: white;
    }

    .footer_col h4 {
      font-size: 0.95rem;
      font-weight: 600;
      color: white;
      margin-bottom: 1rem;
    }

    .footer_links {
      list-style: none;
    }

    .footer_links li {
      margin-bottom: 0.6rem;
    }

    .footer_links a {
      text-decoration: none;
      color: #94a3b8;
      font-size: 0.88rem;
      transition: color 0.2s;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
    }

    .footer_links a:hover {
      color: white;
    }

    .footer_links a svg {
      width: 15px;
      height: 15px;
      flex-shrink: 0;
    }

    /* Responsive Design */
    @media (max-width: 1048px) {
      .nav_links, .nav_buttons { display: none; }
      .nav_menu_button { display: block; }
      .catalog_wrapper { grid-template-columns: 1fr; }
      .filter_sidebar { position: relative; top: 0; }
    }

    @media (max-width: 800px) {
      .horizontal_card { flex-direction: column; }
      .hc_image_wrapper {
        flex: auto;
        width: 100%;
        height: 250px;
      }
      .hc_image_wrapper img { position: relative; }
      .hc_content { padding: 1.5rem; }
      .fav_btn { top: 1.5rem; right: 1.5rem; }
    }

    @media (max-width: 500px) {
      .hc_specs_grid { grid-template-columns: repeat(2, 1fr); }
      .hc_footer { flex-direction: column; align-items: flex-start; gap: 1rem; }
      .hc_footer .button { width: 100%; }
    }
  </style>
</head>

<c:if test="${not empty error}">
  <script>
      alert("${error}");
  </script>
</c:if>

<body>
  <!-- Header -->
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
            <li><a href="<%= request.getContextPath() %>/rentalDeals">Rental Deals</a></li>
            <li><a href="<%= request.getContextPath() %>/about">About</a></li>
            <li><a href="<%= request.getContextPath() %>/contact">Contact Us</a></li>
        </ul>

        <div class="nav_buttons">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <!-- Authenticated User Dropdown -->
                    <div class="user_avatar_wrap" id="userAvatarWrap">
                        <div class="user_avatar">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user.customer_image}">
                                    <img src="<%= request.getContextPath() %>/Assets/Profiles/${sessionScope.user.customer_image}" alt="${sessionScope.user.customer_username}" />
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
                            <a href="<%= request.getContextPath() %>/userDashboard" class="dropdown_item">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
                                Dashboard
                            </a>
                            <a href="<%= request.getContextPath() %>/settings" class="dropdown_item">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                                My Profile
                            </a>
                            <a href="<%= request.getContextPath() %>/myBookings" class="dropdown_item">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
                                My Bookings
                            </a>
                            <a href="<%= request.getContextPath() %>/logout" class="dropdown_item danger">
                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
                                Log Out
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Guest User Logic -->
                    <a href="<%= request.getContextPath() %>/login" class="button button_outline">Login</a>
                    <a href="<%= request.getContextPath() %>/register" class="button">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
  </header>

  <!-- Main Content -->
  <main class="section_container">
    <div class="catalog_wrapper">

      <!-- LEFT: Filter Sidebar -->
      <aside class="filter_sidebar">
        <h3>Filter Options</h3>
        <form action="<%= request.getContextPath() %>/rentalDeals" method="GET">

          <div class="filter_group">
            <label for="searchParam">Search Model</label>
            <input type="text" id="searchParam" name="searchParam" placeholder="e.g. Alto, Toyota...">
          </div>

          <div class="filter_group">
            <label for="type">Vehicle Type</label>
            <select name="type" id="type">
              <option value="All">All Types</option>
              <option value="SUV">SUV</option>
              <option value="Sedan">Sedan</option>
              <option value="Hatchback">Hatchback</option>
            </select>
          </div>

          <div class="filter_group">
            <label for="color">Color</label>
            <select name="color" id="color">
              <option value="All">All Colors</option>
              <option value="Black">Black</option>
              <option value="Slate Grey">Slate Grey</option>
              <option value="White">White</option>
              <option value="Silver">Silver</option>
            </select>
          </div>

          <div class="filter_group">
            <label for="status">Availability</label>
            <select name="status" id="status">
              <option value="Available">Available Only</option>
              <option value="All">Show All</option>
            </select>
          </div>

          <div class="filter_btn_group">
            <button type="submit" class="button" style="width: 100%;">Apply Filters</button>
            <a href="<%= request.getContextPath() %>/rentalDeals" class="button button_outline" style="padding: 0.7rem; display: flex; align-items: center; justify-content: center;" title="Reset Filters">
              <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"></path><polyline points="3 3 3 8 8 8"></polyline></svg>
            </a>
          </div>
        </form>
      </aside>

      <!-- RIGHT: Vehicle Grid -->
      <div class="vehicle_content">
        <div class="vehicle_header">
          <div>
             <h1>Vehicle Catalog</h1>
             <p>Browse and filter our complete fleet.</p>
          </div>
        </div>

        <div class="vehicle_grid">

          <c:choose>
            <c:when test="${not empty vehicleList}">
              <c:forEach var="v" items="${vehicleList}">

                <!-- Main Card container with ID based on Database -->
                <div class="horizontal_card" id="vehicle-card-${v.vehicle_id}">
                  <!-- Image Area -->
                  <div class="hc_image_wrapper">
                    <!-- Dynamic Status Badge -->
                    <span class="hc_badge ${v.vehicle_status != 'Available' ? 'unavailable' : ''}">
                      ${v.vehicle_status}
                    </span>
                    <!-- Dynamic Image fetching from database -->
                    <img src="<%= request.getContextPath() %>/Assets/${v.vehicle_image}" alt="${v.vehicle_brand}" onerror="this.src='https://placehold.co/600x400/f1f5f9/94a3b8?text=Vehicle+Image'" />
                  </div>

                  <!-- Content Area -->
                  <div class="hc_content">

                    <!-- Floating Heart Button (No AJAX) -->
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <!-- Guest: Redirect to login immediately -->
                            <button class="fav_btn" onclick="window.location.href='<%= request.getContextPath() %>/login'" aria-label="Add to favorites">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                    <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                                </svg>
                            </button>
                        </c:when>
                        <c:otherwise>
                            <!-- Logged In: Standard HTML Form Post -->
                            <form action="<%= request.getContextPath() %>/toggleFavorite" method="POST" style="margin:0; padding:0; position:absolute; top:2rem; right:2rem;">
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
                      <div class="hc_price">NPR 4,500 <span>/ day</span></div>
                      <a href="<%= request.getContextPath() %>/viewVehicleDetails?id=${v.vehicle_id}" class="button" ${v.vehicle_status != 'Available' ? 'style="pointer-events: none; opacity: 0.6;"' : ''}>
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
                 <a href="<%= request.getContextPath() %>/rentalDeals" class="button" style="margin-top: 1rem;">View All Vehicles</a>
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
          <li><a href="<%= request.getContextPath() %>/">Home</a></li>
          <li><a href="<%= request.getContextPath() %>/about">About</a></li>
          <li>
            <a href="<%= request.getContextPath() %>/#deals">Rental Deals</a>
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/#choose">Why Choose Us</a>
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/#client">Testimonials</a>
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