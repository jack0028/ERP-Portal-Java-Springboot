<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Table styling */
        .table-bordered {
            border: 2px solid #007bff; /* Blue border */
        }
        .table thead th {
            background-color: #007bff; /* Blue header background */
            color: white;
        }
        .table tbody tr:hover {
            background-color: #e6f2ff; /* Light blue row hover */
        }
        .table tbody td {
            color: #333;
            font-weight: bold;
        }

        /* Stylish Pagination styling */
        .pagination .page-item .page-link {
            color: #0056b3; /* Blue text for page numbers */
            background-color: transparent;
            border: none;
            font-weight: bold;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            line-height: 38px; /* Center the text vertically */
            text-align: center;
            padding: 0;
            margin: 0 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .pagination .page-item.active .page-link {
            background-color: #0056b3; /* Blue background for active page */
            color: white;
            border-radius: 50%;
            font-weight: bold;
        }

        .pagination .page-item .page-link:hover {
            background-color: #0056b3;
            color: white;
        }

        /* Previous and Next arrow styling */
        .pagination .page-item .page-link[aria-label="Previous"],
        .pagination .page-item .page-link[aria-label="Next"] {
            color: #0056b3;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            line-height: 38px;
            text-align: center;
        }

        .pagination .page-item .page-link[aria-label="Previous"]:hover,
        .pagination .page-item .page-link[aria-label="Next"]:hover {
            background-color: #0056b3;
            color: white;
        }

        /* Results information styling */
        .text-center {
            margin-top: 10px;
            font-weight: bold;
            color: #007bff;
        }

        /* Container styling */
        .container {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 123, 255, 0.3);
        }

        /* Header styling */
        h2 {
            color: #007bff;
            font-weight: bold;
        }
        .modal-content {
            border: 2px solid #007bff;
        }

        /* Modal Header */
        .modal-header {
            background-color: #007bff;
            color: white;
        }

        .modal-header .close {
            color: white;
        }

        /* Modal Body */
        .modal-body {
            background-color: #e6f2ff;
        }

        /* Modal Labels */
        .modal-label {
            color: #0056b3;
            font-weight: bold;
        }

        /* Modal Data */
        .modal-data {
            color: #333;
        }

        /* Modal Footer */
        .modal-footer {
            background-color: #f8f9fa;
        }

        /* Close Button in Footer */
        .modal-footer .btn-primary {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        .modal-footer .btn-primary:hover {
            background-color: #003d80;
            border-color: #003d80;
        }
          @media (max-width: 768px) {
    .pagination {
        flex-wrap: wrap; /* Allow wrapping of pagination items */
        justify-content: center; /* Center align the items */
    }

    .pagination .page-link {
        font-size: 12px; /* Reduce font size for smaller devices */
        width: 30px; /* Reduce width for smaller devices */
        height: 30px; /* Reduce height for smaller devices */
        line-height: 28px; /* Adjust text vertical alignment */
        padding: 0;
        margin: 2px; /* Add small margin for spacing */
    }

    .pagination .page-item {
        flex: 0 0 auto; /* Prevent pagination items from shrinking */
    }


        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="container">
        <h2 class="text-center mb-4"><i class="bi bi-box-seam"></i> Products List</h2>
        <div class="d-flex justify-content-start mb-3">
            <a href="/productForm" class="btn btn-success">
                <i class="bi bi-plus-circle"></i> Add Products to Stock
            </a>
        </div>
        <div class="row mb-3">
            <div class="col-md-4">
                <input type="text" id="productIdSearch" class="form-control" placeholder="Search by Product ID">
            </div>
            <div class="col-md-4">
                <input type="text" id="productNameSearch" class="form-control" placeholder="Search by Product Name">
            </div>
        </div>
<div class="table-responsive">
        <!-- Product Table -->
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>S.No</th>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Rate</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="productTableBody">
                <c:set var="sno" value="1" />
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td>${sno}</td>
                        <td class="product-id">${product.id}</td>
                        <td class="product-name">${product.name}</td>
                        <td>${product.quantity}</td>
                        <td>${product.price}</td>
                        <td>
                            <button 
                                class="btn btn-info btn-sm view-btn" 
                                data-id="${product.id}" 
                                data-toggle="modal" 
                                data-target="#productModal">
                                View
                            </button>
                        </td>
                    </tr>
                    <c:set var="sno" value="${sno + 1}" />
                </c:forEach>
            </tbody>
        </table>
</div>
  <c:set var="startPage" value="${currentPage - 1}" />
<c:set var="endPage" value="${currentPage + 2}" />

<!-- Adjust startPage and endPage to ensure they stay within valid bounds -->
<c:if test="${startPage < 0}">
    <c:set var="endPage" value="${endPage + (0 - startPage)}" />
    <c:set var="startPage" value="0" />
</c:if>
<c:if test="${endPage >= totalPages}">
    <c:set var="startPage" value="${startPage - (endPage - totalPages + 1)}" />
    <c:set var="endPage" value="${totalPages - 1}" />
</c:if>
<c:if test="${startPage < 0}">
    <c:set var="startPage" value="0" />
</c:if>

<nav aria-label="Page navigation">
    <ul class="pagination justify-content-center">
        <!-- Previous Arrow -->
        <c:if test="${currentPage > 0}">
            <li class="page-item">
                <a class="page-link" href="/stock?page=${currentPage - 1}" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
        </c:if>

        <!-- Page Numbers (Sliding Window) -->
        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <li class="page-item ${i == currentPage ? 'active' : ''}">
                <a class="page-link" href="/stock?page=${i}">${i + 1}</a>
            </li>
        </c:forEach>

        <!-- Next Arrow -->
        <c:if test="${currentPage < totalPages - 1}">
            <li class="page-item">
                <a class="page-link" href="/stock?page=${currentPage + 1}" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </c:if>
    </ul>
</nav>

        <!-- Results information -->
        <div class="text-center">
            Results: ${currentPage * 10 + 1} - ${Math.min((currentPage + 1) * 10, totalRecords)} of ${totalRecords}
        </div>
    </div>

    <!-- Modal Dialog -->
    <div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productModalLabel">Product Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="productDetails">
                <p><strong>Product ID:</strong> <span id="productId"></span></p>
                <p><strong>Product Name:</strong> <span id="modalName"></span></p>
                <p><strong>Available Quantity:</strong> <span id="modalQuantity"></span></p>
                <p><strong>Description:</strong> <span id="modalDescription"></span></p>
                <p><strong>Price:</strong> ₹<span id="modalPrice"></span></p>
                <p><strong>GST:</strong> <span id="modalGST"></span>%</p>
                <p><strong>Cost Price:</strong> ₹<span id="modalCostPrice"></span></p>
                <p><strong>Selling Price:</strong> ₹<span id="modalSellingPrice"></span></p>
            </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>

<script>

$(document).ready(function () {
    // Initialize DataTable
   const table = $('.table').DataTable({
        dom: 'lrtip',
        paging: true,
        lengthChange: false,
        pageLength: 10,
        autoWidth: false,
        order: [], 
    });

    // Add search functionality
    $('#productIdSearch').on('keyup', function () {
        table.column(1).search(this.value).draw();
    });

    $('#productNameSearch').on('keyup', function () {
        table.column(2).search(this.value).draw();
    });
    
    $(".view-btn").click(function () {
        const productId = $(this).data("id");
console.log(productId);
        $.ajax({
        	url: '/getProductsById',
            method: "GET",
            data: { id: productId},
            success: function (data) {
                $("#productId").text(data.id);
                $('#modalName').text(data.name);
                $('#modalDescription').text(data.description);
                $('#modalPrice').text(data.price);
                $('#modalGST').text(data.gst);
                $('#modalCostPrice').text(data.costPrice);
                $('#modalSellingPrice').text(data.sellingPrice);
                $('#modalQuantity').text(data.quantity);

                // Show the modal
                $('#productModal').modal('show');
            },
            error: function () {
                alert("Failed to fetch product details. Please try again.");
            },
        });
    });
});
</script>

</html>
