package com.make_invoice.Service;

import java.sql.Date;

public class CustomerDetailsDTO {
    private String billNo;
    private String accountName;
    private String address;
    private Date date;
    // Other necessary fields...

    // Constructor
    public CustomerDetailsDTO(String billNo, String accountName, String address, Date date) {
        this.billNo = billNo;
        this.accountName = accountName;
        this.address = address;
        this.date = date;
    }

    // Getters and Setters
    public String getBillNo() {
        return billNo;
    }

    public void setBillNo(String billNo) {
        this.billNo = billNo;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
