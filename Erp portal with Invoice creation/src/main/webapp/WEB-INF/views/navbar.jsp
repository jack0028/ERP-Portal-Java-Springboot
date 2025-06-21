<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&display=swap" rel="stylesheet">
</head>

<style>
    .navbar {
        background-color: #0056b3;
    }

    .navbar-custom {
        background-color: #0056b3;
        border-top: 4px solid #0056b3;
    }

    .navbar-custom .navbar-brand {
        font-size: 28px; /* Increased font size for title */
        font-family: 'Great Vibes', cursive; /* Applied Great Vibes font */
        color: #ffffff !important; /* White color for the title */
        display: flex;
        align-items: center;
    }

    .navbar-custom .navbar-brand img {
        height: 40px; /* Adjust the logo size */
        margin-right: 10px; /* Add some space between logo and text */
    }

    .navbar-custom .navbar-nav > li > a:hover {
        background-color: #004085 !important;
        border-radius: 4px;
    }

    .navbar-custom .navbar-nav {
        display: flex;
        justify-content: flex-end;
        flex-grow: 1;
    }

    .navbar-custom .navbar-collapse {
        text-align: center;
    }

    .navbar .nav-link {
        color: #ffffff !important;
        padding: 8px 12px;
    }

    .navbar .nav-link:hover {
        background-color: #004085 !important;
        border-radius: 4px;
    }

    .dropdown {
        margin-right: -20px;
        margin-top: -5px;
    }

    .dropdown-menu {
        min-width: 160px;
        padding: 8px;
    }

    .dropdown-item i {
        margin-right: 3px;
    }
    /* Style for the navbar toggler */
/* Style for the navbar toggler */
.navbar-toggler {
    border: 2px solid #ffffff; /* White border */
    border-radius: 4px; /* Rounded corners */
    outline: none; /* Remove focus outline */
    background-color: transparent; /* Transparent background */
    padding: 5px; /* Add padding for a larger click area */
    transition: background-color 0.3s ease, border-color 0.3s ease; /* Smooth transition */
}

/* Style for the toggler icon */
.navbar-toggler-icon {
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 24px; /* Size of the icon */
    color: #ffffff; /* Icon color */
}

/* Hover effect for the toggler button */
.navbar-toggler:hover {
    background-color: rgba(255, 255, 255, 0.1); /* Light white background on hover */
    border-color: #d4d4d4; /* Light gray border on hover */
}

@media (max-width: 768px) {
    .navbar-toggler {
        margin-right: 15px; /* Adjust margin to align better */
    }
}

    
</style>

<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container-fluid">
        <!-- Added logo image before the title -->
        <a class="navbar-brand" href="/reports">
            <img src="/business.jpg" alt="Logo">
            Business Planning
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
<span class="navbar-toggler-icon">
    <i class="fas fa-bars"></i>
</span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/reports"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/orders"><i class="fas fa-file-invoice"></i> Invoice</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/newPurchase"><i class="fas fa-shopping-cart"></i> Purchase</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/gstFile"><i class="fas fa-file-alt"></i> GST File</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/expenses"><i class="fas fa-credit-card"></i> Expenses</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/payment"><i class="fas fa-hand-holding-usd"></i> Payment</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/Balance"><i class="fas fa-balance-scale"></i> Balance</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/customers"><i class="fas fa-user"></i> Customers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/settings"><i class="fas fa-cogs"></i> Settings</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/stock"><i class="fas fa-cubes"></i> Stock</a>
                </li>
                <li class="nav-item">
                    <span class="nav-link">${sessionScope.companyName}</span>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img src="/companyLogo?companyId=${sessionScope.companyId}" class="rounded-circle" alt="Profile" width="40" height="40">
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="/profile">
                            <i class="fas fa-user"></i> View Profile
                        </a>
                        <a class="dropdown-item" href="/logout">
                            <i class="fas fa-sign-out-alt"></i> Log Out
                        </a>
                    </div>
                </li>
            </ul>
            <input type="hidden" id="companyId" value="${sessionScope.companyId}">
        </div>
    </div>
</nav>
