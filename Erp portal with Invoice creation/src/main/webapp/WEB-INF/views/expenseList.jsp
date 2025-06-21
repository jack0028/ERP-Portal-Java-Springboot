<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expense Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f4f7fa;
            color: #333;
        }

        .container {
            margin-top: 20px;
            background: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #3498db;
            font-weight: bold;
        }

        .table {
            width: 100%;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .table th, .table td {
            white-space: nowrap; /* Prevent awkward text wrapping */
            text-align: center;
        }

        .table-responsive {
            overflow-x: auto; /* Horizontal scrolling on smaller screens */
            -webkit-overflow-scrolling: touch;
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
            .table th, .table td {
                font-size: 14px;
            }

            h2 {
                text-align: center;
            }
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
    <h2>Expense List</h2>

    <!-- Expense Table -->
    <div class="table-responsive">
        <table class="table table-bordered table-striped w-100">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Expense</th>
                    <th>Amount</th>
                    <th>Category</th>
                    <th>Payment Mode</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty expenses}">
                    <tr>
                        <td colspan="6" class="text-center">No expense data available</td>
                    </tr>
                </c:if>
                <c:forEach var="expense" items="${expenses}">
                    <tr>
                        <td>${expense.id}</td>
                        <td>${expense.expense}</td>
                        <td>${expense.amount}</td>
                        <td>${expense.category}</td>
                        <td>${expense.paymentMode}</td>
                        <td>${expense.date}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
  
    <!-- Pagination -->
    <div class="pagination">
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a href="?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
        </c:forEach>
    </div>
</div>

</body>
</html>
