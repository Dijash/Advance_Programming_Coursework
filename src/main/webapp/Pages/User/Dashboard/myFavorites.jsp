<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="com.model.Customer" %>
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
    <title>RentAll | My Favorites</title>
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
      .sidebar { width: 260px; background: var(--primary); color: white; padding: 2rem 1.5rem; display: flex; flex-direction: column; position: fixed; height: 100vh; }
      .sidebar h2 { font-size: 1.5rem; font-weight: 700; margin-bottom: 2.5rem; }
      .sidebar nav ul { list-style: none; }
      .sidebar nav a { text-decoration: none; color: #94a3b8; padding: 0.8rem 1rem; display: flex; align-items: center; border-radius: var(--radius-md); margin-bottom: 0.5rem; transition: 0.3s; font-weight: 500; }
      .sidebar nav a:hover, .sidebar nav a.active { background: var(--sidebar-active); color: white; }
      .logout { margin-top: auto; background: var(--danger); color: white !important; display: flex; justify-content: center; align-items: center; padding: 0.8rem 1rem; border-radius: var(--radius-md); text-decoration: none; font-weight: 500; transition: 0.3s; }
      .logout:hover { background: #dc2626; }

      /* Main Area */
      main { flex: 1; margin-left: 260px; display: flex; flex-direction: column; }
      .top-navbar { display: flex; justify-content: space-between; align-items: center; padding: 1.5rem 2.5rem; background: var(--bg-main); border-bottom: 1px solid var(--border); }
      .welcome-text h1 { font-size: 1.5rem; font-weight: 700; color: var(--primary); }
      .welcome-text p { font-size: 0.9rem; color: var(--text-muted); }
      .user-actions { display: flex; align-items: center; gap: 1.25rem; }
      .btn-home { text-decoration: none; background: transparent; color: var(--text-main); padding: 0.6rem 1.2rem; border-radius: var(--radius-md); font-weight: 600; font-size: 0.9rem; border: 1px solid var(--border); transition: 0.2s; }
      .btn-home:hover { background: var(--card-bg); border-color: #cbd5e1; box-shadow: var(--shadow); }

      /* Profile */
      .user-profile { display: flex; align-items: center; gap: 12px; font-weight: 600; padding-left: 1.25rem; border-left: 2px solid var(--border); color: var(--primary); }
      .profile-avatar { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; box-shadow: var(--shadow); border: 2px solid white; background-color: #e2e8f0; display: flex; align-items: center; justify-content: center; color: white;}

      /* Dashboard Content & Favorites Grid */
      .dashboard-content { padding: 2.5rem; }

      .content-box { background: var(--card-bg); border-radius: var(--radius-lg); padding: 1.5rem; box-shadow: var(--shadow); border: 1px solid var(--border); }
      .content-box h3 { font-size: 1.2rem; margin-bottom: 1.5rem; color: var(--primary); font-weight: 700;}

      .favorites-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 1.5rem;
      }

      .fav-card {
        border: 1px solid var(--border);
        border-radius: var(--radius-lg);
        overflow: hidden;
        background: var(--card-bg);
        transition: transform 0.2s, box-shadow 0.2s;
        display: flex;
        flex-direction: column;
      }

      .fav-card:hover {
        transform: translateY(-4px);
        box-shadow: var(--shadow-lg);
      }

      .fav-img {
        width: 100%;
        height: 180px;
        object-fit: cover;
        background: #f1f5f9;
        border-bottom: 1px solid var(--border);
      }

      .fav-info {
        padding: 1.2rem;
        display: flex;
        flex-direction: column;
        flex-grow: 1;
      }

      .fav-info h4 {
        font-size: 1.1rem;
        color: var(--primary);
        font-weight: 700;
        margin-bottom: 0.2rem;
      }

      .fav-info p {
        font-size: 0.85rem;
        color: var(--text-muted);
        margin-bottom: 1rem;
      }

      .fav-price {
        font-size: 1.2rem;
        font-weight: 800;
        color: var(--primary);
        margin-top: auto;
        margin-bottom: 1rem;
      }

      .fav-price span {
        font-size: 0.8rem;
        font-weight: 500;
        color: var(--text-muted);
      }

      .fav-actions {
        display: flex;
        gap: 0.5rem;
      }

      .btn-book {
        flex: 1;
        background: var(--accent);
        color: white;
        text-align: center;
        text-decoration: none;
        padding: 0.6rem;
        border-radius: var(--radius-md);
        font-weight: 600;
        font-size: 0.85rem;
        transition: 0.2s;
        border: none;
      }

      .btn-book:hover {
        background: var(--accent-hover);
      }

      .btn-remove {
        background: #fee2e2;
        color: var(--danger);
        border: 1px solid #fca5a5;
        padding: 0.6rem;
        border-radius: var(--radius-md);
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: 0.2s;
      }

      .btn-remove:hover {
        background: var(--danger);
        color: white;
      }

      .empty-state {
        text-align: center;
        padding: 4rem 2rem;
        color: var(--text-muted);
      }

    </style>
  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li><a href="<%= request.getContextPath() %>/userDashboard">Dashboard</a></li>
          <li><a href="<%= request.getContextPath() %>/myBookings">My Bookings</a></li>
          <!-- ADDED FAVORITES TO SIDEBAR -->
          <li><a href="<%= request.getContextPath() %>/myFavorites" class="active">My Favorites</a></li>
          <li><a href="<%= request.getContextPath() %>/settings">Settings</a></li>
        </ul>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout">Logout</a>
    </aside>

    <main>
      <header class="top-navbar">
        <div class="welcome-text">
          <h1>My Favorites</h1>
          <p>Vehicles you have saved for later.</p>
        </div>

        <div class="user-actions">
          <a href="<%= request.getContextPath() %>/rentalDeals" class="btn-home">Browse Fleet</a>

          <div class="user-profile">
            <c:choose>
                <c:when test="${not empty sessionScope.user.customer_image}">
                    <img src="<%= request.getContextPath() %>/Assets/Profiles/${sessionScope.user.customer_image}" alt="Profile Photo" class="profile-avatar" />
                </c:when>
                <c:otherwise>
                    <div class="profile-avatar"><%= String.valueOf(fName.charAt(0)).toUpperCase() %></div>
                </c:otherwise>
            </c:choose>
            <span><%= username %></span>
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

                  <div class="fav-card" id="fav-card-${v.vehicle_id}">
                    <img src="<%= request.getContextPath() %>/Assets/${v.vehicle_image}" alt="${v.vehicle_brand}" class="fav-img" onerror="this.src='https://placehold.co/600x400/f1f5f9/94a3b8?text=Vehicle'"/>

                    <div class="fav-info">
                      <h4>${v.vehicle_brand} ${v.vehicle_type}</h4>
                      <p>${v.vehicle_color} | ${v.vehicle_numberPlate}</p>

                      <div class="fav-price">
                        NPR 4,500 <span>/ day</span>
                      </div>

                      <div class="fav-actions">
                        <a href="<%= request.getContextPath() %>/viewVehicleDetails?id=${v.vehicle_id}" class="btn-book" ${v.vehicle_status != 'Available' ? 'style="background:#94a3b8; pointer-events:none;"' : ''}>
                          ${v.vehicle_status == 'Available' ? 'Book Now' : 'Unavailable'}
                        </a>

                        <!-- Remove button triggers the same toggle API, then removes card from screen -->
                        <button class="btn-remove" onclick="removeFavorite(${v.vehicle_id})" title="Remove from favorites">
                          <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                              <polyline points="3 6 5 6 21 6"></polyline>
                              <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                          </svg>
                        </button>
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
                <a href="<%= request.getContextPath() %>/rentalDeals" class="btn-home" style="display: inline-block; margin-top: 1rem; color: var(--accent); border-color: var(--accent);">Browse Fleet</a>
              </div>
            </c:otherwise>
          </c:choose>

        </section>
      </div>
    </main>

    <script>
      function removeFavorite(vehicleId) {
        // Re-use your working ToggleFavoriteServlet
        fetch('<%= request.getContextPath() %>/toggleFavorite', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: 'vehicleId=' + vehicleId
        })
        .then(response => response.json())
        .then(data => {
          if (data.status === 'success' && !data.isFavorited) {
            // Remove the card from the UI instantly
            const card = document.getElementById('fav-card-' + vehicleId);
            if(card) {
                card.remove();
            }

            // Check if grid is now empty
            const grid = document.querySelector('.favorites-grid');
            if (grid && grid.children.length === 0) {
                location.reload(); // Reload to show the nice empty state
            }
          }
        })
        .catch(error => console.error('Error:', error));
      }
    </script>
  </body>
</html>