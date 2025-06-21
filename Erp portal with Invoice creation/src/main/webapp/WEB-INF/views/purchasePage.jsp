<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Purchased Products</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    
    <style>
        body {
            background-color: #f8f9fa;
            background-image: linear-gradient(to top, #e3e6f1 0%, #eef5f8 100%);
            
        }
        h2 {
            margin-top: 20px;
        }
        .form-group label {
            font-weight: bold;
            color: #333;
        }
        .form-inline .form-group {
            margin-right: 15px;
            margin-bottom: 10px;
        }
        table th {
            background-color: #007bff;
            color: #fff;
            text-align: center;
        }
        table td {
            text-align: center;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-success {
            margin-top: 20px;
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="container mt-4 p-4 bg-white shadow rounded">
        <h2 class="text-center text-primary">Purchase</h2>
        <hr>

        <div class="row mb-3">
            <div class="col-md-4">
                <div class="form-group">
                    <label for="billNo">Purchased Bill No:</label>
                    <input type="text" id="billNo" class="form-control">
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="purchaseDate">Purchase Date:</label>
                    <input type="date" id="purchaseDate" name="purchaseDate" class="form-control" required>
                </div>
            </div>
        </div>

        <hr>

        <!-- Product Form -->
        <form id="billin" class="form-inline bg-light p-3 rounded shadow-sm">
            <div class="form-group">
                <label for="pname">Product Name:</label>
                <input type="text" id="pname" class="form-control ml-2" placeholder="Enter product name" required>
            </div>
            <div class="form-group">
                <label for="qty">Quantity:</label>
                <input type="number" id="qty" class="form-control ml-2" placeholder="Enter quantity" required>
            </div>
            <div class="form-group">
                <label for="rate">Rate:</label>
                <input type="number" id="rate" class="form-control ml-2" placeholder="Enter rate" required>
            </div>
            <button id="nextBtn" class="btn btn-primary ml-2"><i class="bi bi-x-circle"></i> Add</button>
        </form>

        <br>

        <!-- Bill Table -->
        <div class="table-responsive">
    <table id="bill" class="table table-bordered table-hover table-striped mt-4">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Rate</th>
                <th>Amount</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>


        <button type="submit" id="confirm" class="btn btn-success btn-block">Confirm</button>
    </div>

   <!-- Replace the Slim version with Full version -->

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            var companyId = document.getElementById('companyId').value;
            console.log(companyId);
        	
        	let dateInput = $('#purchaseDate');
            let today = new Date();
            let formattedDate = today.toISOString().split('T')[0]; // Format as 'YYYY-MM-DD'
            dateInput.val(formattedDate);

            $('#nextBtn').click(function(e) {
                e.preventDefault();
                var pname = $('#pname').val().trim();
                var qty = parseInt($('#qty').val());
                var rate = parseFloat($('#rate').val());
                var amount = qty * rate;

                if (pname && !isNaN(qty) && !isNaN(rate) && amount) {
                    var newRow = $('<tr></tr>');

                    newRow.append('<td>' + pname + '</td>');
                    newRow.append('<td><input type="number" class="editable-qty" value="' + qty + '" min="1" style="width: 60px;"></td>');
                    newRow.append('<td>' + rate.toFixed(2) + '</td>');
                    newRow.append('<td class="amount-cell">' + amount.toFixed(2) + '</td>');

                    var removeButton = $('<button></button>', {
                        text: "Remove",
                        class: "btn btn-danger",
                        click: function() {
                            newRow.remove();
                        }
                    });

                    newRow.append($('<td></td>').append(removeButton));
                    $('#bill tbody').append(newRow);

                    $('#pname').val('');
                    $('#qty').val('');
                    $('#rate').val('');
                } else {
                    alert("Please enter valid product details.");
                }
            });

            $('#bill').on('input', '.editable-qty', function() {
                var row = $(this).closest('tr');
                var newQty = parseFloat($(this).val());
                var rate = parseFloat(row.find('td:nth-child(3)').text());

                if (!isNaN(newQty) && newQty > 0 && !isNaN(rate)) {
                    var newAmount = newQty * rate;
                    row.find('.amount-cell').text(newAmount.toFixed(2));
                } else {
                    row.find('.amount-cell').text('0.00');
                }
            });

            var purchaseData = [];
            $('#confirm').click(function() {
                var pnames = [], qtys = [], rates = [], amounts = [];

                $('#bill tbody tr').each(function() {
                    pnames.push($(this).find("td:eq(0)").text());
                    qtys.push($(this).find(".editable-qty").val());
                    rates.push($(this).find("td:eq(2)").text());
                    amounts.push($(this).find(".amount-cell").text());
                });

                // Construct the purchase data
                for (var i = 0; i < pnames.length; i++) {
                    var purchase = {
                        companyId : companyId,
                        billNo: $("#billNo").val(),
                        purchaseDate: $("#purchaseDate").val(),
                        productName: pnames[i],
                        quantity: qtys[i],
                        rate: rates[i],
                        amount: amounts[i]
                    };
                    purchaseData.push(purchase);
                    
                }
                console.log(purchaseData);
                $.ajax({
                    url: "/savePurchase", // Endpoint to save the purchase
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(purchaseData),
                    success: function(response) {
                        alert("Data saved successfully!");
                        $('#bill tbody').empty();
                        $('#billin').trigger('reset');
                        $('#billNo, #purchaseDate').val('');
                    },
                    error: function(xhr) {
                    	 $('#bill tbody').empty();
                         $('#billin').trigger('reset');
                         $('#billNo, #purchaseDate').val('');
                    }
                });
            });

        });
    </script>
</body>
</html>
