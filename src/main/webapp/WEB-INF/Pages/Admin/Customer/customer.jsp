<%-- Customer Database listing page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%-- Set active page for sidebar highlighting --%>
    <c:set var="activePage" value="customers" scope="request" />

    <!doctype html>
    <html lang="en">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>RentAll | Customers</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/Customers/Customer.css">
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Dashboard/Admin.css">
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
      <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    </head>

    <body>
      <%-- Include admin sidebar navigation --%>
      <jsp:include page="/WEB-INF/Pages/Includes/adminSidebar.jsp" />

      <main>
        <%-- Search container with title and search form --%>
        <div class="search-container">
          <h2 style="font-weight: 700; color: #0f172a;">Customer Database</h2>

          <%-- Customer search form --%>
          <form action="${pageContext.request.contextPath}/manageCustomers" method="GET" class="search-form">
            <%-- Search input field --%>
            <input type="text" name="search" class="search-bar" placeholder="Search by name, email, username, phone..."
              value="${searchQuery}" />
            <%-- Search submit button --%>
            <button type="submit" class="btn-search">Search</button>

            <%-- Clear search button shown when search query exists --%>
            <c:if test="${not empty searchQuery}">
              <a href="${pageContext.request.contextPath}/manageCustomers" class="btn-clear">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"
                  stroke-linecap="round" stroke-linejoin="round">
                  <line x1="18" y1="6" x2="6" y2="18"></line>
                  <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
                Clear
              </a>
            </c:if>
          </form>
        </div>

        <%-- Content box containing customers table --%>
        <div class="content-box">
          <%-- Responsive table wrapper --%>
          <div class="table-responsive">
            <table>
              <%-- Table header row --%>
              <thead>
                <tr>
                  <th>Customer</th>
                  <th>Phone Number</th>
                  <th>Country</th>
                  <th>Member Since</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <%-- Table body with customers data --%>
              <tbody>
                <%-- Customers loop to display each customer row --%>
                <c:forEach var="customer" items="${customers}">
                  <tr>
                    <%-- Customer details with name and email --%>
                    <td>
                      <div class="user-details">
                        <strong>
                          <c:out value="${customer.fullName}" />
                        </strong>
                        <span>
                          <c:out value="${customer.customer_email}" />
                        </span>
                      </div>
                    </td>
                    <%-- Phone number column --%>
                    <td>
                      <c:out value="${customer.customer_phoneNo}" />
                    </td>
                    <%-- Country column with fallback message --%>
                    <td>
                      <c:choose>
                        <c:when test="${not empty customer.customer_country}">
                          <span class="country-text">
                            <c:out value="${customer.customer_country}" />
                          </span>
                        </c:when>
                        <c:otherwise>
                          <span class="not-provided">Not Provided</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <%-- Member since date column --%>
                    <td style="color: #64748b;">
                      <c:out value="${customer.created_at}" />
                    </td>
                    <%-- Actions column with view profile button --%>
                    <td>
                      <a href="${pageContext.request.contextPath}/viewCustomer?id=${customer.customer_id}"
                        class="action-btn">View Profile</a>
                    </td>
                  </tr>
                </c:forEach>

                <%-- Empty state message when no customers exist --%>
                <c:if test="${empty customers}">
                  <tr>
                    <td colspan="5" style="text-align: center; padding: 50px; color: #94a3b8;">
                      No customer records found in the database.
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