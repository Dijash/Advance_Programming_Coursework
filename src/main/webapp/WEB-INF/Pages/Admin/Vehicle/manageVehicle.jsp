<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="activePage" value="vehicles" scope="request" />
<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/Vehicle/manageVehicle.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
  <title>RentAll | Manage Vehicles</title>
</head>

<body>
  <jsp:include page="/WEB-INF/Pages/Includes/adminSidebar.jsp" />

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

                    <a href="#deleteModal-${car.vehicle_id}" class="action-btn action-btn-delete" style="text-decoration: none;">Delete</a>

                    <div id="deleteModal-${car.vehicle_id}" class="modal-overlay">
                      <div class="modal-content">
                        <div class="modal-header">
                          <h3>Delete Vehicle</h3>
                        </div>
                        <div class="modal-body">
                          <p>Are you sure you want to delete this vehicle? This action cannot be undone and will remove it from the fleet.</p>
                        </div>
                        <div class="modal-footer">
                          <a href="#" class="btn-cancel" style="text-decoration: none;">Cancel</a>
                          <form action="${pageContext.request.contextPath}/deleteVehicle" method="POST" style="margin: 0; display: inline-block;">
                            <input type="hidden" name="vehicle_id" value="${car.vehicle_id}">
                            <button type="submit" class="btn-delete-confirm" style="border: none; cursor: pointer;">Yes, Delete</button>
                          </form>
                        </div>
                      </div>
                    </div>
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

  
</body>

</html>