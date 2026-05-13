<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" />
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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">


  </head>
  <body>
    <jsp:include page="/Pages/Includes/adminSidebar.jsp" />
    </aside>

    <main>
      <div class="search-container">
        <h2 style="font-weight: 700; color: #0f172a;">Customer Database</h2>
        <form action="${pageContext.request.contextPath}/manageCustomers" method="GET" style="display: flex; gap: 10px; width: 100%; max-width: 500px; align-items: center;">
          <input type="text" name="search" class="search-bar" placeholder="Search by name, email, username, phone..." 
                 value="${searchQuery}" style="flex: 1;" />
          <button type="submit" style="padding: 10px 20px; background: #3b82f6; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: 500;">Search</button>
          <c:if test="${not empty searchQuery}">
            <a href="${pageContext.request.contextPath}/manageCustomers" style="padding: 10px 16px; background: transparent; color: #64748b; border: 1px solid #cbd5e1; border-radius: 8px; text-decoration: none; font-weight: 500; transition: 0.2s;">✕ Clear</a>
          </c:if>
        </form>
      </div>

      <div class="content-box">
        <div class="table-responsive">
          <table>
            <thead>
              <tr>
                <th>Customer</th>
                <th>Phone Number</th>
                <th>Country</th>
                <th>Member Since</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="customer" items="${customers}">
                <tr>
                  <td>
                    <div class="user-details">
                      <strong><c:out value="${customer.fullName}" /></strong>
                      <span><c:out value="${customer.customer_email}" /></span>
                    </div>
                  </td>
                  <td><c:out value="${customer.customer_phoneNo}" /></td>
                  <td>
                    <c:choose>
                      <c:when test="${not empty customer.customer_country}">
                        <span class="country-text"><c:out value="${customer.customer_country}" /></span>
                      </c:when>
                      <c:otherwise>
                        <span class="not-provided">Not Provided</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td style="color: #64748b;"><c:out value="${customer.created_at}" /></td>
                  <td>
                    <a href="${pageContext.request.contextPath}/viewCustomer?id=${customer.customer_id}"
                       class="action-btn">View Profile</a>
                  </td>
                </tr>
              </c:forEach>

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