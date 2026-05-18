<%-- Manage Vehicles listing page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%-- Set active page for sidebar highlighting --%>
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
      <%-- Include admin sidebar navigation --%>
      <jsp:include page="/WEB-INF/Pages/Includes/adminSidebar.jsp" />

      <main>
        <%-- Page header with title and add button --%>
        <div class="page-header">
          <h2>Fleet Management</h2>
          <a href="${pageContext.request.contextPath}/addVehicle" class="btn-primary">+ Add Vehicle</a>
        </div>

        <%-- Content box containing vehicles table --%>
        <div class="content-box">
          <%-- Error message alert --%>
          <c:if test="${not empty sessionScope.errorMsg}">
            <div class="alert alert-error">
              <c:out value="${sessionScope.errorMsg}" />
              <c:remove var="errorMsg" scope="session" />
            </div>
          </c:if>

          <%-- Success message alert --%>
          <c:if test="${not empty sessionScope.successMsg}">
            <div class="alert alert-success">
              <c:out value="${sessionScope.successMsg}" />
              <c:remove var="successMsg" scope="session" />
            </div>
          </c:if>

          <%-- Responsive table wrapper --%>
          <div class="table-responsive">
            <table>
              <%-- Table header row --%>
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
              <%-- Table body with vehicles data --%>
              <tbody>
                <%-- Vehicles loop --%>
                <c:forEach var="car" items="${vehicles}">
                  <tr>
                    <%-- Vehicle image column --%>
                    <td>
                      <div class="vehicle-thumb"
                        style="background-image: url('${pageContext.request.contextPath}/Assets/${car.vehicle_image}')">
                      </div>
                    </td>
                    <%-- Brand column --%>
                    <td><strong>
                        <c:out value="${car.vehicle_brand}" />
                      </strong></td>
                    <%-- Type column --%>
                    <td>
                      <c:out value="${car.vehicle_type}" />
                    </td>
                    <%-- Color column --%>
                    <td style="text-transform: capitalize;">
                      <c:out value="${car.vehicle_color}" />
                    </td>
                    <%-- Number plate column --%>
                    <td>
                      <c:out value="${car.vehicle_numberPlate}" />
                    </td>
                    <%-- Condition column --%>
                    <td>
                      <c:out value="${car.vehicle_condition}" />
                    </td>

                    <%-- Status column with dynamic color --%>
                    <td style="font-weight: 600; color:
                          <c:choose>
                              <c:when test=" ${car.vehicle_status=='Available' }">#27ae60</c:when>
                      <c:when test="${car.vehicle_status == 'Maintenance'}">#f39c12</c:when>
                      <c:otherwise>#e74c3c</c:otherwise>
                      </c:choose>;">
                      <c:out value="${car.vehicle_status}" />
                    </td>

                    <%-- Price per day column --%>
                    <td style="font-weight: bold; color: #2c3e50;">
                      NPR
                      <c:out value="${car.vehicle_price}" />
                    </td>

                    <%-- Actions column with view, edit, and delete buttons --%>
                    <td>
                      <%-- Action buttons container --%>
                      <div class="action-buttons">
                        <%-- View vehicle button --%>
                        <a href="${pageContext.request.contextPath}/viewVehicle?id=${car.vehicle_id}"
                          class="action-btn action-btn-view">View</a>
                        <%-- Edit vehicle button --%>
                        <a href="${pageContext.request.contextPath}/editVehicle?id=${car.vehicle_id}"
                          class="action-btn action-btn-edit">Edit</a>

                        <%-- Delete vehicle button with modal --%>
                        <a href="#deleteModal-${car.vehicle_id}" class="action-btn action-btn-delete"
                          style="text-decoration: none;">Delete</a>

                        <%-- Delete confirmation modal --%>
                        <div id="deleteModal-${car.vehicle_id}" class="modal-overlay">
                          <div class="modal-content">
                            <%-- Modal header --%>
                            <div class="modal-header">
                              <h3>Delete Vehicle</h3>
                            </div>
                            <%-- Modal body with warning --%>
                            <div class="modal-body">
                              <p>Are you sure you want to delete this vehicle? This action cannot be undone and will
                                remove it from the fleet.</p>
                            </div>
                            <%-- Modal footer with buttons --%>
                            <div class="modal-footer">
                              <%-- Cancel button --%>
                              <a href="#" class="btn-cancel" style="text-decoration: none;">Cancel</a>
                              <%-- Confirm delete form --%>
                              <form action="${pageContext.request.contextPath}/deleteVehicle" method="POST"
                                style="margin: 0; display: inline-block;">
                                <input type="hidden" name="vehicle_id" value="${car.vehicle_id}">
                                <button type="submit" class="btn-delete-confirm"
                                  style="border: none; cursor: pointer;">Yes, Delete</button>
                              </form>
                            </div>
                          </div>
                        </div>
                      </div>
                    </td>
                  </tr>
                </c:forEach>

                <%-- Empty state when no vehicles --%>
                <c:if test="${empty vehicles}">
                  <tr>
                    <td colspan="9" style="text-align: center; color: #7f8c8d; padding: 40px;">No vehicles found in the
                      fleet.</td>
                  </tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </div>
      </main>


    </body>

    </html>