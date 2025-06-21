package com.make_invoice.Service;

public class RecentProductDTO {
	 private String productName;
	    private String quantity;
	    private String rate;
	    private String amount;
	    
		public RecentProductDTO() {
		
		}
		public RecentProductDTO(String productName, String quantity, String rate, String amount) {
			super();
			this.productName = productName;
			this.quantity = quantity;
			this.rate = rate;
			this.amount = amount;
		}
		public String getProductName() {
			return productName;
		}
		public void setProductName(String productName) {
			this.productName = productName;
		}
		public String getQuantity() {
			return quantity;
		}
		public void setQuantity(String quantity) {
			this.quantity = quantity;
		}
		public String getRate() {
			return rate;
		}
		public void setRate(String rate) {
			this.rate = rate;
		}
		public String getAmount() {
			return amount;
		}
		public void setAmount(String amount) {
			this.amount = amount;
		}

}
