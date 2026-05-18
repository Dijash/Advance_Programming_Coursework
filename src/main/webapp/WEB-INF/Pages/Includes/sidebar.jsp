<%-- User Sidebar navigation component --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ page import="com.model.Customer" %>

      <%-- Sidebar navigation aside --%>
      <aside class="sidebar">
        <%-- RentAll logo with link --%>
        <h2><a href="${pageContext.request.contextPath}/home" class="main-thing">RentAll</a></h2>
        <%-- Navigation menu --%>
        <nav>
          <ul>
            <%-- Dashboard link --%>
            <li>
              <a href="${pageContext.request.contextPath}/userDashboard"
                class="${activePage == 'dashboard' ? 'active' : ''}">
                Dashboard
              </a>
            </li>
            <%-- My Bookings link --%>
            <li>
              <a href="${pageContext.request.contextPath}/myBookings"
                class="${activePage == 'myBookings' ? 'active' : ''}">
                My Bookings
              </a>
            </li>
            <%-- My Favorites link --%>
            <li>
              <a href="${pageContext.request.contextPath}/myFavorites"
                class="${activePage == 'myFavorites' ? 'active' : ''}">
                My Favorites
              </a>
            </li>
            <%-- Settings link --%>
            <li>
              <a href="${pageContext.request.contextPath}/settings"
                class="${activePage == 'settings' ? 'active' : ''}">
                Settings
              </a>
            </li>
          </ul>
        </nav>
        <%-- Logout button --%>
        <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
      </aside>