<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Invoice #${booking.bookingId}</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Fira+Code:wght@400;500&display=swap" rel="stylesheet" />

    <style>
        /* Base Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f7f9;
            color: #0f172a;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 2rem;
            box-sizing: border-box;
        }

        /* Page Wrapper to align the back button */
        .page-wrapper {
            width: 100%;
            max-width: 600px;
            display: flex;
            flex-direction: column;
        }

        /* Back Button */
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            color: #64748b;
            font-weight: 600;
            font-size: 0.95rem;
            margin-bottom: 1rem;
            transition: all 0.2s ease;
            align-self: flex-start;
        }

        .btn-back:hover {
            color: #0f172a;
            transform: translateX(-4px);
        }

        /* Invoice Container */
        .invoice-card {
            background: #ffffff;
            width: 100%;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            padding: 2.5rem;
            border: 1px solid #e2e8f0;
        }

        /* Header Section */
        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 1px solid #e2e8f0;
            padding-bottom: 1.5rem;
            margin-bottom: 2rem;
        }

        .header-title h1 {
            font-size: 1.8rem;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 0.25rem 0;
        }

        .header-title p {
            font-family: 'Fira Code', monospace;
            color: #64748b;
            margin: 0;
            font-size: 0.95rem;
        }

        /* Status Text */
        .status-badge {
            font-weight: 700;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .status-completed { color: #10b981; }
        .status-pending { color: #f59e0b; }
        .status-cancelled { color: #ef4444; }

        /* Detail Sections (Trip Schedule & Customer Info) */
        .detail-section {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .detail-section h3 {
            font-size: 1.15rem;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 1.25rem 0;
        }

        /* Detail Rows */
        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 1rem;
            margin-bottom: 1rem;
            border-bottom: 1px dotted #cbd5e1;
        }

        .detail-row:last-child {
            border-bottom: none;
            padding-bottom: 0;
            margin-bottom: 0;
        }

        .detail-label {
            color: #64748b;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .detail-value {
            color: #0f172a;
            font-weight: 600;
            font-size: 1rem;
        }

        /* Grand Total Box */
        .total-box {
            background: #0f172a;
            color: white;
            border-radius: 10px;
            padding: 1.5rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2rem;
        }

        .total-label {
            color: #cbd5e1;
            font-weight: 500;
            font-size: 1rem;
        }

        .total-amount {
            color: #10b981;
            font-size: 1.5rem;
            font-weight: 700;
        }

        /* Print Styles */
        @media print {
            body { background: white; padding: 0; display: block; }
            .page-wrapper { max-width: 100%; }
            .btn-back { display: none !important; } /* Hides button when printing */
            .invoice-card { box-shadow: none; border: none; max-width: 100%; padding: 0; }
        }
    </style>
</head>
<body>

    <div class="page-wrapper">
        <a href="${pageContext.request.contextPath}/report" class="btn-back">
            <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path d="M19 12H5M12 19l-7-7 7-7"/>
            </svg>
            Back to Reports
        </a>

        <div class="invoice-card">
            <div class="invoice-header">
                <div class="header-title">
                    <h1>Booking Details</h1>
                    <p>REF ID: #<c:out value="${booking.bookingId}" /></p>
                </div>

                <div class="status-badge
                    <c:choose>
                        <c:when test="${booking.status == 'Completed'}">status-completed</c:when>
                        <c:when test="${booking.status == 'Cancelled'}">status-cancelled</c:when>
                        <c:otherwise>status-pending</c:otherwise>
                    </c:choose>">
                    <c:out value="${booking.status}" />
                </div>
            </div>

            <div class="detail-section">
                <h3>Trip Schedule</h3>
                <div class="detail-row">
                    <span class="detail-label">Pickup Date</span>
                    <span class="detail-value"><c:out value="${booking.startDate}" /></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Return Date</span>
                    <span class="detail-value"><c:out value="${booking.endDate}" /></span>
                </div>
            </div>

            <div class="detail-section">
                <h3>Rental Info</h3>
                <div class="detail-row">
                    <span class="detail-label">Renter Name</span>
                    <span class="detail-value"><c:out value="${booking.customerName}" default="N/A" /></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Vehicle Details</span>
                    <span class="detail-value"><c:out value="${booking.vehicleDetails}" default="N/A" /></span>
                </div>
            </div>

            <div class="total-box">
                <span class="total-label">Grand Total Paid</span>
                <span class="total-amount">NPR <c:out value="${booking.totalPrice}" /></span>
            </div>
        </div>
    </div>

</body>
</html>