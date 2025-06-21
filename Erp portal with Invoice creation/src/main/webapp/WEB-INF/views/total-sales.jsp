<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Total Sales</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .section-title {
            color: #dc3545;
            font-weight: bold;
            text-transform: uppercase;
            border-bottom: 2px solid #dc3545;
            padding-bottom: 5px;
            margin-bottom: 20px;
        }
        .label-text {
            font-weight: bold;
            color: #b21f2d;
        }
        .value-text {
            color: #6c757d;
            font-weight: bold;
            font-size: 28px;
        }
        .row {
            padding: 10px 0;
        }
    </style>
</head>
<body>
 <%@ include file="navbar.jsp" %>
<div class="container mt-4">
    <h2 class="section-title text-center"><i class="bi bi-currency-dollar"></i>Total Sales</h2>
    <div class="row">
        <div class="col-4 label-text">
            <label for="totalSalesAmount">Total Sales Amount:</label>
        </div>
        <div class="col-8 value-text">
            <label id="totalSalesAmount">${salesInfo.totalAmount}</label>
        </div>
    </div>
    <div class="row">
        <div class="col-4 label-text">
            <label for="totalInvoices">Total Invoices:</label>
        </div>
        <div class="col-8 value-text">
            <label id="totalInvoices">${salesInfo.totalProducts}</label>
        </div>
    </div>
</div>

<!-- Bootstrap JS (Optional) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
