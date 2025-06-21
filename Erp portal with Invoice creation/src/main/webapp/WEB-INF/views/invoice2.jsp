<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Invoice 2</title>
    <style>
        body {
            font-family: 'Gill Sans', sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            border: 2px solid #e1e1e1;
            border-radius: 10px;
        }

       .header {
  display: flex;
  justify-content: space-between;
  align-items: center; /* Align items vertically */
  background-color: #5639ca;
  padding: 20px;
  color: white;
}

.header h1 {
  margin: 0; /* Remove unnecessary margins */
  font-size: 36px;
  flex-grow: 1; /* Let the heading take up available space */
  text-align: left; /* Align text to the left */
}

.header .logo {
  margin-left: auto; /* Push the logo to the right */
  width: 90px;
  height: auto;
}


        .info-section {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
        }

        .info-column {
            flex: 1 1 calc(50% - 10px);
            min-width: 250px;
        }

        .info-column p {
            display: flex;
            justify-content: start;
            align-items: center;
            margin: 0;
            padding: 2px 0;
        }

        .info-column label {
            font-weight: bold;
            min-width: 120px;
        }

        .table-container {
            margin-top: 20px;
            overflow-x: auto;
        }

        .table-container table {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px; /* Ensure table scrolls on small screens */
        }

        .table-container th,
        .table-container td {
            border: 1px solid #5639ca;
            padding: 10px;
            text-align: center;
        }

        .table-container th {
            background-color: #5639ca;
            color: white;
        }

        .summary {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 10px;
            margin-top: 20px;
        }

        .summary-table {
            width: 100%;
            border-collapse: collapse;
        }

        .summary-table td {
            padding: 5px;
            border: 1px solid #5639ca;
            font-size: 14px;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
        }

        .footer p {
            font-size: 12px;
            color: #333;
            margin: 0;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .header h1 {
                font-size: 20px;
            }

            .logo {
                width: 50px;
            }

            .info-column label {
                min-width: 100px;
            }

            .summary-table td {
                font-size: 12px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 10px;
            }

            .info-column {
                flex: 1 1 100%;
            }

            .table-container table {
                font-size: 12px;
            }

            .footer p {
                font-size: 10px;
            }
        }
    </style>

      <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  
</head>
<body>
<%@ include file ="navbar.jsp" %>
<div class="container">

  <div class="header">
  <h1>Sales Bill</h1>
  <img src="/companyLogo?companyId=${company.companyId}" alt="Logo" class="logo">
</div>

  <div class="info-section">
    <div class="info-column">
      <p><label>Business Name</label> <span style="font-weight:bold">: </span><span >${company.businessName}</span></p>
      <p><label>Address</label> <span style="font-weight:bold">: </span><span >${company.address}</span></p>
      <p><label>Phone Number</label> <span style="font-weight:bold">: </span><span >${company.phone}</span></p>
    </div>
    <div class="info-column">
      <p><label>GSTIN No</label><span style="font-weight:bold">: </span> <span>${company.gstNo}</span></p>
      <p><label>Invoice no</label> <span style="font-weight:bold">: </span><span>${customer.invoiceNo}</span></p>
      <p><label>State</label><span style="font-weight:bold">: </span> <span>Newyork</span></p>
    </div>
    
    
  </div>

  <div class="info-section">
    <div class="info-column">
     <h3>Bill TO</h3>
      <p><label>Name</label> <span style="font-weight:bold">: </span><span id="name">${customer.name}</span></p>
      <p><label>Address</label> <span style="font-weight:bold">: </span><span id="address"> ${customer.address}</span></p>
      <p><label>Phone No</label><span style="font-weight:bold">: </span> <span id="mblno">${customer.phone}</span></p>
      <p><label>GSTIN</label><span style="font-weight:bold">: </span> <span id="gstno"> ${customer.gstno}</span></p>
      <p><label>State</label><span style="font-weight:bold">: </span> <span id="state"> ${customer.state}</span></p>
    </div>
    <div class="info-column">
    <h3>Ship To</h3>
      <p><label>Name</label> <span style="font-weight:bold">: </span> <span id="sname"> ${customer.name}</span></p>
      <p><label>Address</label> <span style="font-weight:bold">: </span><span id="address"> ${customer.address}</span></p>
      <p><label>Phone No</label><span style="font-weight:bold">: </span> <span id="mblno"> ${customer.phone}</span></p>
      <p><label>GSTIN</label><span style="font-weight:bold">: </span> <span id="gstno"> ${customer.gstno}</span></p>
      <p><label>State</label><span style="font-weight:bold">: </span> <span id="state"> ${customer.state}</span></p>
    </div> 
  </div>

  <div class="table-container">
    <table>
      <thead>
        <tr>
          <th>S.No</th>
          <th>Goods Description</th>
          <th>QTY</th>
          <th>MRP</th>
          <th>Amount</th>
        </tr>
      </thead>
      <tbody id="itemsTable">
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

 <div class="summary">
  <table class="summary-table" style="width: 100%;">
    <tr>
      <td style="width: 50%; vertical-align: top;">
        <strong>Amount in Words:</strong> <span id="amountInWords" style="font-weight: lighter; font-size:13px"></span>
      </td>
      <td style="width: 25%; font-weight: bold;">Discount:</td>
      <td style="width: 25%;"><span id="discount">${customer.discount}%</span></td>
    </tr>
    <tr>
      <td style="font-weight: bold; border-bottom: none" colspan="1">Mode Of Payment:</td>
      <td style="font-weight: bold;">SGST:</td>
      <td><span id="sgst"></span></td>
    </tr>
   
    <tr>
      <td style=" border-top: none;"> <span id="modeOfpayment">${customer.modeOfPayment}</span></td>
      <td style="font-weight: bold;">Total:</td>
      <td><span id="total"></span></td>
    </tr>
  </table>
</div>


 <div class="footer" style="display: flex; align-items: center; justify-content: center; margin-top: 20px;">
    <p style="margin: 0;">Create professional invoices using myBillBook</p>
    <img src="google-play.png" alt="Google Play" style="margin-left: 10px; height: 25px; width: 150px;">
</div>


</div>
<script>


window.onload = function() {
    fetchInvoiceCalculations();
};

function fetchInvoiceCalculations() {
    // Remove stray 'e' and correctly parse the server-side values.
    const gst = parseFloat('${customer.gst}');
    const discount = parseFloat('${customer.discount}');
    
    const products = [];
    
    // Loop through each row in the table with ID 'itemsTable' and gather product details.
    $('#itemsTable tr').each(function() {
        const product = {
            amount: parseFloat($(this).find('td').eq(4).text())  // Extract amount from the 5th column (index 4)
        };
        products.push(product);  // Add product to the array
    });

    // AJAX request to send data to the server and receive the calculated invoice values.
    $.ajax({
        type: "POST",
        url: "/calculateInvoice",
        contentType: "application/json",
        data: JSON.stringify({
            gst: gst,            // Send GST value
            discount: discount,  // Send discount value
            products: products   // Send the list of products with their amounts
        }),
        success: function(response) {
            // Update the UI with the calculated values from the server response.
            $('#sgst').text(response.sgst + "%");  // SGST percentage
            $('#cgst').text(response.cgst + "%");  // CGST percentage
            $('#total').text(response.totalAmount.toFixed(2));  // Total amount
            $('#balance').text(response.balance.toFixed(2));    // Final balance amount
            $('#amountInWords').text(response.amountInWords + " Only");  // Amount in words
        },
        error: function(error) {
            console.error("Error fetching invoice calculations:", error);
        }
    });
}
</script>


</body>
</html>
