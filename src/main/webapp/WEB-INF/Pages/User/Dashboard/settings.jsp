<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
  <c:set var="activePage" value="settings" scope="request" />

    <!doctype html>
    <html lang="en">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/User/Dashboard/settings.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/User/sidebar.css">
      <title>RentAll | Profile Settings</title>
      <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet" />

    </head>

    <body>
      <jsp:include page="/WEB-INF/Pages/Includes/sidebar.jsp" />

      <main>
        <header class="top-navbar">
          <div class="welcome-text">
            <h1>Account Settings</h1>
            <p>Manage your personal information.</p>
          </div>
          <div class="user-actions" style="display:flex; gap:1rem; align-items:center;">
            <a href="${pageContext.request.contextPath}/home"
              style="text-decoration:none; color:var(--text-main); font-weight:600; font-size:0.9rem;">Return to
              Home</a>
            <div class="dropdown-wrapper">

              <input type="checkbox" id="notifToggle" class="notif-toggle-input">
              <label for="notifToggle" class="btn-notif">Notifications <span
                  class="notif-badge">${totalNotifCount}</span></label>

              <div class="notif-dropdown">
                <c:forEach var="n" items="${recentNotifs}">
                  <div class="notif-item">
                    <strong>${n.type}</strong><br>${n.description}
                  </div>
                </c:forEach>
                <c:if test="${empty recentNotifs}">
                  <div class="notif-item" style="text-align: center; color: var(--text-muted)">
                    No new notifications.
                  </div>
                </c:if>
              </div>

            </div>
          </div>
        </header>

        <div class="dashboard-content">
          <c:if test="${param.success == 'true'}">
            <div
              style="background:#dcfce7; color:#166534; padding:1rem; border-radius:8px; margin-bottom:1.5rem; border: 1px solid #bbf7d0; font-weight: 500;">
              Profile updated successfully!
            </div>
          </c:if>

          <form action="${pageContext.request.contextPath}/updateProfile" method="POST" class="profile-card"
            enctype="multipart/form-data">
            <div class="profile-header">
              <h2>Profile Overview & Settings</h2>
              <p>View and update your account details.</p>
            </div>

            <div class="profile-body">

              <div class="profile-hero">
                <a href="#avatarModal" class="summary-avatar-wrap" id="openModalBtn" title="Click to view full image">
                  <c:choose>
                    <c:when test="${not empty sessionScope.user.customer_image}">
                      <img src="${pageContext.request.contextPath}/Assets/Profiles/${sessionScope.user.customer_image}"
                        alt="Avatar" class="summary-avatar" />
                    </c:when>
                    <c:otherwise>
                      <div class="summary-avatar"
                        style="background:#e2e8f0; display:flex; align-items:center; justify-content:center; color:#64748b;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24"
                          fill="currentColor">
                          <path
                            d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" />
                        </svg>
                      </div>
                    </c:otherwise>
                  </c:choose>
                  <div class="avatar-overlay">Expand</div>
                </a>

                <div class="hero-details" style="flex: 1;">
                  <h3>${sessionScope.user.first_name} ${sessionScope.user.last_name}</h3>
                  <p>${sessionScope.user.customer_email}</p>
                  <span class="join-date">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none"
                      stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                      <rect x="3" y="4" width="18" height="18" rx="2" ry="2" />
                      <line x1="16" y1="2" x2="16" y2="6" />
                      <line x1="8" y1="2" x2="8" y2="6" />
                      <line x1="3" y1="10" x2="21" y2="10" />
                    </svg>
                    Member Since: ${sessionScope.user.created_at.toString().substring(0, 10)}
                  </span>

                  <div class="upload-row">
                    <label style="font-size: 0.75rem; margin-bottom: 2px;">Update Profile Photo</label>
                    <input type="file" name="customer_image" accept="image/*" class="info-box"
                      style="padding: 0.3rem; font-size: 0.8rem; background: white;" />
                  </div>
                </div>
              </div>

              <h3 class="section-title">Account Credentials</h3>
              <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" class="info-box" value="${sessionScope.user.customer_username}"
                  required>
              </div>
              <div class="form-group">
                <label>New Password</label>
                <input type="password" name="password" class="info-box" placeholder="*******">
              </div>

              <h3 class="section-title">Legal & Contact</h3>
              <div class="form-group">
                <label>Driver's License Number</label>
                <input type="text" name="license" class="info-box" value="${sessionScope.user.customer_license}"
                  required>
              </div>
              <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phone" class="info-box" value="${sessionScope.user.customer_phoneNo}" required>
              </div>

              <div class="form-group full-width">
                <label>Residential Address</label>
                <input type="text" name="address" class="info-box" value="${sessionScope.user.customer_address}"
                  required>
              </div>

              <div class="full-width" style="margin-top: 1rem;">
                <button type="submit" class="save-btn">Save Changes</button>
              </div>
            </div>
          </form>
        </div>
      </main>

      <div class="modal-overlay" id="avatarModal">
        <div class="modal-content">
          <a href="#" class="modal-close" id="closeModalBtn" title="Close modal">
            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none"
              stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <line x1="18" y1="6" x2="6" y2="18" />
              <line x1="6" y1="6" x2="18" y2="18" />
            </svg>
          </a>

          <c:choose>
            <c:when test="${not empty sessionScope.user.customer_image}">
              <img src="${pageContext.request.contextPath}/Assets/Profiles/${sessionScope.user.customer_image}"
                alt="Full Size Profile Image" class="modal-large-avatar" />
            </c:when>
            <c:otherwise>
              <div class="modal-large-avatar"
                style="display:flex; align-items:center; justify-content:center; color:#64748b; min-width: 300px; min-height: 300px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="120" height="120" viewBox="0 0 24 24"
                  fill="currentColor">
                  <path
                    d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" />
                </svg>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      
    </body>

    </html>