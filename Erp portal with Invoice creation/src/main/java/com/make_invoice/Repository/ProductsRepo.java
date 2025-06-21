package com.make_invoice.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.make_invoice.Model.Products;

@Repository
public interface ProductsRepo extends JpaRepository<Products, Long> {
	    
	    List<Products> findByNameContainingIgnoreCase(String name);
	    
	    @Query(value = "SELECT * FROM products WHERE CAST(quantity AS UNSIGNED) < ?1 ORDER BY price ASC LIMIT 10", nativeQuery = true)
	    List<Products> findTop10ByQuantityLessThanOrderByPriceAsc(int quantity);
	    
	    boolean existsByName(String name);

	    // Native query for counting total products
	    @Query(value = "SELECT COUNT(*) FROM products", nativeQuery = true)
	    long countTotalProducts();

		Optional<Products> findByName(String string);
		
		@Query("SELECT p FROM Products p WHERE p.company.companyId = :companyId")
	    Page<Products> findAllByCompanyId(@Param("companyId") Long companyId, Pageable pageable);
	    
	    Products findAllByName(String name);
	    
		@Query("SELECT p FROM Products p WHERE p.company.companyId = :companyId")
		List<Products> findAllByCompany(@Param("companyId") Long companyId);
		
		@Query("SELECT p FROM Products p WHERE p.name = :name AND p.company.companyId = :companyId")
	    Products findByNameAndCompanyId(@Param("name") String name, @Param("companyId") Long companyId);


}
