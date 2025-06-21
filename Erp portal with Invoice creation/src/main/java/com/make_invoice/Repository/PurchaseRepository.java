package com.make_invoice.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import com.make_invoice.Model.Purchase;

@Repository
public interface PurchaseRepository extends JpaRepository<Purchase, Long> {

    @Query("SELECT SUM(p.amount) FROM Purchase p WHERE p.company.companyId = :companyId")
    Double findTotalAmountByCompany(@Param("companyId") Long companyId);

    @Query("SELECT p FROM Purchase p WHERE p.company.companyId = :companyId")
    Page<Purchase> findByCompanyId(@Param("companyId") Long companyId, Pageable pageable);
}




