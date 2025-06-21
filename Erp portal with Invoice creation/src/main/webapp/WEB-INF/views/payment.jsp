<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Status</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script>
    function sendBillNo(){
        var billNo = parseInt("${paymentDetails.billNo}", 10) || 0;
        console.log("Billno: " + billNo);
        document.getElementById("billNo").value = billNo;
    }

        function calculatePaidAmount() {
            var inputAmount = parseFloat(document.getElementById("amount").value) || 0;
            var pendingAmount = parseFloat("${paymentDetails.pendingAmount}") || 0;
            var billAmount = parseFloat("${paymentDetails.billAmount}") || 0;
            var billNo = parseInt("${paymentDetails.billNo}", 10) || 0;
            console.log("Billno: " + billNo);
            document.getElementById("billNo").value = billNo;
            
            // Calculate the new paid amount
            var paidAmount = billAmount - (pendingAmount - inputAmount);
            var pending = billAmount -paidAmount;

            document.getElementById("paidAmount").value = paidAmount.toFixed(2);
            document.getElementById("pending").value = pending.toFixed(2);

            
        }
    </script>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <!-- Add this in your <head> section -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    
</head>
<body class="bg-light">
<%@ include file="navbar.jsp" %>
<div class="container mt-5">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-primary text-white"><h2>
<i class="bi bi-clock" style="font-size: 28px; color: #ffffff; background-color: #007bff; border-radius: 50%; padding: 8px; "></i>
 <!-- Yellow clock icon for pending status -->
            Payment Status</h2>
        </div>
        <div class="card-body">
            <form method="get" action="/searchPaymentStatus" class="form-inline mb-4">
                <label for="invoiceNo" class="mr-2 font-weight-bold">Invoice No:</label>
                <input type="text" id="invoiceNo" name="invoiceNo" class="form-control mr-2" required>
                <button type="submit" class="btn btn-primary" onclick="sendBillNo()">Search</button>
            </form>
            
            <c:if test="${not empty paymentDetails}">
                <h4 class="text-primary"> <!-- Person icon -->
<i class="bi bi-person-lines-fill"></i>
                 Customer Payment Details</h4>
               <ul class="list-group mb-4">
    <li class="list-group-item"><strong>Name:</strong> ${paymentDetails.name}</li>
    <li class="list-group-item"><strong>Bill No:</strong> ${paymentDetails.billNo}</li>
    <li class="list-group-item"><strong>Bill Amount:</strong> ${paymentDetails.billAmount}</li>
    <li class="list-group-item"><strong>Paid Amount:</strong> ${paymentDetails.paidAmount}</li>
    <li class="list-group-item"><strong>Pending Amount:</strong> ${paymentDetails.pendingAmount}</li>
    <li class="list-group-item">
        <button 
            class="btn btn-primary" 
            onclick="redirectToLayout('${paymentDetails.billNo}')">
            <i class="fa fa-eye me-2"></i> View
        </button>
    </li>
   </ul>
                
                <form method="post" action="/processPayment" onsubmit="calculatePaidAmount()" class="border p-4 bg-white rounded">
                    <div class="form-group">
                        <label for="amount" class="font-weight-bold">Amount:</label>
                        <input type="number" id="amount" name="amount" class="form-control" required>
                    </div>
                    
                    <input type="hidden" id="paidAmount" name="paidAmount">
                    <input type="hidden" id="billNo" name="billNo" value="${paymentDetails.billNo}">
                                        <input type="hidden" id="pending" name="pending">
                    
                                        <input type="hidden" id="name" name="name" value="${paymentDetails.name}">
                    
                    <div class="form-group">
                        <p class="font-weight-bold">Mode of Payment:</p>
                        <div class="form-check form-check-inline">
                            <input type="radio" id="creditCard" name="modeOfPayment" value="Credit Card" class="form-check-input" required>
                            <label for="creditCard" class="form-check-label">Credit Card</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input type="radio" id="cash" name="modeOfPayment" value="Cash" class="form-check-input" required>
                            <label for="cash" class="form-check-label">Cash</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input type="radio" id="upi" name="modeOfPayment" value="UPI" class="form-check-input" required>
                            <label for="upi" class="form-check-label">UPI</label>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary"><i class="bi bi-arrow-right-circle"></i> <!-- Arrow right icon for submit -->
                     Submit Payment</button>
                </form>
            </c:if>
            
            <c:if test="${empty paymentDetails && not empty invoiceNo}">
                <div class="alert alert-warning mt-4" role="alert">
                    No payment details found for the given invoice number.
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- Include Bootstrap JS (Optional for advanced interactions) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function redirectToLayout(billNo) {
        // Get companyId from the hidden field or another source
        var companyId = document.getElementById('companyId').value;

        // Redirect to the 'selectLayout' page with query parameters
        window.location.href = '/selectLayout?companyId=' + encodeURIComponent(companyId) + '&billNo=' + encodeURIComponent(billNo);
    }
</script>
</body>
</html>
