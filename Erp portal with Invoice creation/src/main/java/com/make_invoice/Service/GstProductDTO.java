package com.make_invoice.Service;

public class GstProductDTO {
    private String productName;
    private Double gst;

    // Constructor
    public GstProductDTO( String productName, Double gst) {
        this.productName = productName;
        this.gst = gst;
    }

    // Getters and Setters
 
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

	public Double getGst() {
		return gst;
	}

	public void setGst(Double gst) {
		this.gst = gst;
	}

    
}

