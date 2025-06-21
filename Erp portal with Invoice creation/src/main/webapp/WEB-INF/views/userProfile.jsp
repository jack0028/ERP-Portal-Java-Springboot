<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Profile</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #e0f7fa, #ffffff);
            min-height: 100vh;
            margin-bottom: 10px;
        }
        .top-section {
        background: linear-gradient(135deg, #8093fc, #002574);
            border-radius: 20px 20px 0 0;
            padding: 40px 20px;
            color: #ffffff;
            text-align: center;
            position: relative;
            margin-bottom: -40px;
            z-index: 1;
        }
        .profile-card {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            margin-top: 40px;
        }
        .profile-card .profile-pic {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #17a2b8;
            margin-top: -65px;
            z-index: 2;
            position: relative;
        }
        .profile-card .info {
            color: #0056b3;
            font-weight: 700;
            margin-top: 15px;
        }
        .profile-card .details {
            text-align: left;
            margin-top: 20px;
            color: #333;
        }
        .details .icon {
            font-size: 1.2rem;
            color: #17a2b8;
            margin-right: 10px;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container mt-5 pb-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="top-section">
                <h2>Company Profile</h2>
            </div>
            <div class="profile-card">
                <!-- Display company logo -->
                <c:if test="${not empty company.logo}">
                    <img src="/companyLogo?companyId=${company.companyId}" class="profile-pic" alt="Company Logo">
                </c:if>
                <h3 class="info">${company.businessName}</h3>
                <p class="text-muted">${company.gstNo}</p>

                <div class="details">
                    <p><i class="fas fa-map-marker-alt icon"></i> <strong>Address:</strong> ${company.address}</p>
                    <p><i class="fas fa-users icon"></i> <strong>Employees Count:</strong> ${company.employees}</p>
                    <p><i class="fas fa-phone-alt icon"></i> <strong>Phone:</strong> ${company.phone}</p>
                    <p><i class="fas fa-calendar-alt icon"></i> <strong>Start Year:</strong> ${company.startYear}</p>
                    <p><i class="fas fa-chart-line icon"></i> <strong>Yearly Turnover:</strong> ${company.yearlyTurnover}</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
