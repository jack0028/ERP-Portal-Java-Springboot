<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Select Layout</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #f1f3f5;
            font-family: 'Arial', sans-serif;
        }

        h2 {
            color: #007bff;
        }
        h3{
             color: #0056b3;
        }

        .card {
            border: none;
            border-radius: 10px;
        }

        .card-header {
            background-color: #e9ecef;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            transition: background-color 0.3s, border-color 0.3s;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        iframe {
            border: 1px solid #dee2e6;
            border-radius: 8px;
        }

        .card-footer {
            background-color: #f8f9fa;
        }

        .icon {
            font-size: 50px;
            color: #007bff; /* Same as the header color */
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Select Invoice Layout</h2>

        <div class="row">
            <!-- Layout 1 -->
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header text-center">
                        <i class="fas fa-file-invoice icon"></i> <!-- Layout 1 icon -->
                        <h3>Layout 1</h3>
                    </div>
                    <div class="card-body">
                        <iframe src="hello.html" class="w-100" style="height: 600px;"></iframe>
                    </div>
                    <div class="card-footer text-center">
                        <form action="/viewInvoice" method="get">
                            <input type="hidden" name="layout" value="invoice1">
                            <input type="hidden" name="companyId" value="${companyId}">
                            <input type="hidden" name="billNo" value="${billNo}">
                            <button type="submit" class="btn btn-primary">Select Layout 1</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Layout 2 -->
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header text-center">
                        <i class="fas fa-file-invoice icon"></i> <!-- Layout 2 icon -->
                        <h3>Layout 2</h3>
                    </div>
                    <div class="card-body">
                        <iframe src="invo2.html" class="w-100" style="height: 600px;"></iframe>
                    </div>
                    <div class="card-footer text-center">
                        <form action="/viewInvoice" method="get">
                            <input type="hidden" name="layout" value="invoice2">
                            <input type="hidden" name="companyId" value="${companyId}">
                            <input type="hidden" name="billNo" value="${billNo}">
                            <button type="submit" class="btn btn-primary">Select Layout 2</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
