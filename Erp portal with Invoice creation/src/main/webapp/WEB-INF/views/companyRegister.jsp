<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Business Registration Form</title>
    <!-- External CSS Libraries -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    
    
    <style>
        body {
            background-image: linear-gradient(to top, #cfd9df 0%, #e2ebf0 100%);
            font-family: 'Poppins', sans-serif;
        }

        .registration-container {
            background: linear-gradient(to bottom, #eff7ff, #ffffff);
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            max-width: 800px;
            margin: 30px auto;
        }

        .title-container {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            font-family: 'Great Vibes', cursive;
        }

        .title-container img {
            width: 65px;
            height: 65px;
            margin-right: 10px;
        }

        .title-container h1 {
            font-family: 'Great Vibes', cursive;
            font-size: 40px;
            font-weight: 300;
            color: #003366;
            margin: 0;
            margin-top: 10px;

        }

        .tagline {
            text-align: center;
            font-size: 16px;
            color: #0056b3;
            margin: 10px 0 20px 0;
            font-weight: 500;
        }

        h2 {
            text-align: center;
            font-size: 24px;
            font-weight: 600;
            color: #003366;
            margin-bottom: 30px;
        }

        label {
            color: #003366;
            font-weight: 500;
        }

        input, textarea, select {
            border: 1px solid #d1d9e6;
            border-radius: 6px;
            padding: 10px 15px;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .btn-register {
            background-color: #0056b3;
            color: #ffffff;
            border: none;
            border-radius: 6px;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin: 20px auto;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.3s ease;
            width: 50%;
        }

        .btn-register:hover {
            background-color: #004090;
        }

        .already-account {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #555;
        }

        .already-account a {
            color: #0056b3;
            text-decoration: none;
            font-weight: 600;
        }

        .already-account a:hover {
            text-decoration: underline;
        }
         @media (max-width: 576px) {
            .registration-container {
                padding: 20px;
            }

            .title-container h1 {
                font-size: 30px;
            }

            .tagline {
                font-size: 14px;
            }

            h2 {
                font-size: 20px;
            }

            .btn-register {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="registration-container">
        <!-- Title Section -->
        <div class="title-container">
            <img src="/business.jpg" alt="Business Logo"> <!-- Logo aligned to the left -->
            <h1>Business Planning</h1>
        </div>
        <p class="tagline">Join our growing family today!</p>
        <h2>Create New Account</h2>

        <!-- Registration Form -->
        <form action="/registerCompany" method="post" enctype="multipart/form-data">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="bName">Business Name:</label>
                        <input type="text" class="form-control" id="bName" name="businessName" placeholder="Enter your business name" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address:</label>
                        <textarea class="form-control" id="address" name="address" placeholder="Enter your business address" rows="1" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="startYear">Start Year:</label>
                        <input type="number" class="form-control" id="startYear" name="startYear" placeholder="Enter year of establishment" min="1900" max="2099" step="1" required>
                    </div>
                    <div class="form-group">
                        <label for="turnover">Yearly Turnover:</label>
                        <select class="form-control" id="turnover" name="turnover" required>
                            <option value="" disabled selected>Select Yearly Turnover</option>
                            <option value="5lpa">5 LPA</option>
                            <option value="10lpa">10 LPA</option>
                            <option value="15lpa">15 LPA</option>
                            <option value="20lpa">20 LPA</option>
                            <option value="25lpa">25 LPA</option>
                            <option value="30lpa">30 LPA</option>
                            <option value="35lpa">35 LPA</option>
                            <option value="40lpa">40 LPA</option>
                            <option value="45lpa">45 LPA</option>
                            <option value="50lpa">50 LPA</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="phone">Phone Number:</label>
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Enter phone number" pattern="[0-9]{10}" required>
                    </div>
                    <div class="form-group">
                        <label for="gstno">GST No:</label>
                        <input type="text" class="form-control" id="gstno" name="gstno" placeholder="Enter GST number" required>
                    </div>
                    <div class="form-group">
                        <label for="employees">No of Employees:</label>
                        <input type="number" class="form-control" id="employees" name="employees" placeholder="Enter number of employees" min="1" required>
                    </div>
                    <div class="form-group">
                        <label for="logo">Business Logo:</label>
                        <input type="file" class="form-control-file" id="logo" name="logo" accept="image/*">
                    </div>
                </div>
            </div>
            <div class="d-flex justify-content-center">
                <button type="submit" class="btn-register">
                    <i class="fa fa-user-plus"></i> Register Now
                </button>
            </div>
        </form>
        <div class="already-account">
            <p>Already have an account? <a href="/login">Login here</a></p>
        </div>
    </div>
</body>
</html>
