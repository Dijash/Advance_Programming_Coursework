<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/ErrorPage/505.css">
  <title>RentAll | 505 - Protocol Error</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700;800&display=swap" rel="stylesheet" />

</head>
<body>
  <div class="error-container">
    <a href="${pageContext.request.contextPath}/home" class="logo">Rent<span>All</span></a>

    <div class="error-code">
      5<span class="glitch">0</span>5
    </div>

    <div class="error-title">Transmission Error!</div>

    <div class="error-message">
      Your browser is communicating with a protocol our servers don't support. Try updating your browser to continue the journey.
    </div>

    <a href="${pageContext.request.contextPath}/home" class="btn-home">
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
        <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
      </svg>
      Return Home
    </a>
  </div>
</body>
</html>