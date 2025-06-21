<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Report</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    
    
   <style>
 body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        background-image: linear-gradient(to top, #eef0f7 0%, #f7f9fa 100%);
        }
 /* Elegant Dashboard Header with Centering */
.elegant-dashboard-header {
    background-color: #e3f2fd; /* Light blue pastel background */
    color: #333333; /* Darker text for contrast */
    padding: 20px 30px;
    border-radius: 8px;
    display: inline-block;
    font-size: 2rem;
    font-weight: bold;
    letter-spacing: 1px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    text-align: center;

    justify-content:center;
        align-items: center;
    
}



/* Icon Style for Header */
.elegant-dashboard-icon {
    color: #0056b3; /* Light blue shade for the icon */
    margin-right: 12px;
}

/* Centering the header within the page */


      
        .container h1 {
            font-weight: 700;
            color: #495057;
        }
/* Stylish Dashboard Header */
.stylish-dashboard-header {
    background: linear-gradient(135deg, #4ecca3, #b04eab); /* Teal to Purple gradient */
    color: #ffffff;
    padding: 15px 20px;
    border-radius: 10px;
    display: inline-block;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
    font-size: 2rem;
    font-weight: bold;
}

/* Icon Style for Header */
.stylish-dashboard-icon {
    color: #e0e0e0; /* Soft white for the icon */
    margin-right: 10px;
}

 
        
        /* Card styles */
        .card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: left;
            color: #333;
            height: 100%;
        }

        .card-body {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .card-body h2 {
            font-size: 2rem;
            margin: 0;
            font-weight: 600;
        }

        .card-body p {
            font-size: 1rem;
            margin: 0;
            font-weight: 400;
            color: #666;
        }

        .card-footer {
        background: linear-gradient(45deg, rgba(0,0,0,0.1), rgba(0,0,0,0.3));
        color: white;
        font-size: 0.9rem;
        font-weight: 500;
        padding: 10px;
        border-radius: 0 0 10px 10px;
        display: flex;
        justify-content: center; /* Center the link */
        align-items: center;
    }

    /* Link styling */
    .card-footer a {
        background-color: transparent;
        color: white;
        border: none;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 5px;
        padding: 2px;
    }

    .card-footer a:hover {
        color: #ddd;
            text-decoration: none;
        
    }

        /* Card-specific colors */
        .card.earnings {
            border-top: 4px solid #f39c12;
            color: #f39c12;
        }
        .card.earnings .card-footer {
            background: linear-gradient(45deg, #fabf61, #e67e22);
        }

        .card.views {
            border-top: 4px solid #28a745;
            color: #28a745;
        }
        .card.views .card-footer {
            background: linear-gradient(45deg, #5dd87a, #218838);
        }

        .card.tasks {
            border-top: 4px solid #e74c3c;
            color: #e74c3c;
        }
        .card.tasks .card-footer {
            background: linear-gradient(45deg, #fd7a6c, #c0392b);
        }

        .card.downloads {
            border-top: 4px solid #17a2b8;
            color: #17a2b8;
        }
        .card.downloads .card-footer {
            background: linear-gradient(45deg, #6cdbec, #138496);
        }

        /* Icon styling */
        .icon {
            font-size: 2rem;
        }

        .chart-container {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }

        .chart-card {
            width: 48%;
        }
         canvas {
            height: 350px !important; /* Smaller height on small devices */
        }
       
/* Chart header styles */
.chart-card .card-header {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: white;
    font-size: 1.25rem;
    font-weight: 600;
    padding: 10px 15px;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
}

.chart-card .card-header i {
  /* Icon color (e.g., golden yellow) */
    margin-right: 10px;
}

.chart-card .card-header div {
    color: white;
}

/* Table header styles */
.table thead {
    background-color: #0056b3; /* Set a custom color */
    color: #ffffff; /* White text color */
    font-weight: 600;
}

.table thead th {
    padding: 12px; /* Add padding for readability */
    text-align: center; /* Center align header text */
     background-color: #0056b3; /* Change to any desired color */
    color: white;
}


.table tbody tr td {
    text-align: center; /* Center align all table cells */
}


        .table tbody tr {
            transition: all 0.2s ease-in-out;
        }

        .table tbody tr:hover {
            background-color: #e2e6ea;
        }

        .table tbody tr td {
            font-size: 14px;
        }

        .card-table {
            background-color: white;
            padding: 20px;
            border-radius: 12px;
        }

        .card h1 {
            text-align: center;
        }
        
        .custom-icon-size {
              font-size: 3.5rem; /* Adjust this value as needed */
}
/* Stylish Blue Header */
.stylish-blue-header {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: #ffffff;
    font-weight: 600;
    font-size: 1.2rem;
    padding: 10px;
    border-top-left-radius: 8px;
    border-top-right-radius: 8px;
}

.stylish-blue-icon {
    color: #ffffff;
}

.stylish-blue-table thead {
    background: #007bff;
    color: #ffffff;
}

.stylish-blue-table tbody tr:hover {
    background-color: #e2f0ff;
}


        .btn-primary {
        background-color: #0056b3;
        border-color: #0056b3;
    }

        .btn-primary:hover {
            background-color: #004085;
        }

        .btn-link {
            color: #ff758c; /* Link color to match gradient */
            text-decoration: none;
        }
/* Make Cards Responsive */
@media (max-width: 768px) {
    /* Adjust card size and layout for small screens */
    .card {
        margin-bottom: 0.8rem;
    }

 canvas {
            height: 275px !important; /* Smaller height on small devices */
        }

        .card-header {
            font-size: 0.9rem; /* Slightly smaller text for smaller devices */
        }
    /* Make charts responsive */
    .chart-container {
        flex-direction: column;
        gap: 15px;
    }

    .chart-card {
        width: 100%;
    }

    /* Adjust table layout for smaller screens */
    .table-responsive {
        -webkit-overflow-scrolling: touch;
        overflow-x: auto;
    }

    .table th, .table td {
        font-size: 12px; /* Reduce font size for better readability on small screens */
        padding: 8px 10px;
    }

    /* Adjust the table header */
    .table thead {
        font-size: 14px;
    }

    /* Reduce padding in table header and cells */
    .table th, .table td {
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow: hidden;
    }

    /* Adjust the icons in the cards */
    .icon i {
        font-size: 2.1rem; /* Smaller icon size for better layout */
    }

    /* Make header text smaller */
    .elegant-dashboard-header {
        font-size: 1.5rem; /* Smaller font size on small screens */
    }
    
    .card-footer a {
        font-size: 0.85rem; /* Smaller font size for links */
    }
    
    /* Ensure consistent spacing */
    .container-fluid {
        padding-left: 15px;
        padding-right: 15px;
    }
}

        
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container-fluid">
   
<!-- Dashboard Header -->
<div class="d-flex justify-content-center align-items-center mb-2">
    <h1 class="mt-4 mb-4 text-center elegant-dashboard-header">
        <i class="fas fa-home fa-lg elegant-dashboard-icon"></i> Dashboard
    </h1>
</div>



<div class="row g-3">
            <!-- Earnings Card -->
            <div class="col-lg-3 col-md-6">
                <div class="card earnings">
                    <div class="card-body">
                        <div>
                            <h2> ${last10DaysInvoiceCount}</h2>
                            <p>Recent Invoice</p>
                        </div>
                        <div class="icon"><i class="fas fa-clock fa-2x"></i></div>
                    </div>
                    <div class="card-footer">
                        <a href="/reports/getRecentInvoice">View Details <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>

            <!-- Page Views Card -->
            <div class="col-lg-3 col-md-6">
                <div class="card views">
                    <div class="card-body">
                        <div>
                            
                            <p>Top Customers</p>
                        </div>
                        <div class="icon"><i class="fas fa-users fa-2x"></i></div>
                    </div>
                    <div class="card-footer">
                        <a href="/reports/getTopCustomers">View Details <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>

            <!-- Tasks Completed Card -->
            <div class="col-lg-3 col-md-6">
                <div class="card tasks">
                    <div class="card-body">
                        <div>
                            <p>Top Products</p>
                        </div>
                        <div class="icon"><i class="fas fa-chart-line fa-2x"></i></div>
                    </div>
                    <div class="card-footer">
                        <a href="/reports/getTrendingProducts">View Details <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>

            <!-- Downloads Card -->
            <div class="col-lg-3 col-md-6">
                <div class="card downloads">
                    <div class="card-body">
                        <div>
                            <h2>${totalSalesAmount}</h2>
                            <p>Total Sales</p>
                        </div>
                        <div class="icon"><i class="fas fa-coins fa-2x"></i></div>
                    </div>
                    <div class="card-footer">
                        <a href="/reports/getTotalSales">View Details <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
        </div>
<!-- Charts -->
<div class="chart-container mt-4">
    <!-- Daily Sales Chart -->
    <div class="card chart-card">
        <div class="card-header d-flex align-items-center">
            <i class="fas fa-calendar-day fa-2x me-3"></i><div class="pl-2"> Daily Sales</div>
        </div>
        <div class="card-body">
            <canvas id="areaChart"></canvas>
        </div>
    </div>

    <!-- Product Sales Chart -->
    <div class="card chart-card">
        <div class="card-header d-flex align-items-center">
            <i class="fas fa-chart-column fa-2x me-3"></i> <div class="pl-2">Product Sales</div>
        </div>
        <div class="card-body">
        
            <canvas id="barChart"></canvas>
        </div>
    </div>
</div>

<!-- Data Table -->
<div class="card mt-4">
    <div class="card-header d-flex align-items-center stylish-blue-header">
        <i class="fas fa-table fa-2x me-3 stylish-blue-icon"></i> <div class="pl-2">Last Invoices Table</div>
    </div>
    <div class="card-body">
    <div class="table-responsive"> <table class="table table-bordered table-hover stylish-blue-table">
            <thead>
                <tr>
                    <th>S.No</th>
                    <th>Name</th>
                    <th>Place</th>
                    <th>Date</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table></div>
       
    </div>
</div>

</div>

<!-- Chart Initialization Script -->
<script>
$(document).ready(function() {
    var companyId = document.getElementById('companyId').value;

    fetchProductAmounts();
    loadLast10Invoices();
	
    function loadLast10Invoices() {
        $("tbody").empty(); // Clear existing rows
        $.ajax({
            type: "GET",
            contentType: "application/json",
            url: "/reports/getLast10Invoices", 
            success: function(data) {
                var users = data; 
                var serialNumber = 1; // Start serial number from 1
                for (var i in users) {
                    $("tbody").append("<tr> \
                        <td>" + serialNumber++ + "</td> <!-- Serial Number --> \
                        <td>" + users[i].customerName + "</td> \
                        <td>" + users[i].place + "</td> \
                        <td>" + users[i].lastPurchaseDate + "</td> \
                        <td>" + users[i].totalAmount + "</td> \
                    </tr>");
                }
            },
            error: function(xhr, status, error) {
                console.error('Error fetching last 10 invoices:', {
                    statusCode: xhr.status,
                    statusText: xhr.statusText,
                    responseText: xhr.responseText,
                    errorThrown: error
                });
            }
        });
    }


    // Fetch Daily Sales
    $.ajax({
        url: '/reports/getDailySales',
        method: 'GET',
        success: function(response) {
            const dailyAmounts = response.map(item => parseFloat(item.totalAmount));
            const dates = response.map(item => item.date); 
            const areaCtx = document.getElementById('areaChart').getContext('2d');
            const areaGradient = areaCtx.createLinearGradient(0, 0, 0, 400);
            areaGradient.addColorStop(0, 'rgba(54, 162, 235, 0.5)');
            areaGradient.addColorStop(1, 'rgba(54, 162, 235, 0)');

            new Chart(areaCtx, {
                type: 'line',
                data: {
                    labels: dates,
                    datasets: [{
                        label: 'Total Amount per Day',
                        data: dailyAmounts,
                        backgroundColor: areaGradient,
                        borderColor: 'rgba(54, 162, 235, 1)',
                        fill: true
                    }]
                },
                options: {
                	responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        x: { title: { display: true, text: 'Date' } },
                        y: { title: { display: true, text: 'Amount' }, beginAtZero: true }
                    }
                }
            });
        },
        error: function(error) {
            console.error('Error fetching daily sales:', error);
        }
        
    });
    
  
/*----------------------Product and amount chart-------------------------*/
    function fetchProductAmounts() {
        $.ajax({
            url: '/reports/getProductAmounts',
            method: 'GET',
            success: function(response) {
            	 console.log(response);
                const productNames = response.map(item => item.productName);
                const productAmounts = response.map(item => parseFloat(item.totalAmount));

                const barCtx = document.getElementById('barChart').getContext('2d');
                const barGradient = barCtx.createLinearGradient(0, 0, 0, 400);
                barGradient.addColorStop(0, 'rgba(148, 0, 211, 0.5)');
                barGradient.addColorStop(1, 'rgba(148, 0, 211, 0)');
                new Chart(barCtx, {
                    type: 'bar',
                    data: {
                        labels: productNames,
                        datasets: [{
                            label: 'Product Amount',
                            data: productAmounts,
                            backgroundColor: barGradient,
                            borderColor: 'rgba(148, 0, 211, 1)',      
                            borderWidth: 1
                        }]
                    },
                    options: {
                    	responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            x: { title: { display: true, text: 'Product Name' } },
                            y: { title: { display: true, text: 'Amount' }, beginAtZero: true }
                        }
                    }
                });
            },
            error: function(error) {
                console.error('Error fetching product amounts:', error);
            }
        });
    }
});

</script>

<!-- Bootstrap JS and dependencies -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

</body>
</html>

