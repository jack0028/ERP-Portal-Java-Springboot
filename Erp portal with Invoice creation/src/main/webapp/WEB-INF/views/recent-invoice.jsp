<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Recent Invoices</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .section-title {
            color: #007bff;
            font-weight: bold;
            text-transform: uppercase;
            border-bottom: 2px solid #007bff;
            padding-bottom: 5px;
        }
        .label-title {
            font-weight: bold;
            color: #343a40;
        }
        .data-value {
            color: #495057;
        }
        .product-row {
            margin-bottom: 10px;
            padding: 10px;
            border-bottom: 1px solid #dee2e6;
        }
        .product-row:last-child {
            border-bottom: none;
        }
        @media (max-width: 768px) {
            .product-row {
                display: flex;
                flex-direction: column;
            }
            .product-detail {
                margin-bottom: 5px;
            }
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container mt-4">
    <h2 class="text-center section-title mb-4"><i class="fas fa-clock"></i> 
    Recent Invoice</h2>
    <c:if test="${recentCustomer != null}">
        <div class="row mb-2">
            <div class="col-md-4 label-title">Invoice Number:</div>
            <div class="col-md-8 data-value" id="invoiceNumber">${recentCustomer.invoiceNo}</div>
        </div>
        <div class="row mb-2">
            <div class="col-md-4 label-title">Customer Name:</div>
            <div class="col-md-8 data-value" id="customerName">${recentCustomer.name}</div>
        </div>
        <div class="row mb-2">
            <div class="col-md-4 label-title">Bill Number:</div>
            <div class="col-md-8 data-value" id="billNo">${recentCustomer.billNo}</div>
        </div>
        <div class="row mb-4">
            <div class="col-md-4 label-title">Date:</div>
            <div class="col-md-8 data-value" id="date">${recentCustomer.date}</div>
        </div>
    </c:if>

    <h3 class="section-title mb-3">Product Details</h3>
    <c:if test="${recentCustomer != null}">
        <c:choose>
            <c:when test="${recentCustomer != null and not empty recentCustomer.productDetails}">
                <div class="product-list">
                    <c:forEach items="${recentCustomer.productDetails}" var="product">
                        <div class="row product-row">
                            <div class="col-md-4 product-detail">
                                <strong>Product Name:</strong> ${product.productName}
                            </div>
                            <div class="col-md-4 product-detail">
                                <strong>Quantity:</strong> ${product.quantity}
                            </div>
                            <div class="col-md-4 product-detail">
                                <strong>Amount:</strong> ${product.amount}
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p>No products found for this customer.</p>
            </c:otherwise>
        </c:choose>
    </c:if>
</div>
</body>
</html>
