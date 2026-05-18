<%-- Admin Sidebar navigation component --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>

  <%-- Mobile menu toggle checkbox and label --%>
  <input type="checkbox" id="menu-toggle" style="display:none;" />
  <label for="menu-toggle" class="menu-btn" style="display:none;">MENU</label>

  <%-- Sidebar navigation aside --%>
  <aside class="sidebar">
    <%-- RentAll logo --%>
    <h2>RentAll</h2>
    <%-- Navigation menu --%>
    <nav>
      <ul>
        <%-- Dashboard link --%>
        <li>
          <a href="${pageContext.request.contextPath}/admin" class="${activePage == 'dashboard' ? 'active' : ''}">
            <span>Dashboard</span>
          </a>
        </li>
        <%-- Bookings link --%>
        <li>
          <a href="${pageContext.request.contextPath}/manageBooking"
            class="${activePage == 'bookings' ? 'active' : ''}">
            <span>Bookings</span>
          </a>
        </li>
        <%-- Manage Vehicles link --%>
        <li>
          <a href="${pageContext.request.contextPath}/manageVehicles"
            class="${activePage == 'vehicles' ? 'active' : ''}">
            <span>Manage Vehicles</span>
          </a>
        </li>
        <%-- Customers link --%>
        <li>
          <a href="${pageContext.request.contextPath}/manageCustomers"
            class="${activePage == 'customers' ? 'active' : ''}">
            <span>Customers</span>
          </a>
        </li>
        <%-- Reviews link --%>
        <li>
          <a href="${pageContext.request.contextPath}/manageReviews"
            class="${activePage == 'reviews' ? 'active' : ''}">
            <span>Reviews</span>
          </a>
        </li>
        <%-- Notifications link --%>
        <li>
          <a href="${pageContext.request.contextPath}/manageNotification"
            class="${activePage == 'notifications' ? 'active' : ''}">
            <span>Notifications</span>
          </a>
        </li>
        <%-- Reports link --%>
        <li>
          <a href="${pageContext.request.contextPath}/report" class="${activePage == 'reports' ? 'active' : ''}">
            <span>Reports</span>
          </a>
        </li>
      </ul>
    </nav>
    <%-- Logout button --%>
    <a href="${pageContext.request.contextPath}/logout" class="logout"><span>Logout</span></a>
  </aside>