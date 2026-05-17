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

<c:set var="activePage" value="about" scope="request" />

<body>
  <jsp:include page="/WEB-INF/Pages/Includes/navbar.jsp" />

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
<jsp:include page="/WEB-INF/Pages/Includes/footer.jsp" />
<script>
    document.addEventListener("DOMContentLoaded", function() {
      const menuBtn = document.getElementById('menu-btn');
      const navLinks = document.getElementById('nav-links');
      if (menuBtn && navLinks) {
        menuBtn.addEventListener('click', () => navLinks.classList.toggle('active'));
      }
    });
  </script>
</body>
</html>