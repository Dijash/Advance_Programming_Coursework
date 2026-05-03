<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | System Reports</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/Admin/Dashboard/Admin.css">
    <style>
      /* Minor inline styles for report specific buttons */
      .btn-invoice {
        background-color: #3b82f6;
        color: white;
        padding: 6px 12px;
        border-radius: 6px;
        text-decoration: none;
        font-size: 0.85rem;
        font-weight: 600;
        transition: background-color 0.2s;
      }
      .btn-invoice:hover {
        background-color: #2563eb;
      }
    </style>
  </head>
  <body>
    <input type="checkbox" id="menu-toggle" style="display:none;" />
    <label for="menu-toggle" class="menu-btn" style="display:none;">MENU</label>

    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li><a href="<%= request.getContextPath() %>/admin"><span>Dashboard</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageBooking"><span>Bookings</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageVehicles"><span>Manage Vehicles</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageCustomers"><span>Customers</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageReviews"><span>Reviews</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageNotification"><span>Notifications</span></a></li>
          <!-- Active class moved to Reports -->
          <li><a href="<%= request.getContextPath() %>/report" class="active"><span>Reports</span></a></li>
        </ul>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout"><span>Logout</span></a>
    </aside>

    <main>
      <!-- Top Statistics Row -->
      <section class="stats-container">
        <div class="stat-card">
          <h3>Total Vehicles</h3>
          <div class="value"><c:out value="${totalVehicles}" default="0" /></div>
        </div>

        <div class="stat-card">
          <h3>Rented Vehicles</h3>
          <div class="value"><c:out value="${rentedVehicles}" default="0" /></div>
        </div>

        <div class="stat-card">
          <h3>In Maintenance</h3>
          <div class="value" style="color: #eab308;"><c:out value="${maintenanceVehicles}" default="0" /></div>
        </div>

        <div class="stat-card">
          <h3>Total Customers</h3>
          <div class="value"><c:out value="${totalCustomers}" default="0" /></div>
        </div>

        <div class="stat-card">
          <h3>Total Bookings</h3>
          <div class="value"><c:out value="${totalBookings}" default="0" /></div>
        </div>
      </section>

      <!-- Bookings Report Table -->
      <div class="dashboard-grid" style="grid-template-columns: 1fr;">
        <section class="left-col">
          <div class="content-box">
            <h3>Full Bookings Report</h3>
            <p style="color: #64748b; font-size: 0.9rem; margin-bottom: 1rem;">View all historical and active bookings. Generate invoices for record-keeping.</p>

            <div class="table-responsive">
              <table>
                <thead>
                  <tr>
                    <th>Booking ID</th>
                    <th>Customer Name</th>
                    <th>Vehicle Details</th>
                    <th>Date Range</th>
                    <th>Total Amount</th>
                    <th>Status</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="b" items="${allBookingsList}">
                    <tr>
                      <!-- These now perfectly match your Booking.java getters -->
                      <td><strong>#<c:out value="${b.bookingId}" /></strong></td>
                      <td><c:out value="${b.customerName}" /></td>
                      <td><c:out value="${b.vehicleDetails}" /></td>
                      <td><c:out value="${b.startDate} to ${b.endDate}" /></td>
                      <td>NPR <c:out value="${b.totalPrice}" /></td>
                      <td>
                        <!-- UPDATED NESTED TERNARY OPERATOR FOR COLORS -->
                        <span style="font-weight: 600; color: ${b.status == 'Completed' ? '#22c55e' : (b.status == 'On Track' ? '#3b82f6' : (b.status == 'Cancelled' ? '#ef4444' : '#64748b'))};">
                          <c:out value="${b.status}" />
                        </span>
                      </td>
                      <td>
                        <a href="<%= request.getContextPath() %>/invoice?id=${b.bookingId}" target="_blank" class="btn-invoice">View / PDF</a>
                      </td>
                    </tr>
                  </c:forEach>

                  <c:if test="${empty allBookingsList}">
                     <tr>
                        <td colspan="7" style="text-align: center; color: #7f8c8d; padding: 2rem;">No bookings recorded in the system yet.</td>
                     </tr>
                  </c:if>
                </tbody>
              </table>
            </div>
          </div>
        </section>
      </div>
    </main>
  </body>
</html>