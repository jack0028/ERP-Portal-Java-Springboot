package com.make_invoice.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.make_invoice.Service.DailySalesDTO;
import com.make_invoice.Service.InvoiceService;
import com.make_invoice.Service.LastInvoiceDTO;

import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/reports")
public class InvoiceController {

    @Autowired
    private InvoiceService invoiceService;

    
    @GetMapping("/getDailySales")
    public List<DailySalesDTO> getDailySales(HttpSession session) {
      	 Long companyId = (Long) session.getAttribute("companyId");
        return invoiceService.getDailySales(companyId);  // Call service method to fetch daily sales
    }
    
    @GetMapping("/getProductAmounts")
    public List<Map<String, Object>> getProductAmounts(HttpSession session) {
   	 Long companyId = (Long) session.getAttribute("companyId");

        return invoiceService.getProductAmounts(companyId);
    }
    
 
    @GetMapping("/getLast10Invoices")
    @ResponseBody
    public List<LastInvoiceDTO> getLast10Invoices(HttpSession session) {
      	 Long companyId = (Long) session.getAttribute("companyId");

        return invoiceService.getLast10Invoices(companyId);
    }

}
