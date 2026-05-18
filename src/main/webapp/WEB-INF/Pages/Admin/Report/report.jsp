<%-- Admin Reports page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ page isELIgnored="false" %>
      <%-- Set active page for sidebar highlighting --%>
      <c:set var="activePage" value="reports" scope="request" />

      <!doctype html>
      <html lang="en">

      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Report/Report.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Modal.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Dashboard/Admin.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">

      </head>

      <body>
        <%-- Include admin sidebar navigation --%>
        <jsp:include page="/WEB-INF/Pages/Includes/adminSidebar.jsp" />

        <main>
          <%-- Statistics container showing fleet overview --%>
          <section class="stats-container">
            <%-- Total vehicles stat card --%>
            <div class="stat-card">
              <h3>Total Vehicles</h3>
              <div class="value">
                <c:out value="${totalVehicles}" default="0" />
              </div>
            </div>

            <%-- Rented vehicles stat card --%>
            <div class="stat-card">
              <h3>Rented Vehicles</h3>
              <div class="value">
                <c:out value="${rentedVehicles}" default="0" />
              </div>
            </div>

            <%-- Maintenance vehicles stat card --%>
            <div class="stat-card">
              <h3>In Maintenance</h3>
              <div class="value" style="color: #eab308;">
                <c:out value="${maintenanceVehicles}" default="0" />
              </div>
            </div>

            <%-- Total customers stat card --%>
            <div class="stat-card">
              <h3>Total Customers</h3>
              <div class="value">
                <c:out value="${totalCustomers}" default="0" />
              </div>
            </div>

            <%-- Total bookings stat card --%>
            <div class="stat-card">
              <h3>Total Bookings</h3>
              <div class="value">
                <c:out value="${totalBookings}" default="0" />
              </div>
            </div>
          </section>

          <%-- Dashboard grid with single column layout --%>
          <div class="dashboard-grid" style="grid-template-columns: 1fr; gap: 2rem;">

            <%-- Full bookings report section --%>
            <section class="left-col">
              <div class="content-box">
                <%-- Bookings report header --%>
                <h3>Full Bookings Report</h3>
                <p style="color: #64748b; font-size: 0.9rem; margin-bottom: 1rem;">View all historical and active
                  bookings. Generate invoices for record-keeping.</p>

                <%-- Responsive table wrapper --%>
                <div class="table-responsive">
                  <table>
                    <%-- Table header row --%>
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
                    <%-- Table body with bookings data --%>
                    <tbody>
                      <%-- Bookings loop --%>
                      <c:forEach var="b" items="${allBookingsList}">
                        <tr>
                          <%-- Booking ID column --%>
                          <td><strong>#
                              <c:out value="${b.bookingId}" />
                            </strong></td>
                          <%-- Customer name column --%>
                          <td>
                            <c:out value="${b.customerName}" />
                          </td>
                          <%-- Vehicle details column --%>
                          <td>
                            <c:out value="${b.vehicleDetails}" />
                          </td>
                          <%-- Date range column --%>
                          <td>
                            <c:out value="${b.startDate} to ${b.endDate}" />
                          </td>
                          <%-- Total amount column --%>
                          <td>NPR
                            <c:out value="${b.totalPrice}" />
                          </td>
                          <%-- Status column with dynamic color --%>
                          <td>
                            <span
                              style="font-weight: 600; color: ${b.status == 'Completed' ? '#22c55e' : (b.status == 'On Track' ? '#3b82f6' : (b.status == 'Cancelled' ? '#ef4444' : '#64748b'))};">
                              <c:out value="${b.status}" />
                            </span>
                          </td>
                          <%-- Action column with invoice button --%>
                          <td>
                            <a href="${pageContext.request.contextPath}/invoice?id=${b.bookingId}" target="_blank"
                              class="btn-invoice"
                              style="background: #f8fafc; color: #0f172a; border: 1px solid #cbd5e1; padding: 6px 12px; border-radius: 6px; text-decoration: none; font-size: 0.85rem; font-weight: 600; transition: all 0.2s;">
                              View Invoice
                            </a>
                          </td>
                        </tr>
                      </c:forEach>
                      <%-- Empty state when no bookings --%>
                      <c:if test="${empty allBookingsList}">
                        <tr>
                          <td colspan="7" style="text-align: center; color: #7f8c8d; padding: 2rem;">No bookings
                            recorded.</td>
                        </tr>
                      </c:if>
                    </tbody>
                  </table>
                </div>
              </div>
            </section>

            <%-- User contact messages section --%>
            <section class="left-col">
              <div class="content-box">
                <%-- Contact messages header --%>
                <h3>User Contact Messages</h3>
                <p style="color: #64748b; font-size: 0.9rem; margin-bottom: 1rem;">Direct inquiries and feedback sent by
                  users via the contact form.</p>

                <%-- Responsive table wrapper --%>
                <div class="table-responsive">
                  <table>
                    <%-- Table header row --%>
                    <thead>
                      <tr>
                        <th>Date</th>
                        <th>User Name</th>
                        <th>Email</th>
                        <th>Subject</th>
                        <th>Message Snippet</th>
                      </tr>
                    </thead>
                    <%-- Table body with contact messages --%>
                    <tbody>
                      <%-- Contact messages loop --%>
                      <c:forEach var="msg" items="${contactMessagesList}">
                        <tr>
                          <%-- Date column --%>
                          <td style="font-size: 0.8rem; color: #64748b; min-width: 100px;">
                            <c:out value="${msg.submittedAt}" />
                          </td>
                          <%-- User name column --%>
                          <td><strong>
                              <c:out value="${msg.firstName} ${msg.lastName}" />
                            </strong></td>
                          <%-- Email column --%>
                          <td>
                            <c:out value="${msg.email}" />
                          </td>
                          <%-- Subject column --%>
                          <td>
                            <c:out value="${msg.subject}" />
                          </td>
                          <%-- Message snippet column --%>
                          <td style="max-width: 300px; white-space: normal; font-size: 0.85rem; line-height: 1.4;">
                            <c:out value="${msg.message}" />
                          </td>
                        </tr>
                      </c:forEach>

                      <%-- Empty state when no messages --%>
                      <c:if test="${empty contactMessagesList}">
                        <tr>
                          <td colspan="5" style="text-align: center; color: #7f8c8d; padding: 2rem;">No messages
                            received from users yet.</td>
                        </tr>
                      </c:if>
                    </tbody>
                  </table>
                </div>
              </div>
            </section>
          </div>
          </section>

          <%-- Newsletter subscribers section --%>
          <section class="left-col">
            <div class="content-box">
              <%-- Subscribers header --%>
              <h3>Newsletter Subscribers</h3>
              <p style="color: #64748b; font-size: 0.9rem; margin-bottom: 1rem;">
                All emails registered via the home-page subscription form.
                Total active: <strong style="color:#22c55e;">${totalSubscribers}</strong>
              </p>

              <%-- Responsive table wrapper --%>
              <div class="table-responsive">
                <table>
                  <%-- Table header row --%>
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>Email</th>
                      <th>Subscribed At</th>
                      <th>Status</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <%-- Table body with subscribers data --%>
                  <tbody>
                    <%-- Subscribers loop --%>
                    <c:forEach var="sub" items="${subscribersList}">
                      <tr>
                        <%-- Subscriber ID column --%>
                        <td><strong>
                            <c:out value="${sub.subscriberId}" />
                          </strong></td>
                        <%-- Email column --%>
                        <td>
                          <c:out value="${sub.email}" />
                        </td>
                        <%-- Subscribed at column --%>
                        <td style="font-size: 0.8rem; color: #64748b;">
                          <c:out value="${sub.subscribedAt}" />
                        </td>
                        <%-- Status column with dynamic color --%>
                        <td>
                          <span style="font-weight: 600; color: ${sub.status == 'active' ? '#22c55e' : '#ef4444'};">
                            <c:out value="${sub.status}" />
                          </span>
                        </td>
                        <%-- Action column with activate/inactivate buttons --%>
                        <td>
                          <c:choose>
                            <%-- Inactivate button for active subscribers --%>
                            <c:when test="${sub.status == 'active'}">
                              <a href="#inactivateModal-${sub.subscriberId}" class="btn-inactivate"
                                style="text-decoration: none;">
                                Deactivate
                              </a>
                              <%-- Inactivate confirmation modal --%>
                              <div id="inactivateModal-${sub.subscriberId}" class="modal-overlay">
                                <div class="modal-content">
                                  <%-- Modal header --%>
                                  <div class="modal-header">
                                    <h3>Inactivate Subscriber</h3>
                                  </div>
                                  <%-- Modal body --%>
                                  <div class="modal-body">
                                    <p>Are you sure you want to deactivate this subscriber? They will no longer receive
                                      newsletter emails.</p>
                                  </div>
                                  <%-- Modal footer with buttons --%>
                                  <div class="modal-footer">
                                    <a href="#" class="btn-cancel" style="text-decoration: none;">Cancel</a>
                                    <form action="${pageContext.request.contextPath}/report" method="post"
                                      style="margin:0;">
                                      <input type="hidden" name="action" value="unsubscribe" />
                                      <input type="hidden" name="email" value="${sub.email}" />
                                      <button type="submit" class="btn-delete-confirm"
                                        style="border: none; cursor: pointer;">Yes, Deactivate</button>
                                    </form>
                                  </div>
                                </div>
                              </div>
                            </c:when>
                            <%-- Activate button for inactive subscribers --%>
                            <c:otherwise>
                              <a href="#activateModal-${sub.subscriberId}" class="btn-activate"
                                style="text-decoration: none;">
                                Activate
                              </a>
                              <%-- Activate confirmation modal --%>
                              <div id="activateModal-${sub.subscriberId}" class="modal-overlay">
                                <div class="modal-content">
                                  <%-- Modal header --%>
                                  <div class="modal-header">
                                    <h3>Activate Subscriber</h3>
                                  </div>
                                  <%-- Modal body --%>
                                  <div class="modal-body">
                                    <p>Are you sure you want to activate this subscriber? They will start receiving
                                      newsletter emails again.</p>
                                  </div>
                                  <%-- Modal footer with buttons --%>
                                  <div class="modal-footer">
                                    <a href="#" class="btn-cancel" style="text-decoration: none;">Cancel</a>
                                    <form action="${pageContext.request.contextPath}/report" method="post"
                                      style="margin:0;">
                                      <input type="hidden" name="action" value="reactivate" />
                                      <input type="hidden" name="email" value="${sub.email}" />
                                      <button type="submit" class="btn-activate-confirm"
                                        style="background:#22c55e; color:white; border:none; padding:10px 18px; border-radius:8px; font-weight:600; cursor:pointer;">Yes,
                                        Activate</button>
                                    </form>
                                  </div>
                                </div>
                              </div>
                            </c:otherwise>
                          </c:choose>
                        </td>
                      </tr>
                    </c:forEach>

                    <%-- Empty state when no subscribers --%>
                    <c:if test="${empty subscribersList}">
                      <tr>
                        <td colspan="5" style="text-align: center; color: #7f8c8d; padding: 2rem;">No subscribers yet.
                        </td>
                      </tr>
                    </c:if>
                  </tbody>
                </table>
              </div>
            </div>
          </section>
          </div>
          </section>
          </div>
        </main>
      </body>

      </html>