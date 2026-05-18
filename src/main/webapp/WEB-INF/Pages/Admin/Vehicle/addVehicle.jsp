<%-- Add New Vehicle page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- Set active page for sidebar highlighting --%>
<c:set var="activePage" value="vehicles" scope="request" />
<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/Vehicle/addVehicle.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
  <title>RentAll | Add Vehicle</title>
</head>

<body>
  <%-- Include admin sidebar navigation --%>
  <jsp:include page="/WEB-INF/Pages/Includes/adminSidebar.jsp" />

  <main>
    <%-- Page header with title and back button --%>
    <div class="page-header">
      <h2>Add New Vehicle</h2>
      <a href="${pageContext.request.contextPath}/manageVehicles" class="btn-secondary">Back to Fleet</a>
    </div>

    <%-- Content box containing vehicle add form --%>
    <div class="content-box">

      <%-- ADDED class 'vehicle-form' for CSS targeting --%>
      <form class="vehicle-form" action="${pageContext.request.contextPath}/addVehicleData" method="POST" enctype="multipart/form-data">

        <%-- PURE CSS HACK: Hidden checkbox to trigger the modal --%>
        <input type="checkbox" id="validation-modal-toggle" class="hidden-checkbox">

        <%-- Form grid layout --%>
        <div class="form-grid">
          <%-- Vehicle brand and model input --%>
          <div class="form-group">
            <label for="vehicle_brand">Vehicle Brand & Model</label>
            <%-- ADDED 'required' attribute here --%>
            <input type="text" id="vehicle_brand" name="vehicle_brand" class="form-control"
              placeholder="e.g. Alto 800" required>
          </div>

          <%-- Vehicle type/category select --%>
          <div class="form-group">
            <label for="vehicle_type">Vehicle Type / Category</label>
            <select id="vehicle_type" name="vehicle_type" class="form-control" required>
              <option value="" disabled selected>Select Category</option>
              <option value="SUV">SUV</option>
              <option value="Sedan">Sedan</option>
              <option value="Hatchback">Hatchback</option>
              <option value="Two-Wheeler">Two-Wheeler</option>
              <option value="Electric">Electric (EV)</option>
              <option value="Luxury">Luxury / Premium</option>
            </select>
          </div>

          <%-- Vehicle color input --%>
          <div class="form-group">
            <label for="vehicle_color">Vehicle Color</label>
            <input type="text" id="vehicle_color" name="vehicle_color" class="form-control"
              placeholder="e.g. Matte Black" required>
          </div>

          <%-- Number plate input --%>
          <div class="form-group">
            <label for="vehicle_numberPlate">Number Plate</label>
            <input type="text" id="vehicle_numberPlate" name="vehicle_numberPlate" class="form-control"
              placeholder="Bagmati 01-001-Pa 1234" required>
          </div>

          <%-- Vehicle condition select --%>
          <div class="form-group">
            <label for="vehicle_condition">Vehicle Condition</label>
            <select id="vehicle_condition" name="vehicle_condition" class="form-control" required>
              <option value="Excellent">Excellent</option>
              <option value="Good">Good</option>
              <option value="Fair">Fair</option>
              <option value="Needs Servicing">Needs Servicing</option>
            </select>
          </div>

          <%-- Initial status select --%>
          <div class="form-group">
            <label for="vehicle_status">Initial Status</label>
            <select id="vehicle_status" name="vehicle_status" class="form-control" required>
              <option value="Available">Available</option>
              <option value="Maintenance">Maintenance</option>
            </select>
          </div>

          <%-- Rental price input --%>
          <div class="form-group">
            <label for="vehicle_price">Rental Price / Day (NPR)</label>
            <input type="number" id="vehicle_price" name="vehicle_price" class="form-control"
              placeholder="e.g. 4500" step="0.01" min="0" required>
          </div>

          <%-- Vehicle image file upload (full width) --%>
          <div class="form-group full-width">
            <label for="vehicle_image">Vehicle Photo</label>
            <input type="file" id="vehicle_image" name="vehicle_image" class="form-control"
              accept="image/png, image/jpeg, image/jpg" style="padding: 10px 16px; cursor: pointer;">
            <small style="color: var(--text-muted); display: block; margin-top: 6px;">Accepted formats: JPG, PNG.
              Max size: 10MB. (Optional: defaults to standard image if left blank).</small>
          </div>
        </div>

        <%-- Submit Wrapper --%>
        <div class="form-group full-width submit-wrapper" style="margin-top: 20px;">
          <%-- Real Button: Works only when form is valid --%>
          <button type="submit" class="btn-primary real-submit">Save Vehicle to Fleet</button>

          <%-- Fake Button: Sits on top and triggers modal if form is invalid --%>
          <label for="validation-modal-toggle" class="btn-primary fake-submit">Save Vehicle to Fleet</label>
        </div>

        <%-- PURE CSS MODAL  --%>
        <div class="modal-overlay">
          <div class="modal-content">
            <div class="modal-header">
              <h3 style="color: #e74c3c;">Incomplete Vehicle Details</h3>
            </div>
            <div class="modal-body">
              <p>Please fill in all the required fields before saving the vehicle to the fleet.</p>
            </div>
            <div class="modal-footer">
              <%-- Clicking this label unchecks the hidden box, closing the modal --%>
              <label for="validation-modal-toggle" class="btn-cancel" style="display: inline-block; text-decoration: none; text-align: center;">Try Again</label>
            </div>
          </div>
        </div>

      </form>
    </div>
  </main>
</body>

</html>