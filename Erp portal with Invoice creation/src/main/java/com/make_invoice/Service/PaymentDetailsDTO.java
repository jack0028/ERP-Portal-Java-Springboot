package com.make_invoice.Service;

public class PaymentDetailsDTO {
	 private String name;
	    private Long billNo;
	    private double billAmount;
	    private double paidAmount;
	    private double pendingAmount;
		
		public PaymentDetailsDTO(String name, Long billNo, double billAmount, double paidAmount,
				double pendingAmount) {
			super();
			this.name = name;
			this.billNo = billNo;
			this.billAmount = billAmount;
			this.paidAmount = paidAmount;
			this.pendingAmount = pendingAmount;
		}
		public PaymentDetailsDTO() {
			// TODO Auto-generated constructor stub
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public Long getBillNo() {
			return billNo;
		}
		public void setBillNo(Long billNo) {
			this.billNo = billNo;
		}
		public double getBillAmount() {
			return billAmount;
		}
		public void setBillAmount(double billAmount) {
			this.billAmount = billAmount;
		}
		public double getPaidAmount() {
			return paidAmount;
		}
		public void setPaidAmount(double paidAmount) {
			this.paidAmount = paidAmount;
		}
		public double getPendingAmount() {
			return pendingAmount;
		}
		public void setPendingAmount(double pendingAmount) {
			this.pendingAmount = pendingAmount;
		}
	    
	    

}
