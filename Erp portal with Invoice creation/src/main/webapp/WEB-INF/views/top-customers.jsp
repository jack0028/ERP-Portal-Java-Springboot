<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Top Customers</title>
<!-- Use full jQuery version -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
    body {
        background-color: #f8f9fa;
    }
    .container {
        background-color: #ffffff;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    }
    .section-title {
        color: #FFDD00;
        font-weight: bold;
        text-transform: uppercase;
        border-bottom: 2px solid #FFDD00;
        padding-bottom: 5px;
    }
    .row-header {
        background-color: #FFDD00;
        color: #Gold;
        padding: 10px 0;
    }
    .customer-row {
        padding: 10px 0;
    }
    .customer-row:nth-child(even) {
        background-color: #f1f3f5;
    }
    .font-weight-bold {
        font-weight: bold;
    }
    
        .modal-content {
        background-color: #f8f9fa;
        border-radius: 8px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
    }

    /* Modal header styling */
    .modal-header {
        background-color: #FFDD00;
        color: #333333;
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
    }

    .modal-title {
        font-weight: bold;
    }

    /* Close button styling */
    .close {
        color: #333333;
        opacity: 0.8;
    }
    .close:hover {
        opacity: 1;
    }

    /* Table styling */
    .table-bordered {
        background-color: #ffffff;
    }
    
    /* Table header */
    .table thead th {
        background-color: #FFDD00;
        color: #333333;
        font-weight: bold;
    }

    /* Table row styling */
    .table tbody tr:nth-child(even) {
        background-color: #f1f3f5;
    }
    .table tbody tr:nth-child(odd) {
        background-color: #ffffff;
    }
    
    /* Font weight for field labels in modal */
    .modal-body .form-group label {
        color: #333333;
        font-weight: bold;
    }

    /* Data field styling */
    .modal-body .form-group div {
        color: #555555;
    }
</style>
</head>
<body>
 <%@ include file="navbar.jsp" %>
<div class="container mt-4">
    <h2 class="section-title text-center mb-4"><i class="fas fa-trophy"></i> Top Customers</h2>
    <div class="row row-header">
        <div class="col-4 font-weight-bold">Customer Name</div>
        <div class="col-4 font-weight-bold">Total Amount</div>
        <div class="col-4 font-weight-bold">Actions</div>
    </div>

    <c:forEach items="${topCustomers}" var="customer">
        <div class="row customer-row">
            <div class="col-4">${customer.customerName}</div>
            <div class="col-4">${customer.totalAmount}</div>
            <div class="col-4">
                <button type="button" class="btn btn-info btn-sm" onclick="viewHistory('${customer.customerName}')">History</button>
            </div>
        </div>
    </c:forEach>
</div>

<!-- Modal for History -->
<div class="modal fade" id="historyModal" tabindex="-1" role="dialog" aria-labelledby="historyModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="historyModalLabel"><i class="fas fa-history"></i> <!-- History icon -->
                Customer History</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
           
           
           <div class="modal-body">
    <div class="form-group d-flex justify-content-between">
        <label for="customerDetailsName" class="w-25"><strong>Name:</strong></label>
        <div id="customerDetailsName" class="w-75"></div>
    </div>
    <div class="form-group d-flex justify-content-between">
        <label for="customerDetailsAddress" class="w-25"><strong>Address:</strong></label>
        <div id="customerDetailsAddress" class="w-75"></div>
    </div>
    <div class="form-group d-flex justify-content-between">
        <label for="customerDetailsState" class="w-25"><strong>State:</strong></label>
        <div id="customerDetailsState" class="w-75"></div>
    </div>
    <div class="form-group d-flex justify-content-between">
        <label for="customerDetailsGstNo" class="w-25"><strong>GST No:</strong></label>
        <div id="customerDetailsGstNo" class="w-75"></div>
    </div>
    <div class="form-group d-flex justify-content-between">
        <label for="customerDetailsPhone" class="w-25"><strong>Phone:</strong></label>
        <div id="customerDetailsPhone" class="w-75"></div>
    </div>




                <table class="table table-bordered">
                    <thead>
                        <tr>
                        <th>S.No</th>
                            <th>Bill No</th>
                            <th>Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="productDetailsTable"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (include it at the bottom after jQuery) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
function viewHistory(customerName) {
    $.ajax({
        url: '/reports/getTopCustomers/' + encodeURIComponent(customerName),
        method: 'GET',
        success: function(data) {
            console.log("Data received from server:", data);  // Log the whole data structure

            if (data.customer && data.history) {
                console.log("Customer details:", data.customer);
                console.log("History list:", data.history);

                // Display customer information in the modal
                document.getElementById('customerDetailsName').innerHTML = data.customer.name;
                document.getElementById('customerDetailsAddress').innerHTML = data.customer.address;
                document.getElementById('customerDetailsState').innerHTML = data.customer.state;
                document.getElementById('customerDetailsGstNo').innerHTML = data.customer.gstno;
                document.getElementById('customerDetailsPhone').innerHTML = data.customer.phone;

                // Initialize serial number for history rows
                let serialNumber = 1;

                // Clear existing rows in the product details table
                $('#productDetailsTable').empty();

                // Iterate over the history list to append billNo and date details to the table
                for (var i in data.history) {
                    const history = data.history[i];

                    $('#productDetailsTable').append("<tr> \
                        <td>" + serialNumber++ + "</td> <!-- Serial Number --> \
                        <td>" + history.billNo + "</td> \
                        <td>" + history.date + "</td> \
                        <td><button class='btn btn-primary btn-sm' onclick='viewInvoice(\"" + history.billNo + "\")'>View</button></td> \
                    </tr>");
                }

                // Show the modal after populating the data
                $('#historyModal').modal('show');
            } else {
                console.error("Error: Expected data format is missing.");
                alert("Error: Data not found.");
            }
        },
        error: function(error) {
            console.error("Error fetching data: ", error);
        }
    });
}


function viewInvoice(billNo) {
    // Get the companyId from the hidden input field in the navbar
    var companyId = document.getElementById('companyId').value;

    // Redirect to the 'selectLayout' page with companyId and billNo as query parameters
    window.location.href = '/selectLayout?companyId=' + encodeURIComponent(companyId) + '&billNo=' + encodeURIComponent(billNo);
}

</script>

</body>
</html>
