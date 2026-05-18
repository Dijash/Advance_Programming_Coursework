<%-- Manage Notifications page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
      <%-- Set active page for sidebar highlighting --%>
      <c:set var="activePage" value="notifications" scope="request" />

      <!doctype html>
      <html lang="en">

      <head>
        <meta charset="UTF-8" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/Notification/Notification.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Modal.css">
        <title>RentAll | Manage Notifications</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/Dashboard/Admin.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Admin/adminSidebar.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet" />
      </head>

      <body>
        <%-- Include admin sidebar navigation --%>
        <jsp:include page="/WEB-INF/Pages/Includes/adminSidebar.jsp" />

        <main>
          <%-- Page header with title --%>
          <div class="page-header" style="margin-bottom: 2rem">
            <h2 style="font-weight: 700; color: #0f172a">Broadcast Notification</h2>
          </div>

          <%-- Send notification form box --%>
          <div class="send-box">
            <%-- Form to send new notification --%>
            <form action="${pageContext.request.contextPath}/sendNotification" method="POST">
              <%-- Subject input field --%>
              <div class="form-group">
                <label>Subject</label>
                <input type="text" name="subject" class="form-control" placeholder="e.g., Weekend Discount!" required />
              </div>
              <%-- Message textarea field --%>
              <div class="form-group">
                <label>Message Content</label>
                <textarea name="message" class="form-control" rows="3" placeholder="Write your message to all users..."
                  required></textarea>
              </div>
              <%-- Submit button to send notification --%>
              <button type="submit" class="btn-send">Send to All Users</button>
            </form>
          </div>

          <%-- Content box containing notification history table --%>
          <div class="content-box"
            style="background: white; border-radius: 12px; border: 1px solid #e2e8f0; box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);">
            <%-- Sent history section header --%>
            <h3 style="padding: 20px; font-size: 1.1rem; border-bottom: 1px solid #f1f5f9; color: #0f172a;">
              Sent History
            </h3>
            <%-- Responsive table wrapper --%>
            <div class="table-responsive">
              <table style="width: 100%; border-collapse: collapse">
                <%-- Table header row --%>
                <thead>
                  <tr
                    style="background: #f8fafc; text-align: left; color: #64748b; font-size: 0.85rem; text-transform: uppercase;">
                    <th style="padding: 15px">Subject</th>
                    <th style="padding: 15px">Message</th>
                    <th style="padding: 15px">Date Sent</th>
                    <th style="padding: 15px; text-align: center">Action</th>
                  </tr>
                </thead>
                <%-- Table body with notification history --%>
                <tbody>
                  <%-- Notifications loop --%>
                  <c:forEach var="row" items="${notifHistory}">
                    <tr style="border-bottom: 1px solid #f1f5f9">
                      <%-- Subject column --%>
                      <td style="padding: 15px; color: #1e293b">
                        <strong>
                          <c:out value="${row.type}" />
                        </strong>
                      </td>
                      <%-- Message column --%>
                      <td style="padding: 15px">
                        <div class="notif-msg">
                          <c:out value="${row.description}" />
                        </div>
                      </td>
                      <%-- Date sent column --%>
                      <td style="padding: 15px; font-size: 0.8rem; color: #94a3b8">
                        <c:out value="${row.date}" />
                      </td>
                      <%-- Action column with delete button --%>
                      <td style="padding: 15px; text-align: center">
                        <%-- Delete notification button --%>
                        <a href="#deleteModal-${row.id}" class="btn-delete" style="text-decoration: none;">
                          Delete
                        </a>

                        <%-- Delete confirmation modal --%>
                        <div id="deleteModal-${row.id}" class="modal-overlay">
                          <div class="modal-content">
                            <%-- Modal header --%>
                            <div class="modal-header">
                              <h3>Delete Notification</h3>
                            </div>
                            <%-- Modal body with warning --%>
                            <div class="modal-body">
                              <p>Are you sure you want to delete this broadcast? This action cannot be undone and will
                                remove it from all user dashboards.</p>
                            </div>
                            <%-- Modal footer with buttons --%>
                            <div class="modal-footer">
                              <%-- Cancel button --%>
                              <a href="#" class="btn-cancel" style="text-decoration: none;">Cancel</a>
                              <%-- Confirm delete link --%>
                              <a href="${pageContext.request.contextPath}/deleteNotification?id=${row.id}"
                                class="btn-delete-confirm" style="text-decoration: none;">Yes, Delete</a>
                            </div>
                          </div>
                        </div>
                      </td>
                    </tr>
                  </c:forEach>

                  <%-- Empty state when no notifications exist --%>
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