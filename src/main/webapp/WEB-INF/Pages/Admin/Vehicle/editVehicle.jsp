<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
  <c:set var="activePage" value="vehicles" scope="request" />
    <!doctype html>
    <html lang="en">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/Vehicle/editVehicle.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
      <title>RentAll | Edit Vehicle</title>

    </head>

    <body>
      <jsp:include page="/WEB-INF/Pages/Includes/adminSidebar.jsp" />
        <a href="${pageContext.request.contextPath}/logout" class="logout"><span>Logout</span></a>
      </aside>

      <main>
        <div class="page-header">
          <h2>Edit Vehicle</h2>
          <a href="${pageContext.request.contextPath}/manageVehicles" class="btn-secondary">Cancel</a>
        </div>

        <div class="content-box">
          <form action="${pageContext.request.contextPath}/updateVehicle" method="POST" enctype="multipart/form-data">

            <input type="hidden" name="vehicle_id" value="${vehicle.vehicle_id}">
            <input type="hidden" name="existing_image" value="${vehicle.vehicle_image}">

            <div class="form-grid">
              <div class="form-group">
                <label for="vehicle_brand">Vehicle Brand & Model</label>
                <input type="text" id="vehicle_brand" name="vehicle_brand" class="form-control"
                  value="<c:out value='${vehicle.vehicle_brand}'/>" required>
              </div>

              <div class="form-group">
                <label for="vehicle_type">Vehicle Type / Category</label>
                <select id="vehicle_type" name="vehicle_type" class="form-control" required>
                  <option value="SUV" ${vehicle.vehicle_type=='SUV' ? 'selected' : '' }>SUV</option>
                  <option value="Sedan" ${vehicle.vehicle_type=='Sedan' ? 'selected' : '' }>Sedan</option>
                  <option value="Hatchback" ${vehicle.vehicle_type=='Hatchback' ? 'selected' : '' }>Hatchback</option>
                  <option value="Two-Wheeler" ${vehicle.vehicle_type=='Two-Wheeler' ? 'selected' : '' }>Two-Wheeler
                  </option>
                  <option value="Electric" ${vehicle.vehicle_type=='Electric' ? 'selected' : '' }>Electric (EV)</option>
                  <option value="Luxury" ${vehicle.vehicle_type=='Luxury' ? 'selected' : '' }>Luxury / Premium</option>
                </select>
              </div>

              <div class="form-group">
                <label for="vehicle_color">Vehicle Color</label>
                <input type="text" id="vehicle_color" name="vehicle_color" class="form-control"
                  value="<c:out value='${vehicle.vehicle_color}'/>" required>
              </div>

              <div class="form-group">
                <label for="vehicle_numberPlate">Number Plate</label>
                <input type="text" id="vehicle_numberPlate" name="vehicle_numberPlate" class="form-control"
                  value="<c:out value='${vehicle.vehicle_numberPlate}'/>" required>
              </div>

              <div class="form-group">
                <label for="vehicle_condition">Vehicle Condition</label>
                <select id="vehicle_condition" name="vehicle_condition" class="form-control" required>
                  <option value="Excellent" ${vehicle.vehicle_condition=='Excellent' ? 'selected' : '' }>Excellent
                  </option>
                  <option value="Good" ${vehicle.vehicle_condition=='Good' ? 'selected' : '' }>Good</option>
                  <option value="Fair" ${vehicle.vehicle_condition=='Fair' ? 'selected' : '' }>Fair</option>
                  <option value="Needs Servicing" ${vehicle.vehicle_condition=='Needs Servicing' ? 'selected' : '' }>
                    Needs Servicing</option>
                </select>
              </div>

              <div class="form-group">
                <label for="vehicle_status">Current Status</label>
                <select id="vehicle_status" name="vehicle_status" class="form-control" required>
                  <option value="Available" ${vehicle.vehicle_status=='Available' ? 'selected' : '' }>Available</option>
                  <option value="Maintenance" ${vehicle.vehicle_status=='Maintenance' ? 'selected' : '' }>Maintenance
                  </option>
                </select>
              </div>

              <div class="form-group">
                <label for="vehicle_price">Rental Price / Day (NPR)</label>
                <input type="number" id="vehicle_price" name="vehicle_price" class="form-control"
                  value="<c:out value='${vehicle.vehicle_price}'/>" step="0.01" min="0" required>
              </div>

              <div class="form-group full-width">
                <label for="vehicle_image">Update Vehicle Photo (Optional)</label>
                <input type="file" id="vehicle_image" name="vehicle_image" class="form-control"
                  accept="image/png, image/jpeg, image/jpg" style="padding: 10px 16px; cursor: pointer;">
                <small style="color: var(--text-muted); display: block; margin-top: 6px;">Accepted formats: JPG, PNG.
                  Max size: 10MB. Leave blank to keep current photo.</small>
              </div>
            </div>

            <div class="form-group full-width">
              <button type="submit" class="btn-primary">Update Details</button>
            </div>

          </form>
        </div>
      </main>
    </body>

  </html>