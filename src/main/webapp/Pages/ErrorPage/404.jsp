<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RentAll | 404 - Wrong Turn</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700;800&display=swap" rel="stylesheet" />
  <style>
    :root {
      --primary: #0f172a;
      --accent: #3b82f6;
      --accent-hover: #2563eb;
      --bg-main: #f8fafc;
      --card-bg: #ffffff;
      --text-muted: #64748b;
      --border: #e2e8f0;
    }

    body {
      font-family: "Poppins", sans-serif;
      background-color: var(--bg-main);
      /* Hand-crafted CSS dot grid - no images needed! */
      background-image: radial-gradient(#cbd5e1 1.5px, transparent 1.5px);
      background-size: 24px 24px;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
      margin: 0;
      color: var(--primary);
    }

    .error-container {
      background: var(--card-bg);
      padding: 3.5rem 3rem;
      border-radius: 16px;
      box-shadow: 0 10px 40px -10px rgba(0, 0, 0, 0.1);
      max-width: 480px;
      width: 90%;
      text-align: center;
      border: 1px solid var(--border);
      /* Thick bottom border gives a solid, grounded, modern feel */
      border-bottom: 6px solid var(--accent);
      position: relative;
    }

    .logo {
      font-size: 1.4rem;
      font-weight: 800;
      color: var(--primary);
      text-decoration: none;
      display: inline-block;
      margin-bottom: 1.5rem;
      text-transform: uppercase;
      letter-spacing: 1px;
    }

    .logo span { color: var(--accent); }

    .error-code {
      font-size: 8rem;
      font-weight: 800;
      line-height: 1;
      margin: 0.5rem 0;
      letter-spacing: -4px;
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 2px;
    }

    /* Playful animation: makes the zero act like a wobbly tire */
    .error-code .wobbly-tire {
      color: var(--accent);
      display: inline-block;
      animation: wobble 3s ease-in-out infinite;
    }

    .error-title {
      font-size: 1.75rem;
      font-weight: 700;
      margin-bottom: 0.75rem;
      letter-spacing: -0.5px;
    }

    .error-message {
      color: var(--text-muted);
      margin-bottom: 2.5rem;
      line-height: 1.6;
      font-size: 0.95rem;
    }

    .btn-home {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      background: var(--primary);
      color: white;
      text-decoration: none;
      padding: 12px 28px;
      border-radius: 8px;
      font-weight: 600;
      transition: all 0.2s ease;
    }

    .btn-home:hover {
      background: var(--accent);
      transform: translateY(-2px);
      box-shadow: 0 8px 15px -3px rgba(59, 130, 246, 0.3);
    }

    /* Simple inline SVG arrow - purely code, no external files */
    .btn-home svg {
      width: 18px;
      height: 18px;
      transition: transform 0.2s ease;
    }

    .btn-home:hover svg {
      transform: translateX(-4px);
    }

    @keyframes wobble {
      0% { transform: rotate(0deg) translateY(0); }
      25% { transform: rotate(15deg) translateY(-4px); }
      50% { transform: rotate(0deg) translateY(0); }
      75% { transform: rotate(-15deg) translateY(-4px); }
      100% { transform: rotate(0deg) translateY(0); }
    }
  </style>
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