<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<c:set var="activePage" value="reports" scope="request" />

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Report/Report.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Dashboard/Admin.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">

  </head>
  <body>
    <jsp:include page="/Pages/Includes/adminSidebar.jsp" />

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

      <div class="dashboard-grid" style="grid-template-columns: 1fr; gap: 2rem;">

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
                      <td><strong>#<c:out value="${b.bookingId}" /></strong></td>
                      <td><c:out value="${b.customerName}" /></td>
                      <td><c:out value="${b.vehicleDetails}" /></td>
                      <td><c:out value="${b.startDate} to ${b.endDate}" /></td>
                      <td>NPR <c:out value="${b.totalPrice}" /></td>
                      <td>
                        <span style="font-weight: 600; color: ${b.status == 'Completed' ? '#22c55e' : (b.status == 'On Track' ? '#3b82f6' : (b.status == 'Cancelled' ? '#ef4444' : '#64748b'))};">
                          <c:out value="${b.status}" />
                        </span>
                      </td>
                      <td>
                        <a href="${pageContext.request.contextPath}/invoice?id=${b.bookingId}" target="_blank" class="btn-invoice" style="background: #f8fafc; color: #0f172a; border: 1px solid #cbd5e1; padding: 6px 12px; border-radius: 6px; text-decoration: none; font-size: 0.85rem; font-weight: 600; transition: all 0.2s;">
                          View Invoice
                        </a>
                      </td>
                    </tr>
                  </c:forEach>
                  <c:if test="${empty allBookingsList}">
                    <tr><td colspan="7" style="text-align: center; color: #7f8c8d; padding: 2rem;">No bookings recorded.</td></tr>
                  </c:if>
                </tbody>
              </table>
            </div>
          </div>
        </section>

        <section class="left-col">
          <div class="content-box">
            <h3>User Contact Messages</h3>
            <p style="color: #64748b; font-size: 0.9rem; margin-bottom: 1rem;">Direct inquiries and feedback sent by users via the contact form.</p>

            <div class="table-responsive">
              <table>
                <thead>
                  <tr>
                    <th>Date</th>
                    <th>User Name</th>
                    <th>Email</th>
                    <th>Subject</th>
                    <th>Message Snippet</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="msg" items="${contactMessagesList}">
                    <tr>
                      <td style="font-size: 0.8rem; color: #64748b; min-width: 100px;">
                        <c:out value="${msg.submittedAt}" />
                      </td>
                      <td><strong><c:out value="${msg.firstName} ${msg.lastName}" /></strong></td>
                      <td><c:out value="${msg.email}" /></td>
                      <td><c:out value="${msg.subject}" /></td>
                      <td style="max-width: 300px; white-space: normal; font-size: 0.85rem; line-height: 1.4;">
                        <c:out value="${msg.message}" />
                      </td>
                    </tr>
                  </c:forEach>

                  <c:if test="${empty contactMessagesList}">
                    <tr>
                      <td colspan="5" style="text-align: center; color: #7f8c8d; padding: 2rem;">No messages received from users yet.</td>
                    </tr>
                  </c:if>
                </tbody>
              </table>
            </div>
          </div>
        </section>
      </div>
    </section>
     <section class="left-col">
              <div class="content-box">
                <h3>Newsletter Subscribers</h3>
                <p style="color: #64748b; font-size: 0.9rem; margin-bottom: 1rem;">
                  All emails registered via the home-page subscription form.
                  Total active: <strong style="color:#22c55e;">${totalSubscribers}</strong>
                </p>

                <div class="table-responsive">
                  <table>
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>Email</th>
                        <th>Subscribed At</th>
                        <th>Status</th>
                        <th>Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="sub" items="${subscribersList}">
                        <tr>
                          <td><strong><c:out value="${sub.subscriberId}" /></strong></td>
                          <td><c:out value="${sub.email}" /></td>
                          <td style="font-size: 0.8rem; color: #64748b;">
                            <c:out value="${sub.subscribedAt}" />
                          </td>
                          <td>
                            <span style="font-weight: 600; color: ${sub.status == 'active' ? '#22c55e' : '#ef4444'};">
                              <c:out value="${sub.status}" />
                            </span>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${sub.status == 'active'}">
                                <form action="${pageContext.request.contextPath}/report"
                                      method="post" style="margin:0;">
                                  <input type="hidden" name="action" value="unsubscribe" />
                                  <input type="hidden" name="email" value="${sub.email}" />
                                  <button type="submit"
                                          style="background:#fee2e2; color:#dc2626; border:1px solid #fca5a5;
                                                 padding:5px 12px; border-radius:6px; font-size:0.82rem;
                                                 font-weight:600; cursor:pointer;">
                                    Inactivate
                                  </button>
                                </form>
                              </c:when>
                              <c:otherwise>
                                <span style="color:#94a3b8; font-size:0.82rem;">Inactive</span>
                              </c:otherwise>
                            </c:choose>
                          </td>
                        </tr>
                      </c:forEach>

                      <c:if test="${empty subscribersList}">
                        <tr>
                          <td colspan="5" style="text-align: center; color: #7f8c8d; padding: 2rem;">No subscribers yet.</td>
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