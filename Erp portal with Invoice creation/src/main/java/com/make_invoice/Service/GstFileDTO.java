package com.make_invoice.Service;
import java.time.LocalDate;

public class GstFileDTO {
    private Long billNo;
    private LocalDate date;
    private String name;
    private String gstAmount;   // Changed to String
    private String totalAmount; // Changed to String

    // Constructor with all fields
    public GstFileDTO(Long billNo, LocalDate date, String name, String gstAmount, String totalAmount) {
        this.billNo = billNo;
        this.date = date;
        this.name = name;
        this.gstAmount = gstAmount;
        this.totalAmount = totalAmount;
    }

    // Getters and Setters
    public Long getBillNo() {
        return billNo;
    }

    public void setBillNo(Long billNo) {
        this.billNo = billNo;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGstAmount() {
        return gstAmount;
    }

    public void setGstAmount(String gstAmount) {
        this.gstAmount = gstAmount;
    }

    public String getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(String totalAmount) {
        this.totalAmount = totalAmount;
    }
}
