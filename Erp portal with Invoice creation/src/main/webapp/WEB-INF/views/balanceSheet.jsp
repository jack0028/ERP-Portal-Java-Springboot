<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Balance Sheet</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Custom styles for the Balance Sheet */
        .balance-sheet-heading {
            color: #0056b3;
            text-align: center;
            margin-top: 20px;
            font-size: 1.8rem;
        }

        .balance-column {
            background-color: #e3f2fd;
            padding: 20px;
            border-radius: 5px;
        }

        .total-text {
            font-weight: bold;
            font-size: 1.7rem;
            color: #003366;
            text-align: right;
        }

        .amount {
            color: #003366;
            font-size: 1.2rem;
        }

        .view-btn {
            margin-left: 10px;
            font-size: 0.9rem;
        }

        @media (max-width: 576px) {
            .balance-sheet-heading {
                font-size: 1.5rem;
            }

            .balance-column {
                padding: 15px;
            }

            .total-text {
                text-align: center;
            }

            .amount {
                font-size: 1rem;
            }

            .view-btn {
                margin-left: 0;
                margin-top: 5px;
                display: block;
                text-align: center;
            }
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container mt-5">
    <!-- Heading -->
    <h2 class="balance-sheet-heading"><i class="bi bi-balance-scale"></i> Balance Sheet</h2>

    <div class="row mt-4">
        <!-- First Column -->
        <div class="col-md-6">
            <div class="balance-column">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="text-primary">Purchase</h5>
                    <a href="/purchaseList" class="btn btn-sm btn-primary view-btn">View</a>
                </div>
                <p class="amount" id="purchaseAmount">Rs.${purchaseAmount != null ? purchaseAmount : 0}</p>

                <div class="d-flex justify-content-between align-items-center mt-4">
                    <h5 class="text-primary">Expenses</h5>
                    <a href="/expenseList" class="btn btn-sm btn-primary view-btn">View</a>
                </div>
                <p class="amount" id="expensesAmount">Rs. ${expenseAmount != null ? expenseAmount : 0}</p>

                <hr>
                <div class="total-text">
                    Total: Rs. ${ (purchaseAmount != null ? purchaseAmount : 0) + (expenseAmount != null ? expenseAmount : 0) }
                </div>
            </div>
        </div>

        <!-- Second Column -->
        <div class="col-md-6">
            <div class="balance-column">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="text-primary">Sales</h5>
                    <a href="/sales" class="btn btn-sm btn-primary view-btn">View</a>
                </div>
                <p class="amount" id="salesAmount">Rs. ${salesAmount != null ? salesAmount : 0}</p>

                <hr>
                <div class="total-text">
                    Total: Rs.${salesAmount != null ? salesAmount : 0}
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
