package com.make_invoice.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.make_invoice.Model.CompanyDetails;
import com.make_invoice.Model.CustomerDetails;
import com.make_invoice.Model.Customers;
import com.make_invoice.Model.Expense;
import com.make_invoice.Model.ProductDetails;
import com.make_invoice.Model.Products;
import com.make_invoice.Model.Purchase;
import com.make_invoice.Repository.CompanyRepository;
import com.make_invoice.Repository.CustomersRepository;
import com.make_invoice.Repository.ExpenseRepository;
import com.make_invoice.Repository.ProductRepository;
import com.make_invoice.Repository.ProductsRepo;
import com.make_invoice.Repository.PurchaseRepository;
import com.make_invoice.Repository.customerDetailsRepository;

@Service
public class CustomerService {

    @Autowired
    private customerDetailsRepository customerRepo;

    @Autowired
    private CustomersRepository customersRepo;
    
    @Autowired
    private ProductRepository productRepo;
    
    @Autowired
    private CompanyRepository companyRepo;
    
    @Autowired
    private ProductsRepo productsRepo;
    
    @Autowired
    private ExpenseRepository expenseRepo;
    
    @Autowired
    private PurchaseRepository purchaseRepo;

    @Transactional
    public CompanyDetails validateCompany(String gstNo, String phoneNumber) {
        return companyRepo.findByGstNoAndPhone(gstNo, phoneNumber);
    }
    @Transactional
    public void saveData(Long companyId, Long customerId, String invoiceNo, Long billNo, String name, String gst, String discount,
                         String address, String gstno, String phone, String state, LocalDate invoiceDate,  String modeOfPayment, double paidAmount, List<String> pnames, List<String> qtys, 
                         List<String> rates, List<String> amounts) {

        // Fetch the company based on companyId
        CompanyDetails company = companyRepo.findById(companyId)
                                .orElseThrow(() -> new IllegalArgumentException("Invalid company ID"));
        Customers customers = customersRepo.findByCustomerId(customerId);

        CustomerDetails customer = new CustomerDetails();
        customer.setInvoiceNo(invoiceNo);
        customer.setBillNo(billNo);
        customer.setName(name);
        customer.setGst(gst);
        customer.setDiscount(discount);
        customer.setAddress(address);
        customer.setGstno(gstno);
        customer.setPhone(phone);
        customer.setState(state);
        customer.setDate(invoiceDate);
        customer.setModeOfPayment(modeOfPayment);
        System.out.println("Mode :"+modeOfPayment);
        customer.setPaidAmount(paidAmount);
        customer.setCompany(company); // Set the company here
        customer.setCustomers(customers);
        customerRepo.save(customer);

        // Save product details and update product stock
        for (int i = 0; i < pnames.size(); i++) {
            // Fetch the product from the Products table by product name or ID
        	  final int index = i;

        	    // Fetch the product from the Products table by product name or ID
        	    Products product = productsRepo.findByName(pnames.get(index))
        	            .orElseThrow(() -> new IllegalArgumentException("Product not found: " + pnames.get(index)));

        	    // Parse the quantity being purchased
        	    int purchaseQuantity = Integer.parseInt(qtys.get(index));
        	    int productQuant = product.getQuantity();

        	    // Check if there is enough stock
        	    if (productQuant < purchaseQuantity) {
        	        throw new IllegalArgumentException("Insufficient stock for product: " + pnames.get(index));
        	    }

        	    // Reduce the stock quantity
        	    product.setQuantity(productQuant - purchaseQuantity);
        	    productsRepo.save(product);

        	    // Save product details for this order
        	    ProductDetails productDetails = new ProductDetails();
        	    productDetails.setProductName(pnames.get(index));
        	    productDetails.setQuantity(qtys.get(index));
        	    productDetails.setRate(rates.get(index));
        	    productDetails.setAmount(amounts.get(index));
        	    productDetails.setCustomer(customer); // Associate product with customer
        	    productDetails.setCompany(company);

        	    productRepo.save(productDetails);
        }
    }
public void SaveCustomers(Long companyId, Long customerId, String name, String gst, String discount,
                         String address, String gstno, String phone, String state) {
	Customers customer = new Customers();
	
	 CompanyDetails company = companyRepo.findById(companyId)
             .orElseThrow(() -> new IllegalArgumentException("Invalid company ID"));
	 customer.setCustomerId(customerId);
	 customer.setName(name);
     customer.setGst(gst);
     customer.setDiscount(discount);
     customer.setAddress(address);
     customer.setGstNo(gstno);
     customer.setPhone(phone);
     customer.setState(state);
     customer.setCompany(company);
     customersRepo.save(customer);
	
}
    public CompanyDetails registerCompany(String businessName, String address, String phone, String gstNo, 
                                          Integer startYear, Integer employees, String yearlyTurnover, byte[] logo) {
        CompanyDetails companyDetails = new CompanyDetails();
        companyDetails.setBusinessName(businessName);
        companyDetails.setAddress(address);
        companyDetails.setPhone(phone);
        companyDetails.setGstNo(gstNo);
        companyDetails.setStartYear(startYear);
        companyDetails.setEmployees(employees);
        companyDetails.setYearlyTurnover(yearlyTurnover);
        companyDetails.setLogo(logo);
        
        return companyRepo.save(companyDetails);
    }

    @Transactional(readOnly = true)
    public CustomerDetails getInvoiceDetails(Long billNo) {
        Optional<CustomerDetails> customerOpt = customerRepo.findById(billNo);
        
        if (customerOpt.isPresent()) {
            CustomerDetails customer = customerOpt.get();
            List<ProductDetails> productList = productRepo.findByCustomer_BillNo(billNo); // Ensure repository method is correctly implemented
            customer.setOrders(productList); // Assuming `setOrders` sets the products in CustomerDetails
            return customer;
        }
        
        return null; // Return null if customer is not found
    }
    
    @Transactional(readOnly = true)
    public List<Customers> getAllCustomersByCompanyId(Long companyId) {
        return customersRepo.findAllByCompanyId(companyId);
    }

    @Transactional(readOnly = true)
    public List<ProductDetails> getProductsByBillNo(Long billNo) {
        return productRepo.findByCustomer_BillNo(billNo);
    }

    @Transactional(readOnly = true)
    public CompanyDetails getCompanyDetails(Long companyId) {
        return companyRepo.findById(companyId).orElse(null);
    }

    @Transactional(readOnly = true)
    public List<Customers> findCustomersByNameAndCompanyId(String query, Long companyId) {
        List<Customers> allCustomers = customersRepo.findAll();
        return allCustomers.stream()
                .filter(customer -> customer.getCompany().getCompanyId().equals(companyId) && // Access company ID via foreign key
                        customer.getName().toLowerCase().contains(query.toLowerCase()))
                .collect(Collectors.toList());
    }


    
    public boolean existsByName(String productName) {
        return productsRepo.existsByName(productName);
    }
    
    public Long generateNewBillNumber() {
        // Generate a random UUID and use its hash code to create a Long number
        UUID uuid = UUID.randomUUID();
        Long randomBillNo = Math.abs(uuid.getMostSignificantBits() % 1000000); // Mod to keep it within a range
        return randomBillNo;
    }

    @Transactional(readOnly = true)
    public CustomerDetails findById(Long billNo) {
        // Properly implement the findById method with Optional handling
        return customerRepo.findById(billNo).orElse(null);
    }
    public CustomerDetails findByBillNo(Long billno) {
        return customerRepo.findById(billno)
            .orElseThrow(() -> new NoSuchElementException("Customer not found with bill no: " + billno));
    }
    
    public CustomerDetails getCustomerDetailsById(Long id) {
        // Use the repository to find the customer by ID
        return customerRepo.findById(id).orElse(null);
    }
    
    public boolean customerNameExists(String name, Long companyId) {
        return customerRepo.existsByNameAndCompanyId(name, companyId);
    }

    
   //Navigation Part
    public List<GstFileDTO> getBillSummaryWithGstAndTotalAmount(Long companyId) {
        // Adjust the repository query to filter results by companyId
        List<Object[]> results = customerRepo.findBillSummaryWithGstAndTotalAmount(companyId);

        // Map each result row to GstFileDTO and convert BigDecimal to String
        return results.stream().map(record -> new GstFileDTO(
                ((Number) record[0]).longValue(),                   // billNo
                ((java.sql.Date) record[1]).toLocalDate(),          // date
                (String) record[2],                                 // name
                record[3].toString(),                               // gstAmount as String
                record[4].toString()                                // totalAmount as String
        )).collect(Collectors.toList());
    }

    public List<GstProductDTO> getProductGstDetails(Long companyId) {
        // Retrieve all customers for the given companyId
        List<CustomerDetails> customers = customerRepo.findAllByCompanyId(companyId);

        Map<String, Double> productGstMap = new HashMap<>();

        for (CustomerDetails customer : customers) {
            // Convert GST percentage from CustomerDetails to decimal
            String gstPercentageStr = customer.getGst();  // e.g., "18%"
            if (gstPercentageStr != null && gstPercentageStr.endsWith("%")) {
                gstPercentageStr = gstPercentageStr.substring(0, gstPercentageStr.length() - 1);
            }

            double gstPercentage = Double.parseDouble(gstPercentageStr) / 100;

            // Calculate total GST amount for each associated product
            for (ProductDetails product : customer.getOrders()) {
                double gstAmo = Double.parseDouble(product.getAmount());
                double gstAmount = gstAmo * gstPercentage;  // Multiply amount by GST percentage

                // Sum GST by product name
                productGstMap.merge(
                    product.getProductName(),
                    gstAmount,
                    Double::sum
                );
            }
        }

        // Convert map to a list of GstProductDTO
        return productGstMap.entrySet().stream()
                .map(entry -> new GstProductDTO(entry.getKey(), entry.getValue()))
                .collect(Collectors.toList());
    }
  
    
    public List<Products> getAvailableProducts() {
        List<Products> products = productsRepo.findTop10ByQuantityLessThanOrderByPriceAsc(1);
        if (products.isEmpty()) {
            // Return an empty list or handle the case as needed
            return new ArrayList<>(); // or Collections.emptyList();
        }
        return products;
    }

    public List<Products> searchProducts(String query) {
        List<Products> products = new ArrayList<>();
        if (query != null && !query.trim().isEmpty()) {
            products = productsRepo.findByNameContainingIgnoreCase(query);
        }
        return products;
    }
    public List<Products> getAllProducts(Long companyId) {
        return productsRepo.findAllByCompany(companyId);
    }
    
    public List<Products> findTop10LowQuantityProducts(int limit) {
        List<Products> allProducts = productsRepo.findAll();
        return allProducts.stream()
            .filter(p -> p.getQuantity() < limit)
            .sorted(Comparator.comparingDouble(Products::getPrice))
            .limit(10)
            .collect(Collectors.toList());
    }
    
    public boolean expenseExists(String category, String expenseName) {
        return expenseRepo.existsByCategoryAndExpense(category, expenseName);
    }
    
    @Transactional
    public List<String> getExpensesByCategory(String category) {
        return expenseRepo.findByCategory(category)
                                .stream()
                                .map(Expense::getExpense)
                                .collect(Collectors.toList());
    }
    public void saveExpense(Expense expense) {
        expenseRepo.save(expense);
    }
    
    public Page<Products> getPaginatedProducts(int offset, int recordsPerPage) {
        Page<Products> products = productsRepo.findAll(PageRequest.of(offset / recordsPerPage, recordsPerPage));
         return products;
    }

    public long getProductCount() {
        return productsRepo.countTotalProducts();
    }
    
    public String savePurchases(List<Purchase> purchases, Long companyId) {
    	 for (Purchase dto : purchases) {
             // Map DTO to entity
             Purchase purchase = new Purchase();
             purchase.setBillNo(dto.getBillNo());
             purchase.setPurchaseDate(dto.getPurchaseDate());
             purchase.setProductName(dto.getProductName());
             purchase.setQuantity(dto.getQuantity());
             purchase.setRate(dto.getRate());
             purchase.setAmount(dto.getAmount());

             // Fetch the company and associate it
             CompanyDetails company = companyRepo.findById(companyId)
                 .orElseThrow(() -> new RuntimeException("Company not found with ID: "));
             purchase.setCompany(company);

             // Save the purchase
             purchaseRepo.save(purchase);
         }
        return "Success";
    }
    
    public double findTotalAmountByCompany(Long companyId) {
        // Query to fetch the total amount for the given companyId
    	Double amount = purchaseRepo.findTotalAmountByCompany(companyId);
    	return amount != null ? amount : 0.0;
    }

	


    public double findSalesAmountByCompany(Long companyId) {
        // Fetch the sales amount, ensuring a null value defaults to 0
    	Double totalAmount = productRepo.findSalesAmountByCompanyId(companyId);
        if (totalAmount == null) {
            totalAmount = 0.0; // Default to zero if null
        }
        return totalAmount != null ? totalAmount : 0.0;
    }


public double findExpenseAmountByCompany(Long companyId) {
    // Query to fetch the expense amount for the given companyId
    Double expenseAmount =expenseRepo.findExpenseAmountByCompany(companyId);
    return (expenseAmount != null) ? expenseAmount : 0.0;

}
	
	public Page<Products> getProducts(Pageable pageable, Long companyId) {
        return productsRepo.findAllByCompanyId(companyId, pageable);
    }
	
	public long getTotalRecords() {
        return productsRepo.count();
    }
    
	@Transactional
    public boolean updatePaidAmount(Long billNo, double newPaidAmount) {
        CustomerDetails customerDetails = customerRepo.findByBillNo(billNo);
        
        if (customerDetails != null) {
            customerDetails.setPaidAmount(newPaidAmount);
            customerRepo.save(customerDetails);
            return true;
        } else {
            return false;
        }
    }
	 public PaymentDetailsDTO processPayment(Long billNo, double amount, double paidAmount, double pending, String name) {
	        // Logic to update the payment in the database and calculate pending amount
	        Optional<CustomerDetails> customerOpt = customerRepo.findById(billNo);
	        if (customerOpt.isPresent()) {
	            CustomerDetails customer = customerOpt.get();

	            // Calculate the new paid amount and pending amount
	            double newPaidAmount =  paidAmount;
	           // double newPendingAmount = customer.getPendingAmount() - amountPaid;

	            // Update the customer details
	            customer.setPaidAmount(newPaidAmount);
	            //customer.setPendingAmount(newPendingAmount);

	            // Save the updated customer details
	            customerRepo.save(customer);
	        } else {
	            throw new IllegalArgumentException("No customer found with billNo: " + billNo);
	        }
	    

	        // Dummy data for example purposes (replace with actual logic)
	        PaymentDetailsDTO paymentDetails = new PaymentDetailsDTO();
	        paymentDetails.setBillNo(billNo);
	        paymentDetails.setName(name); // Retrieve actual customer name
	        paymentDetails.setPaidAmount(paidAmount); // Calculate new total
	        paymentDetails.setPendingAmount(pending); // Calculate remaining pending amount

	        return paymentDetails;
	    }
	
	public PaymentDetailsDTO getPaymentDetails(String invoiceNo) {
        CustomerDetails customer = customerRepo.findByInvoiceNo(invoiceNo);
        if (customer != null) {
        	Long billNo = customer.getBillNo();
            double totalBillAmount = productRepo.sumAmountsByBillNo(billNo);
            double pendingAmount = totalBillAmount - customer.getPaidAmount();
            return new PaymentDetailsDTO(customer.getName(), billNo, totalBillAmount, customer.getPaidAmount(), pendingAmount);
        }
        return null;
    }
	
	public List<Products> getAllProductsName() {
        return productsRepo.findAll();
    }


	public Customers findByCustomerId(Long customerId) {
		// TODO Auto-generated method stub
		return customersRepo.findByCustomerId(customerId);
	}
	public Products findByName(String pname, Long companyId) {
        return productsRepo.findByNameAndCompanyId(pname, companyId);
    }
	
	public Page<Purchase> getPurchasesByCompany(Long companyId, int page, int size) {
        return purchaseRepo.findByCompanyId(companyId, PageRequest.of(page, size));
    }
	public List<Expense> getAllExpenses(Long companyId) {
        return expenseRepo.findAllCompanyId(companyId);
    }
	
	public Page<ProductDetails> getAllProductsd(Pageable pageable, Long companyId) {
	    return productRepo.findAllproducts(pageable, companyId);
	}

}

