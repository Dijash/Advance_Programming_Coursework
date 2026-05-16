<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Auth/forgotpassword.css">
    <title>Forgot Password</title>

    <c:choose>
        <c:when test="${not empty error}">
            <script>
                alert("<c:out value='${error}' />");
            </script>
        </c:when>
        <c:when test="${not empty message}">
            <script>
                alert("<c:out value='${message}' />");
            </script>
        </c:when>
    </c:choose>
  </head>

  <body style="background-image: url('${pageContext.request.contextPath}/Assets/Background.jpg'); background-size: cover; background-position: center;">
    <div class="main">
      <div class="form-head">
        <h1>Forgot Password?</h1>
        <p>No worries, enter your email and we'll send you reset instructions.</p>
      </div>

      <form id="forgotPasswordForm" action="${pageContext.request.contextPath}/forgotPassword" method="post">

        <div class="field">
          <label>Email Address</label>
          <div class="field-inner">
            <input
              type="email"
              id="email"
              name="email"
              placeholder="example@gmail.com"
              required
            />
          </div>
        </div>

        <button type="submit" class="submit-btn" style="margin-top: 24px;">Send Reset Link</button>
      </form>

      <div class="form-foot">
        Remember your password? <a href="${pageContext.request.contextPath}/login">Back to Login</a>
      </div>
    </div>
  </body>
</html>