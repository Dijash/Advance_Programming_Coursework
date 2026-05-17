<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.model.Customer" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Root/Contactus.Css">
  <title>RentAll - Contact Us</title>

</head>

<c:set var="activePage" value="contact" scope="request" />

<body>
  <jsp:include page="/WEB-INF/Pages/Includes/navbar.jsp" />

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
        <c:if test="${param.status == 'success'}">
            <div style="background: #d1fae5; color: #065f46; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; border: 1px solid #34d399; font-weight: 500;">
                Thank you! Your message has been sent successfully.
            </div>
        </c:if>
        <c:if test="${param.status == 'error'}">
            <div style="background: #fee2e2; color: #b91c1c; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; border: 1px solid #fca5a5; font-weight: 500;">
                Oops! Something went wrong. Please try again.
            </div>
        </c:if>

        <h3>Send us a Message</h3>

        <form action="${pageContext.request.contextPath}/submitContact" method="POST">

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

            <button type="submit" class="button" style="width: 100%">Send Message</button>
        </form>
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