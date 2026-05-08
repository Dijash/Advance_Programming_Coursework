<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.model.Customer" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RentAll - About Us</title>
  <style>
    @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap");

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: "Poppins", sans-serif;
      background-color: #ffffff;
      color: #1e293b;
      line-height: 1.6;
      overflow-x: hidden;
      scroll-behavior: smooth;
    }

    .icon { width: 1em; height: 1em; display: inline-block; vertical-align: middle; flex-shrink: 0; }

    .section_container {
      max-width: 1280px;
      margin: auto;
      padding: 4rem 2rem;
    }

    .section_header {
      font-size: 2.2rem;
      font-weight: 700;
      text-align: center;
      margin-bottom: 1rem;
      color: #0f172a;
    }

    .section_description {
      text-align: center;
      max-width: 650px;
      margin: 0 auto 3rem auto;
      color: #475569;
      font-size: 1rem;
      line-height: 1.7;
    }

    /* Standardized Buttons */
    .button {
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      background-color: #2563eb;
      color: white;
      padding: 0.7rem 1.5rem;
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
      transform: scale(1.02);
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
      max-width: 1280px;
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
       PAGE HEADER
    ======================================== */
    .page_header {
      background: linear-gradient(to bottom, #f8fafc, #ffffff);
      padding: 5rem 2rem;
      text-align: center;
      border-bottom: 1px solid #f1f5f9;
    }

    .page_header h1 {
      font-size: 2.8rem;
      font-weight: 800;
      color: #0f172a;
      margin-bottom: 0.8rem;
    }

    .page_header p {
      color: #64748b;
      max-width: 600px;
      margin: auto;
      font-size: 1.05rem;
    }

    /* ========================================
       OUR STORY
    ======================================== */
    .story_wrapper {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 4rem;
      align-items: center;
    }

    .story_content h2 {
      font-size: 2.2rem;
      font-weight: 700;
      color: #0f172a;
      margin-bottom: 1.5rem;
    }

    .story_content p {
      color: #475569;
      margin-bottom: 1rem;
      font-size: 1rem;
      line-height: 1.8;
    }

    .story_image {
      position: relative;
    }

    .story_image img {
      width: 100%;
      border-radius: 1.5rem;
      object-fit: cover;
      box-shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.1);
    }

    .story_stats {
      display: flex;
      gap: 2rem;
      margin-top: 2rem;
      padding-top: 2rem;
      border-top: 1px solid #e2e8f0;
    }

    .stat_item {
      display: flex;
      flex-direction: column;
    }

    .stat_item h4 {
      font-size: 2rem;
      font-weight: 800;
      color: #2563eb;
      line-height: 1;
    }

    .stat_item span {
      font-size: 0.85rem;
      color: #64748b;
      font-weight: 500;
      margin-top: 0.5rem;
      text-transform: uppercase;
      letter-spacing: 1px;
    }

    /* ========================================
       TEAM SECTION (5 MEMBERS)
    ======================================== */
    .team_section {
      background-color: #f8fafc;
      padding: 5rem 0;
    }

    .team_grid {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 2.5rem;
      max-width: 1100px;
      margin: 0 auto;
    }

    .team_card {
      background: white;
      padding: 2rem 1.5rem;
      border-radius: 1.5rem;
      text-align: center;
      width: calc(33.333% - 1.67rem);
      min-width: 260px;
      border: 1px solid #e2e8f0;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .team_card:hover {
      transform: translateY(-8px);
      box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05);
    }

    .team_avatar {
      width: 120px;
      height: 120px;
      border-radius: 50%;
      object-fit: cover;
      margin: 0 auto 1.5rem auto;
      border: 4px solid #eff6ff;
      background-color: #e2e8f0;
    }

    .team_card h4 {
      font-size: 1.2rem;
      font-weight: 700;
      color: #0f172a;
      margin-bottom: 0.2rem;
    }

    .team_role {
      font-size: 0.9rem;
      color: #2563eb;
      font-weight: 500;
      margin-bottom: 1rem;
      display: block;
    }

    .team_card p {
      font-size: 0.85rem;
      color: #64748b;
      margin-bottom: 1.5rem;
      line-height: 1.6;
    }

    .team_socials {
      display: flex;
      justify-content: center;
      gap: 0.8rem;
    }

    .team_socials a {
      width: 34px;
      height: 34px;
      border-radius: 50%;
      background: #f1f5f9;
      color: #475569;
      display: flex;
      align-items: center;
      justify-content: center;
      text-decoration: none;
      transition: all 0.2s ease;
    }

    .team_socials a:hover {
      background: #2563eb;
      color: white;
    }

    .team_socials svg {
      width: 16px;
      height: 16px;
    }

    /* ========================================
       FOOTER
    ======================================== */
    .footer {
      background: #0f172a;
      color: #cbd5e1;
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

    /* Responsive */
    @media (max-width: 1048px) {
      .nav_links {
          display: none;
          width: 100%;
          flex-direction: column;
          align-items: center;
          padding: 1rem 0;
          gap: 1rem;
          order: 3;
      }
      .nav_links.active { display: flex; }
      .nav_buttons { display: none; }
      .nav_menu_button { display: block; }
      nav { flex-wrap: wrap; }
    }

    @media (max-width: 900px) {
      .story_wrapper {
        grid-template-columns: 1fr;
        gap: 3rem;
      }
      .team_card {
        width: calc(50% - 1.25rem);
      }
    }

    @media (max-width: 600px) {
      .team_card {
        width: 100%;
      }
      .story_stats {
        flex-direction: column;
        gap: 1.5rem;
      }
    }
  </style>
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
            <li><a href="${pageContext.request.contextPath}/about" class="active">About</a></li>
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
                    <a href="${pageContext.request.contextPath}/login" class="button button_outline">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="button">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
  </header>

  <section class="page_header">
    <h1>About RentAll</h1>
    <p>
      Discover our story, our mission, and the passionate team dedicated to making your journey unforgettable.
    </p>
  </section>

  <section class="section_container">
    <div class="story_wrapper">
      <div class="story_content">
        <h2>Driven by a Passion for Seamless Travel</h2>
        <p>
          Founded in Kathmandu, RentAll started with a simple vision: to eliminate the hassle from car rentals. We realized that exploring our beautiful country, or just getting around the city, shouldn't involve complex paperwork or hidden fees.
        </p>
        <p>
          Today, we pride ourselves on offering a modern, diverse fleet of vehicles paired with top-tier customer service. Whether you're navigating the bustling streets of Thamel or heading out for a rugged mountain adventure, we ensure you have the perfect ride.
        </p>

        <div class="story_stats">
          <div class="stat_item">
            <h4>${not empty totalVehicles ? totalVehicles : '0'}+</h4>
            <span>Vehicles Available</span>
          </div>
          <div class="stat_item">
            <h4>24/7</h4>
            <span>Customer Support</span>
          </div>
          <div class="stat_item">
            <h4>${not empty totalCustomers ? totalCustomers : '0'}+</h4>
            <span>Happy Clients</span>
          </div>
        </div>
      </div>
      <div class="story_image">
        <img src="https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?auto=format&fit=crop&q=80&w=800&h=600" alt="RentAll Fleet" />
      </div>
    </div>
  </section>

  <section class="team_section">
    <div class="section_container" style="padding-top: 0; padding-bottom: 0;">
      <h2 class="section_header">Meet Our Team</h2>
      <p class="section_description">
        We are a group of dedicated students bringing our skills in development, design, and management together to build RentAll.
      </p>

      <div class="team_grid">
        <div class="team_card">
          <img src="${pageContext.request.contextPath}/Assets/Team/team-1.jpeg" alt="Member 1" class="team_avatar" />
          <h4>Aarav Bhattarai</h4>
          <span class="team_role">Project Lead</span>
          <p>Passionate about backend architecture and ensuring seamless integrations across the application.</p>
          <div class="team_socials">
            <a href="https://github.com/Dijash"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg></a>
            <a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path><rect x="2" y="9" width="4" height="12"></rect><circle cx="4" cy="4" r="2"></circle></svg></a>
          </div>
        </div>

        <div class="team_card">
          <img src="https://placehold.co/150x150/eff6ff/2563eb?text=M2" alt="Member 2" class="team_avatar" />
          <h4>Yubraj Sah</h4>
          <span class="team_role">Full Stack</span>
          <p>Focused on creating intuitive user interfaces and ensuring a responsive experience on all devices.</p>
          <div class="team_socials">
            <a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg></a>
            <a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path><rect x="2" y="9" width="4" height="12"></rect><circle cx="4" cy="4" r="2"></circle></svg></a>
          </div>
        </div>

        <div class="team_card">
          <img src="${pageContext.request.contextPath}/Assets/Team/team-3.jpg" alt="Member 3" class="team_avatar" />
          <h4>Rojal Shrestha</h4>
          <span class="team_role">Database Administrator</span>
          <p>Handles the intricate details of our database design, queries, and keeping our data secure.</p>
          <div class="team_socials">
            <a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg></a>
            <a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path><rect x="2" y="9" width="4" height="12"></rect><circle cx="4" cy="4" r="2"></circle></svg></a>
          </div>
        </div>

        <div class="team_card">
          <img src="${pageContext.request.contextPath}/Assets/Team/team-4.jpg" alt="Member 4" class="team_avatar" />
          <h4>Rehan Basnet</h4>
          <span class="team_role">QA Engineer</span>
          <p>Dedicated to testing every feature and ensuring the platform is bug-free before launch.</p>
          <div class="team_socials">
            <a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg></a>
            <a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path><rect x="2" y="9" width="4" height="12"></rect><circle cx="4" cy="4" r="2"></circle></svg></a>
          </div>
        </div>

        <div class="team_card">
          <img src="https://placehold.co/150x150/eff6ff/2563eb?text=M5" alt="Member 5" class="team_avatar" />
          <h4>Kushal Khanal</h4>
          <span class="team_role">UI/UX Designer</span>
          <p>Bringing creativity to the table to ensure RentAll is both beautiful and easy to use.</p>
          <div class="team_socials">
            <a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg></a>
            <a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path><rect x="2" y="9" width="4" height="12"></rect><circle cx="4" cy="4" r="2"></circle></svg></a>
          </div>
        </div>

      </div>
    </div>
  </section>

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
          <li><a href="${pageContext.request.contextPath}/#deals">Rental Deals</a></li>
          <li><a href="${pageContext.request.contextPath}/#choose">Why Choose Us</a></li>
          <li><a href="${pageContext.request.contextPath}/client">Testimonials</a></li>
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
what java servlet code do i need for this in order to show the totalVehicle count and Customer count in here