package com.make_invoice.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.make_invoice.Model.ProductDetails;
import com.make_invoice.Service.CustomerHistoryDTO;
import com.make_invoice.Service.InvoiceService;
import com.make_invoice.Service.ProductDetailsDTO;
import com.make_invoice.Service.TopCustomerDTO;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/reports")
public class InvoiceViewConroller {

    @Autowired
    private InvoiceService invoiceService;

    @GetMapping("/getRecentInvoice")
    public String getRecentInvoice(HttpSession session,Model model) {
    	 Long companyId = (Long) session.getAttribute("companyId");

         if (companyId == null) {
             // Handle the case where companyId is not found in the session (e.g., redirect to login)
             return "redirect:/login";
         }
        Map<String, Object> response = invoiceService.getRecentInvoice(companyId);
        model.addAttribute("recentCustomer", response.get("recentCustomer"));
        return "recent-invoice"; // JSP page name
    }

    @GetMapping("/getTopCustomers")
    public String getTopCustomers(HttpSession session, Model model) {
    	 Long companyId = (Long) session.getAttribute("companyId");

         if (companyId == null) {
             // Handle the case where companyId is not found in the session (e.g., redirect to login)
             return "redirect:/login";
         }
        List<TopCustomerDTO> topCustomers = invoiceService.getTopCustomers(companyId);
        

        model.addAttribute("topCustomers", topCustomers);
        return "top-customers"; // JSP page name
    }

    @GetMapping("/getTrendingProducts")
    public String getTrendingProducts(HttpSession session, Model model) {
    	 Long companyId = (Long) session.getAttribute("companyId");

         if (companyId == null) {
             // Handle the case where companyId is not found in the session (e.g., redirect to login)
             return "redirect:/login";
         }
        List<ProductDetailsDTO> trendingProducts = invoiceService.getTrendingProducts(companyId);
        
        // Debug print statement to verify data retrieval
        if (trendingProducts == null || trendingProducts.isEmpty()) {
            System.out.println("No trending products retrieved.");
        } else {
            System.out.println("Trending products retrieved: " + trendingProducts.size());
        }

        model.addAttribute("trendingProducts", trendingProducts);
        return "trending-products"; // JSP page name
    }

   
    
    @GetMapping("/getTotalSales")
    public String getTotalSales(HttpSession session, Model model) {
    	 Long companyId = (Long) session.getAttribute("companyId");

         if (companyId == null) {
             // Handle the case where companyId is not found in the session (e.g., redirect to login)
             return "redirect:/login";
         }
        Map<String, Object> totalSales = invoiceService.getTotalSales(companyId);
        model.addAttribute("salesInfo", totalSales);
        return "total-sales"; 
    }
    
    @GetMapping("/last-10-days-count")
    public void getLast10DaysInvoiceCount(HttpSession session, HttpServletResponse response) throws IOException {
    	 Long companyId = (Long) session.getAttribute("companyId");

       
        LocalDate tenDaysAgo = LocalDate.now().minusDays(10);
        Long count = invoiceService.countByDateAfterAndCompanyId(tenDaysAgo, companyId);
        
        response.setContentType("application/json");
        response.getWriter().write(count.toString());
    }
    
    @GetMapping("/getTopCustomers/{name}")
    @ResponseBody
    public CustomerHistoryDTO getCustomerHistory(HttpSession session, @PathVariable String name) {
    	 Long companyId = (Long) session.getAttribute("companyId");

        

        // Get the customer history details
        CustomerHistoryDTO customerHistory = invoiceService.getCustomerHistoryByName(name, companyId);


        return customerHistory;
    }

  

}
