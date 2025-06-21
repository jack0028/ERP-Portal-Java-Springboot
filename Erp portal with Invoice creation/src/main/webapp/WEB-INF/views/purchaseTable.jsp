<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase Data</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #3498db;
            color: white;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            color: #333;
        }

        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .header h1 {
            margin: 0;
            font-size: 24px;
            color: #3498db;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            text-align: center;
            padding: 10px;
            border: 1px solid #3498db;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
        }

        .pagination a {
            margin: 0 5px;
            padding: 10px 15px;
            text-decoration: none;
            background-color: #3498db;
            color: white;
            border-radius: 4px;
        }

        .pagination a.active {
            background-color: #2c6dad;
            font-weight: bold;
        }

        .pagination a:hover {
            background-color: #1d5489;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header h1 {
                font-size: 18px;
            }

            th, td {
                font-size: 14px;
                padding: 8px;
            }

            .pagination a {
                padding: 8px 12px;
            }
        }
    </style>
</head>
<body>
<%@ include file ="navbar.jsp" %>
    <div class="container">
        <div class="header">
            <h1>Purchase Data</h1>
        </div>

        <div class="table-container">
            <table>
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
