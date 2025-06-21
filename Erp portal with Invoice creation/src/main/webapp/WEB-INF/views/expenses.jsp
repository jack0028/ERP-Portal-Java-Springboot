<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Expense Tracker</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Add this in your <head> section -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        .not-found {
            color: red;
            font-weight: bold;
        }
        
        .custom-dropdown {
            position: relative;
        }

        .dropdown-list {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            border: 1px solid #ddd;
            background-color: #fff;
            max-height: 150px;
            overflow-y: auto;
            z-index: 1000;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .dropdown-item {
            padding: 10px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .dropdown-item:hover {
            background-color: #f1f1f1;
        }

        /* Styling the Expense Heading */
        .expense-heading {
            color: #0056b3; /* Dark blue for the heading */
            font-size: 24px;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 10px; /* Space between the icon and the text */
        }

        .expense-heading i {
            font-size: 28px; /* Slightly larger icon */
        }

        /* Custom styling for the button with the glyphicon */
        .plus-btn {
            margin-left: 10px;
         background-color: #007bff;

         border-color: #007bff;
         padding: 6px 12px;
         font-size: 14px; 
        }
    </style>
</head>
<body>
    <!-- Include Navbar -->
    <jsp:include page="navbar.jsp" />

    <!-- Expense Form -->
    <div class="container mt-5">
        <h2 class="expense-heading">
            <i class="glyphicon glyphicon-plus"></i> <!-- Glyphicon icon for the expense heading -->
            Add Expense
        </h2>
        <form id="expenseForm" action="saveExpense" method="post">
            <!-- Date -->
            <div class="form-group">
                <label for="date">Date</label><span class="glyphicon glyphicon-plus-sign"></span>
                <input type="date" class="form-control" id="date" name="date" required>
            </div>

            <!-- Category -->
            <div class="form-group">
                <label for="category">Category</label>
                <select class="form-control" id="category" name="category" required>
                    <option value="" disabled selected>Select Category</option>
                    <option value="travel">Travel</option>
                    <option value="employee">Employee</option>
                    <option value="office">Office</option>
                    <option value="other">Other</option>
                </select>
            </div>

            <div class="form-group">
                <label for="expenseInput">Expense</label>
                <input type="text" class="form-control" name="expense" id="expenseInput" placeholder="Start typing an expense..." list="expenseOptions">
                <datalist id="expenseOptions">
                    <!-- Options will be dynamically populated by JavaScript -->
                </datalist>
                <small id="expenseStatus" class="form-text"></small>
                <button type="button" class="btn btn-primary plus-btn" data-toggle="modal" data-target="#createNewModal">
                    <span class="glyphicon glyphicon-plus-sign"></span><i class="bi bi-plus-circle"></i>
                </button>
            </div>
<input type="hidden" id="companyId" name="companyId" value="${sessionScope.company.companyId}">

            <!-- Amount -->
            <div class="form-group">
                <label for="amount">Amount</label>
                <input type="number" class="form-control" id="amount" name="amount" required>
            </div>

            <!-- Mode of Payment -->
            <div class="form-group">
                <label>Mode of Payment</label><br>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="upi" name="paymentMode" value="UPI Payment" required>
                    <label class="form-check-label" for="upi">UPI Payment</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="creditCard" name="paymentMode" value="Credit Card" required>
                    <label class="form-check-label" for="creditCard">Credit Card</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="cash" name="paymentMode" value="Cash" required>
                    <label class="form-check-label" for="cash">Cash</label>
                </div>
            </div>

            <!-- Confirm Button -->
            <button type="submit" class="btn btn-primary">Confirm</button>
        </form>
    </div>

    <!-- Modal for Adding New Expense -->
    <div class="modal fade" id="createNewModal" tabindex="-1" aria-labelledby="createNewModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createNewModalLabel">Add New Expense</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="newExpenseForm">
                        <div class="form-group">
                            <label for="modalCategory">Category</label>
                            <select class="form-control" id="modalCategory" name="modalCategory" required>
                                <option value="travel">Travel</option>
                                <option value="employee">Employee</option>
                                <option value="office">Office</option>
                                <option value="other">Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="modalExpense">Expense</label>
                            <input type="text" class="form-control" id="modalExpense" name="modalExpense" required>
                        </div>
                        <button type="button" class="btn btn-success" id="saveExpenseBtn">Save</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
    $(document).ready(function() {
    	let dateInput = $('#date');
        let today = new Date();
        let formattedDate = today.toISOString().split('T')[0]; // Format as 'YYYY-MM-DD'
        dateInput.val(formattedDate);

        // Load expenses when the category changes
        $('#category').change(function() {
            let category = $(this).val();
            if (category) {
                $.ajax({
                    url: '/getExpensesByCategory',
                    type: 'GET',
                    data: { category: category },
                    success: function(response) {
                        let expenseOptions = $('#expenseOptions');
                        expenseOptions.empty(); // Clear existing options
                        response.forEach(function(expense) {
                            expenseOptions.append('<option value="' + expense + '">' + expense + '</option>');
                        });
                    },
                    error: function() {
                        alert('Error while fetching expenses.');
                    }
                });
            }
        });
        $('#saveExpenseBtn').click(function () {
            const newExpense = $('#modalExpense').val().trim();
            const category = $('#modalCategory').val();
            if (newExpense && category) {
                $('#expenseInput').val(newExpense); // Set new expense in the main input
                $('#createNewModal').modal('hide'); // Close modal
            } else {
                alert('Please enter expense and category.');
            }
        });

        // Filter options as the user types
        $('#expenseInput').on('input', function() {
            let inputVal = $(this).val().toLowerCase();
            let options = $('#expenseOptions option');

            options.each(function() {
                if ($(this).val().toLowerCase().includes(inputVal)) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });
    });
    </script>
</body>
</html>
