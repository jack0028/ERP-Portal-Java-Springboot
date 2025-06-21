<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to bottom, #b3daff, #ffffff);
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Inter', sans-serif;
        }

        .container-wrapper {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
        }

        .title-container {
            text-align: center;
            margin-bottom: 2rem;
        }

        .title-container h1 {
            font-family: 'Great Vibes', cursive;
            font-size: 3rem; /* Adjusted for smaller screens */
            color: #0D47A1;
            margin-bottom: 1rem;
            font-weight: 500;
        }

        .title-container img {
            height: 60px; /* Adjusted logo size */
            margin-bottom: 5px;
        }

        .login-container {
            background: #f0f5fa;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            width: 90%; /* Flexible width */
            max-width: 400px; /* Restrict max width */
            text-align: center;
            color: #0D47A1;
        }

        .login-container .form-control {
            border-radius: 5px;
        }

        .login-container .btn-primary {
            width: 100%;
            border-radius: 5px;
            background-color: #0D47A1;
            border: none;
        }

        .login-container .btn-primary:hover {
            background-color: #1A237E;
        }

        .social-buttons i {
            font-size: 1.5rem;
            margin: 0 10px;
            color: #333;
        }

        .social-buttons i:hover {
            color: #0D47A1;
        }

        @media (max-width: 576px) {
            .title-container h1 {
                font-size: 2.5rem; /* Smaller font size for very small devices */
            }

            .title-container img {
                height: 50px;
            }

            .login-container {
                padding: 1.5rem; /* Reduce padding for smaller screens */
            }
        }
    </style>
</head>
<body>

<div class="container-wrapper">
    <!-- Title Section -->
    <div class="title-container">
        <img src="/business.jpg" alt="Logo">
        <h1>Business Planning</h1>
    </div>

    <!-- Login Form Section -->
    <div class="login-container">
        <h5 class="mb-2">Sign into Your Account</h5>
        <p class="text-muted">Make a new doc to bring your words, data, and teams together. For free</p>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="input-group mb-3">
                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                <input type="text" name="gstNo" class="form-control" placeholder="GSTNo">
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                <input type="password" name="phoneNumber" class="form-control" placeholder="Phone Number">
            </div>
            <div class="text-end mb-3">
                <p class="d-inline text-muted">Don't have an account?</p>
                <a href="/register" class="text-primary ms-1">Register</a>
            </div>
            <button type="submit" class="btn btn-primary mb-3">Login</button>
        </form>
        
        <p class="text-muted">Or sign in with</p>
        <div class="social-buttons">
            <a href="#"><i class="fab fa-google"></i></a>
            <a href="#"><i class="fab fa-facebook"></i></a>
            <a href="#"><i class="fab fa-apple"></i></a>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
