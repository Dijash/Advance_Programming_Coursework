<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/Vehicle/manageVehicle.css">
  <title>RentAll | Manage Vehicles</title>
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
      <h2>Fleet Management</h2>
      <a href="${pageContext.request.contextPath}/addVehicle" class="btn-primary">+ Add Vehicle</a>
    </div>

    <div class="content-box">
      <c:if test="${not empty sessionScope.errorMsg}">
        <div class="alert alert-error">
          <c:out value="${sessionScope.errorMsg}" />
          <c:remove var="errorMsg" scope="session" />
        </div>
      </c:if>

      <c:if test="${not empty sessionScope.successMsg}">
        <div class="alert alert-success">
          <c:out value="${sessionScope.successMsg}" />
          <c:remove var="successMsg" scope="session" />
        </div>
      </c:if>

      <div class="table-responsive">
        <table>
          <thead>
            <tr>
              <th>Image</th>
              <th>Brand</th>
              <th>Type</th>
              <th>Color</th>
              <th>Number Plate</th>
              <th>Condition</th>
              <th>Status</th>
              <th>Price/Day</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="car" items="${vehicles}">
              <tr>
                <td>
                  <div class="vehicle-thumb" style="background-image: url('${pageContext.request.contextPath}/Assets/${car.vehicle_image}')">
                  </div>
                </td>
                <td><strong><c:out value="${car.vehicle_brand}" /></strong></td>
                <td><c:out value="${car.vehicle_type}" /></td>
                <td style="text-transform: capitalize;"><c:out value="${car.vehicle_color}" /></td>
                <td><c:out value="${car.vehicle_numberPlate}" /></td>
                <td><c:out value="${car.vehicle_condition}" /></td>

                <td style="font-weight: 600; color:
                          <c:choose>
                              <c:when test="${car.vehicle_status == 'Available'}">#27ae60</c:when>
                              <c:when test="${car.vehicle_status == 'Maintenance'}">#f39c12</c:when>
                              <c:otherwise>#e74c3c</c:otherwise>
                          </c:choose>;">
                  <c:out value="${car.vehicle_status}" />
                </td>

                <td style="font-weight: bold; color: #2c3e50;">
                  NPR <c:out value="${car.vehicle_price}" />
                </td>

                <td>
                  <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/viewVehicle?id=${car.vehicle_id}" class="action-btn action-btn-view">View</a>
                    <a href="${pageContext.request.contextPath}/editVehicle?id=${car.vehicle_id}" class="action-btn action-btn-edit">Edit</a>

                    <button type="button" class="action-btn action-btn-delete" onclick="openModal('${car.vehicle_id}')">Delete</button>
                  </div>
                </td>
              </tr>
            </c:forEach>

            <c:if test="${empty vehicles}">
              <tr>
                <td colspan="9" style="text-align: center; color: #7f8c8d; padding: 40px;">No vehicles found in the fleet.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </main>

  <div id="deleteModal" class="modal-overlay" style="display: none;">
    <div class="modal-content">
      <div class="modal-header">
        <h3>Delete Vehicle</h3>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete this vehicle? This action cannot be undone and will remove it from the fleet.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn-cancel" onclick="closeModal()">Cancel</button>

        <form id="deleteForm" action="${pageContext.request.contextPath}/deleteVehicle" method="POST" style="margin: 0; display: inline-block;">
          <input type="hidden" name="vehicle_id" id="modalVehicleId" value="">
          <button type="submit" class="btn-delete-confirm" style="border: none; cursor: pointer;">Yes, Delete</button>
        </form>
      </div>
    </div>
  </div>

  <script>
    const modal = document.getElementById('deleteModal');
    const vehicleIdInput = document.getElementById('modalVehicleId');

    function openModal(vehicleId) {
      // Set the hidden input value to the specific vehicle's ID
      vehicleIdInput.value = vehicleId;
      modal.style.display = 'flex';
    }

    function closeModal() {
      modal.style.display = 'none';
      // Clear the input value
      vehicleIdInput.value = '';
    }

    // Close modal if user clicks outside of the modal content
    window.onclick = function(event) {
      if (event.target === modal) {
        closeModal();
      }
    }
  </script>
</body>

</html>