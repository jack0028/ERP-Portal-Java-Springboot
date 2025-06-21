<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Payment Completed</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .container {
            text-align: center;
            margin-top: 100px;
        }
        .big-text {
            font-size: 36px;
            font-weight: bold;
            color: #28a745; /* Success green color */
        }
        .icon {
            font-size: 60px;
            color: #28a745;
        }
        .info-card {
            margin-top: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">
            <i class="bi bi-check-circle-fill"></i> <!-- Success icon -->
        </div>
        <p class="big-text">Payment Completed Successfully</p>
        
        <div class="info-card">
            <h4>Payment Details</h4>
            <ul class="list-group">
                <li class="list-group-item"><strong>Bill No:</strong> ${paymentDetails.billNo}</li>
                <li class="list-group-item"><strong>Name:</strong> ${paymentDetails.name}</li>
                <li class="list-group-item"><strong>Total Amount Paid:</strong> ${paymentDetails.paidAmount}</li>
                <li class="list-group-item"><strong>Pending Amount:</strong> ${paymentDetails.pendingAmount}</li>
            </ul>
        </div>

        <!-- Return to Payment button -->
        <div class="mt-4">
            <a href="/payment" class="btn btn-primary">
                <i class="bi bi-arrow-left-circle"></i> Return to Payment
            </a>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
