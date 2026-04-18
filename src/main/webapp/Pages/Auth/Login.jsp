<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/LoginStyle.css">
    <title>Login</title>
  </head>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
    <script>
        alert("<%= error %>");
    </script>
<%
    }
%>
  <body style="background-image: url('<%= request.getContextPath() %>/Assets/Background.jpg'); background-size: cover; background-position: center;">
    <div class="main">
      <div class="form-head">
        <h1>Sign in</h1>
        <p>Welcome back - login to continue</p>
      </div>

      <div class="social-row">
        <button class="social-btn">
          <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 48 48">
            <path fill="#FFC107" d="M43.611 20.083H42V20H24v8h11.303c-1.649 4.657-6.08 8-11.303 8c-6.627 0-12-5.373-12-12s5.373-12 12-12c3.059 0 5.842 1.154 7.961 3.039l5.657-5.657C34.046 6.053 29.268 4 24 4C12.955 4 4 12.955 4 24s8.955 20 20 20s20-8.955 20-20c0-1.341-.138-2.65-.389-3.917z"/>
            <path fill="#FF3D00" d="m6.306 14.691l6.571 4.819C14.655 15.108 18.961 12 24 12c3.059 0 5.842 1.154 7.961 3.039l5.657-5.657C34.046 6.053 29.268 4 24 4C16.318 4 9.656 8.337 6.306 14.691z"/>
            <path fill="#4CAF50" d="M24 44c5.166 0 9.86-1.977 13.409-5.192l-6.19-5.238C29.211 35.091 26.715 36 24 36c-5.202 0-9.619-3.317-11.283-7.946l-6.522 5.025C9.505 39.556 16.227 44 24 44z"/>
            <path fill="#1976D2" d="M43.611 20.083H42V20H24v8h11.303c-.792 2.237-2.231 4.166-4.087 5.571c.001-.001.002-.001.003-.002l6.19 5.238C36.971 39.205 44 34 44 24c0-1.341-.138-2.65-.389-3.917z"/>
          </svg>
          Google
        </button>
        <button class="social-btn">
          <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="#1877F2">
            <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.469h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.469h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
          </svg>
          Facebook
        </button>
      </div>

      <div class="or-divider">or</div>

      <form id="loginForm" action="<%= request.getContextPath() %>/login" method="post">
        <div class="field">
          <label>Email</label>
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

        <div class="field">
          <label>Password</label>
          <div class="field-inner">
            <input
              type="password"
              id="password"
              name="password"
              placeholder="Password"
              required
            />
            <button type="button" class="eye" onclick="togglePassword()" style="display: flex; align-items: center; justify-content: center;">
              
              <svg id="eyeOpen" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/>
                <circle cx="12" cy="12" r="3"/>
              </svg>

              <svg id="eyeClosed" style="display: none;" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M9.88 9.88a3 3 0 1 0 4.24 4.24"/>
                <path d="M10.73 5.08A10.43 10.43 0 0 1 12 5c7 0 10 7 10 7a13.16 13.16 0 0 1-1.67 2.68"/>
                <path d="M6.61 6.61A13.526 13.526 0 0 0 2 12s3 7 10 7a9.74 9.74 0 0 0 5.39-1.61"/>
                <line x1="2" y1="2" x2="22" y2="22"/>
              </svg>

            </button>
          </div>
        </div>

        <div class="meta-row">
          <label><input type="checkbox" /> Remember Me</label>
          <a href="<%= request.getContextPath() %>/resetPassword">Forgot Password?</a>
        </div>

        <button type="submit" class="submit-btn">Sign In</button>
      </form>

      <div class="form-foot">
        Don't have a account ? <a href="<%= request.getContextPath() %>/register">Create one</a>
      </div>
    </div>

    <script>
      function togglePassword() {
        const passwordInput = document.getElementById("password");
        const eyeOpen = document.getElementById("eyeOpen");
        const eyeClosed = document.getElementById("eyeClosed");

        if (passwordInput.type === "password") {
          passwordInput.type = "text";
          eyeOpen.style.display = "none";
          eyeClosed.style.display = "block";
        } else {
          passwordInput.type = "password";
          eyeOpen.style.display = "block";
          eyeClosed.style.display = "none";
        }
      }
    </script>
  </body>
</html>