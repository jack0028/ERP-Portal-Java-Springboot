<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Purchase Data</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f3f9f3;
            color: #2c3e50;
        }

        .container {
            background: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 60px;
        }

        h2 {
            color: #3498db;
            font-weight: bold;
        }

        .table {
            margin-top: 20px;
        }

        .table thead {
            background: #3498db;
            color: white;
            font-weight: bold;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination a {
            margin: 0 5px;
            padding: 10px 15px;
            text-decoration: none;
            color: white;
            background-color: #3498db;
            border-radius: 5px;
        }

        .pagination a.active {
            background-color: #2c6dad;
            font-weight: bold;
        }

        .pagination a:hover {
            background-color: #1d5489;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
                margin: 10px auto;
            }

            h2 {
                font-size: 1.5rem;
                text-align: center;
            }

            .table {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container">
    <h2>Purchase Data</h2>

    <div class="table-responsive">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Bill No</th>
                    <th>Amount</th>
                    <th>Product Name</th>
                    <th>Purchase Date</th>
                    <th>Quantity</th>
                    <th>Rate</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty purchases}">
                    <tr>
                        <td colspan="6" class="text-center">No purchase data available</td>
                    </tr>
                </c:if>
                <c:forEach var="purchase" items="${purchases}" varStatus="status">
                    <tr>
                        <td>${purchase.billNo}</td>
                        <td>${purchase.amount}</td>
                        <td>${purchase.productName}</td>
                        <td>${purchase.purchaseDate}</td>
                        <td>${purchase.quantity}</td>
                        <td>${purchase.rate}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="pagination">
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a href="?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
        </c:forEach>
    </div>
</div>
</body>
</html>
