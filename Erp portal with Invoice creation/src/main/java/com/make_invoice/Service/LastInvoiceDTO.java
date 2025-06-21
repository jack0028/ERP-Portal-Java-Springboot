package com.make_invoice.Service;

import java.sql.Date;

public class LastInvoiceDTO {
    private String customerName;
    private String place;
    private String totalAmount;
    private Date lastPurchaseDate;

    // Constructor
    public LastInvoiceDTO(String customerName, String place, String totalAmount, Date lastPurchaseDate) {
        this.customerName = customerName;
        this.place = place;
        this.totalAmount = totalAmount;
        this.lastPurchaseDate = lastPurchaseDate;
    }

    // Getters and Setters
    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(String totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Date getLastPurchaseDate() {
        return lastPurchaseDate;
    }

    public void setLastPurchaseDate(Date lastPurchaseDate) {
        this.lastPurchaseDate = lastPurchaseDate;
    }
}
