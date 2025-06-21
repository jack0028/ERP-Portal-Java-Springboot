package com.make_invoice.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.make_invoice.Model.Expense;

@Repository
public interface ExpenseRepository extends JpaRepository<Expense, Long> {
	
    boolean existsByCategoryAndExpense(String category, String expense);
    
    @Query("SELECT e.expense FROM Expense e WHERE e.category = :category")
    List<String> findExpenseByCategory(@Param("category") String category);
    
    List<Expense> findByCategory(String category);

    @Query(value = "SELECT SUM(e.amount) FROM expense e JOIN company_details c ON e.company_id = c.company_id WHERE c.company_id = :companyId", nativeQuery = true)
    Double findExpenseAmountByCompany(@Param("companyId") Long companyId);

    @Query("SELECT e FROM Expense e WHERE e.company.companyId = :companyId")
	List<Expense> findAllCompanyId(Long companyId);


   

}
