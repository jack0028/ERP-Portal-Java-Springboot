package com.make_invoice.Repository;


import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.make_invoice.Model.CustomerDetails;

@Repository
public interface customerDetailsRepository extends JpaRepository<CustomerDetails, Long> {

	@Query(value = "SELECT * FROM customer_details c WHERE c.company_id = :companyId", nativeQuery = true)
	List<CustomerDetails> findAllByCompanyId(@Param("companyId") Long companyId);

	 
    CustomerDetails findByInvoiceNo(String invoiceNo);

    
    
    @Query("SELECT c.name FROM CustomerDetails c WHERE LOWER(c.name) LIKE LOWER(CONCAT('%', :query, '%'))")
    List<String> findCustomerNamesContaining(String query);
    
    @Query(value = "SELECT * FROM customer_details c WHERE c.company_id = :companyId ORDER BY c.date DESC LIMIT 1", nativeQuery = true)
     CustomerDetails findLastCustomer(@Param("companyId") Long companyId);
    
    @Query(value = "SELECT * FROM customer_details c WHERE c.company_id = :companyId ORDER BY c.date DESC LIMIT 10", nativeQuery = true)
    List<CustomerDetails> findLast10ByCompanyIdOrderByDateDesc(@Param("companyId") Long companyId);

    @Query(value = "SELECT c.name, SUM(CAST(p.amount AS DECIMAL)) AS totalAmount " +
            "FROM customer_details c " +
            "JOIN product_details p ON c.bill_no = p.bill_no " +
            "WHERE c.company_id = :companyId " +  // Add companyId filter
            "GROUP BY c.name " +
            "ORDER BY totalAmount DESC", nativeQuery = true)
    List<Object[]> findTopCustomersByCompanyId(@Param("companyId") Long companyId, Pageable pageable);

   // List<CustomerDetails> findByNameContainingIgnoreCase(String query);

    @Query("SELECT MAX(c.billNo) FROM CustomerDetails c")
    Long findLastBillNumber();
    
    @Query(value = "SELECT c.name AS customerName, c.state, SUM(p.amount) AS totalAmount, MAX(c.date) AS lastPurchaseDate " +
            "FROM customer_details c " +
            "JOIN product_details p ON c.bill_no = p.bill_no " +
            "WHERE c.company_id = :companyId " +  // Filter by companyId
            "GROUP BY c.name, c.state " +
            "ORDER BY lastPurchaseDate DESC " +
            "LIMIT 10", nativeQuery = true)
    List<Map<String, Object>> findLast10InvoicesByCompany(@Param("companyId") Long companyId);


    @Query(value = "SELECT " +
            "c.bill_no AS billNo, " +
            "c.date AS date, " +
            "c.name AS name, " +
            "ROUND((CAST(c.gst AS DECIMAL(10, 2)) / 100) * SUM(CAST(p.amount AS DECIMAL(10, 2))), 2) AS gstAmount, " +
            "SUM(CAST(p.amount AS DECIMAL(10, 2))) AS totalAmount " +
            "FROM customer_details c " +
            "JOIN product_details p ON c.bill_no = p.bill_no " +
            "JOIN company_details comp ON c.company_id = comp.company_id " + 
            "WHERE comp.company_id = :companyId " + 
            "GROUP BY c.bill_no, c.date, c.name, c.gst", nativeQuery = true)

    List<Object[]> findBillSummaryWithGstAndTotalAmount(@Param("companyId") Long companyId);



@Query("SELECT COUNT(c) FROM CustomerDetails c WHERE c.date > :date AND c.company.id = :companyId")
    Long countByDateAfterAndCompanyId(@Param("date") LocalDate date, @Param("companyId") Long companyId);


Optional<CustomerDetails> findOptionalByName(String name);

@Query("SELECT c.billNo FROM CustomerDetails c WHERE c.name = :name")
List<Long> findBillNosByName(@Param("name") String name);

List<CustomerDetails> findAllByName(String name);

List<CustomerDetails> findAllByNameAndCompany_CompanyId(String name, Long companyId);


CustomerDetails findByBillNo(Long billNo);

@Query("SELECT CASE WHEN COUNT(c) > 0 THEN true ELSE false END FROM CustomerDetails c WHERE c.name = :name AND c.company.companyId = :companyId")
boolean existsByNameAndCompanyId(@Param("name") String name, @Param("companyId") Long companyId);

@Query("SELECT c FROM CustomerDetails c JOIN c.customers cd WHERE cd.customerId = :customerId AND c.company.companyId = :companyId")
List<CustomerDetails> findByCustomerIdAndCompanyId(Long customerId, Long companyId);



}
