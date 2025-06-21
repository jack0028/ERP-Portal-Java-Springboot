package com.make_invoice.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.make_invoice.Model.Customers;

@Repository
public interface CustomersRepository extends JpaRepository<Customers, Long> {

	Customers findByCustomerId(Long customerId);

	@Query(value = "SELECT * FROM customers c WHERE c.company_id = :companyId", nativeQuery = true)
	List<Customers> findAllByCompanyId(@Param("companyId") Long companyId);


}
