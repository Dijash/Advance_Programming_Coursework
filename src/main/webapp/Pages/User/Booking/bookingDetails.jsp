<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RentAll | Booking Details</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
  <style>
    :root {
      --primary: #0f172a;
      --sidebar-active: #334155;
      --accent: #3b82f6;
      --accent-hover: #2563eb;
      --success: #10b981;
      --warning: #f59e0b;
      --danger: #ef4444;
      --bg-main: #f8fafc;
      --card-bg: #ffffff;
      --text-main: #1e293b;
      --text-muted: #64748b;
      --border: #e2e8f0;
      --radius-lg: 12px;
      --radius-md: 8px;
      --radius-sm: 4px;
      --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
      --shadow-lg: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: "Poppins", sans-serif; background-color: var(--bg-main); color: var(--text-main); display: flex; min-height: 100vh; }

    /* Sidebar */
    .sidebar { width: 260px; background: var(--primary); color: white; padding: 2rem 1.5rem; display: flex; flex-direction: column; position: fixed; height: 100vh; z-index: 50; }
    .sidebar h2 { font-size: 1.5rem; font-weight: 700; margin-bottom: 2.5rem; }
    .sidebar nav ul { list-style: none; }
    .sidebar nav a { text-decoration: none; color: #94a3b8; padding: 0.8rem 1rem; display: flex; align-items: center; border-radius: var(--radius-md); margin-bottom: 0.5rem; transition: 0.3s; font-weight: 500; }
    .sidebar nav a:hover, .sidebar nav a.active { background: var(--sidebar-active); color: white; }
    .logout { margin-top: auto; background: var(--danger); color: white !important; display: flex; justify-content: center; padding: 0.8rem 1rem; border-radius: var(--radius-md); text-decoration: none; font-weight: 500; transition: 0.3s; }
    .logout:hover { background: #dc2626; }

    /* Main Area */
    main { flex: 1; margin-left: 260px; display: flex; flex-direction: column; }
    .top-navbar { display: flex; justify-content: space-between; align-items: center; padding: 1.5rem 2.5rem; background: var(--bg-main); border-bottom: 1px solid var(--border); }
    .welcome-text h1 { font-size: 1.5rem; font-weight: 700; color: var(--primary); }
    .welcome-text p { font-size: 0.9rem; color: var(--text-muted); }
    .user-actions { display: flex; align-items: center; gap: 1.25rem; }

    .btn-home { text-decoration: none; background: transparent; color: var(--text-main); padding: 0.6rem 1.2rem; border-radius: var(--radius-md); font-weight: 600; font-size: 0.9rem; border: 1px solid var(--border); transition: 0.2s; }
    .btn-home:hover { background: var(--card-bg); border-color: #cbd5e1; box-shadow: var(--shadow); }

    /* Notification Dropdown */
    .dropdown-wrapper { position: relative; }
    .btn-notif { background: var(--card-bg); border: 1px solid var(--border); padding: 0.6rem 1.2rem; border-radius: var(--radius-md); font-weight: 600; font-size: 0.9rem; cursor: pointer; display: flex; align-items: center; gap: 0.5rem; color: var(--text-main); transition: 0.2s; }
    .btn-notif:hover { border-color: var(--accent); }
    .notif-badge { background: var(--danger); color: white; padding: 2px 6px; border-radius: var(--radius-sm); font-size: 0.75rem; }
    .notif-dropdown { position: absolute; top: calc(100% + 0.5rem); right: 0; width: 340px; background: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius-md); box-shadow: var(--shadow-lg); display: none; flex-direction: column; z-index: 100; overflow: hidden; }
    .notif-dropdown.show { display: flex; }
    .notif-header { padding: 1rem; border-bottom: 1px solid var(--border); background: var(--bg-main); font-weight: 600; font-size: 0.9rem; color: var(--primary); }
    .notif-list { max-height: 320px; overflow-y: auto; }
    .notif-item { padding: 1rem; border-bottom: 1px solid var(--border); transition: background 0.2s; text-align: left; }
    .notif-item:hover { background: #f8fafc; }
    .notif-item strong { display: block; font-size: 0.85rem; color: var(--accent); margin-bottom: 0.25rem; }
    .notif-item p { font-size: 0.8rem; color: var(--text-muted); margin-bottom: 0.5rem; line-height: 1.4; }
    .notif-item small { font-size: 0.7rem; color: #94a3b8; display: block; }

    /* User Profile */
    .user-profile { display: flex; align-items: center; gap: 12px; font-weight: 600; padding-left: 1.25rem; border-left: 2px solid var(--border); color: var(--primary); }
    .profile-avatar { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; box-shadow: var(--shadow); border: 2px solid white; }
    .default-avatar { background-color: #e2e8f0; display: flex; align-items: center; justify-content: center; color: #64748b; }
    .default-avatar svg { width: 24px; height: 24px; }

    /* Dashboard Content & Header Actions */
    .dashboard-content { padding: 2.5rem; max-width: 1100px; margin: 0 auto; width: 100%; }
    .header-actions { display: flex; justify-content: flex-end; gap: 1rem; margin-bottom: 1.5rem; }

    .btn-back-dashboard { text-decoration: none; background: var(--primary); color: white; padding: 0.6rem 1.2rem; border-radius: var(--radius-md); font-weight: 600; font-size: 0.85rem; transition: 0.3s; box-shadow: var(--shadow); }
    .btn-back-dashboard:hover { background: var(--sidebar-active); transform: translateY(-1px); }

    .btn-download-pdf { text-decoration: none; background: var(--card-bg); color: var(--primary); border: 1px solid var(--border); padding: 0.6rem 1.2rem; border-radius: var(--radius-md); font-weight: 600; font-size: 0.85rem; transition: 0.3s; display: flex; align-items: center; gap: 0.5rem;}
    .btn-download-pdf:hover { background: #e2e8f0; border-color: #cbd5e1; }

    /* New Layout Grid */
    .booking-layout-grid {
      display: grid;
      grid-template-columns: 1.6fr 1fr;
      gap: 2rem;
      align-items: start;
    }

    .content-box { background: var(--card-bg); border-radius: var(--radius-lg); padding: 2rem; box-shadow: var(--shadow); border: 1px solid var(--border); }

    .booking-header { display: flex; justify-content: space-between; align-items: flex-start; border-bottom: 1px solid var(--border); padding-bottom: 1.5rem; margin-bottom: 1.5rem; }
    .booking-title h2 { font-size: 1.5rem; color: var(--primary); margin-bottom: 0.25rem; }
    .booking-title p { font-size: 0.9rem; color: var(--text-muted); font-family: monospace; }
    .status-text { font-weight: 700; font-size: 1rem; text-transform: uppercase; letter-spacing: 0.05em; }

    .details-section { background: var(--bg-main); padding: 1.5rem; border-radius: var(--radius-md); border: 1px solid var(--border); margin-bottom: 1.5rem;}
    .details-section h3 { font-size: 1.1rem; color: var(--primary); margin-bottom: 1.25rem; font-weight: 700; }
    .detail-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem; border-bottom: 1px dashed #cbd5e1; padding-bottom: 0.75rem; }
    .detail-row:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }
    .detail-label { color: var(--text-muted); font-size: 0.9rem; font-weight: 500; }
    .detail-value { font-weight: 600; color: var(--text-main); font-size: 0.95rem; text-align: right; }

    .total-row { background: var(--primary); color: white; padding: 1.25rem; border-radius: var(--radius-md); margin-top: 1.5rem; display: flex; justify-content: space-between; align-items: center; }
    .total-row .detail-label { color: #cbd5e1; font-weight: 600; }
    .total-row .detail-value { color: var(--success); font-size: 1.4rem; text-shadow: 0 0 10px rgba(16, 185, 129, 0.3); }

    /* DANGER ZONE CSS */
    .danger-zone { margin-top: 2rem; padding-top: 2rem; border-top: 1px solid var(--border); display: flex; justify-content: center; }
    .btn-cancel-large { background: #fff1f1; color: var(--danger); border: 1px solid #fca5a5; padding: 0.75rem 2rem; border-radius: var(--radius-md); font-weight: 700; cursor: pointer; transition: 0.3s; text-transform: uppercase; letter-spacing: 1px; width: 100%;}
    .btn-cancel-large:hover { background: var(--danger); color: white; }

    /* Right Side: Vehicle Card */
    .vehicle-preview-card { padding: 1.5rem; background: var(--card-bg); border-radius: var(--radius-lg); box-shadow: var(--shadow); border: 1px solid var(--border); text-align: center; margin-bottom: 1.5rem; }
    .vehicle-preview-img { width: 100%; height: 200px; object-fit: cover; border-radius: var(--radius-md); margin-bottom: 1rem; background: #e2e8f0; }
    .vehicle-preview-title { font-size: 1.25rem; font-weight: 700; color: var(--primary); margin-bottom: 0.2rem;}
    .vehicle-preview-plate { color: var(--text-muted); font-family: monospace; font-size: 0.9rem; background: #f1f5f9; padding: 4px 8px; border-radius: 4px; display: inline-block; border: 1px solid var(--border);}

    /* Right Side: Review Form */
    .review-box { background: var(--card-bg); border-radius: var(--radius-lg); padding: 1.5rem; box-shadow: var(--shadow); border: 1px solid var(--border); }
    .review-box h3 { margin-bottom: 1.2rem; color: var(--primary); font-size: 1.1rem; border-bottom: 1px solid var(--border); padding-bottom: 0.75rem; }
    .form-group { margin-bottom: 1.2rem; text-align: left; }
    .form-group label { display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-muted); margin-bottom: 0.4rem; }
    .form-group select, .form-group textarea { width: 100%; padding: 0.75rem; border: 1px solid var(--border); border-radius: var(--radius-md); font-family: inherit; font-size: 0.9rem; color: var(--text-main); background: #f8fafc;}
    .form-group select:focus, .form-group textarea:focus { border-color: var(--accent); outline: none; background: white;}
    .btn-submit-review { width: 100%; background: var(--accent); color: white; padding: 0.8rem; border: none; border-radius: var(--radius-md); font-weight: 600; cursor: pointer; transition: 0.2s; font-family: 'Poppins', sans-serif;}
    .btn-submit-review:hover { background: var(--accent-hover); }

    /* Alerts */
    .alert { padding: 1rem; border-radius: var(--radius-md); margin-bottom: 1.5rem; font-weight: 600; font-size: 0.9rem; }
    .alert-success { background: #d1fae5; color: #065f46; border: 1px solid #34d399; }
    .alert-danger { background: #fee2e2; color: #b91c1c; border: 1px solid #fca5a5; }

    @media (max-width: 900px) {
      .booking-layout-grid { grid-template-columns: 1fr; }
      .sidebar { transform: translateX(-100%); transition: 0.3s; }
      main { margin-left: 0; }
    }
  </style>
</head>

<body>
  <aside class="sidebar">
    <h2>RentAll</h2>
    <nav>
      <ul>
        <li><a href="${pageContext.request.contextPath}/userDashboard">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/myBookings" class="active">My Bookings</a></li>
        <li><a href="${pageContext.request.contextPath}/myFavorites" >My Favorites</a></li>
        <li><a href="${pageContext.request.contextPath}/settings">Settings</a></li>
      </ul>
    </nav>
    <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
  </aside>

  <main>
    <header class="top-navbar">
      <div class="welcome-text">
        <h1>Booking Summary</h1>
        <p>Full breakdown of your reservation details.</p>
      </div>

      <div class="user-actions">
        <a href="${pageContext.request.contextPath}/home" class="btn-home">Return to Home</a>

        <div class="dropdown-wrapper">
          <button class="btn-notif" id="notifBtn">
            Notifications <span class="notif-badge"><c:out value="${totalNotifCount}" default="0" /></span>
          </button>
          <div class="notif-dropdown" id="notifMenu">
            <div class="notif-header">Recent Broadcasts</div>
            <div class="notif-list">
              <c:forEach var="n" items="${recentNotifs}">
                <div class="notif-item">
                  <strong><c:out value="${n.type}" /></strong>
                  <p><c:out value="${n.description}" /></p>
                  <small>Date: <c:out value="${n.date}" /></small>
                </div>
              </c:forEach>
              <c:if test="${empty recentNotifs}">
                <div class="notif-item" style="text-align: center; color: var(--text-muted)">No active system alerts.</div>
              </c:if>
            </div>
          </div>
        </div>

        <div class="user-profile">
          <c:choose>
            <c:when test="${not empty sessionScope.user.customer_image}">
              <img src="${pageContext.request.contextPath}/Assets/Profiles/${sessionScope.user.customer_image}" alt="Profile Photo" class="profile-avatar" />
            </c:when>
            <c:otherwise>
              <div class="profile-avatar default-avatar">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" /></svg>
              </div>
            </c:otherwise>
          </c:choose>
          <span><c:out value="${sessionScope.user.customer_username}" default="Profile" /></span>
        </div>
      </div>
    </header>

    <div class="dashboard-content">

      <c:if test="${not empty sessionScope.successMsg}">
          <div class="alert alert-success">${sessionScope.successMsg}</div>
          <c:remove var="successMsg" scope="session"/>
      </c:if>
      <c:if test="${not empty sessionScope.errorMsg}">
          <div class="alert alert-danger">${sessionScope.errorMsg}</div>
          <c:remove var="errorMsg" scope="session"/>
      </c:if>

      <div class="header-actions">
        <a href="${pageContext.request.contextPath}/downloadInvoice?bookingId=${bookingDetails.bookingId}" class="btn-download-pdf">
          <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
          </svg>
          Download PDF
        </a>
        <a href="${pageContext.request.contextPath}/userDashboard" class="btn-back-dashboard">Back to Dashboard</a>
      </div>

      <div class="booking-layout-grid">

        <div class="left-column">
          <section class="content-box">
            <div class="booking-header">
              <div class="booking-title">
                <h2>Booking Details</h2>
                <p>REF ID: #<c:out value="${bookingDetails.bookingId}" /></p>
              </div>

              <div class="status-text" style="color: ${bookingDetails.status == 'On Track' || bookingDetails.status == 'Completed' ? '#10b981' : (bookingDetails.status == 'Cancelled' ? '#ef4444' : '#f59e0b')}; text-shadow: 0 0 15px ${bookingDetails.status == 'On Track' || bookingDetails.status == 'Completed' ? 'rgba(16,185,129,0.2)' : 'transparent'};">
                <c:out value="${bookingDetails.status}" />
              </div>
            </div>

            <div class="details-section">
              <h3>Trip Schedule</h3>
              <div class="detail-row">
                <span class="detail-label">Pickup Date</span>
                <span class="detail-value"><c:out value="${bookingDetails.startDate}" /></span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Return Date</span>
                <span class="detail-value"><c:out value="${bookingDetails.endDate}" /></span>
              </div>
            </div>

            <div class="details-section" style="margin-bottom: 0;">
              <h3>Customer Info</h3>
              <div class="detail-row">
                <span class="detail-label">Renter Name</span>
                <span class="detail-value"><c:out value="${sessionScope.user.first_name} ${sessionScope.user.last_name}" /></span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Email</span>
                <span class="detail-value"><c:out value="${sessionScope.user.customer_email}" /></span>
              </div>
            </div>

            <div class="total-row">
              <span class="detail-label">Grand Total Paid</span>
              <span class="detail-value">NPR <c:out value="${bookingDetails.totalPrice}" /></span>
            </div>

            <%-- ONLY show cancel button if status is Pending --%>
            <c:if test="${bookingDetails.status == 'Pending'}">
              <div class="danger-zone">
                <form action="${pageContext.request.contextPath}/cancelBooking" method="POST" onsubmit="return confirm('WARNING: Are you sure you want to cancel this reservation?')">
                  <input type="hidden" name="bookingId" value="${bookingDetails.bookingId}">
                  <button type="submit" class="btn-cancel-large">
                    Cancel Reservation
                  </button>
                </form>
              </div>
            </c:if>
          </section>
        </div>

        <div class="right-column">
          <div class="vehicle-preview-card">
            <img src="${pageContext.request.contextPath}/Assets/${not empty vehicleImage ? vehicleImage : 'images.jpeg'}" alt="Vehicle Image" class="vehicle-preview-img" />
            <h3 class="vehicle-preview-title"><c:out value="${bookingDetails.vehicleDetails}" /></h3>
            <span class="vehicle-preview-plate"><c:out value="${bookingDetails.numberPlate}" /></span>
          </div>

          <c:if test="${bookingDetails.status == 'Completed'}">
                      <div class="review-box">
                        <h3>Leave a Review</h3>
                        <form action="${pageContext.request.contextPath}/submitReview" method="POST">
                          <input type="hidden" name="bookingId" value="${bookingDetails.bookingId}" />
                          <input type="hidden" name="vehicleId" value="${vehicleId}" />

                          <div class="form-group">
                            <label for="comment">Your Feedback</label>
                            <textarea id="comment" name="comment" rows="4" placeholder="Tell us about the car and your trip..." required></textarea>
                          </div>

                          <button type="submit" class="btn-submit-review">Submit Review</button>
                        </form>
                      </div>
                    </c:if>
        </div>

      </div>

    </div>
  </main>

  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const notifBtn = document.getElementById("notifBtn");
      const notifMenu = document.getElementById("notifMenu");

      notifBtn.addEventListener("click", function (event) {
        event.stopPropagation();
        notifMenu.classList.toggle("show");
      });

      window.addEventListener("click", function () {
        if (notifMenu.classList.contains("show")) {
          notifMenu.classList.remove("show");
        }
      });

      notifMenu.addEventListener("click", function (event) {
        event.stopPropagation();
      });
    });
  </script>
</body>
</html>