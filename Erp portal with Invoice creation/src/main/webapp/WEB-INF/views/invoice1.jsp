<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Invoice 1</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

    <style>
   body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #636363;
    }

    .container {
        width: 800px;
        margin: 4pc auto;
        padding: 20px;
        background-color: #ffffff;
    }

    .header-section {
        display: flex;
        justify-content: flex-start;
        align-items: flex-start;
        position: relative;
    }

    .logo {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        background-color: #ec7019;
    }

    .logo img {
        width: 100%;
        height: 100%;
    }

    .company-details {
        position: absolute;
        top: 100px;
        left: 0;
        text-align: left;
        margin-bottom: 10px;
        margin-top: -25px;
    }

    .company-details h4 {
        color: #c01600;
        margin-bottom: 4px;
        font-size: 16px;
        font-weight: bold;
    }

    .company-details p {
        margin: 0;
        font-size: 12px;
    }

    .rightdetails {
        text-align: right;
        margin-left: auto;
    }

    .rightdetails h1 {
        color: #c01600;
        font-size: 28px;
        margin: 0%;
    }

    h1 {
        font-size: 26px;
        font-weight: bold;
        color: #c01600;
    }

    .clearfix {
        clear: both;
    }

    .from-to-section {
        margin-top: 4pc;
        display: block;
    }

    .from, .to {
        width: 100%;
        margin-top: 20px;
    }

    .from h4, .to h4 {
        margin-bottom: 4px;
        font-size: 14px;
        font-weight: bold;
    }

    .from p, .to p {
        margin: 2px 0;
        font-size: 12px;
    }

    .invoice-info {
        text-align: right;
        font-size: 14px;
        margin-top: -30px;
    }

    .invoice-table {
        width: 100%;
        margin-top: 10px;
        border-collapse: collapse;
        border-spacing: 0;
    }

    .invoice-table th, .invoice-table td {
        padding: 10px;
        font-size: 14px;
        border: none;
    }

    .invoice-table th {
        background-color: #c01600;
        font-weight: bold;
        color: #fdfdfd;
        text-align: left;
    }

    .invoice-table tbody tr td:nth-child(3),
    .invoice-table tbody tr td:nth-child(4),
    .invoice-table tbody tr td:nth-child(5) {
        text-align: right;
    }

    .invoice-table tbody tr {
        background-color: #f8f8f8;
    }

    .total-summary {
        width: 50%;
        float: right;
        margin-top: 20px;
        border-collapse: collapse;
        font-size: 14px;
    }

    .total-summary td {
        padding: 5px;
        text-align: right;
        font-size: 13px;
    }

    .total-summary .label {
        text-align: center;
        color: rgb(0, 0, 0);
    }

    .total-summary .label1 {
        text-align: center;
        font-weight: bold;
    }

    .total-summary tr {
        border-bottom: 1px solid #ffffff;
    }

    .total-summary tr:last-child {
        border-bottom: none;
        background-color: #c01600;
        color: #fff;
    }

    .notes {
        margin-top: 15pc;
        font-size: 14px;
        margin-bottom: 5px;
    }

    .notes h4, .terms h4 {
        font-weight: bold;
    }

    .terms {
        margin-top: 2pc;
        margin-bottom: 10px;
    }

    .notes p, .terms p {
        margin: 0;
    }
      @media print {
    body {
        background-color: #ffffff !important;
    }
    
    .container {
        width: 100%;
        margin: 0;
        padding: 0;
    }
    
    .header-section, .company-details h4, .rightdetails h1, h1 {
        color: #c01600 !important;
    }

    .invoice-table th, .invoice-table td, .total-summary td {
        border: 1px solid #ddd !important;
        color: #000 !important;
        background-color: #f8f8f8 !important;
    }

    .invoice-table th {
        background-color: #c01600 !important;
        color: #ffffff !important;
    }
     .total-summary .label {
        text-align: center;
        color: rgb(0, 0, 0);
        background-color: white;
        border: none;
    }

    .total-summary tr:last-child {
        background-color: #c01600 !important;
        color: #ffffff !important;
    }
    
    .btn-print {
        display: none; /* Hide print button */
    }
    
    </style>
</head>
<body>
<%@ include file ="navbar.jsp" %>

<div class="text-right" style="padding: 10px; margin-top: 10px;">
    <button onclick="printInvoice()" class="btn btn-primary btn-print"><i class="fa fa-print"></i> Print Invoice</button>
</div>
    <div class="container">
        <!-- Logo and Company Details -->
        <div class="header-section">
            <div class="logo">
                <img src="/companyLogo?companyId=${company.companyId}" alt="Logo" class="logo">
            </div>
            <div class="company-details">
                <h4><span>${company.businessName}</span></h4>
                <p><span>${company.address}</span></p>
                <p><span>${customer.state}</span></p>
                <p>New York, New York 10001</p>
                <p>U.S.A</p>
            </div>
            <div class="rightdetails">
                <h1>INVOICE</h1>
                <p style="font-weight: bold;">#<span>${customer.invoiceNo}</span></p>
                <p style="margin-top: 5px;">Balance Due</p>
                <p style="font-weight: bold;">$<span id="balance"></span></p>
            </div>
        </div>

        <div class="clearfix"></div>

        <!-- Billing and Shipping Information -->
        <div class="from-to-section">
            <div class="from">
                <h4>Bill To</h4>
                <p style="font-weight:bold;font-size:14px; color: #c01600"><span id="name">${customer.name}</span></p>
                <p><span id="address">${customer.address}</span></p>
                <p id="cityState"><span id="mblno">${customer.state}</span></p>
                <p id="zipCode">628103</p>
            </div>

            <div class="to">
                <h4>Ship To</h4>
                <p><span id="address">${customer.address}</span></p>
                <p id="cityState"><span>${customer.state}</span></p>
                <p id="shipZipCode">628103</p>
            </div>
            
            <div class="invoice-info">
                <p>Invoice Date: <span id="invoiceDate">${customer.date}</span></p>
                <p>Terms: Due on Receipt</p>
            </div>
        </div>

        <div class="clearfix"></div>

        <!-- Product Table -->
        <div class="invoice-table">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Item & Description</th>
                        <th>Qty</th>
                        <th>Rate</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody id="itemRows">
                    <c:forEach var="product" items="${products}" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td>${product.productName}</td>
                            <td>${product.quantity}</td>
                            <td>${product.rate}</td>
                            <td>${product.amount}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Total Summary -->
        <div class="invoice-total">
            <table class="total-summary">
                <tr>
                    <td class="label">Sub Total</td>
                    <td id="subtotal">${response.subtotal}</td>
                </tr>
                <tr>
                    <td class="label">Tax Rate</td>
                    <td id="gst">${customer.gst}</td>
                </tr>
                <tr>
                    <td class="label">Total</td>
                    <td id="total"></td>
                </tr>
                <tr>
                    <td class="label1"><strong>Balance Due</strong></td>
                    <td id="balance1"></td>
                </tr>
            </table>
        </div>

        <!-- Notes and Terms Section -->
        <div class="notes">
            <h4>Notes</h4>
            <p>Thanks for your business.</p>
        </div>

        <div class="terms">
            <h4>Terms & Condition</h4>
            <p>All payments must be made in full before the commencement of any design work.</p>
        </div>
        <br><br><br>
        <hr>
        <br><br>
    </div>

    <!-- JavaScript for Invoice Calculations -->
    <script>
    
    function printInvoice() {
        const printContent = document.querySelector('.container').innerHTML;
        const originalContent = document.body.innerHTML;

        document.body.innerHTML = printContent;
        window.print();
        document.body.innerHTML = originalContent;

        location.reload();
    }

        window.onload = function() {
            fetchInvoiceCalculations();
        };

        function fetchInvoiceCalculations() {
            const gst = parseFloat('${customer.gst}');
            const discount = parseFloat('${customer.discount}');

            const products = [];
            $('#itemRows tr').each(function() {
                const amount = parseFloat($(this).find('td').eq(4).text());
                if (!isNaN(amount)) {
                    products.push({ amount: amount });
                }
            });

            console.log("GST:", gst, "Discount:", discount, "Products:", products);

            $.ajax({
                type: "POST",
                url: "/calculateInvoice",
                contentType: "application/json",
                data: JSON.stringify({
                    gst: gst,
                    discount: discount,
                    products: products
                }),
                success: function(response) {
                    console.log("Response from server:", response);

                    $('#subtotal').text(response.subtotal);
                    $('#total').text(response.totalAmount.toFixed(2));
                    $('#balance').text(response.balance.toFixed(2));
                    $('#balance1').text(response.balance.toFixed(2));
                },
                error: function(error) {
                    console.error("Error fetching invoice calculations:", error);
                }
            });
        }
    </script>
</body>
</html>