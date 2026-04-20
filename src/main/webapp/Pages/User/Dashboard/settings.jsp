<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

      <sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/java_coursework" user="root" password="" />

      <sql:query var="totalNotification" dataSource="${dbConnection}">
        SELECT COUNT(*) as count FROM notification;
      </sql:query>

      <sql:query var="recentNotifications" dataSource="${dbConnection}">
        SELECT notification_type, notification_description, notification_date
        FROM notification ORDER BY notification_date DESC LIMIT 5;
      </sql:query>

      <!doctype html>
      <html lang="en">

      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>RentAll | Profile Settings</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet" />
        <style>
          :root {
            --primary: #0f172a;
            --sidebar-active: #334155;
            --accent: #3b82f6;
            --bg-main: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --radius-lg: 12px;
            --radius-md: 8px;
            --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
          }

          * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
          }

          body {
            font-family: "Poppins", sans-serif;
            background-color: var(--bg-main);
            display: flex;
            min-height: 100vh;
          }

          .sidebar {
            width: 260px;
            background: var(--primary);
            color: white;
            padding: 2rem 1.5rem;
            position: fixed;
            height: 100vh;
            display: flex;
            flex-direction: column;
            z-index: 50;
          }

          .sidebar h2 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 2.5rem;
          }

          .sidebar nav a {
            text-decoration: none;
            color: #94a3b8;
            padding: 0.8rem 1rem;
            display: flex;
            border-radius: var(--radius-md);
            margin-bottom: 0.5rem;
            font-weight: 500;
            transition: 0.3s;
          }

          .sidebar nav a:hover,
          .sidebar nav a.active {
            background: var(--sidebar-active);
            color: white;
          }

          .logout {
            margin-top: auto;
            background: #ef4444;
            color: white !important;
            text-align: center;
            justify-content: center;
            padding: 0.8rem;
            border-radius: var(--radius-md);
            text-decoration: none;
          }

          main {
            flex: 1;
            margin-left: 260px;
          }

          .top-navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem 2.5rem;
            background: var(--bg-main);
            border-bottom: 1px solid var(--border);
          }

          .dashboard-content {
            padding: 2.5rem;
            max-width: 850px;
            margin: 0 auto;
          }

          .profile-card {
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            overflow: hidden;
          }

          .profile-header {
            background: var(--primary);
            color: white;
            padding: 2rem;
          }

          .profile-header h2 {
            font-size: 1.5rem;
          }

          .profile-header p {
            opacity: 0.8;
            font-size: 0.9rem;
            margin-top: 0.2rem;
          }

          .profile-body {
            padding: 2rem;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
          }

          .profile-hero {
            grid-column: span 2;
            display: flex;
            align-items: center;
            gap: 2rem;
            background: var(--bg-main);
            padding: 1.5rem;
            border-radius: var(--radius-md);
            border: 1px solid var(--border);
          }

          @media (max-width: 600px) {
            .profile-hero {
              flex-direction: column;
              text-align: center;
            }

            .profile-body {
              grid-template-columns: 1fr;
            }
          }

          .summary-avatar-wrap {
            position: relative;
            display: inline-block;
            cursor: pointer;
            border-radius: 50%;
            border: 4px solid white;
            box-shadow: var(--shadow);
            overflow: hidden;
            flex-shrink: 0;
          }

          .summary-avatar {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            object-fit: cover;
            display: block;
            transition: transform 0.3s ease;
          }

          .avatar-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            background: rgba(15, 23, 42, 0.75);
            color: white;
            padding: 6px 0;
            font-size: 0.7rem;
            font-weight: 600;
            text-transform: uppercase;
            text-align: center;
            opacity: 0;
            transition: opacity 0.3s ease;
          }

          .summary-avatar-wrap:hover .summary-avatar {
            transform: scale(1.05);
          }

          .summary-avatar-wrap:hover .avatar-overlay {
            opacity: 1;
          }

          .hero-details h3 {
            margin: 0 0 0.2rem 0;
            font-size: 1.4rem;
            color: var(--primary);
          }

          .hero-details p {
            margin: 0 0 0.5rem 0;
            color: var(--text-muted);
            font-size: 0.9rem;
          }

          .hero-details .join-date {
            font-size: 0.8rem;
            color: var(--text-main);
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: #e2e8f0;
            padding: 4px 10px;
            border-radius: 12px;
          }

          .upload-row {
            margin-top: 1rem;
            border-top: 1px solid #cbd5e1;
            padding-top: 1rem;
          }

          .form-group {
            display: flex;
            flex-direction: column;
          }

          label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-muted);
            margin-bottom: 0.4rem;
            text-transform: uppercase;
          }

          .info-box {
            width: 100%;
            background: var(--bg-main);
            padding: 0.75rem 1rem;
            border-radius: 4px;
            border: 1px solid var(--border);
            color: var(--text-main);
            font-weight: 500;
            font-size: 0.95rem;
            font-family: "Poppins", sans-serif;
            transition: 0.2s;
          }

          .info-box:focus {
            outline: none;
            border-color: var(--accent);
            background: white;
          }

          .full-width {
            grid-column: span 2;
          }

          .section-title {
            grid-column: span 2;
            border-bottom: 1px solid var(--border);
            padding-bottom: 0.5rem;
            margin-top: 1rem;
            color: var(--primary);
            font-weight: 700;
            font-size: 1.1rem;
          }

          .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(15, 23, 42, 0.85);
            backdrop-filter: blur(5px);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s;
          }

          .modal-overlay.show {
            display: flex;
            opacity: 1;
          }

          .modal-content {
            background: var(--card-bg);
            width: 90%;
            max-width: 420px;
            border-radius: var(--radius-lg);
            padding: 2.5rem;
            position: relative;
            transform: translateY(-20px);
            transition: transform 0.3s;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.3);
            text-align: center;
            border: 1px solid var(--border);
          }

          .modal-overlay.show .modal-content {
            transform: translateY(0);
          }

          .modal-close {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: var(--bg-main);
            border: 1px solid var(--border);
            width: 32px;
            height: 32px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            transition: 0.2s;
          }

          .modal-close:hover {
            background: #ef4444;
            color: white;
            border-color: #ef4444;
          }

          .modal-large-avatar {
            width: 220px;
            height: 220px;
            border-radius: 50%;
            object-fit: cover;
            margin: 0 auto 1.5rem;
            border: 6px solid var(--bg-main);
            box-shadow: var(--shadow);
          }

          .modal-tag {
            display: inline-block;
            background: #e0f2fe;
            color: #0369a1;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 0.85rem;
            font-family: monospace;
            font-weight: 700;
            margin-top: 0.5rem;
            border: 1px solid #bae6fd;
          }

          .dropdown-wrapper {
            position: relative;
          }

          .btn-notif {
            background: var(--card-bg);
            border: 1px solid var(--border);
            padding: 0.6rem 1.2rem;
            border-radius: var(--radius-md);
            font-weight: 600;
            cursor: pointer;
            display: flex;
            gap: 0.5rem;
          }

          .notif-badge {
            background: #ef4444;
            color: white;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 0.75rem;
          }

          .notif-dropdown {
            position: absolute;
            top: 110%;
            right: 0;
            width: 300px;
            background: white;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            display: none;
            z-index: 100;
            border-radius: var(--radius-md);
          }

          .notif-dropdown.show {
            display: block;
          }

          .notif-item {
            padding: 1rem;
            border-bottom: 1px solid var(--border);
            font-size: 0.8rem;
          }

          .save-btn {
            display: inline-block;
            background: var(--primary);
            color: white;
            padding: 0.8rem 2rem;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 1rem;
            transition: 0.3s;
            box-shadow: var(--shadow);
            border: none;
            cursor: pointer;
            width: 100%;
          }

          .save-btn:hover {
            background: var(--sidebar-active);
            transform: translateY(-2px);
          }
        </style>
      </head>

      <body>
        <aside class="sidebar">
          <h2>RentAll</h2>
          <nav>
            <a href="<%= request.getContextPath() %>/userDashboard">Dashboard</a>
            <a href="<%= request.getContextPath() %>/myBookings">My Bookings</a>
            <a href="<%= request.getContextPath() %>/settings" class="active">Settings</a>
          </nav>
          <a href="<%= request.getContextPath() %>/logout" class="logout">Logout</a>
        </aside>

        <main>
          <header class="top-navbar">
            <div class="welcome-text">
              <h1>Account Settings</h1>
              <p>Manage your personal information.</p>
            </div>
            <div class="user-actions" style="display:flex; gap:1rem; align-items:center;">
              <a href="<%= request.getContextPath() %>/home"
                style="text-decoration:none; color:var(--text-main); font-weight:600; font-size:0.9rem;">Return to
                Home</a>
              <div class="dropdown-wrapper">
                <button class="btn-notif" id="notifBtn">Notifications <span
                    class="notif-badge">${totalNotification.rows[0].count}</span></button>
                <div class="notif-dropdown" id="notifMenu">
                  <c:forEach var="n" items="${recentNotifications.rows}">
                    <div class="notif-item"><strong>${n.notification_type}</strong><br>${n.notification_description}
                    </div>
                  </c:forEach>
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

            <form action="<%= request.getContextPath() %>/updateProfile" method="POST" class="profile-card"
              enctype="multipart/form-data">
              <div class="profile-header">
                <h2>Profile Overview & Settings</h2>
                <p>View and update your account details.</p>
              </div>

              <div class="profile-body">

                <div class="profile-hero">
                  <div class="summary-avatar-wrap" id="openModalBtn" title="Click to view full image">
                    <c:choose>
                      <c:when test="${not empty sessionScope.user.customer_image}">
                        <img src="<%= request.getContextPath() %>/Assets/Profiles/${sessionScope.user.customer_image}"
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
                  </div>

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
                  <input type="password" name="password" class="info-box" placeholder="Leave blank to keep current">
                </div>

                <h3 class="section-title">Legal & Contact</h3>
                <div class="form-group">
                  <label>Driver's License Number</label>
                  <input type="text" name="license" class="info-box" value="${sessionScope.user.customer_license}"
                    required>
                </div>
                <div class="form-group">
                  <label>Phone Number</label>
                  <input type="text" name="phone" class="info-box" value="${sessionScope.user.customer_phoneNo}"
                    required>
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
            <button class="modal-close" id="closeModalBtn" title="Close modal">
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
                stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="18" y1="6" x2="6" y2="18" />
                <line x1="6" y1="6" x2="18" y2="18" />
              </svg>
            </button>

            <c:choose>
              <c:when test="${not empty sessionScope.user.customer_image}">
                <img src="<%= request.getContextPath() %>/Assets/Profiles/${sessionScope.user.customer_image}"
                  alt="Expanded Profile Image" class="modal-large-avatar" />
              </c:when>
              <c:otherwise>
                <div class="modal-large-avatar"
                  style="background:#e2e8f0; display:flex; align-items:center; justify-content:center; color:#64748b;">
                  <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" viewBox="0 0 24 24"
                    fill="currentColor">
                    <path
                      d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" />
                  </svg>
                </div>
              </c:otherwise>
            </c:choose>

            <h2 style="color: var(--primary); margin-bottom: 0.3rem;">${sessionScope.user.first_name}
              ${sessionScope.user.last_name}</h2>
            <div class="modal-tag">LIC: ${sessionScope.user.customer_license}</div>
          </div>
        </div>

        <script>
          const btn = document.getElementById('notifBtn');
          const menu = document.getElementById('notifMenu');
          btn.addEventListener('click', (e) => { e.stopPropagation(); menu.classList.toggle('show'); });
          window.addEventListener('click', () => menu.classList.remove('show'));

          const modal = document.getElementById('avatarModal');
          const openModalBtn = document.getElementById('openModalBtn');
          const closeModalBtn = document.getElementById('closeModalBtn');

          openModalBtn.addEventListener('click', () => { modal.classList.add('show'); });
          closeModalBtn.addEventListener('click', () => { modal.classList.remove('show'); });
          modal.addEventListener('click', (e) => { if (e.target === modal) modal.classList.remove('show'); });
        </script>
      </body>

      </html>