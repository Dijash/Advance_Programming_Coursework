<%-- adminSidebar.jsp - Reusable sidebar for admin pages --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<input type="checkbox" id="menu-toggle" style="display:none;" />
<label for="menu-toggle" class="menu-btn" style="display:none;">MENU</label>

<aside class="sidebar">
  <h2>RentAll</h2>
  <nav>
    <ul>
      <li>
        <a href="${pageContext.request.contextPath}/admin" 
           class="${activePage == 'dashboard' ? 'active' : ''}">
           <span>Dashboard</span>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/manageBooking" 
           class="${activePage == 'bookings' ? 'active' : ''}">
           <span>Bookings</span>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/manageVehicles" 
           class="${activePage == 'vehicles' ? 'active' : ''}">
           <span>Manage Vehicles</span>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/manageCustomers" 
           class="${activePage == 'customers' ? 'active' : ''}">
           <span>Customers</span>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/manageReviews" 
           class="${activePage == 'reviews' ? 'active' : ''}">
           <span>Reviews</span>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/manageNotification" 
           class="${activePage == 'notifications' ? 'active' : ''}">
           <span>Notifications</span>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/report" 
           class="${activePage == 'reports' ? 'active' : ''}">
           <span>Reports</span>
        </a>
      </li>
    </ul>
  </nav>
  <a href="${pageContext.request.contextPath}/logout" class="logout"><span>Logout</span></a>
</aside>