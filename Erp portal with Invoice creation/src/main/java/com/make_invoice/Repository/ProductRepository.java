package com.make_invoice.Repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.make_invoice.Model.ProductDetails;

@Repository
public interface ProductRepository extends JpaRepository<ProductDetails, Long> {

    List<ProductDetails> findByCustomer_BillNo(Long billNo);
    
    @Query(value = "SELECT DATE(cd.date) AS saleDate, SUM(pd.amount) AS totalAmount " +
            "FROM product_details pd " +
            "JOIN customer_details cd ON pd.bill_no = cd.bill_no " +
            "WHERE cd.company_id = :companyId " +  // Filter by companyId
            "GROUP BY DATE(cd.date) " +
            "ORDER BY saleDate ASC", 
    nativeQuery = true)
List<Object[]> findDailySales(@Param("companyId") Long companyId);

    
@Query("SELECT p.productName AS productName, SUM(p.quantity) AS totalQuantity " +
	       "FROM ProductDetails p " +
	       "WHERE p.company.id = :companyId " +  // Filter by companyId in ProductDetails
	       "GROUP BY p.productName " +
	       "ORDER BY totalQuantity DESC")
	List<Object[]> findTopProductsByCompanyId(@Param("companyId") Long companyId, Pageable pageable);

	@Query("SELECT COUNT(p) FROM ProductDetails p WHERE p.company.companyId = :companyId")
	Integer countTotalProductsByCompany(@Param("companyId") Long companyId);

	@Query("SELECT SUM(p.amount) FROM ProductDetails p WHERE p.company.id = :companyId")
	Double findSalesAmountByCompanyId(@Param("companyId") Long companyId);

    
	@Query("SELECT p.productName AS productName, SUM(p.amount) AS totalAmount FROM ProductDetails p " +
		       "WHERE p.company.id = :companyId " +
		       "GROUP BY p.productName")
		List<Object[]> findProductAmountsByCompany(@Param("companyId") Long companyId);

    
    @Query(value = "SELECT " +
            "p.bill_no AS billNo, " +
            "p.product_name AS productName, " +
            "ROUND((CAST(c.gst AS DECIMAL(10, 2)) / 100) * CAST(p.amount AS DECIMAL(10, 2)), 2) AS gst " +
            "FROM product_details p " +
            "JOIN customer_details c ON p.bill_no = c.bill_no", 
    nativeQuery = true)

List<Object[]> findProductGstDetails();

    
@Query("SELECT COALESCE(SUM(p.amount), 0) FROM ProductDetails p JOIN p.customer c WHERE c.billNo = :billNo")
double sumAmountsByBillNo(@Param("billNo") Long billNo);


List<ProductDetails> findByCustomer_BillNoAndCompany_CompanyId(Long billNo, Long companyId);

List<ProductDetails> findByCustomer_BillNoIn(List<Long> billNos);

@Query("SELECT p FROM ProductDetails p WHERE p.company.companyId = :companyId")
Page<ProductDetails> findAllproducts(Pageable pageable, Long companyId);


}



