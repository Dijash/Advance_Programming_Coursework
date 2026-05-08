<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.model.Customer" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Root/Aboutus.css">
  <title>RentAll - About Us</title>

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
          <img src="${pageContext.request.contextPath}/Assets/Team/team-2.jpg" alt="Member 2" class="team_avatar" />
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
          <img src="${pageContext.request.contextPath}/Assets/Team/team-5.jpg" alt="Member 5" class="team_avatar" />
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