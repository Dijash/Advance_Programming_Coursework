<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
  <c:set var="activePage" value="vehicles" scope="request" />
    <!doctype html>
    <html lang="en">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/Vehicle/viewVehicle.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
      <title>RentAll | Vehicle Details</title>
      <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">

    </head>

    <body>
      <jsp:include page="/Pages/Includes/adminSidebar.jsp" />
        <a href="${pageContext.request.contextPath}/logout" class="logout"><span>Logout</span></a>
      </aside>

      <main>
        <div class="page-container">
          <div class="page-header">
            <h2>Vehicle Profile</h2>
            <div class="btn-group">
              <a href="${pageContext.request.contextPath}/manageVehicles" class="btn btn-secondary">Back to Fleet</a>
              <a href="${pageContext.request.contextPath}/editVehicle?id=${vehicle.vehicle_id}"
                class="btn btn-primary">Edit Details</a>
            </div>
          </div>

          <div class="content-box">
            <div class="vehicle-hero"
              style="background-image: linear-gradient(to bottom, transparent, rgba(0,0,0,0.3)), url('${pageContext.request.contextPath}/Assets/${vehicle.vehicle_image}');">
              <span class="status-badge">
                <c:out value="${vehicle.vehicle_status}" default="Unknown Status" />
              </span>
            </div>

            <div class="detail-grid">
              <div class="detail-card">
                <span class="label">Brand & Model</span>
                <div class="value">
                  <c:out value="${vehicle.vehicle_brand}" default="N/A" />
                </div>
              </div>

              <div class="detail-card">
                <span class="label">Vehicle Category</span>
                <div class="value">
                  <c:out value="${vehicle.vehicle_type}" default="N/A" />
                </div>
              </div>

              <div class="detail-card">
                <span class="label">Exterior Color</span>
                <div class="value" style="text-transform: capitalize;">
                  <c:out value="${vehicle.vehicle_color}" default="N/A" />
                </div>
              </div>

              <div class="detail-card">
                <span class="label">License Number Plate</span>
                <div class="value">
                  <c:out value="${vehicle.vehicle_numberPlate}" default="N/A" />
                </div>
              </div>

              <div class="detail-card">
                <span class="label">Mechanical Condition</span>
                <div class="value">
                  <c:out value="${vehicle.vehicle_condition}" default="N/A" />
                </div>
              </div>

              <div class="detail-card">
                <span class="label">Availability Status</span>
                <div class="value">
                  <c:out value="${vehicle.vehicle_status}" default="N/A" />
                </div>
              </div>

              <div class="detail-card" style="background-color: #f8fafc; border: 1px solid #e2e8f0;">
                <span class="label">Rental Price / Day</span>
                <div class="value" style="color: #2c3e50; font-weight: 700;">
                  NPR
                  <c:out value="${vehicle.vehicle_price}" default="0.0" />
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>
    </body>

    </html>