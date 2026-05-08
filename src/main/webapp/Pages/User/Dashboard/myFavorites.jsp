<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.model.Customer" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | My Favorites</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li><a href="${pageContext.request.contextPath}/userDashboard">Dashboard</a></li>
          <li><a href="${pageContext.request.contextPath}/myBookings">My Bookings</a></li>
          <li><a href="${pageContext.request.contextPath}/myFavorites" class="active">My Favorites</a></li>
          <li><a href="${pageContext.request.contextPath}/settings">Settings</a></li>
        </ul>
      </nav>
      <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
    </aside>

    <main>
      <header class="top-navbar">
        <div class="welcome-text">
          <h1>
            Hello, <c:out value="${not empty sessionScope.user.first_name ? sessionScope.user.first_name : sessionScope.user.customer_username}" default="Driver" />
          </h1>
          <p>Vehicles you have saved for later.</p>
        </div>

        <div class="user-actions">
          <a href="${pageContext.request.contextPath}/rentalDeals" class="btn-home">Browse Fleet</a>

          <div class="user-profile">
            <c:choose>
                <c:when test="${not empty sessionScope.user.customer_image}">
                    <img src="${pageContext.request.contextPath}/Assets/Profiles/${sessionScope.user.customer_image}" alt="Profile Photo" class="profile-avatar" />
                </c:when>
                <c:otherwise>
                    <div class="profile-avatar" style="background: #3b82f6; color: white; display: flex; align-items: center; justify-content: center; font-weight: bold; text-transform: uppercase;">
                        <c:out value="${fn:substring(not empty sessionScope.user.first_name ? sessionScope.user.first_name : sessionScope.user.customer_username, 0, 1)}" default="U" />
                    </div>
                </c:otherwise>
            </c:choose>
            <span><c:out value="${sessionScope.user.customer_username}" /></span>
          </div>
        </div>
      </header>

      <div class="dashboard-content">
        <section class="content-box">
          <h3>Saved Vehicles</h3>

          <c:choose>
            <c:when test="${not empty favoriteVehicles}">
              <div class="favorites-grid">
                <c:forEach var="v" items="${favoriteVehicles}">

                  <div class="fav-card">
                    <img src="${pageContext.request.contextPath}/Assets/${v.vehicle_image}" alt="${v.vehicle_brand}" class="fav-img" onerror="this.src='https://placehold.co/600x400/f1f5f9/94a3b8?text=Vehicle'"/>

                    <div class="fav-info">
                      <h4><c:out value="${v.vehicle_brand}" /> <c:out value="${v.vehicle_type}" /></h4>
                      <p><c:out value="${v.vehicle_color}" /> | <c:out value="${v.vehicle_numberPlate}" /></p>

                      <div class="fav-price">
                        NPR 4,500 <span>/ day</span>
                      </div>

                      <div class="fav-actions">
                        <a href="${pageContext.request.contextPath}/viewVehicleDetails?id=${v.vehicle_id}" class="btn-book" ${v.vehicle_status != 'Available' ? 'style="background:#94a3b8; pointer-events:none;"' : ''}>
                          ${v.vehicle_status == 'Available' ? 'Book Now' : 'Unavailable'}
                        </a>

                        <form action="${pageContext.request.contextPath}/toggleFavorite" method="POST" style="margin: 0;">
                          <input type="hidden" name="vehicleId" value="${v.vehicle_id}" />
                          <button type="submit" class="btn-remove" title="Remove from favorites">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <polyline points="3 6 5 6 21 6"></polyline>
                                <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                            </svg>
                          </button>
                        </form>
                      </div>
                    </div>
                  </div>

                </c:forEach>
              </div>
            </c:when>

            <c:otherwise>
              <div class="empty-state">
                <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="color: #cbd5e1; margin-bottom: 1rem;">
                  <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                </svg>
                <h4 style="color: var(--primary); margin-bottom: 0.5rem;">No Favorites Yet</h4>
                <p>You haven't saved any vehicles to your favorites.</p>
                <a href="${pageContext.request.contextPath}/rentalDeals" class="btn-home" style="display: inline-block; margin-top: 1rem; color: var(--accent); border-color: var(--accent);">Browse Fleet</a>
              </div>
            </c:otherwise>
          </c:choose>

        </section>
      </div>
    </main>
  </body>
</html>