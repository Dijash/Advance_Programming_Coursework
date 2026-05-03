<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/LoginStyle.css">
    <title>Create New Password</title>

    <%-- Moved inside the head tag and updated to use c:out for safety --%>
    <c:if test="${not empty error}">
        <script>
            alert("<c:out value='${error}' />");
        </script>
    </c:if>
  </head>

  <body style="background-image: url('${pageContext.request.contextPath}/Assets/Background.jpg'); background-size: cover; background-position: center;">
    <div class="main">
      <div class="form-head">
        <h1>Create New Password</h1>
        <p>Your new password must be different from previous used passwords.</p>
      </div>

      <form action="${pageContext.request.contextPath}/resetPassword" method="post">

        <div class="field">
          <label>New Password</label>
          <div class="field-inner">
            <input
              type="password"
              id="newPassword"
              name="newPassword"
              placeholder="Enter new password"
              required
              minlength="6"
            />
          </div>
        </div>

        <button type="submit" class="submit-btn" style="margin-top: 24px;">Reset Password</button>
      </form>
    </div>
  </body>
</html>