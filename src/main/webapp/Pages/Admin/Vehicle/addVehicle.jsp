<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Add Vehicle</title>

  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li><a href="${pageContext.request.contextPath}/admin"><span>Dashboard</span></a></li>
          <li><a href="${pageContext.request.contextPath}/manageBooking"><span>Bookings</span></a></li>
          <li><a href="${pageContext.request.contextPath}/manageVehicles" class="active"><span>Manage Vehicles</span></a></li>
          <li><a href="${pageContext.request.contextPath}/manageCustomers"><span>Customers</span></a></li>
          <li><a href="${pageContext.request.contextPath}/manageReviews"><span>Reviews</span></a></li>
          <li><a href="${pageContext.request.contextPath}/manageNotification"><span>Notifications</span></a></li>
          <li><a href="${pageContext.request.contextPath}/report"><span>Reports</span></a></li>

        </ul>
      </nav>
      <a href="${pageContext.request.contextPath}/logout" class="logout"><span>Logout</span></a>
    </aside>

    <main>
      <div class="page-header">
        <h2>Add New Vehicle</h2>
        <a href="${pageContext.request.contextPath}/manageVehicles" class="btn-secondary">Back to Fleet</a>
      </div>

      <div class="content-box">
        <form action="${pageContext.request.contextPath}/addVehicleData" method="POST" enctype="multipart/form-data">

          <div class="form-grid">
            <div class="form-group">
              <label for="vehicle_brand">Vehicle Brand & Model</label>
              <input type="text" id="vehicle_brand" name="vehicle_brand" class="form-control" placeholder="e.g. Alto 800" required>
            </div>

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

            <div class="form-group">
              <label for="vehicle_color">Vehicle Color</label>
              <input type="text" id="vehicle_color" name="vehicle_color" class="form-control" placeholder="e.g. Matte Black" required>
            </div>

            <div class="form-group">
              <label for="vehicle_numberPlate">Number Plate</label>
              <input type="text" id="vehicle_numberPlate" name="vehicle_numberPlate" class="form-control" placeholder=" Bagmati 01-001-Pa 1234" required>
            </div>

            <div class="form-group">
              <label for="vehicle_condition">Vehicle Condition</label>
              <select id="vehicle_condition" name="vehicle_condition" class="form-control" required>
                <option value="Excellent">Excellent</option>
                <option value="Good">Good</option>
                <option value="Fair">Fair</option>
                <option value="Needs Servicing">Needs Servicing</option>
              </select>
            </div>

            <div class="form-group">
              <label for="vehicle_status">Initial Status</label>
              <select id="vehicle_status" name="vehicle_status" class="form-control" required>
                <option value="Available">Available</option>
                <option value="Maintenance">Maintenance</option>
              </select>
            </div>

            <div class="form-group full-width">
              <label for="vehicle_image">Vehicle Photo</label>
              <input type="file" id="vehicle_image" name="vehicle_image" class="form-control" accept="image/png, image/jpeg, image/jpg" style="padding: 10px 16px; cursor: pointer;">
              <small style="color: var(--text-muted); display: block; margin-top: 6px;">Accepted formats: JPG, PNG. Max size: 10MB. (Optional: defaults to standard image if left blank).</small>
            </div>
          </div>

          <div class="form-group full-width" style="margin-top: 20px;">
            <button type="submit" class="btn-primary">Save Vehicle to Fleet</button>
          </div>

        </form>
      </div>
    </main>
  </body>
</html>