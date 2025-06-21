package com.make_invoice.Service;

public class DailySalesDTO {
	    private String date; // Change to String to hold the formatted date
	    private double totalAmount;
	    public DailySalesDTO() {
	    }
	    // Getters and setters
	    public String getDate() {
	        return date;
	    }

	    public void setDate(String date) {
	        this.date = date;
	    }

	    public double getTotalAmount() {
	        return totalAmount;
	    }

	    public void setTotalAmount(double totalAmount) {
	        this.totalAmount = totalAmount;
	    }

		public DailySalesDTO(String date, double totalAmount) {
			super();
			this.date = date;
			this.totalAmount = totalAmount;
		}
	

}
