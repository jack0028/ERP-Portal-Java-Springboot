package com.make_invoice.Service;

public class ProductDTO {
	private String pnames;
    private String quantity;
    private String rates;
    private String amounts;
	public String getPnames() {
		return pnames;
	}
	public void setPnames(String pnames) {
		this.pnames = pnames;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getAmounts() {
		return amounts;
	}
	public void setAmounts(String amounts) {
		this.amounts = amounts;
	}
	
	public String getRates() {
		return rates;
	}
	public void setRates(String rates) {
		this.rates = rates;
	}
	public ProductDTO(String pnames, String quantity, String rates, String amounts) {
		super();
		this.pnames = pnames;
		this.quantity = quantity;
		this.rates = rates;
		this.amounts = amounts;
	}


}
