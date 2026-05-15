<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
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
  <jsp:include page="/Pages/Includes/adminSidebar.jsp" />

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
                  <a href="#deleteModal-${r.reviewId}" class="btn-delete" style="text-decoration: none;">
                    Delete
                  </a>

                  <div id="deleteModal-${r.reviewId}" class="modal-overlay">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h3>Delete Review</h3>
                      </div>
                      <div class="modal-body">
                        <p>Are you sure you want to delete this customer review? This action cannot be undone.</p>
                      </div>
                      <div class="modal-footer">
                        <a href="#" class="btn-cancel" style="text-decoration: none;">Cancel</a>
                        <form action="${pageContext.request.contextPath}/deleteReview" method="POST" style="margin: 0; display: inline-block;">
                          <input type="hidden" name="reviewId" value="${r.reviewId}">
                          <button type="submit" class="btn-delete-confirm" style="border: none; cursor: pointer;">Yes, Delete</button>
                        </form>
                      </div>
                    </div>
                  </div>
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