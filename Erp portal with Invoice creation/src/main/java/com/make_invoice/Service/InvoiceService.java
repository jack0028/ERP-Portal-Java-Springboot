package com.make_invoice.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;


import com.make_invoice.Model.CustomerDetails;
import com.make_invoice.Model.Customers;
import com.make_invoice.Model.ProductDetails;
import com.make_invoice.Model.Products;
import com.make_invoice.Repository.CustomersRepository;
import com.make_invoice.Repository.ProductRepository;
import com.make_invoice.Repository.ProductsRepo;
import com.make_invoice.Repository.customerDetailsRepository;

import jakarta.transaction.Transactional;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class InvoiceService {

    @Autowired
    private customerDetailsRepository customerDetailsRepository;
    @Autowired
    private CustomersRepository customersRepo;
    @Autowired
    private ProductRepository productDetailsRepository;
    
    @Autowired
    private ProductsRepo productsRepo;

    // Fetch the most recent invoice details (customer and related products)
    public Map<String, Object> getRecentInvoice(Long companyId) {
        Map<String, Object> response = new HashMap<>();

        try {
            // Fetch the most recent customer for the specific companyId
            CustomerDetails recentCustomer = customerDetailsRepository.findLastCustomer(companyId);
            System.out.println("Fetched recent customer for companyId: " + companyId); // Log for debugging

            if (recentCustomer != null) {
                System.out.println("Processing customer with invoiceNo: " + recentCustomer.getInvoiceNo()); // Log customer processing

                // Map the customer details
                Map<String, Object> customerDetails = new HashMap<>();
                customerDetails.put("invoiceNo", recentCustomer.getInvoiceNo());
                customerDetails.put("name", recentCustomer.getName());
                customerDetails.put("billNo", recentCustomer.getBillNo());
                customerDetails.put("date", recentCustomer.getDate());

                // Fetch related products
                List<ProductDetails> productDetailsList = productDetailsRepository.findByCustomer_BillNoAndCompany_CompanyId(recentCustomer.getBillNo(), companyId);
                System.out.println("Fetched " + productDetailsList.size() + " products for billNo: " + recentCustomer.getBillNo()); // Log product count

                // Map product details to DTO
                List<RecentProductDTO> recentProducts = productDetailsList.stream()
                        .map(product -> {
                            System.out.println("Mapping product: " + product.getProductName()); // Log each product
                            return new RecentProductDTO(
                                    product.getProductName(),
                                    product.getQuantity(),
                                    product.getRate(),
                                    product.getAmount());
                        })
                        .collect(Collectors.toList());

                // Add product details to the customer details
                customerDetails.put("productDetails", recentProducts);

                // Add customer details to the response
                response.put("recentCustomer", customerDetails);
                System.out.println("Added customer details to the response"); // Log completion
            } else {
                // No recent customer found; return an empty object
                response.put("recentCustomer", new HashMap<String, Object>());
                System.out.println("No recent customer found. Returning an empty object.");
            }
        } catch (Exception e) {
            // Log any unexpected errors
            System.err.println("Error occurred while fetching recent invoice: " + e.getMessage());
            response.put("recentCustomer", new HashMap<String, Object>()); // Safe empty response
        }

        return response;
    }

 // Fetch top 5 customers based on their total amount spent
    public List<TopCustomerDTO> getTopCustomers(Long companyId) {
        // Fetch raw data with pagination and companyId filter
        List<Object[]> topCustomersRaw = customerDetailsRepository.findTopCustomersByCompanyId(companyId, PageRequest.of(0, 5));

        // Map raw data to TopCustomerDTO list
        return topCustomersRaw.stream()
                .map(record -> new TopCustomerDTO(
                        (String) record[0],                  // customer name
                        ((Number) record[1]).doubleValue()   // totalAmount as Double
                ))
                .collect(Collectors.toList());
    }
   // Fetch top 5 most sold products by quantity
    public List<ProductDetailsDTO> getTrendingProducts(Long companyId) {
        // Fetch the top 5 products by quantity for a specific company
        List<Object[]> topProductsRaw = productDetailsRepository.findTopProductsByCompanyId(companyId, PageRequest.of(0, 5));

        // Map raw data to ProductDetailsDTO list
        return topProductsRaw.stream()
                .map(record -> {
                    String productName = (String) record[0];
                    Integer totalQuantity = (record[1] instanceof BigDecimal) ? ((BigDecimal) record[1]).intValue() : ((Number) record[1]).intValue();
                    return new ProductDetailsDTO(productName, totalQuantity);
                })
                .collect(Collectors.toList());
    }


    // Fetch total number of products and their cumulative amount
    public Map<String, Object> getTotalSales(Long companyId) {
        Map<String, Object> result = new HashMap<>();

        // Fetch the total number of products for a specific company
        Integer totalProducts = productDetailsRepository.countTotalProductsByCompany(companyId);
        if (totalProducts == null) {
            totalProducts = 0; // Default to zero if null
        }

        // Fetch the total sales amount for a specific company
        Double totalAmount = productDetailsRepository.findSalesAmountByCompanyId(companyId);
        if (totalAmount == null) {
            totalAmount = 0.0; // Default to zero if null
        }

        // Put the values into the result map
        result.put("totalProducts", totalProducts);
        result.put("totalAmount", totalAmount);

        return result;
    }



    public List<DailySalesDTO> getDailySales(Long companyId) {
        List<Object[]> dailySalesData = productDetailsRepository.findDailySales(companyId);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Choose your desired date format

        return dailySalesData.stream().map(data -> {
            // Ensure that data is correctly cast and converted
            String formattedDate = (data[0] instanceof java.sql.Date) ? 
                dateFormat.format((java.sql.Date) data[0]) : "";
            double amount = (data[1] instanceof Number) ? 
                ((Number) data[1]).doubleValue() : 0.0;

            // Use the constructor to create DailySalesDTO
            return new DailySalesDTO(formattedDate, amount);
        }).collect(Collectors.toList());
    }


    
    public List<Map<String, Object>> getProductAmounts(Long companyId) {
        // Fetch product names and amounts filtered by companyId
        List<Object[]> productAmountsRaw = productDetailsRepository.findProductAmountsByCompany(companyId);

        // Print the raw data to see what is fetched from the database
        System.out.println("Fetched Raw Product Amount Data:");
        if (productAmountsRaw != null) {
            productAmountsRaw.forEach(record -> {
                System.out.println("Product Name: " + record[0] + ", Total Amount: " + record[1]);
            });
        } else {
            System.out.println("No product amounts found.");
        }

        // Process and map the results into a list of maps
        List<Map<String, Object>> processedData = productAmountsRaw.stream()
                .map(record -> {
                    Map<String, Object> result = new HashMap<>();
                    result.put("productName", record[0]); // product name
                    result.put("totalAmount", record[1]); // total amount
                    return result;
                })
                .collect(Collectors.toList());

        // Print the processed data to verify the result
        System.out.println("Processed Product Amount Data:");
        processedData.forEach(record -> {
            System.out.println("Product Name: " + record.get("productName") + ", Total Amount: " + record.get("totalAmount"));
        });

        return processedData;
    }


    public List<LastInvoiceDTO> getLast10Invoices(Long companyId) {
        // Fetch the last 10 invoices for a specific company
        List<Map<String, Object>> last10Invoices = customerDetailsRepository.findLast10InvoicesByCompany(companyId);
        List<LastInvoiceDTO> invoiceDTOs = new ArrayList<>();

        // Check if the list is empty
        if (last10Invoices == null || last10Invoices.isEmpty()) {
            System.out.println("No invoices found. List is either null or empty.");
        } else {
            System.out.println("Last 10 Invoices retrieved successfully.");

            for (Map<String, Object> invoice : last10Invoices) {
                String customerName = (String) invoice.get("customerName");
                String place = (String) invoice.get("state");

                // Convert totalAmount safely to BigDecimal
                Object totalAmountObj = invoice.get("totalAmount");
                BigDecimal totalAmountBigDecimal = null;

                if (totalAmountObj instanceof BigDecimal) {
                    totalAmountBigDecimal = (BigDecimal) totalAmountObj;
                } else if (totalAmountObj instanceof Double) {
                    totalAmountBigDecimal = BigDecimal.valueOf((Double) totalAmountObj);
                }

                // Ensure totalAmount is not null, default to "0" if it is
                String totalAmount = totalAmountBigDecimal != null ? totalAmountBigDecimal.toPlainString() : "0";

                Date lastPurchaseDate = (Date) invoice.get("lastPurchaseDate");

                // Create a new DTO and add it to the list
                LastInvoiceDTO dto = new LastInvoiceDTO(customerName, place, totalAmount, lastPurchaseDate);
                invoiceDTOs.add(dto);
            }
        }
        return invoiceDTOs;
    }


       
    public Long countByDateAfterAndCompanyId(LocalDate date, Long companyId) {
        return customerDetailsRepository.countByDateAfterAndCompanyId(date, companyId);
    }

    public double getTotalSalesAmount(Long companyId) {
        Double salesAmount = productDetailsRepository.findSalesAmountByCompanyId(companyId);
        return salesAmount != null ? salesAmount : 0.0;
    }

	
	
	public CustomerHistoryDTO getCustomerHistoryByName(String name, Long companyId) {
	    // Fetch customer details by name and companyId
	    List<CustomerDetails> customers = customerDetailsRepository.findAllByNameAndCompany_CompanyId(name, companyId);
	    if (customers.isEmpty()) {
	        throw new RuntimeException("Customer not found for the given name and company ID");
	    }

	    // Fetch billNos and dates related to this customer
	    List<CustomerHistoryDTO> customerHistory = customers.stream()
	        .map(customer -> new CustomerHistoryDTO(
	            customer.getBillNo(),  // Access billNo directly from CustomerDetails
	            customer.getDate()     // Assuming `date` is a field in CustomerDetails
	        ))
	        .collect(Collectors.toList());

	    // Return the customer and list of billNo/date in CustomerHistoryDTO
	    return new CustomerHistoryDTO(customers.get(0), customerHistory);
	}



	public Customers findById(Long customerId) {
		return customersRepo.findByCustomerId(customerId);
	}



	  @Transactional
	    public void saveAll(List<CustomerDetails> customersList) {
	        try {
	            customerDetailsRepository.saveAll(customersList); // This handles both persist and merge operations
	        } catch (Exception e) {
	            throw new RuntimeException("Failed to save Customers", e);
	        }
	    }

	    @Transactional
	    public void saveAllDetails(List<Customers> customerDetailsList) {
	        try {
	            for (Customers details : customerDetailsList) {
	                // Check if the CustomerDetails already exist (based on customerId)
	                if (!customersRepo.existsById(details.getCustomerId())) {
	                    customersRepo.save(details); // Persist new CustomerDetails
	                } else {
	                    customersRepo.save(details); // The save method handles both persist and merge automatically
	                }
	            }
	        } catch (Exception e) {
	            throw new RuntimeException("Failed to save CustomerDetails", e);
	        }
	    }


	 public CustomerHistoryDTO getCustomerHistoryById(Long customerId, Long companyId) {
	        // Query to fetch customers by customerId and companyId
	        List<CustomerDetails> customers = customerDetailsRepository.findByCustomerIdAndCompanyId(customerId, companyId);

	        if (customers.isEmpty()) {
	            throw new RuntimeException("Customer not found for the given ID and company ID");
	        }

	        // Format date into a readable string
	        List<CustomerHistoryDTO> history = customers.stream()
	    	        .map(customer -> new CustomerHistoryDTO(
	    	            customer.getBillNo(),  // Access billNo directly from CustomerDetails
	    	            customer.getDate()     // Assuming `date` is a field in CustomerDetails
	    	        ))
	    	        .collect(Collectors.toList());

	        return new CustomerHistoryDTO(customers.get(0), history);
	    }



	public List<Customers> getCustomers(Long companyId) {
		// TODO Auto-generated method stub
		return customersRepo.findAllByCompanyId(companyId);
	}
	
	
	public Products getProductById(Long id) {
        return productsRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + id));
    }
	
	public void saveProduct(Products product) {
        productsRepo.save(product);
    }
}
