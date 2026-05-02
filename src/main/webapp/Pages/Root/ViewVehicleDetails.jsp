<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.model.Customer" %>
<%@ page isELIgnored="false" %>
<%
    Customer loggedInUser = (Customer) session.getAttribute("user");
    String username = (loggedInUser != null) ? loggedInUser.getCustomer_username() : "User";
    String email    = (loggedInUser != null) ? loggedInUser.getCustomer_email()    : "";

    String fName = (loggedInUser != null && loggedInUser.getFirst_name() != null) ? loggedInUser.getFirst_name() : "User";
    String lName = (loggedInUser != null && loggedInUser.getLast_name() != null) ? loggedInUser.getLast_name() : "";
    String fullName = fName + " " + lName;

    String profileImage = (loggedInUser != null && loggedInUser.getCustomer_image() != null && !loggedInUser.getCustomer_image().trim().isEmpty())
                          ? loggedInUser.getCustomer_image().trim()
                          : null;
%>
<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll — ${vehicle.vehicle_brand} ${vehicle.vehicle_type}</title>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@300;400;500;600;700;800&display=swap");

        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --bg: #f8fafc;
            --text-main: #0f172a;
            --text-muted: #475569;
            --border: #e2e8f0;
            --white: #ffffff;
            --success: #10b981;
            --danger: #ef4444;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--white);
            color: var(--text-main);
            line-height: 1.6;
            overflow-x: hidden;
            scroll-behavior: smooth;
        }

        .icon { width: 1em; height: 1em; display: inline-block; vertical-align: middle; flex-shrink: 0; }

        /* --- Global & Buttons --- */
        .button {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background-color: var(--primary);
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
        }

        .button:hover {
            background-color: var(--primary-dark);
            transform: scale(1.02);
        }

        .button_outline {
            background-color: transparent;
            color: var(--primary);
            border: 2px solid var(--primary);
        }

        .button_outline:hover {
            background-color: var(--primary);
            color: white;
        }

        /* --- Header & Nav --- */
        header {
            background: var(--white);
            border-bottom: 1px solid var(--border);
            position: sticky;
            top: 0;
            z-index: 100;
        }

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

        .nav_links a:hover { color: var(--primary); }

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
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
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
            color: var(--text-main);
        }

        .user_dropdown {
            display: none;
            position: absolute;
            top: calc(100% + 10px);
            right: 0;
            min-width: 220px;
            background: var(--white);
            border: 1px solid var(--border);
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
            border-bottom: 1px solid var(--bg);
            background: var(--bg);
        }
        .dropdown_header p {
            font-weight: 600;
            font-size: 0.9rem;
            margin: 0 0 2px;
            color: var(--text-main);
        }
        .dropdown_header span {
            font-size: 0.78rem;
            color: var(--text-muted);
        }
        .dropdown_item {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            padding: 0.7rem 1rem;
            font-size: 0.88rem;
            color: var(--text-main);
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
            background: var(--bg);
            color: var(--primary);
        }
        .dropdown_item.danger {
            color: var(--danger);
        }
        .dropdown_item.danger:hover {
            background: #fff1f1;
            color: #b91c1c;
        }

        /* --- Main Layout --- */
        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 2rem;
            background: var(--bg);
        }

        .layout {
            display: grid;
            grid-template-columns: 1.6fr 1fr;
            gap: 2.5rem;
            margin-top: 1.5rem;
        }

        /* --- Left Side: Vehicle Details --- */
        .image_card {
            background: var(--white);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.03);
            border: 1px solid var(--border);
        }

        .image_container {
            position: relative;
            aspect-ratio: 16 / 9;
            background: #f1f5f9;
        }

        .image_container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .status_badge {
            position: absolute;
            top: 1.5rem;
            left: 1.5rem;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--white);
            background: var(--success);
        }

        .status_badge.unavailable { background: var(--danger); }

        .content_padding { padding: 2.5rem; }

        .brand_tag {
            color: var(--primary);
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 0.5rem;
            display: block;
        }

        .title {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 2rem;
            color: var(--text-main);
            line-height: 1.2;
        }

        .specs_list {
            display: flex;
            flex-direction: column;
            margin-bottom: 2.5rem;
            border-top: 1px solid var(--border);
        }

        .spec_row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.2rem 0;
            border-bottom: 1px solid var(--border);
        }

        .spec_label {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            color: var(--text-muted);
            font-size: 0.95rem;
            font-weight: 500;
        }

        .spec_label svg {
            width: 20px;
            height: 20px;
            color: var(--primary);
        }

        .spec_value {
            font-weight: 600;
            color: var(--text-main);
            font-size: 1rem;
        }

        .features_list {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.2rem;
        }

        .feature_item {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .feature_item svg {
            width: 20px;
            height: 20px;
            color: var(--success);
        }

        /* --- Right Side: Booking Card --- */
        .booking_card {
            background: var(--white);
            border-radius: 20px;
            padding: 2.5rem;
            border: 1px solid var(--border);
            box-shadow: 0 10px 30px rgba(0,0,0,0.04);
            position: sticky;
            top: 100px;
        }

        .price_display {
            display: flex;
            align-items: baseline;
            gap: 0.5rem;
            margin-bottom: 2rem;
        }

        .price_display h2 { font-size: 2rem; font-weight: 800; color: #0f172a; }
        .price_display span { color: #64748b; font-size: 0.9rem; font-weight: 500;}

        .form_label {
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            display: block;
            color: var(--text-muted);
        }

        .input_field {
            width: 100%;
            padding: 0.8rem 1rem;
            border-radius: 10px;
            border: 1px solid var(--border);
            background: var(--bg);
            margin-bottom: 1.2rem;
            transition: all 0.2s;
            font-family: 'Poppins', sans-serif;
        }

        .input_field:focus {
            outline: none;
            border-color: var(--primary);
            background: var(--white);
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
        }

        .summary_box {
            background: var(--bg);
            padding: 1.5rem;
            border-radius: 15px;
            margin: 2rem 0;
        }

        .summary_row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .total_row {
            display: flex;
            justify-content: space-between;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px dashed var(--border);
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--primary);
        }

        .book_btn {
            width: 100%;
            background: var(--primary);
            color: var(--white);
            padding: 1rem;
            border-radius: 90px;
            font-weight: 700;
            border: none;
            cursor: pointer;
            transition: background 0.2s;
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
        }

        .book_btn:hover { background: var(--primary-dark); }
        .book_btn:disabled { background: #94a3b8; cursor: not-allowed; }

        /* --- Footer Styles --- */
        .footer {
            background: #0f172a;
            color: #cbd5e1;
        }

        .section_container {
            max-width: 1280px;
            margin: auto;
            padding: 4rem 2rem;
        }

        .footer_container {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
            justify-content: space-between;
            padding: 4rem 2rem 2rem;
        }

        .footer_col { flex: 1; min-width: 180px; }

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

        .footer_col > p {
            font-size: 0.88rem;
            line-height: 1.7;
            color: #94a3b8;
            margin-bottom: 1.2rem;
        }

        .footer_socials { display: flex; gap: 0.8rem; margin-top: 0.5rem; }
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
        .footer_socials a:hover { background: var(--primary); color: white; }
        .footer_socials a svg { width: 18px; height: 18px; }

        .footer_col h4 {
            font-size: 0.95rem;
            font-weight: 600;
            color: white;
            margin-bottom: 1rem;
        }

        .footer_links { list-style: none; }
        .footer_links li { margin-bottom: 0.6rem; }
        .footer_links a {
            text-decoration: none;
            color: #94a3b8;
            font-size: 0.88rem;
            transition: color 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        .footer_links a:hover { color: white; }
        .footer_links a svg { width: 15px; height: 15px; flex-shrink: 0; }

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
            .layout { grid-template-columns: 1fr; }
            .booking_card { position: relative; top: 0; }
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
                <% if (loggedInUser != null) { %>
                    <div class="user_avatar_wrap" id="userAvatarWrap">
                        <div class="user_avatar">
                            <% if (profileImage != null) { %>
                                <img src="<%= request.getContextPath() %>/Assets/Profiles/<%= profileImage %>" alt="<%= username %>" />
                            <% } else { %>
                                <%= String.valueOf(fName.charAt(0)).toUpperCase() %>
                            <% } %>
                        </div>
                        <span class="user_name_nav"><%= username %></span>
                        <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#64748b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width: 16px; height: 16px;"><polyline points="6 9 12 15 18 9"/></svg>

                        <div class="user_dropdown" id="userDropdown">
                            <div class="dropdown_header">
                                <p><%= fullName %></p>
                                <span><%= email %></span>
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
                <% } else { %>
                    <a href="<%= request.getContextPath() %>/login" class="button button_outline">Login</a>
                    <a href="<%= request.getContextPath() %>/register" class="button">Register</a>
                <% } %>
            </div>
        </nav>
    </header>

    <div style="background: var(--bg);">
        <main class="container">
            <div style="margin-bottom: 2rem; color: #64748b; font-size: 0.9rem; font-weight: 500;">
                <a href="<%= request.getContextPath() %>/rentalDeals" style="color: #2563eb; text-decoration: none;">Fleet & Deals</a>
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
                                <img src="<%= request.getContextPath() %>/Assets/${vehicle.vehicle_image}" alt="Car View" />
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

                            <form action="<%= request.getContextPath() %>/submitBooking" method="POST">
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
                    <li><a href="<%= request.getContextPath() %>/">Home</a></li>
                    <li><a href="<%= request.getContextPath() %>/about">About</a></li>
                    <li><a href="<%= request.getContextPath() %>/rentalDeals">Rental Deals</a></li>
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