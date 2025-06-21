package com.make_invoice.Service;


public class TopCustomerDTO {
    private String CustomerName;
    private Double totalAmount;

    // Constructors, getters, and setters
    public TopCustomerDTO(String name, Double totalAmount) {
        this.CustomerName = name;
        this.totalAmount = totalAmount;
    }


    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

	public String getCustomerName() {
		return CustomerName;
	}

	public void setCustomerName(String customerName) {
		CustomerName = customerName;
	}
}
