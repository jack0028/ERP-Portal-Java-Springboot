<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Form</title>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
   <style>
        body {
            background-color: #e3f2fd; /* Light blue background */
        }

        .container {
            margin-top: 60px;
        }

        .form-container {
            background-color: #bbdefb; /* Light blue form background */
            border: 1px solid #2196f3; /* Blue border */
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #0d47a1; /* Darker blue for headings */
        }

        .btn-primary {
            background-color: #1976d2;
            border-color: #1976d2;
        }

        .btn-primary:hover {
            background-color: #1565c0;
            border-color: #0d47a1;
        }

        @media (max-width: 768px) {
            .container {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="container">
        <div class="form-container">
            <h2>Product Form</h2>
            <form action="/products" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="id">ID:</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-id-badge"></i></span>
                        </div>
                        <input type="text" class="form-control" id="id" name="id" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="name">Name:</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-tag"></i></span>
                        </div>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="quantity">Quantity:</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-boxes"></i></span>
                        </div>
                        <input type="number" class="form-control" id="quantity" name="quantity" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="sellingPrice">Selling Price:</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-dollar-sign"></i></span>
                        </div>
                        <input type="number" class="form-control" id="sellingPrice" name="sellingPrice" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="mrp">MRP:</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-tags"></i></span>
                        </div>
                        <input type="number" class="form-control" id="price" name="price" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="costPrice">Cost Price:</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-money-bill-wave"></i></span>
                        </div>
                        <input type="number" class="form-control" id="costPrice" name="costPrice" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="gst">GST (%):</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-percentage"></i></span>
                        </div>
                        <input type="number" class="form-control" id="gst" name="gst" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="photo">Product Photo:</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-image"></i></span>
                        </div>
        <input type="file" class="form-control-file" id="photo" name="photo" accept="image/*" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-pencil-alt"></i></span>
                        </div>
                        <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </div>
</body>
</html>
