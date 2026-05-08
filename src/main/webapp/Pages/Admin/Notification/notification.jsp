<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="jakarta.tags.core" %> <%@
taglib prefix="sql" uri="jakarta.tags.sql" %> <%-- Database Connection --%>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>RentAll | Manage Notifications</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Dashboard/Admin.css">
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />

  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li>
            <a href="${pageContext.request.contextPath}/admin"
              ><span>Dashboard</span></a
            >
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/manageBooking"
              ><span>Bookings</span></a
            >
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/manageVehicles"
              ><span>Manage Vehicles</span></a
            >
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/manageCustomers"
              ><span>Customers</span></a
            >
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/manageReviews"
              ><span>Reviews</span></a
            >
          </li>
          <li>
            <a
              href="${pageContext.request.contextPath}/manageNotification"
              class="active"
              ><span>Notifications</span></a
            >
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/report"
              ><span>Reports</span></a
            >
          </li>
        </ul>
      </nav>
      <a href="${pageContext.request.contextPath}/logout" class="logout"
        ><span>Logout</span></a
      >
    </aside>

    <main>
      <div class="page-header" style="margin-bottom: 2rem">
        <h2 style="font-weight: 700; color: #0f172a">Broadcast Notification</h2>
      </div>

      <div class="send-box">
        <form
          action="${pageContext.request.contextPath}/sendNotification"
          method="POST"
        >
          <div class="form-group">
            <label>Subject</label>
            <input
              type="text"
              name="subject"
              class="form-control"
              placeholder="e.g., Weekend Discount!"
              required
            />
          </div>
          <div class="form-group">
            <label>Message Content</label>
            <textarea
              name="message"
              class="form-control"
              rows="3"
              placeholder="Write your message to all users..."
              required
            ></textarea>
          </div>
          <button type="submit" class="btn-send">Send to All Users</button>
        </form>
      </div>

      <div
        class="content-box"
        style="
          background: white;
          border-radius: 12px;
          border: 1px solid #e2e8f0;
          box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
        "
      >
        <h3
          style="
            padding: 20px;
            font-size: 1.1rem;
            border-bottom: 1px solid #f1f5f9;
            color: #0f172a;
          "
        >
          Sent History
        </h3>
        <div class="table-responsive">
          <table style="width: 100%; border-collapse: collapse">
            <thead>
              <tr
                style="
                  background: #f8fafc;
                  text-align: left;
                  color: #64748b;
                  font-size: 0.85rem;
                  text-transform: uppercase;
                "
              >
                <th style="padding: 15px">Subject</th>
                <th style="padding: 15px">Message</th>
                <th style="padding: 15px">Date Sent</th>
                <th style="padding: 15px; text-align: center">Action</th>
              </tr>
            </thead>
            <tbody>
              <%-- Iterate over the list of objects sent from the Servlet --%>
              <c:forEach var="row" items="${notifHistory}">
                <tr style="border-bottom: 1px solid #f1f5f9">
                  <td style="padding: 15px; color: #1e293b">
                    <%-- Use the property names from your Notification model (Java class) --%>
                    <strong><c:out value="${row.type}" /></strong>
                  </td>
                  <td style="padding: 15px">
                    <div class="notif-msg">
                      <c:out value="${row.description}" />
                    </div>
                  </td>
                  <td style="padding: 15px; font-size: 0.8rem; color: #94a3b8">
                    <c:out value="${row.date}" />
                  </td>

                  <td style="padding: 15px; text-align: center">
                    <%-- Use row.id to match your Java model property --%>
                    <a
                      href="${pageContext.request.contextPath}/deleteNotification?id=${row.id}"
                      class="btn-delete"
                      onclick="return confirm('Are you sure you want to delete this notification?');"
                    >
                      Delete
                    </a>
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${empty notifHistory}">
                <tr>
                  <td colspan="4" style="text-align: center; padding: 30px; color: #94a3b8">
                    No notifications sent yet.
                  </td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </main>
  </body>
</html>
