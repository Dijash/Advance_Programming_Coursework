<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" />
<c:set var="activePage" value="customers" scope="request" />
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/Customers/ViewCustomer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
    <title>RentAll | View Customer</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  </head>
  <body>
    <jsp:include page="/Pages/Includes/adminSidebar.jsp" />

    <main>
      <div class="page-container">
        <div class="page-header">
          <h2>Customer Details</h2>
          <a href="${pageContext.request.contextPath}/manageCustomers" class="btn-back">Back to Database</a>
        </div>

        <div class="content-box">
          <div class="profile-top">
            <div class="avatar-circle">
               ${customer.first_name.substring(0,1)}${customer.last_name.substring(0,1)}
            </div>
            <div class="user-info-main">
              <h1><c:out value="${customer.fullName}" /></h1>
              <p>User ID: <strong>#${customer.customer_id}</strong> | <span class="username-badge">@${customer.customer_username}</span></p>
            </div>

            <a href="#deleteModal" class="delete-btn" style="text-decoration: none;">Delete Account</a>
          </div>

          <div class="detail-grid">
            <div class="detail-card">
              <span class="label">Gender</span>
              <div class="value">${customer.gender}</div>
            </div>

            <div class="detail-card">
              <span class="label">Email Address</span>
              <div class="value">${customer.customer_email}</div>
            </div>

            <div class="detail-card">
              <span class="label">Phone Number</span>
              <div class="value">${customer.customer_phoneNo}</div>
            </div>

            <div class="detail-card">
              <span class="label">Date of Birth</span>
              <div class="value">${customer.customer_dob}</div>
            </div>

            <div class="detail-card">
              <span class="label">Full Address</span>
              <div class="value">${customer.customer_address}, ${customer.customer_country}</div>
            </div>

            <div class="detail-card">
              <span class="label">License Number</span>
              <div class="value">${customer.customer_license}</div>
            </div>

            <div class="detail-card">
              <span class="label">Registration Date</span>
              <div class="value">${customer.created_at}</div>
            </div>

            <div class="detail-card">
              <span class="label">Referral Code</span>
              <div class="value" style="color: #10b981; font-weight: 700;">${customer.referral_code}</div>
            </div>
          </div>
        </div>
      </div>
    </main>

    <div id="deleteModal" class="modal-overlay">
      <div class="modal-content">
        <div class="modal-header">
          <h3>Delete Customer</h3>
        </div>
        <div class="modal-body">
          <p>Are you sure you want to permanently delete this customer? This action cannot be undone.</p>
        </div>
        <div class="modal-footer">
          <a href="#" class="btn-cancel" style="text-decoration: none;">Cancel</a>

          <form action="${pageContext.request.contextPath}/deleteCustomer" method="POST" style="margin: 0; display: inline-block;">
            <input type="hidden" name="customer_id" value="${customer.customer_id}">
            <button type="submit" class="btn-delete-confirm" style="border: none; cursor: pointer;">Yes, Delete</button>
          </form>
        </div>
      </div>
    </div>
  </body>
</html>