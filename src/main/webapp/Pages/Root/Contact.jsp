<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.model.Customer" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RentAll - Contact Us</title>
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
       CONTACT SECTION
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

    .contact_wrapper {
      display: grid;
      grid-template-columns: 1fr 1.3fr;
      gap: 4rem;
      max-width: 1150px;
      margin: 5rem auto;
      padding: 0 2rem;
    }

    /* Left Side: Info */
    .contact_info {
      display: flex;
      flex-direction: column;
      gap: 1.5rem;
    }

    .contact_card {
      display: flex;
      align-items: flex-start;
      gap: 1.2rem;
      background: #ffffff;
      padding: 1.5rem;
      border-radius: 1rem;
      border: 1px solid #e2e8f0;
      transition: transform 0.2s, box-shadow 0.2s;
    }

    .contact_card:hover {
      transform: translateY(-4px);
      box-shadow: 0 12px 28px rgba(0, 0, 0, 0.07);
    }

    .contact_icon {
      width: 50px;
      height: 50px;
      background: #eff6ff;
      color: #2563eb;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
      flex-shrink: 0;
    }

    .contact_card h4 {
      font-size: 1.1rem;
      font-weight: 600;
      color: #0f172a;
      margin-bottom: 0.3rem;
    }

    .contact_card p {
      color: #64748b;
      font-size: 0.95rem;
      line-height: 1.5;
    }

    /* Right Side: Form */
    .contact_form_container {
      background: white;
      padding: 3rem;
      border-radius: 1.5rem;
      box-shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.08);
      border: 1px solid #e2e8f0;
    }

    .contact_form_container h3 {
      font-size: 1.8rem;
      font-weight: 700;
      color: #0f172a;
      margin-bottom: 2rem;
    }

    .form_group {
      margin-bottom: 1.5rem;
    }

    .form_group label {
      display: block;
      font-size: 0.88rem;
      font-weight: 600;
      color: #475569;
      margin-bottom: 0.5rem;
    }

    .form_group input,
    .form_group textarea {
      width: 100%;
      padding: 0.9rem 1.2rem;
      border: 1.5px solid #e2e8f0;
      border-radius: 10px;
      font-size: 0.95rem;
      font-family: "Poppins", sans-serif;
      background-color: #f8fafc;
      color: #1e293b;
      outline: none;
      transition: border-color 0.2s, background-color 0.2s;
    }

    .form_group input:focus,
    .form_group textarea:focus {
      border-color: #2563eb;
      background-color: white;
    }

    .form_row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1.5rem;
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
      .contact_wrapper {
        grid-template-columns: 1fr;
        gap: 4rem;
      }
    }

    @media (max-width: 768px) {
      .page_header h1 {
        font-size: 2.2rem;
      }
    }

    @media (max-width: 500px) {
      .form_row {
        grid-template-columns: 1fr;
        gap: 1rem;
      }
      .contact_form_container {
        padding: 2rem 1.5rem;
      }
      .contact_card {
        padding: 1.2rem;
      }
    }
  </style>
</head>

<body>
  <header>
    <nav>
        <div class="nav_header">
            <div class="nav_logo">
                <a href="<%= request.getContextPath() %>/home" class="logo"><span>RentAll</span></a>
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

  <section class="page_header">
    <h1>Get in Touch</h1>
    <p>
      Have questions about renting a car? Need help with your booking? Our
      team is ready to assist you.
    </p>
  </section>

  <section class="contact_wrapper">
    <div class="contact_info">
      <div class="contact_card">
        <div class="contact_icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="1em" height="1em" fill="currentColor">
            <path d="M12 20.8995L16.9497 15.9497C19.6834 13.2161 19.6834 8.78392 16.9497 6.05025C14.2161 3.31658 9.78392 3.31658 7.05025 6.05025C4.31658 8.78392 4.31658 13.2161 7.05025 15.9497L12 20.8995ZM12 23.7279L5.63604 17.364C2.12132 13.8492 2.12132 8.15076 5.63604 4.63604C9.15076 1.12132 14.8492 1.12132 18.364 4.63604C21.8787 8.15076 21.8787 13.8492 18.364 17.364ZM12 13C13.1046 13 14 12.1046 14 11C14 9.89543 13.1046 9 12 9C10.8954 9 10 9.89543 10 11C10 12.1046 10.8954 13 12 13ZM12 15C9.79086 15 8 13.2091 8 11C8 8.79086 9.79086 7 12 7C14.2091 7 16 8.79086 16 11C16 13.2091 14.2091 15 12 15Z"></path>
          </svg>
        </div>
        <div>
          <h4>Our Location</h4>
          <p>123 Thamel Street<br />Kathmandu, Bagmati Province, Nepal</p>
        </div>
      </div>

      <div class="contact_card">
        <div class="contact_icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="1em" height="1em" fill="currentColor">
            <path d="M9.36556 10.6829C10.3023 12.3303 11.6696 13.6976 13.3169 14.6343L14.207 13.3882C14.4754 13.0125 14.9669 12.8617 15.4116 13.0189L19.5392 14.4789C20.0888 14.6734 20.4578 15.1955 20.4542 15.7797C20.4191 21.4392 15.6888 21.9961 12 22C6.18206 22.0068 2 17.8184 2 12C2.00392 8.31135 2.56073 3.58087 8.22026 3.54578C8.80436 3.54226 9.32653 3.91118 9.52103 4.46081L10.981 8.58828C11.1382 9.03303 10.9874 9.52453 10.6117 9.79289L9.36556 10.6829ZM7.44755 11.9686L9.12328 10.795L8.03716 7.72464C5.00624 8.21208 4.02062 10.8874 4 12C3.98592 16.7138 7.28616 20.014 12 20C13.1124 19.9793 15.7876 18.9937 16.2752 15.9627L13.2048 14.8766L12.0312 16.5524C11.6884 17.0321 11.0258 17.1594 10.5199 16.8524C8.44199 15.5907 6.40916 13.5579 5.1475 11.48C4.84047 10.9741 4.96783 10.3114 5.44755 9.96864V11.9686Z"></path>
          </svg>
        </div>
        <div>
          <h4>Phone Number</h4>
          <p>+977 9818162494<br />+977 1-4234567</p>
        </div>
      </div>

      <div class="contact_card">
        <div class="contact_icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="1em" height="1em" fill="currentColor">
            <path d="M21 3C21.5523 3 22 3.44772 22 4V20.0066C22 20.5552 21.5447 21 21.0082 21H2.9918C2.44405 21 2 20.5551 2 20.0066V19H20V7.3L12 14.5L2 5.5V4C2 3.44772 2.44772 3 3 3H21ZM8 15V17H0V15H8ZM5 10V12H0V10H5ZM19.5659 5H4.43414L12 11.8093L19.5659 5Z"></path>
          </svg>
        </div>
        <div>
          <h4>Email Address</h4>
          <p>support@rentall.com<br />info@rentall.com</p>
        </div>
      </div>

      <div class="contact_card">
        <div class="contact_icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="1em" height="1em" fill="currentColor">
            <path d="M12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12C22 17.5228 17.5228 22 12 22ZM12 20C16.4183 20 20 16.4183 20 12C20 7.58172 16.4183 4 12 4C7.58172 4 4 7.58172 4 12C4 16.4183 7.58172 20 12 20ZM13 12H17V14H11V7H13V12Z"></path>
          </svg>
        </div>
        <div>
          <h4>Working Hours</h4>
          <p>Sunday - Friday: 8:00 AM - 8:00 PM<br />Saturday: Closed</p>
        </div>
      </div>
    </div>

    <div class="contact_form_container">
      <h3>Send us a Message</h3>
      <form action="<%= request.getContextPath() %>/submitContact" method="POST">
        <div class="form_row">
          <div class="form_group">
            <label for="firstName">First Name</label>
            <input type="text" id="firstName" name="firstName" placeholder="John" required />
          </div>
          <div class="form_group">
            <label for="lastName">Last Name</label>
            <input type="text" id="lastName" name="lastName" placeholder="Doe" required />
          </div>
        </div>

        <div class="form_group">
          <label for="email">Email Address</label>
          <input type="email" id="email" name="email" placeholder="john@example.com" required />
        </div>

        <div class="form_group">
          <label for="subject">Subject</label>
          <input type="text" id="subject" name="subject" placeholder="How can we help you?" required />
        </div>

        <div class="form_group">
          <label for="message">Message</label>
          <textarea id="message" name="message" rows="5" placeholder="Write your message here..." required></textarea>
        </div>

        <button type="submit" class="button" style="width: 100%">
          Send Message
        </button>
      </form>
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
          <li><a href="<%= request.getContextPath() %>/#about">About</a></li>
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