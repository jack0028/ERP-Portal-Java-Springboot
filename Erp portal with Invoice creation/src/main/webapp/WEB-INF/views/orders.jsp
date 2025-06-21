<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Invoice Generate</title>
<!-- Bootstrap 4.5.2 CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- Font Awesome for Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<!-- Select2 CSS for enhanced select elements -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet">

<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Bootstrap 4.5.2 JS (includes Popper.js for dropdowns, modals, etc.) -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

<!-- Select2 JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>



<style>
    body {
        background-color: #f8f9fa;
        font-family: Arial, sans-serif;
        background-image: linear-gradient(to top, #e3e6f1 0%, #eef5f8 100%);
        
    }

     .container {
        margin-top: 20px;
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }
    
     
    .btn-primary {
        background-color: #0056b3;
        border-color: #0056b3;
    }

    .btn-primary:hover {
        background-color: #004085;
        border-color: #004085;
    }
  
    h2, h3 {
        color: #007bff;
    }

    hr {
        border-top: 1px solid #007bff;
    }

    #customerSelect {
        width: 65%;
        display: inline-block;
    }
    
    .plus-btn {
         margin-left: 10px;
         background-color: #007bff;
         color: #ffffff;
         border-color: #007bff;
         padding: 6px 12px;
         font-size: 14px;
    }

    .input-group-btn .btn {
        background-color: #007bff;
        color: #ffffff;
        border-color: #007bff;
    }

    .form-control {
        border-radius: 4px;
    }

    .btn {
        border-radius: 4px;
        padding: 8px 16px;
        transition: background-color 0.3s;
    }

    .btn-primary {
        background-color: #0056b3;
        border-color: #0056b3;
        color: #ffffff;
    }

    .btn-primary:hover {
        background-color: #004085;
    }

    .btn-success {
        background-color: #0062cc;
        border-color: #0062cc;
        color: #ffffff;
    }

    .btn-success:hover {
        background-color: #004085;
    }

    #bill th, #bill td {
        text-align: center;
        vertical-align: middle;
    }

    #bill th {
        background-color: #007bff;
        color: #ffffff;
    }

   /* Custom Styling for Modal */
.modal-content {
    border-radius: 8px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    background-color: #f9f9f9;
}

.modal-header {

    color: #fff;
    border-bottom: 2px solid #ddd;
    font-weight: bold;
}

.modal-title {
    font-size: 1.5rem;
}

.modal-footer button {
    font-size: 1rem;
    padding: 10px 20px;
}

.form-control {
    border-radius: 5px;
    border: 1px solid #ccc;
    box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.1);
    transition: border 0.3s ease;
}

.form-control:focus {
    border-color: #007bff;
    box-shadow: 0px 0px 5px rgba(0, 123, 255, 0.5);
}

label {
    color: #333;
    font-size: 1rem;
}

.font-weight-bold {
    font-weight: 600;
}

.btn-success {
    background-color: #28a745;
    border-color: #28a745;
    color: white;
}

.btn-secondary {
    background-color: #6c757d;
    border-color: #6c757d;
    color: white;
}

.btn-success:hover, .btn-secondary:hover {
    opacity: 0.9;
}

.small {
    font-size: 0.85rem;
}

 .exists {
    border-color: green !important;
}
.not-exists {
    border-color: red !important;
}

    
</style>


    
    <script>
    
$(document).ready(function() {
	
	
	$('#mname').on('keyup', checkCustomerName);
	  $('#mname').on('keyup', function () {
	        var name = $(this).val(); // Fetch value from the input field

	        if (name.length > 0) {
	            $.ajax({
	                url: "/checkCustomerName", // Adjust your URL as needed
	                type: "GET",
	                data: { name: name },
	                success: function (response) {
	                    if (response) {
	                        $('#nameAlert').show(); // Show alert if name exists
	                    } else {
	                        $('#nameAlert').hide(); // Hide alert if name does not exist
	                    }
	                },
	                error: function () {
	                    console.log("Error checking customer name.");
	                }
	            });
	        } else {
	            $('#nameAlert').hide(); // Hide alert if input is empty
	        }
	    });
	let dateInput = $('#invoiceDate');
    let today = new Date();
    let formattedDate = today.toISOString().split('T')[0]; // Format as 'YYYY-MM-DD'
    dateInput.val(formattedDate);

	initializeSelect2();
    
    loadCustomerNames(""); 
    function checkProductName() {
        let productName = $('#pname').val().trim();
        let productInput = $('#pname');

        if (productName.length === 0) {
            productInput.removeClass("exists not-exists"); // Clear styles if input is empty
            return;
        }

        // AJAX request to check product name existence
        $.ajax({
            url: `/checkProductName`,
            type: "GET",
            data: { name: productName },
            success: function(response) {
                console.log("Response received:", response);
                if (response.exists) {
                    productInput.addClass("exists").removeClass("not-exists");
                    $('#productAlert').hide(); // Hide the alert if the product exists
                } else {
                    productInput.addClass("not-exists").removeClass("exists");
                    $('#productAlert').show(); // Show the alert if the product does not exist
                }
            },
            error: function() {
                console.error("Error checking product name existence.");
            }
        });
    }

    // Trigger product name check on input change
    $('#pname').on('input', checkProductName);

    // Rest of your code remains as is...
    
    // Example CSS for the classes
    $('<style>')
        .prop('type', 'text/css')
        .html(`
            .exists { border-color: green; }
            .not-exists { border-color: red; }
        `)
        .appendTo('head');

    let matchedCustomerId = null;
    setRandomInvoiceNo();

    const urlParams = new URLSearchParams(window.location.search);
    var companyId = document.getElementById('companyId').value;
    var savedCompanyId = companyId;
    var billNo =  ${billNo};
    var savedBillNo = billNo;
    $('#billNo').val(savedBillNo);

    
    
    console.log("Initial Bill No: " + savedBillNo);
    $('#billin').trigger('reset');
    

    var serialNo = 1;
    
    /*---------------Name field------------------------- */
   $('#customerSelect').on('change', function() {
    var selectedBillNo = $(this).val();
    if (selectedBillNo && !isNaN(selectedBillNo)) {
        $.ajax({
            url: '/getCustomerDetails',
            type: 'GET',
            data: { id: selectedBillNo },
            success: function(response) {
                if (response.error) {
                    alert(response.error);
                } else {
                	$('#customerId').val(response.customerId);
                    $('#name').val(response.name);
                    $('#gst').val(response.gst);
                    $('#gstno').val(response.gstno);
                    $('#address').val(response.address);
                    $('#phone').val(response.phone);
                    $('#discount').val(response.discount);
                    $('#state').val(response.state);
                }
            },
            error: function(xhr, status, error) {
                alert("An error occurred while fetching customer details.");
            }
        });
    } else {
        alert("Invalid customer selection.");
    }
});
    /*-------------------------------Product Validation ------------------------*/
      // When the product name is selected or changed
        $('#pname').on('input', function() {
            let productName = $(this).val();
            if (productName) {
            	$.ajax({
            	    url: '/validateProduct',
            	    type: 'GET',
            	    data: { pname: productName },
            	    dataType: 'json',  // Ensure response is parsed as JSON
            	    success: function(response) {
            	        console.log(response); // Check if response is parsed correctly
            	        if (response && response.rate) {
            	            $('#rate').val(response.rate);
            	        } else {
            	            $('#rate').val('');
            	        }
            	    },
            	    error: function(xhr, status, error) {
            	        console.error("AJAX error:", status, error);
            	        alert('Failed to fetch product data');
            	    }
            	});

            } else {
                $('#rate').val('');
            }
        });

        let isStockAvailable = false; // Flag to track stock availability

     // Disable the "Add" button initially
     $('#nextBtn').prop('disabled', true);

     // When the quantity field loses focus
     $('#qty').on('change', function() {
         let productName = $('#pname').val();
         let quantity = $(this).val();

         if (productName && quantity) {
             $.ajax({
                 url: '/checkStock',
                 type: 'GET',
                 data: { pname: productName, qty: quantity },
                 success: function(response) {
                     if (response.available) {
                         $('#productAlert').hide();
                         isStockAvailable = true;
                         $('#nextBtn').prop('disabled', false); // Enable the Add button
                         console.log("Product available");
                     } else {
                         $('#productAlert').text('Out of Stock').show();
                         isStockAvailable = false;
                         $('#nextBtn').prop('disabled', true); // Disable the Add button
                     }
                 },
                 error: function() {
                     $('#productAlert').text('Error checking stock').show();
                     isStockAvailable = false;
                     $('#nextBtn').prop('disabled', true); // Disable the Add button
                     console.log("Error checking product availability");
                 }
             });
         } else {
             $('#nextBtn').prop('disabled', true); // Disable the Add button if fields are invalid
         }
     });


        // Add product when 'Next' button is clicked
        $('#nextBtn').click(function(e) {
            e.preventDefault();

            var pname = $('#pname').val().trim();
            var qty = parseInt($('#qty').val());
            var rate = parseFloat($('#rate').val());
            var amount = qty * rate;

            console.log("Products " + pname + " " + qty + " " + rate);
            if (pname && !isNaN(qty) && !isNaN(rate) && amount && isStockAvailable) {
                var newRow = $('<tr></tr>');

                // Adding each column in the new row
                newRow.append('<td>' + pname + '</td>');
                newRow.append('<td><input type="number" class="editable-qty" value="' + qty + '" min="1" style="width: 60px;"></td>');
                newRow.append('<td>' + rate.toFixed(2) + '</td>');
                newRow.append('<td class="amount-cell">' + amount.toFixed(2) + '</td>');

                // Create the Remove button
                var removeButton = $('<button></button>', {
                    class: "btn btn-danger",
                    click: function() {
                        $(this).closest('tr').remove();
                    }
                }).append($('<i></i>', { class: "fas fa-trash" }));

                newRow.append($('<td></td>').append(removeButton));

                // Append the row to the table
                $('#bill tbody').append(newRow);
                isStockAvailable = false;
                // Reset form fields
                $('#pname').val('');
                $('#qty').val('');
                $('#rate').val('');
            } else {
                alert("Please enter valid product details and ensure the product is in stock.");
            }
        });

        // Update the amount when quantity is edited in the table
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
/*--------------------------Product Name ---------------------------------------*/
 $.ajax({
        url: '/getProductNames',
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            const datalist = $('#productList');
            data.forEach(function(productName) {
                $('<option>').val(productName).appendTo(datalist);
            });
        },
        error: function() {
            console.error('Error fetching product names.');
        }
    });



  /*------------------------------ "Confirm" ---------------------------------*/
 $('#confirm').click(function() {
    var pnames = [], qtys = [], rates = [], amounts = [];
    var totalAmount = 0; // Initialize totalAmount

    $('#bill tbody tr').each(function() {
        // Collect product name
        var pname = $(this).find("td:eq(0)").text().trim();
        // Collect quantity (ensure the class matches your input field for quantity)
        var qty = parseFloat($(this).find('.editable-qty').val());
        // Collect rate
        var rate = parseFloat($(this).find("td:eq(2)").text());
        // Collect amount from the correct cell class
        var amount = parseFloat($(this).find(".amount-cell").text()) || 0;

        // Validate the data and push it to arrays if valid
        if (pname && !isNaN(qty) && qty > 0 && !isNaN(rate) && !isNaN(amount)) {
            totalAmount += amount; // Add to totalAmount

            pnames.push(pname);
            qtys.push(qty);
            rates.push(rate.toFixed(2));
            amounts.push(amount.toFixed(2));
        }
    });

    // Check if the bill number is available
    if (!savedBillNo) {
        alert("Bill Number is missing. Please reload the page or try again.");
        return;
    }

    // Log for debugging
    console.log("Products: ", pnames);
    console.log("Quantities: ", qtys);
    console.log("Rates: ", rates);
    console.log("Amounts: ", amounts);

    // Set bill number and prepare data to be sent
    $('#billNo').val(savedBillNo);
    $('input[name="billNo"]').val(savedBillNo); 
    console.log("Confirmed Bill No: " + savedBillNo);

    var mod = $('input[name="modeOfPayment"]:checked').val();
    var paidAmount = 0;

    if (mod === "cash") {
        paidAmount = totalAmount; // Assign totalAmount if payment is by cash
    }

    var billData = {
        companyId: savedCompanyId,
        customerId: $("#customerId").val(),
        invoiceNo: $("#invoiceNo").val(),
        billNo: $("#billNo").val(),
        name: $("#name").val(),
        gst: $("#gst").val(),
        discount: $("#discount").val(),
        address: $("#address").val(),
        phone: $("#phone").val(),
        gstno: $("#gstno").val(),
        state: $("#state").val(),
        invoiceDate: $("#invoiceDate").val(),
        modeOfPayment: $('input[name="modeOfPayment"]:checked').val(),
        totalAmount: totalAmount,
        paidAmount: paidAmount, // Add paidAmount to billData
        products: {
            pnames: pnames,
            qtys: qtys,
            rates: rates,
            amounts: amounts
        }
    };

    // Send AJAX request
    $.ajax({
        url: "/saveData",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(billData),
        success: function(response) {
            alert("Data saved successfully!");
            console.log("Bill No after save: " + savedBillNo);
            $('#bill tbody').empty(); 
            $('#billin').trigger('reset');
            $('#companyId, #invoiceNo, #billNo, #name, #gst, #discount, #phone, #gstno, #address, #state, #invoiceDate, #modeOfPayment').val(''); // Clear invoiceDate
        },
        error: function(xhr) {
            alert("Failed to save data!");
        }
    });
});

    /*------------------------------------ Save Button in Modal----------------------------------------*/
    $('#save').click(function () {
        var modalName = $('#mname').val();
        var address = $('#maddress').val();
        var phone = $('#mphone').val();
        var gst = $('#mgst').val();
        var gstno = $('#mgstno').val();
        var discount = $('#mdiscount').val();
        var state = $('#mstate').val();

        if (modalName && address && phone && gst && gstno && discount) {
            // Fill the main form fields with modal data
            $('#name').val(modalName);
            $('#address').val(address);
            $('#phone').val(phone);
            $('#gst').val(gst);
            $('#gstno').val(gstno);
            $('#discount').val(discount);
            $('#state').val(state);

            // Hide the modal
             $('#createnew').modal('hide'); // Fix: Ensure the modal is hidden
        } else {
            alert("Please enter all customer details.");
        }
    });
    
    function checkCustomerName() {
        var name = $('#mname').val(); 

        if (name.length > 0) {
            $.ajax({
                url: "/checkCustomerName",  
                type: "GET",
                data: { name: name },
                success: function(response) {
                    if (response) {  
                        $('#nameAlert').show();  
                    } else {
                        $('#nameAlert').hide();  
                    }
                },
                error: function() {
                    console.log("Error checking customer name.");
                }
            });
        } else {
            $('#nameAlert').hide(); 
        }
    }
    /*------------------------------------Random Bill No---------------------------------------------*/
    
    function setRandomInvoiceNo() {
        const randomInvoiceNo = Math.floor(1000000 + Math.random() * 9000);
        var savedinvoiceNo = randomInvoiceNo;
        $('#invoiceNo').val("INV"+savedinvoiceNo); 

    }
    
   
    function setRandomBillNo() {
        const randomBillNo = Math.floor(1000 + Math.random() * 9000);
        savedBillNo = randomBillNo;
        $('#billNo').val(savedBillNo); 
        $('input[name="billNo"]').val(savedBillNo);
    }

    function initializeSelect2() {
        $('#customerSelect').select2({
        	 width: '300px',
            placeholder: "Search for a customer",
            allowClear: true
        });
    }
    
    /*--------------------------------Load Options----------------------------------*/
    function loadCustomerNames(query) {
        $.ajax({
            url: "/getCustomerNames",
            type: "GET",
            data: { query: query },
            success: function(response) {
                $('#customerSelect').empty();
                $('#customerSelect').append('<option value="" disabled selected>Select Customer</option>');
                response.forEach(function(customer) {
                    // Use customer.id for the billNo since it's being mapped in the backend
                    $('#customerSelect').append('<option value="' + customer.id + '">' + customer.name + '</option>');
                });
                $('#customerSelect').select2(); // Initialize Select2 or re-initialize if necessary
            },

            error: function(error) {
                console.log("Error loading customer names: ", error);
            }
        });
    }
    
  

// Function to update the amount based on quantity change
function updateAmount(row, rate) {
    const quantity = row.find(".quantity").val();
    const amountCell = row.find(".amount");
    const amount = quantity * rate;
    amountCell.text(amount.toFixed(2));
}
// Update amount when quantity is edited

    
    /*---------------------------Fill Details --------------------------------*/
    function fillCustomerDetails(customerId) {
    if (!customerId) return;

    $.ajax({
        url: "/getCustomerDetails",
        type: "GET",
        data: { id: customerId }, // Pass the billno to the backend
        success: function(response) {
        	$('#customerId').val(response.customerId);
            $('#name').val(response.name);
            $('#address').val(response.address);
            $('#phone').val(response.phone);
            $('#gst').val(response.gst);
            $('#gstno').val(response.gstno);
            $('#discount').val(response.discount);
            $('#state').val(response.state);
        },
        error: function(xhr, status, error) {
            console.log("Error fetching customer details:", xhr);
            alert("Failed to load customer details. Please try again.");
        }
    });
}

});

 </script>
    

</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container">
    <h2 class="text-center text-primary"><i class="fas fa-receipt"></i> Bill Invoice</h2>
    <hr>

    <!-- Product Form -->
    
 <!-- Product Form -->
      <form id="billin" class="form-inline bg-light p-3 rounded shadow-sm">
    <div class="form-group mb-3">
     <div id="productAlert" class="text-danger" style="display: none;">Product not found</div>
        <label for="pname" class="mr-2">Product Name:</label>
        <input type="text" id="pname" class="form-control ml-2" placeholder="Enter product name" list="productList" required>
        <datalist id="productList">
            <c:forEach var="product" items="${productNames}">
                <option value="${product}"></option>
            </c:forEach>
        </datalist>
        <div id="productAlert" class="text-danger mt-1" style="display: none;">Product not found</div>
    </div>

    <div class="form-group mb-3">
        <label for="qty" class="mr-2">Quantity:</label>
        <input type="number" id="qty" class="form-control ml-2" placeholder="Enter quantity" required>
    </div>

    <div class="form-group mb-3">
        <label for="rate" class="mr-2">Rate:</label>
        <input type="number" id="rate" class="form-control ml-2" placeholder="Enter rate" required>
    </div>

    <button id="nextBtn" class="btn btn-primary ml-2">
        <i class="fas fa-plus-circle"></i> Add
    </button>
</form>
 <!-- Product Form -->
<br>
<hr>

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

    <hr>

    <!-- Customer Details -->
    <h3> <i class="fas fa-user"></i> 
 <!-- Hand holding money icon -->
    Customer Details</h3>
    <div class="form-group">
        <label>Select Customer:</label>
         <div class="input-group" style="display: flex; align-items: center;">
        <select id="customerSelect" class="form-control"></select>
        <button type="button" class="btn btn-primary plus-btn" data-toggle="modal" data-target="#createnew">
            <span class="glyphicon glyphicon-plus-sign"> <i class="fas fa-plus-square"></i>  </span>
        </button>
    </div>
    </div>

    <!-- Bill No, Invoice No, and Invoice Date -->
    <div class="row">
        <div class="col-md-4">
            <div class="form-group">
                <label>Bill No:</label>
                <input type="text" id="billNo" class="form-control" readonly>
            </div>
        </div>
        <div class="col-md-4">
            <div class="form-group">
                <label>Invoice No:</label>
                <input type="text" id="invoiceNo" class="form-control" readonly>
            </div>
        </div>
        <div class="col-md-4">
            <div class="form-group">
                <label>Invoice Date:</label>
                <input type="date" id="invoiceDate" name="invoiceDate" class="form-control" required>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label>Name:</label>
                <input type="text" id="name" class="form-control" readonly>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label>Address:</label>
                <input type="text" id="address" class="form-control" readonly>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label>Phone Number:</label>
                <input type="text" id="phone" class="form-control" readonly>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label>GST:</label>
                <input type="text" id="gst" class="form-control" readonly>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label>GST No:</label>
                <input type="text" id="gstno" class="form-control" readonly>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label>Discount:</label>
                <input type="text" id="discount" class="form-control" readonly>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="form-group">
                <label>State:</label>
                <input type="text" id="state" class="form-control" readonly>
            </div>
        </div>
        
        <div class="col-md-6">
            <p>Mode of Payment:</p>
            <input type="radio" id="creditCard" name="modeOfPayment" value="Credit Card" required>
            <label for="creditCard">Credit Card</label><br>
            
            <input type="radio" id="cash" name="modeOfPayment" value="cash" required>
            <label for="cash">Cash</label><br>
            
            <input type="radio" id="upi" name="modeOfPayment" value="UPI" required>
            <label for="upi">UPI</label><br>
            
        </div>
                        <input type="hidden" id="customerId" name="customerId" class="form-control" readonly>
        
    </div>

    <hr>

   
    <!-- Confirm Button -->
    <form action="/selectLayout" method="GET">
        <input type="hidden" name="companyId" value="${companyId}">
        <input type="hidden" name="billNo" value="${savedBillNo}">
        <button type="submit" id="confirm" class="btn btn-success"><i class="fas fa-check-circle"></i> Confirm Order</button>
    </form>
</div>

<!-- Modal for Creating New Customer -->
<div id="createnew" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg"> <!-- Adjust modal size -->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title text-center w-100" style="color: #007bff;">Enter Customer Details</h4>
            </div>
            <form id="formLogin" method="post">
                <div class="modal-body">
                    <small id="nameAlert" class="form-text text-danger" style="display: none;">Name already exists!</small>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="mname" class="font-weight-bold">Name:</label>
                            <input type="text" id="mname" class="form-control" required>
                        </div>
                        <div class="col-md-6 form-group">
                            <label for="maddress" class="font-weight-bold">Address:</label>
                            <input type="text" id="maddress" class="form-control" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="mphone" class="font-weight-bold">Phone Number:</label>
                            <input type="text" id="mphone" class="form-control" required>
                        </div>
                        <div class="col-md-6 form-group">
                            <label for="mgst" class="font-weight-bold">GST:</label>
                            <input type="text" id="mgst" class="form-control" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="mgstno" class="font-weight-bold">GST No:</label>
                            <input type="text" id="mgstno" class="form-control" required>
                        </div>
                        <div class="col-md-6 form-group">
                            <label for="mdiscount" class="font-weight-bold">Discount:</label>
                            <input type="text" id="mdiscount" class="form-control" required>
                        </div>
                    </div>
                    <!-- Added State Input -->
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="mstate" class="font-weight-bold">State:</label>
                            <input type="text" id="mstate" class="form-control" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" id="save"><i class="fas fa-save"></i> Save</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"><i class="fas fa-times"></i> Cancel</button>
                </div>
            </form>
        </div>
    </div>


</div>
</body>



</html>