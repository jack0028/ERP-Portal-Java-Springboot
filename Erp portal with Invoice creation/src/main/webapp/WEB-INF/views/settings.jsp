<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Settings</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css">
    
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 30px;
        }
        h2 {
            color: #007bff;
            font-weight: bold;
            font-size: 36px;
            text-align: center;
            margin-bottom: 30px;
            border-radius: 9px;
        }
        h4 {
            background-color: #007bff;
            color: #ffffff;
            font-weight: bold;
            padding: 15px;
            border-radius: 9px;
        }
        .card-body {
            background-color: #ffffff;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .icon-btn {
            margin-right: 10px;
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>
<div class="container mt-5">
    <h2 class="text-center mb-4">User Query and Backup</h2>

    <!-- Form for Sending an Email Query -->
    <div class="card mb-4">
        <div class="card-header">
            <h4><i class="bi bi-envelope icon-btn"></i>Send a Query</h4>
        </div>
        <div class="card-body">
            <form action="/queryAndBackup" method="post">
                <div class="form-group">
                    <label for="cname">Your Name:</label>
                    <input type="text" class="form-control" id="cname" name="cname" required>
                </div>
                <div class="form-group">
                    <label for="email">Your Email:</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="subject">Subject:</label>
                    <input type="text" class="form-control" id="subject" name="subject" required>
                </div>
                <div class="form-group">
                    <label for="message">Message:</label>
                    <textarea class="form-control" id="message" name="message" rows="4" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary"><i class="bi bi-send"></i> Send Query</button>
            </form>
        </div>
    </div>

    <!-- Form for Downloading User Details -->
    <div class="card">
        <div class="card-header">
            <h4><i class="bi bi-cloud-download icon-btn"></i>Download Database Backup</h4>
        </div>
        <div class="card-body text-center">
            <form action="${pageContext.request.contextPath}/backup" method="get">
                <button type="submit" class="btn btn-success">Download Database Backup</button>
            </form>
        </div>
    </div>

    <!-- Success Message -->
    <c:if test="${not empty emailSuccess}">
        <div class="alert alert-success mt-4">${emailSuccess}</div>
    </c:if>
</div>

</body>
</html>
