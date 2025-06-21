package com.make_invoice.Service;

public class TopCoustomerProductDTO {
	
	 private String productName;
	    private String quantity;
	    private String amount;
	    private Long billno;
		public TopCoustomerProductDTO(String productName, String quantity, String amount, Long billno) {
			super();
			this.productName = productName;
			this.quantity = quantity;
			this.amount = amount;
			this.billno = billno;
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
		public String getAmount() {
			return amount;
		}
		public void setAmount(String amount) {
			this.amount = amount;
		}
		public Long getBillno() {
			return billno;
		}
		public void setBillno(Long billno) {
			this.billno = billno;
		}
		
		
}
