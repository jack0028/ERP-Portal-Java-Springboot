package com.make_invoice.Service;

import java.time.LocalDate;
import java.util.List;

import com.make_invoice.Model.CustomerDetails;


public class CustomerHistoryDTO {
	 private Long billNo;
	    private LocalDate date;
	    private CustomerDetails customer;
	    private List<CustomerHistoryDTO> history;
	    
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
		public CustomerHistoryDTO(Long billNo, LocalDate date) {
			super();
			this.billNo = billNo;
			this.date = date;
		}
		
		public CustomerHistoryDTO(CustomerDetails customer, List<CustomerHistoryDTO> history) {
			super();
			this.customer = customer;
			this.history = history;
		}
		public CustomerDetails getCustomer() {
			return customer;
		}
		public void setCustomer(CustomerDetails customer) {
			this.customer = customer;
		}
		public List<CustomerHistoryDTO> getHistory() {
			return history;
		}
		public void setHistory(List<CustomerHistoryDTO> history) {
			this.history = history;
		}



}
