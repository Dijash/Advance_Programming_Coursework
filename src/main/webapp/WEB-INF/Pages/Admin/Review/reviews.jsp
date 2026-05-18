<%-- Customer Reviews management page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
      <%-- Set active page for sidebar highlighting --%>
      <c:set var="activePage" value="reviews" scope="request" />

      <!doctype html>
      <html lang="en">

      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Review/review.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Modal.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Dashboard/Admin.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">
      </head>

      <body>
        <%-- Include admin sidebar navigation --%>
        <jsp:include page="/WEB-INF/Pages/Includes/adminSidebar.jsp" />

        <main>
          <%-- Page header with title --%>
          <div class="page-header">
            <h2>Customer Feedback</h2>
          </div>

          <%-- Content box containing reviews table --%>
          <div class="content-box">
            <%-- Responsive table wrapper --%>
            <div class="table-responsive">
              <table>
                <%-- Table header row --%>
                <thead>
                  <tr>
                    <th>Customer</th>
                    <th>Comment</th>
                    <th>Date Posted</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <%-- Table body with reviews data --%>
                <tbody>
                  <%-- Reviews loop --%>
                  <c:forEach var="r" items="${reviews}">
                    <tr>
                      <%-- Customer name and ID column --%>
                      <td>
                        <span class="customer-name">
                          <c:out value="${r.customerName}" />
                        </span>
                        <span class="review-date">ID: #
                          <c:out value="${r.reviewId}" />
                        </span>
                      </td>
                      <%-- Review comment column --%>
                      <td>
                        <div class="review-desc">
                          "
                          <c:out value="${r.reviewDescription}" />"
                        </div>
                      </td>
                      <%-- Review date column --%>
                      <td>
                        <c:out value="${r.reviewDate}" />
                      </td>
                      <%-- Actions column with delete button --%>
                      <td>
                        <%-- Delete review button --%>
                        <a href="#deleteModal-${r.reviewId}" class="btn-delete" style="text-decoration: none;">
                          Delete
                        </a>

                        <%-- Delete confirmation modal --%>
                        <div id="deleteModal-${r.reviewId}" class="modal-overlay">
                          <div class="modal-content">
                            <%-- Modal header --%>
                            <div class="modal-header">
                              <h3>Delete Review</h3>
                            </div>
                            <%-- Modal body with warning --%>
                            <div class="modal-body">
                              <p>Are you sure you want to delete this customer review? This action cannot be undone.</p>
                            </div>
                            <%-- Modal footer with buttons --%>
                            <div class="modal-footer">
                              <%-- Cancel button --%>
                              <a href="#" class="btn-cancel" style="text-decoration: none;">Cancel</a>
                              <%-- Confirm delete form --%>
                              <form action="${pageContext.request.contextPath}/deleteReview" method="POST"
                                style="margin: 0; display: inline-block;">
                                <input type="hidden" name="reviewId" value="${r.reviewId}">
                                <button type="submit" class="btn-delete-confirm"
                                  style="border: none; cursor: pointer;">Yes, Delete</button>
                              </form>
                            </div>
                          </div>
                        </div>
                      </td>
                    </tr>
                  </c:forEach>

                  <%-- Empty state when no reviews --%>
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