<%-- Reset Password page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ page isELIgnored="false" %>

      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Auth/resetPassword.css">
        <title>RentAll | Create New Password</title>
      </head>

      <%-- Background image with cover styling --%>
      <body
        style="background-image: url('${pageContext.request.contextPath}/Assets/Background.jpg'); background-size: cover; background-position: center;">
        <%-- Main form container --%>
        <div class="main">
          <%-- Form header with title and instructions --%>
          <div class="form-head">
            <h1>Create New Password</h1>
            <p>Your new password must be different from previous used passwords.</p>
          </div>

          <%-- Error message alert --%>
          <c:if test="${not empty error}">
            <div class="alert-box error">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="alert-icon">
                <circle cx="12" cy="12" r="10"></circle>
                <line x1="12" y1="8" x2="12" y2="12"></line>
                <line x1="12" y1="16" x2="12.01" y2="16"></line>
              </svg>
              <span>
                <c:out value='${error}' />
              </span>
            </div>
          </c:if>

          <%-- Reset password form --%>
          <form action="${pageContext.request.contextPath}/resetPassword" method="post">

            <%-- New password input field --%>
            <div class="field">
              <label>New Password</label>
              <div class="field-inner">
                <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password" required
                  minlength="6" />
              </div>
            </div>

            <%-- Submit button for resetting password --%>
            <button type="submit" class="submit-btn" style="margin-top: 24px;">Reset Password</button>
          </form>
        </div>
      </body>

      </html>