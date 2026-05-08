<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/ErrorPage/404.css">
  <title>RentAll | 404 - Wrong Turn</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700;800&display=swap" rel="stylesheet" />

</head>
<body>
  <div class="error-container">
    <a href="${pageContext.request.contextPath}/" class="logo">Rent<span>All</span></a>

    <div class="error-code">
      4<span class="wobbly-tire">0</span>4
    </div>

    <div class="error-title">Whoops! Dead End.</div>

    <div class="error-message">
      Looks like you've driven off the map. The vehicle or page you're looking for doesn't exist in our current fleet.
    </div>

    <a href="${pageContext.request.contextPath}/home" class="btn-home">
      <!-- Pure CSS/SVG icon -->
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
        <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
      </svg>
      Turn Around
    </a>
  </div>
</body>
</html>