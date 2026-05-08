<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

          <!doctype html>
          <html lang="en">

          <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>RentAll | Reviews</title>
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Dashboard/Admin.css">
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
              rel="stylesheet">

          </head>

          <body>
            <input type="checkbox" id="menu-toggle" style="display:none;" />
            <label for="menu-toggle" class="menu-btn" style="display:none;">MENU</label>

            <%-- Consistent Sidebar --%>
              <aside class="sidebar">
                <h2>RentAll</h2>
                <nav>
                  <ul>
                    <li><a href="${pageContext.request.contextPath}/admin"><span>Dashboard</span></a></li>
                    <li><a href="${pageContext.request.contextPath}/manageBooking"><span>Bookings</span></a></li>
                    <li><a href="${pageContext.request.contextPath}/manageVehicles"><span>Manage Vehicles</span></a></li>
                    <li><a href="${pageContext.request.contextPath}/manageCustomers"><span>Customers</span></a></li>
                    <li><a href="${pageContext.request.contextPath}/manageReviews" class="active"><span>Reviews</span></a>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/manageNotification"><span>Notifications</span></a></li>
                    <li><a href="${pageContext.request.contextPath}/report"><span>Reports</span></a></li>

                  </ul>
                </nav>
                <a href="${pageContext.request.contextPath}/logout" class="logout"><span>Logout</span></a>
              </aside>

              <main>
                <div class="page-header">
                  <h2>Customer Feedback</h2>
                </div>

                <div class="content-box">
                  <div class="table-responsive">
                    <table>
                      <thead>
                        <tr>
                          <th>Customer</th>
                          <th>Comment</th>
                          <th>Date Posted</th>
                          <th>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="r" items="${reviews}">
                          <tr>
                            <td>
                              <span class="customer-name">
                                <%-- Matches getCustomerName() in your Review class --%>
                                <c:out value="${r.customerName}" />
                              </span>
                              <span class="review-date">ID: #<c:out value="${r.reviewId}" /></span>
                            </td>
                            <td>
                              <div class="review-desc">
                                <%-- Matches getReviewDescription() --%>
                                "<c:out value="${r.reviewDescription}" />"
                              </div>
                            </td>
                            <td>
                              <%-- Matches getReviewDate() --%>
                              <c:out value="${r.reviewDate}" />
                            </td>
                            <td>
                              <form action="${pageContext.request.contextPath}/deleteReview" method="POST" style="display:inline;">
                                <input type="hidden" name="reviewId" value="${r.reviewId}">
                                <button type="submit" class="btn-delete" onclick="return confirm('Delete this review?');">
                                  Delete
                                </button>
                              </form>
                            </td>
                          </tr>
                        </c:forEach>

                        <c:if test="${empty reviews}">
                          <tr>
                            <td colspan="4" style="text-align: center; padding: 40px; color: #64748b;">
                              No reviews found in the database.
                            </td>
                          </tr>
                        </c:if>
                      </tbody>
                    </table>
                  </div>
                </div>
              </main>
          </body>

          </html>