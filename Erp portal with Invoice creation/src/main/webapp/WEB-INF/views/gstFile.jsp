<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GST File</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .container {
            width: 100%;
            display: flex;
            justify-content: center;
            flex-direction: column;
        }

        .table-container {
            display: flex;
            justify-content: space-between;
            width: 100%;
        }

        .table-container > div {
            width: 49%; /* Each table takes up 48% of the width, with space in between */
        }

        .table-header {
            background-color: #003d73;
            color: #ffffff;
        }

        .table-hover tbody tr:hover {
            background-color: #e7f1ff;
        }

        .table {
            background-color: #ffffff;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        th, td {
            text-align: center;
            vertical-align: middle;
        }

        h1, h2 {
            font-family: 'Arial', sans-serif;
            text-align: center;
            padding: 10px;
            border-radius: 5px;
        }

        h1 {
            color: #0056b3;
        }

        h2 {
            background-color: #003d73;
            color: #ffffff;
        }

        /* Responsive adjustment for smaller screens */
        @media (max-width: 768px) {
            .table-container {
                flex-direction: column; /* Stack tables vertically on smaller screens */
            }

            .table-container > div {
                width: 100%;
                margin-bottom: 20px;
            }
        }

        /* Pagination styles */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }

        .pagination button {
            margin: 0 5px;
            padding: 5px 10px;
            background-color: #0056b3;
            color: #ffffff;
            border: none;
            border-radius: 3px;
        }

        .pagination button:hover {
            background-color: #004085;
        }
        
         .download-btn {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <%@ include file="navbar.jsp" %>
    <div class="container mt-5">
        <h1>GST File</h1>

        <div class="table-container mt-4">
            <!-- GST of Customer Table -->
            <div class="table-responsive">
                <h2><i class="bi bi-file-earmark-person"></i> GST Of Customer</h2>
                <table id="customerTable" class="table table-bordered table-hover">
                    <thead class="table-header">
                        <tr>
                            <th>Bill No</th>
                            <th>Date</th>
                            <th>Name</th>
                            <th>GST Amount</th>
                            <th>Total Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="bill" items="${billDetails}">
                            <tr>
                                <td>${bill.billNo}</td>
                                <td>${bill.date}</td>
                                <td>${bill.name}</td>
                                <td>${bill.gstAmount}</td>
                                <td>${bill.totalAmount}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div id="customerPagination" class="pagination"></div>
            </div>

            <!-- GST of Products Table -->
            <div class="table-responsive">
                <h2><i class="bi bi-box"></i> GST of Products</h2>
                <table id="productTable" class="table table-bordered table-hover">
                    <thead class="table-header">
                        <tr>
                            <th>S.No</th>
                            <th>Product Name</th>
                            <th>GST</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${productGstDetails}" varStatus="status">
                            <tr>
                                <td>${status.count}</td> <!-- Display serial number -->
                                <td>${product.productName}</td>
                                <td>${product.gst}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div id="productPagination" class="pagination"></div>
            </div>
        </div>
        
         <div class="download-btn">
            <a href="downloadExcel" class="btn btn-primary">
                <i class="bi bi-download"></i> Download Excel
            </a>
        </div>
    </div>
   

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Pagination Script -->
    <script>
        function paginateTable(tableId, paginationId, rowsPerPage) {
            const table = document.getElementById(tableId);
            const pagination = document.getElementById(paginationId);
            const rows = Array.from(table.getElementsByTagName("tr")).slice(1); // Skip header row
            const pageCount = Math.ceil(rows.length / rowsPerPage);
            let currentPage = 1;

            function renderPage(page) {
                rows.forEach((row, index) => {
                    row.style.display = (index >= (page - 1) * rowsPerPage && index < page * rowsPerPage) ? "" : "none";
                });
            }

            function renderPagination() {
                pagination.innerHTML = "";
                for (let i = 1; i <= pageCount; i++) {
                    const pageLink = document.createElement("button");
                    pageLink.innerText = i;
                    pageLink.onclick = () => {
                        currentPage = i;
                        renderPage(currentPage);
                    };
                    pagination.appendChild(pageLink);
                }
            }

            renderPagination();
            renderPage(currentPage);
        }

        document.addEventListener("DOMContentLoaded", function () {
            paginateTable("customerTable", "customerPagination", 5);
            paginateTable("productTable", "productPagination", 5);
        });
    </script>
</body>
</html>
