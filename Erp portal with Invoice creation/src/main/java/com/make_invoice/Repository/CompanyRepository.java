package com.make_invoice.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.make_invoice.Model.CompanyDetails;

public interface CompanyRepository extends JpaRepository<CompanyDetails,Long> {
    CompanyDetails findByGstNoAndPhone(String gstNo, String phone);

}
