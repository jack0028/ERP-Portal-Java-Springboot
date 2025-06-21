package com.make_invoice.Service;



public class ProductDetailsDTO {
    private String productName;
    private String amount;
    private Integer totalQuantity;

    // Constructor
    

    // Getters and Setters
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	
	public ProductDetailsDTO(String productName, Integer totalQuantity) {
		super();
		this.productName = productName;
		this.totalQuantity = totalQuantity;
	}
	

	public Integer getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(Integer totalQuantity) {
		this.totalQuantity = totalQuantity;
	}

  
   
}
