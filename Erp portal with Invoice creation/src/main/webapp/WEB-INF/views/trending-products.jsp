<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trending Products</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    
    <style>
        body {
            background-color: #f2f4f6; /* Light grey background */
            font-family: Arial, sans-serif; /* Stylish font */
        }
        
        .container {
            margin-top: 50px;
            padding: 30px;
            border-radius: 10px; /* Rounded corners */
            background-color: #ffffff; /* White background for the container */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        }

        h2 {
            text-align: center;
            color: #2e8b57; /* Dark Sea Green (hex value) */
            margin-bottom: 30px;
            font-size: 2.5rem; /* Larger font size */
            font-weight: 600; /* Semi-bold */
            text-transform: uppercase; /* Uppercase for emphasis */
            letter-spacing: 1px; /* Spacing between letters */
        }

        .row {
            margin-bottom: 15px; /* Space between rows */
            align-items: center; /* Center alignment */
        }

        .font-weight-bold {
            font-weight: bold;
            color: #27ae60; /* Stylish green for headers */
        }

        .product-name, .sales-volume {
            text-align: center; /* Center alignment for product name and sales volume */
            padding: 20px; /* Increased padding for more height */
            border-radius: 5px; /* Rounded corners */
            background-color: #e8f5e9; /* Very light green for product name */
            border: 1px solid #c8e6c9; /* Light green border for better visual separation */
            transition: background-color 0.3s ease; /* Smooth transition for hover effect */
            width: 80%; /* Reduced width */
            margin: 0 auto; /* Center the column content */
        }

        .product-name:hover, .sales-volume:hover {
            background-color: #c8e6c9; /* Change color on hover */
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            h2 {
                font-size: 2rem; /* Adjust font size for smaller screens */
            }
            .container {
                padding: 10px; /* Reduce padding on smaller screens */
            }
        }

        @media (max-width: 576px) {
            .container {
                margin: 15px 15px; /* Add side margins for smaller screens */
                padding: 5px; /* Reduce padding for compact view */
            }

            h2 {
                font-size: 1.8rem; /* Further reduce font size for very small screens */
            }

            .row {
                margin-bottom: 10px; /* Reduce spacing between rows */
            }

            .product-name, .sales-volume {
                font-size: 0.9rem; /* Adjust font size for better fit */
                padding: 15px; /* Compact padding for mobile view */
                width: 80%; /* Slightly increased width for smaller screens */
            }
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>
<div class="container">
    <h2><i class="bi bi-arrow-up-right"></i> Trending Products</h2>
    <div class="row mb-2">
        <div class="col-6 font-weight-bold">Product Name</div>
        <div class="col-6 font-weight-bold">Sales Volume</div>
    </div>
    <c:forEach items="${trendingProducts}" var="product">
        <div class="row mb-2">
            <div class="col-6 product-name">${product.productName}</div>
            <div class="col-6 sales-volume">${product.totalQuantity}</div>
        </div>
    </c:forEach>
</div>

</body>
</html>
