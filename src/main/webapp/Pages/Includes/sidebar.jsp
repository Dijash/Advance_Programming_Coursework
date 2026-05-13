<%-- sidebar.jsp - Reusable sidebar for user pages --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.model.Customer" %>

<aside class="sidebar">
  <h2><a href="${pageContext.request.contextPath}/home" class="main-thing">RentAll</a></h2>
  <nav>
    <ul>
      <li>
        <a href="${pageContext.request.contextPath}/userDashboard" 
           class="<%= activePage.equals("dashboard") ? "active" : "" %>">
           Dashboard
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/myBookings" 
           class="<%= activePage.equals("myBookings") ? "active" : "" %>">
           My Bookings
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/myFavorites" 
           class="<%= activePage.equals("myFavorites") ? "active" : "" %>">
           My Favorites
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/settings" 
           class="<%= activePage.equals("settings") ? "active" : "" %>">
           Settings
        </a>
      </li>
    </ul>
  </nav>
  <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
</aside>