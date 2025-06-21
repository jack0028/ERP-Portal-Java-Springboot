package com.make_invoice.Model;

import jakarta.persistence.*;

@Entity
public class CompanyDetails {
	@Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 @Column(name = "company_id", nullable = false)
	private Long companyId;
	
	 @Column(name = "business_name", nullable = false)
	    private String businessName;

	    @Column(name = "address", nullable = false)
	    private String address;

	    @Column(name = "phone", nullable = false)
	    private String phone;
	    
		@Column(name = "gst_no", nullable = false)
	    private String gstNo;

	    @Column(name = "start_year", nullable = false)
	    private int startYear;

	    @Column(name = "employees_count", nullable = false)
	    private int employees;

	    @Column(name = "yearly_turnover", nullable = false)
	    private String yearlyTurnover;

	    @Lob
	    @Column(name = "logo", columnDefinition = "LONGBLOB")
	    private byte[] logo;

	    public Long getCompanyId() {
			return companyId;
		}

		public void setCompanyId(Long companyId) {
			this.companyId = companyId;
		}

		public String getBusinessName() {
			return businessName;
		}

		public void setBusinessName(String businessName) {
			this.businessName = businessName;
		}

		public String getAddress() {
			return address;
		}

		public void setAddress(String address) {
			this.address = address;
		}

		public String getPhone() {
			return phone;
		}

		public void setPhone(String phone) {
			this.phone = phone;
		}

		public String getGstNo() {
			return gstNo;
		}

		public void setGstNo(String gstNo) {
			this.gstNo = gstNo;
		}

		public int getStartYear() {
			return startYear;
		}

		public void setStartYear(int startYear) {
			this.startYear = startYear;
		}

		public int getEmployees() {
			return employees;
		}

		public void setEmployees(int employees) {
			this.employees = employees;
		}

		public String getYearlyTurnover() {
			return yearlyTurnover;
		}

		public void setYearlyTurnover(String yearlyTurnover) {
			this.yearlyTurnover = yearlyTurnover;
		}

		public byte[] getLogo() {
			return logo;
		}

		public void setLogo(byte[] logo) {
			this.logo = logo;
		}

	
}
