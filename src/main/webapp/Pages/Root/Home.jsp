<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/HomeStyle.css">
    <title>RentAll - Car Rental</title>
  </head>
  <body>

    <header>
      <nav>
        <div class="nav_header">
          <div class="nav_logo">
            <a href="<%= request.getContextPath() %>/home" class="logo"><span>RentAll</span></a>
          </div>
          <button class="nav_menu_button" aria-label="Toggle menu">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="28" height="28"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
          </button>
        </div>
        <ul class="nav_links" id="nav-links">
          <li><a href="#about">Services</a></li>
          <li><a href="#deals">Rental Deals</a></li>
          <li><a href="#choose">About</a></li>
          <li><a href="<%= request.getContextPath() %>/contact">Contact Us</a></li>
        </ul>

        <div class="nav_buttons">
          <div class="user_avatar_wrap" id="userAvatarWrap">
            <div class="user_avatar">
              <c:if test="${not empty sessionScope.user.customer_image}">
                <img src="<%= request.getContextPath() %>/Assets/Profiles/${sessionScope.user.customer_image}" alt="${sessionScope.user.customer_username}" />
              </c:if>
            </div>
            <span class="user_name_nav">${not empty sessionScope.user.customer_username ? sessionScope.user.customer_username : 'User'}</span>
            <%-- Chevron down --%>
            <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#64748b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"/></svg>

            <div class="user_dropdown" id="userDropdown">
              <div class="dropdown_header">
                <p>${sessionScope.user.first_name} ${sessionScope.user.last_name}</p>
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
        </div>
      </nav>

      <div class="header_container" id="home">
        <div class="header_image">
          <img src="<%= request.getContextPath() %>/Assets/header.png" alt="Luxury car rental" />
        </div>
        <div class="header_content">
          <h1>Fast and Easy Way to Rent a Car</h1>
          <p class="section_description">
            Discover a seamless car rental experience with us. Choose from a
            range of premium vehicles to suit your style and needs, and hit the
            road with confidence. Quick, easy, and reliable — rent your ride today!
          </p>
        </div>
      </div>
    </header>


    <section class="header_form">
      <form action="<%= request.getContextPath() %>/home">
        <div class="input_group">
          <label for="location">
            <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
            Pick up &amp; Return location
          </label>
          <div class="input_icon">
            <select id="location" name="location">
              <option value="">Select a location</option>
              <option value="Kathmandu">Kathmandu</option>
              <option value="Lalitpur">Lalitpur</option>
              <option value="Bhaktapur">Bhaktapur</option>
              <option value="Pokhara">Pokhara</option>
              <option value="Chitwan">Chitwan</option>
            </select>
            <span class="input_arrow">
              <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"/></svg>
            </span>
          </div>
        </div>

        <div class="input_group date-group">
          <label for="start">
            <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
            Pick up date
          </label>
          <div class="input_icon">
            <input type="date" id="start" name="startDate" />
          </div>
        </div>

        <div class="input_group date-group">
          <label for="stop">
            <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
            Return date
          </label>
          <div class="input_icon">
            <input type="date" id="stop" name="endDate" />
          </div>
        </div>

        <button type="submit" class="button button_search">
          <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
          Search
        </button>
      </form>
    </section>
    <section class="section_container about_container" id="about">
      <h2 class="section_header">How it works</h2>
      <p class="section_description">
        Renting a car with us is simple! Choose your vehicle, pick your dates,
        and complete your booking. We'll handle the rest, ensuring a smooth
        start to your journey.
      </p>
      <div class="about_grid">
        <div class="about_card">
          <div class="about_icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
          </div>
          <h4>Choose Location</h4>
          <p>Select from a variety of pick-up locations that best suit your needs.</p>
        </div>
        <div class="about_card">
          <div class="about_icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/><polyline points="9 16 11 18 15 14"/></svg>
          </div>
          <h4>Pick-up Date</h4>
          <p>Choose the exact date and time for your car pick-up.</p>
        </div>
        <div class="about_card">
          <div class="about_icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 17H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h1l2-4h10l2 4h1a2 2 0 0 1 2 2v6a2 2 0 0 1-2 2h-2"/><circle cx="7.5" cy="17" r="2.5"/><circle cx="16.5" cy="17" r="2.5"/></svg>
          </div>
          <h4>Book your Car</h4>
          <p>Complete your booking with just a few clicks.</p>
        </div>
      </div>
    </section>

    <section class="deals" id="deals">
      <div class="section_container deals_container">
        <h2 class="section_header">Most popular car rental deals</h2>
        <p class="section_description">
          Explore our top car rental deals, handpicked to give you the best value.
        </p>

        <div class="deals_tabs_wrapper">
          <input type="radio" name="deal" id="tab-corolla" hidden checked />
          <input type="radio" name="deal" id="tab-noah" hidden />
          <input type="radio" name="deal" id="tab-pajero" hidden />
          <input type="radio" name="deal" id="tab-swift" hidden />

          <div class="deals_tabs">
            <label for="tab-corolla" class="deals_tab">
              <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 17H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h1l2-4h10l2 4h1a2 2 0 0 1 2 2v6a2 2 0 0 1-2 2h-2"/><circle cx="7.5" cy="17" r="2.5"/><circle cx="16.5" cy="17" r="2.5"/></svg>
              Toyota Corolla
            </label>
            <label for="tab-noah" class="deals_tab">
              <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="1" y="3" width="15" height="13" rx="2"/><path d="M16 8h4l3 5v3h-7V8z"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg>
              Toyota Noah
            </label>
            <label for="tab-pajero" class="deals_tab">
              <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 3h15v13H1z"/><path d="M16 8h4l3 3v5h-7V8z"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg>
              Mitsubishi Pajero
            </label>
            <label for="tab-swift" class="deals_tab">
              <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M7 17H3a2 2 0 0 1-2-2v-4l3-6h12l3 6v4a2 2 0 0 1-2 2h-2"/><circle cx="7" cy="17" r="2"/><circle cx="17" cy="17" r="2"/><path d="M5 9h14"/></svg>
              Suzuki Swift
            </label>
          </div>

          <div class="deal_panel" id="panel-corolla">
            <div class="deal_image">
              <img src="<%= request.getContextPath() %>/Assets/range-1.jpg" alt="Toyota Corolla" />
            </div>
            <div class="deal_info">
              <h3>Toyota Corolla</h3>
              <p class="deal_tagline">Comfortable sedan — ideal for city &amp; highway</p>
              <div class="deal_specs">
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg><span>5</span><small>Seats</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14"/><path d="M4.93 4.93a10 10 0 0 0 0 14.14"/></svg><span>Auto</span><small>Transmission</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 22V8l9-6 9 6v14"/><path d="M9 22v-6h6v6"/></svg><span>Petrol</span><small>Fuel</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M12 2a10 10 0 0 1 10 10c0 4-2.5 7.4-6 9"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10"/></svg><span>AC</span><small>Climate</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2"/></svg><span>4 Doors</span><small>Body</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg><span>2022</span><small>Year</small></div>
              </div>
              <div class="deal_price_row">
                <div class="deal_price">NPR 4,500 <small>/ day</small></div>
                <a href="<%= request.getContextPath() %>/user?section=bookings" class="button">Book Now <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></a>
              </div>
            </div>
          </div>

          <div class="deal_panel" id="panel-noah">
            <div class="deal_image">
              <img src="<%= request.getContextPath() %>/Assets/range-2.jpg" alt="Toyota Noah" />
            </div>
            <div class="deal_info">
              <h3>Toyota Noah</h3>
              <p class="deal_tagline">Spacious MPV — perfect for families &amp; groups</p>
              <div class="deal_specs">
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg><span>8</span><small>Seats</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14"/><path d="M4.93 4.93a10 10 0 0 0 0 14.14"/></svg><span>Auto</span><small>Transmission</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M3 22V8l9-6 9 6v14"/><path d="M9 22v-6h6v6"/></svg><span>Petrol</span><small>Fuel</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M12 2a10 10 0 0 1 10 10c0 4-2.5 7.4-6 9"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10"/></svg><span>Dual AC</span><small>Climate</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2"/></svg><span>Sliding</span><small>Door</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg><span>2021</span><small>Year</small></div>
              </div>
              <div class="deal_price_row">
                <div class="deal_price">NPR 7,000 <small>/ day</small></div>
                <a href="<%= request.getContextPath() %>/user?section=bookings" class="button">Book Now <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></a>
              </div>
            </div>
          </div>

          <div class="deal_panel" id="panel-pajero">
            <div class="deal_image">
              <img src="<%= request.getContextPath() %>/Assets/range-3.jpg" alt="Mitsubishi Pajero" />
            </div>
            <div class="deal_info">
              <h3>Mitsubishi Pajero</h3>
              <p class="deal_tagline">Rugged 4WD SUV — built for mountain terrain</p>
              <div class="deal_specs">
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg><span>7</span><small>Seats</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14"/><path d="M4.93 4.93a10 10 0 0 0 0 14.14"/></svg><span>Manual</span><small>Transmission</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M3 22V8l9-6 9 6v14"/><path d="M9 22v-6h6v6"/></svg><span>Diesel</span><small>Fuel</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><circle cx="5" cy="17" r="3"/><circle cx="19" cy="17" r="3"/><path d="M5 14V9l7-5 7 5v5"/></svg><span>4WD</span><small>Drive</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2"/></svg><span>SUV</span><small>Body</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg><span>2020</span><small>Year</small></div>
              </div>
              <div class="deal_price_row">
                <div class="deal_price">NPR 9,500 <small>/ day</small></div>
                <a href="<%= request.getContextPath() %>/user?section=bookings" class="button">Book Now <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></a>
              </div>
            </div>
          </div>


          <div class="deal_panel" id="panel-swift">
            <div class="deal_image">
              <img src="<%= request.getContextPath() %>/Assets/range-4.jpg" alt="Suzuki Swift" />
            </div>
            <div class="deal_info">
              <h3>Suzuki Swift</h3>
              <p class="deal_tagline">Compact hatchback — nimble &amp; fuel efficient</p>
              <div class="deal_specs">
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg><span>5</span><small>Seats</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14"/><path d="M4.93 4.93a10 10 0 0 0 0 14.14"/></svg><span>Manual</span><small>Transmission</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M3 22V8l9-6 9 6v14"/><path d="M9 22v-6h6v6"/></svg><span>Petrol</span><small>Fuel</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M12 2a10 10 0 0 1 10 10c0 4-2.5 7.4-6 9"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10"/></svg><span>AC</span><small>Climate</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2"/></svg><span>Hatchback</span><small>Body</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg><span>2023</span><small>Year</small></div>
              </div>
              <div class="deal_price_row">
                <div class="deal_price">NPR 3,500 <small>/ day</small></div>
                <a href="<%= request.getContextPath() %>/user?section=bookings" class="button">Book Now <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></a>
              </div>
            </div>
          </div>

        </div>
      </div>
    </section>


    <section class="choose_container" id="choose">
      <div class="choose_image">
        <img src="<%= request.getContextPath() %>/Assets/why choosed us.jpeg" alt="Happy customer with car" />
      </div>
      <div class="choose_content">
        <h2 class="section_header">Why choose us</h2>
        <p class="section_description">
          Discover the difference with our car rental service. We offer reliable
          vehicles, exceptional customer service, and competitive pricing.
        </p>
        <div class="choose_grid">
          <div class="choose_card">
            <span><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 18v-6a9 9 0 0 1 18 0v6"/><path d="M21 19a2 2 0 0 1-2 2h-1a2 2 0 0 1-2-2v-3a2 2 0 0 1 2-2h3z"/><path d="M3 19a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-3a2 2 0 0 0-2-2H3z"/></svg></span>
            <div><h4>Customer Support</h4><p>Our dedicated support team is available to assist you 24/7.</p></div>
          </div>
          <div class="choose_card">
            <span><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg></span>
            <div><h4>Many Locations</h4><p>Convenient pick-up and drop-off locations to suit your travel needs.</p></div>
          </div>
          <div class="choose_card">
            <span><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="5" width="20" height="14" rx="2"/><line x1="2" y1="10" x2="22" y2="10"/><circle cx="17" cy="15" r="1" fill="#2563eb"/></svg></span>
            <div><h4>Best Price</h4><p>Enjoy competitive rates and great value for every rental.</p></div>
          </div>
          <div class="choose_card">
            <span><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/><line x1="10" y1="15" x2="14" y2="19"/><line x1="14" y1="15" x2="10" y2="19"/></svg></span>
            <div><h4>Free Cancellations</h4><p>Flexible bookings with free cancellation options.</p></div>
          </div>
        </div>
      </div>
    </section>

    <section class="subscribe_container">
      <div class="subscribe_image">
        <img src="<%= request.getContextPath() %>/Assets/ford-raptor-r-concept-1.jpg" alt="Newsletter car" />
      </div>
      <div class="subscribe_content">
        <h2 class="section_header">Subscribe for the latest car rental updates</h2>
        <p class="section_description">
          Stay in the know! Subscribe to receive the latest car rental deals,
          exclusive offers, and updates right to your inbox.
        </p>
        <div class="subscribe_form">
          <input type="email" placeholder="Enter your email address" />
          <button type="button" class="button">Subscribe</button>
        </div>
      </div>
    </section>

<section class="section_container client_container" id="client">
      <h2 class="section_header">What people say about us</h2>
      <p class="section_description">Discover why our customers love renting with us!</p>
      <div class="client_grid">
        <div class="client_card">
          <div class="client_details">
            <img src="<%= request.getContextPath() %>/Assets/images.jpeg" alt="Kushal Khanal" class="client_avatar" />
            <div>
              <h4>Kushal Khanal</h4>
              <div class="client_rating">
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-empty" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
              </div>
            </div>
          </div>
          <p>Affordable prices and great selection of vehicles! I found exactly what I needed, and the pick-up and drop-off process was seamless.</p>
        </div>
        <div class="client_card">
          <div class="client_details">
            <img src="<%= request.getContextPath() %>/Assets/images.jpeg" alt="Rehan Basnet" class="client_avatar" />
            <div>
              <h4>Rehan Basnet</h4>
              <div class="client_rating">
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-empty" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
              </div>
            </div>
          </div>
          <p>The flexibility of free cancellations made my trip stress-free. Great service overall — will definitely rent again!</p>
        </div>
        <div class="client_card">
          <div class="client_details">
            <img src="<%= request.getContextPath() %>/Assets/images.jpeg" alt="Rojal Shrestha" class="client_avatar" />
            <div>
              <h4>Rojal Shrestha</h4>
              <div class="client_rating">
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
              </div>
            </div>
          </div>
          <p>Excellent vehicles and very professional staff. The booking process was quick and the car was in perfect condition.</p>
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
            <a href="#" aria-label="Facebook"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/></svg></a>
            <a href="#" aria-label="Instagram"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"/><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"/><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"/></svg></a>
            <a href="#" aria-label="Twitter / X"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg></a>
          </div>
        </div>
        <div class="footer_col">
          <h4>Our Services</h4>
          <ul class="footer_links">
            <li><a href="#">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Rental Deals</a></li>
            <li><a href="#">Why Choose Us</a></li>
            <li><a href="#">Testimonials</a></li>
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
            <li><a href="tel:+9779818162494"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M6.62 10.79a15.05 15.05 0 0 0 6.59 6.59l2.2-2.2a1 1 0 0 1 1.02-.24 11.44 11.44 0 0 0 3.58.57 1 1 0 0 1 1 1V20a1 1 0 0 1-1 1A17 17 0 0 1 3 4a1 1 0 0 1 1-1h3.5a1 1 0 0 1 1 1c0 1.25.2 2.45.57 3.58a1 1 0 0 1-.25 1.01z"/></svg>+977 9818162494</a></li>
            <li><a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z"/></svg>Kathmandu, Nepal</a></li>
            <li><a href="mailto:kushal@gmail.com"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>kushal@gmail.com</a></li>
          </ul>
        </div>
      </div>

    </footer>

    <script>

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
        document.addEventListener('click', function() {
          dropdown.classList.remove('open');
        });
      }
    </script>

  </body>
</html>
