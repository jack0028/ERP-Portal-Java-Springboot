package com.make_invoice.Controller;

import java.io.ByteArrayOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import net.coobird.thumbnailator.Thumbnails;
import com.make_invoice.Model.CompanyDetails;
import com.make_invoice.Model.CustomerDetails;
import com.make_invoice.Model.Customers;
import com.make_invoice.Model.Expense;
import com.make_invoice.Model.ProductDetails;
import com.make_invoice.Model.Products;
import com.make_invoice.Model.Purchase;
import com.make_invoice.Repository.customerDetailsRepository;
import com.make_invoice.Service.CustomerHistoryDTO;
import com.make_invoice.Service.CustomerService;
import com.make_invoice.Service.GstFileDTO;
import com.make_invoice.Service.GstProductDTO;
import com.make_invoice.Service.InvoiceService;
import com.make_invoice.Service.PaymentDetailsDTO;
import com.make_invoice.utility.DatabaseUtil;
import com.make_invoice.utility.NumberToWords;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class CustomerControllers {

	@Autowired
	private JavaMailSender emailSender;

	@PostMapping("/queryAndBackup")
	public String submitQuery(@RequestParam("email") String email, @RequestParam("subject") String subject,
			@RequestParam("message") String message, @RequestParam("cname") String cname,
			RedirectAttributes redirectAttributes) {

		sendConfirmationEmail(email, cname, subject, message);

		redirectAttributes.addFlashAttribute("emailSuccess",
				"Thank you for your query, " + cname + ". Our customer care will reach you soon.");

		return "redirect:/settings";
	}

	public void sendConfirmationEmail(String userEmail, String cname, String subject, String messageContent) {
		try {
			MimeMessage message = emailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

			// HTML Template for Email Body
			String htmlBody = "<div style='font-family: Arial, sans-serif; border: 1px solid #ddd; padding: 20px; max-width: 600px; margin: auto;background-color: #f8f8f8;'>"
					+ "<div style='background-color: #0056b3; text-align: center; padding: 20px;'>"
					+ "<img src='cid:businessLogo' alt='Company Logo' style='width: 60px; height: 60px; display: block; margin: 0 auto;'/>"
					+ "<h1 style='color: #fff; font-family: \"Brush Script MT\", \"Lucida Handwriting\", cursive; font-style: italic; margin-top: 10px;'>Business Planning</h1>\n"
					+ "</div>" + "<div style='padding: 20px;'>" + "<h2 style='color: #0056b3;'>Dear " + cname + ",</h2>"
					+ "<p>We have received your query regarding: <strong>" + subject + "</strong></p>"
					+ "<p><strong>Message:</strong><br>" + messageContent + "</p>"
					+ "<p>Our customer care team will get back to you soon.</p>" + "<br>"
					+ "<p style='text-align: center;'>Best regards,<br><strong>Care Executive</strong></p>" + "</div>"
					+ "<hr>"
					+ "<p style='font-size: 12px; text-align: center; color: #888;'>This is an automated email. Please do not reply.</p>"
					+ "</div>";

			helper.setFrom("jackjustin909@gmail.com");
			helper.setTo(userEmail);
			helper.setSubject("Query Received: " + subject);
			helper.setText(htmlBody, true); // Enable HTML

			// Attach Inline Logo
			ClassPathResource resource = new ClassPathResource("/static/business.jpg");
			helper.addInline("businessLogo", resource);

			emailSender.send(message);

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	// Constructor injection of customerDetailsRepository
	@Autowired
	public CustomerControllers(customerDetailsRepository customerDetailsRepository) {
	}

	@Autowired
	private CustomerService cs;

	@Autowired
	private InvoiceService invoiceService;

	@GetMapping("/")
	public String homePage(HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");
		if (companyId == null) {
			return "redirect:/login";
		}
		return "report";

	}

	@PostMapping("/login")
	public String login(@RequestParam("gstNo") String gstNo, @RequestParam("phoneNumber") String phoneNumber,
			HttpSession session, HttpServletResponse response, Model model) {

		CompanyDetails company = cs.validateCompany(gstNo, phoneNumber);

		if (company != null) {
			session.setAttribute("companyId", company.getCompanyId());
			session.setAttribute("companyName", company.getBusinessName());
			session.setAttribute("companyLogoUrl", company.getLogo());
			Long companyId = company.getCompanyId();
			addPersistentCookie(response, companyId);

			return "redirect:/reports";
		} else {
			model.addAttribute("loginError", "Invalid credentials, please try again.");
			return "index";
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletResponse response) {
		session.invalidate();

		Cookie cookie = new Cookie("companyId", null);
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);

		return "redirect:/login";
	}

	@GetMapping("/login")
	public String getLogin(HttpSession session, HttpServletRequest request) {
		Long companyId = (Long) session.getAttribute("companyId");
		System.out.println("Company id :" + companyId);
		if (companyId == null) {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if ("companyId".equals(cookie.getName())) {
						companyId = Long.parseLong(cookie.getValue());
						session.setAttribute("companyId", companyId);
						break;
					}
				}
			}
		}

		if (companyId != null) {
			return "redirect:/reports";
		}
		return "index";
	}

	private void addPersistentCookie(HttpServletResponse response, Long companyId) {
		Cookie cookie = new Cookie("companyId", String.valueOf(companyId));
		cookie.setMaxAge(7 * 24 * 60 * 60);
		cookie.setPath("/");
		cookie.setHttpOnly(true);
		response.addCookie(cookie);
	}

	@GetMapping("/profile")
	public String viewProfile(HttpSession session, Model model) {
		Long companyId = (Long) session.getAttribute("companyId");
		if (companyId == null) {
			return "redirect:/login";
		}

		CompanyDetails companyDetails = cs.getCompanyDetails(companyId);
		model.addAttribute("company", companyDetails);
		return "userProfile";
	}

	@PostMapping("/registerCompany")
	public String registerCompany(@RequestParam("businessName") String businessName,
			@RequestParam("address") String address, @RequestParam("phone") String phone,
			@RequestParam("gstno") String gstNo, @RequestParam("startYear") Integer startYear,
			@RequestParam("employees") Integer employees, @RequestParam("turnover") String yearlyTurnover,
			@RequestParam("logo") MultipartFile logoFile, Model model, RedirectAttributes redirectAttributes) {

		try {
			byte[] logo = null;
			if (!logoFile.isEmpty()) {
				logo = resizeImage(logoFile);
			}

			CompanyDetails savedCompany = cs.registerCompany(businessName, address, phone, gstNo, startYear, employees,
					yearlyTurnover, logo);

			if (savedCompany != null) {
				return "redirect:/login";
			}

		} catch (IOException e) {
			e.printStackTrace();
			model.addAttribute("error", "Failed to register company: " + e.getMessage());
			return "errorPage";
		}
		return "errorPage";
	}

	public byte[] resizeImage(MultipartFile logoFile) throws IOException {
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		Thumbnails.of(logoFile.getInputStream()).size(300, 300).outputFormat("jpg").toOutputStream(outputStream);
		return outputStream.toByteArray();
	}

	@GetMapping("/register")
	public String registersPage() {
		return "companyRegister";
	}

	@GetMapping("/Balance")
	public String balancePage(@SessionAttribute("companyId") Long companyId, Model model) {

		if (companyId == null) {
			return "redirect:/login";
		}
		double purchaseAmount = cs.findTotalAmountByCompany(companyId);
		model.addAttribute("purchaseAmount", purchaseAmount);

		double salesAmount = cs.findSalesAmountByCompany(companyId);
		model.addAttribute("salesAmount", salesAmount);

		double expenseAmount = cs.findExpenseAmountByCompany(companyId);
		model.addAttribute("expenseAmount", expenseAmount);

		return "balanceSheet";
	}

	@GetMapping("/reports")
	public String reportsPage(HttpSession session, Model model) {

		Long companyId = (Long) session.getAttribute("companyId");

		if (companyId == null) {
			return "redirect:/login";
		}
		Double totalSalesAmount = invoiceService.getTotalSalesAmount(companyId);
		model.addAttribute("totalSalesAmount", totalSalesAmount);

		LocalDate tenDaysAgo = LocalDate.now().minusDays(10);

		Long count = invoiceService.countByDateAfterAndCompanyId(tenDaysAgo, companyId);
		System.out.println("Count :" + count);
		model.addAttribute("last10DaysInvoiceCount", count);

		return "report";
	}

	@GetMapping("/orders")
	public String showOrdersPage(Model model, HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		if (companyId == null) {
			return "redirect:/login";
		}

		Long newBillNo = cs.generateNewBillNumber();
		if (newBillNo == null) {
			model.addAttribute("error", "Failed to generate a new bill number.");
			return "errorPage";
		}
		System.out.println("Bill:" + newBillNo);
		model.addAttribute("billNo", newBillNo);

		return "orders";

	}

	@GetMapping("/checkProductName")
	@ResponseBody
	public Map<String, Boolean> checkProductName(@RequestParam String name) {
		boolean exists = cs.existsByName(name);
		Map<String, Boolean> response = new HashMap<>();
		response.put("exists", exists);
		return response;
	}

	@GetMapping("/generateNewBillNo")
	@ResponseBody
	public Long generateNewBillNo() {
		return cs.generateNewBillNumber();
	}

	@GetMapping("/checkCustomerName")
	@ResponseBody
	public boolean checkCustomerName(@RequestParam("name") String name, HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		System.out.println("Checking customer name: " + name + " for companyId: " + companyId);

		return cs.customerNameExists(name, companyId);
	}

	@GetMapping("/selectLayout")
	public String selectLayout(@RequestParam("companyId") Long companyId, @RequestParam("billNo") Long billNo,
			Model model) {
		if (companyId == null || billNo == null) {
			model.addAttribute("error", "Missing company or bill information.");
			return "errorPage";
		}
		System.out.println("CompanyId: " + companyId + ", BillNo: " + billNo);
		model.addAttribute("companyId", companyId);
		model.addAttribute("billNo", billNo);
		return "selectLayout";
	}

	@GetMapping("/getCustomerNames")
	@ResponseBody
	public List<Map<String, String>> getCustomerNames(@RequestParam(value = "query", required = false) String query,
			HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");
		List<Customers> customers;

		if (query != null && !query.isEmpty()) {
			customers = cs.findCustomersByNameAndCompanyId(query, companyId);
		} else {
			customers = cs.getAllCustomersByCompanyId(companyId);
		}

		Set<String> uniqueNames = new HashSet<>();
		List<Map<String, String>> customerList = new ArrayList<>();

		for (Customers customer : customers) {
			if (uniqueNames.add(customer.getCustomerId().toString())) {
				Map<String, String> customerMap = new HashMap<>();
				customerMap.put("id", customer.getCustomerId().toString());
				customerMap.put("name", customer.getName());
				customerList.add(customerMap);
			}
		}

		return customerList;
	}

	@GetMapping("/getCustomerDetails")
	@ResponseBody
	public Map<String, Object> getCustomerDetails(@RequestParam("id") Long customerId, HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		Map<String, Object> response = new HashMap<>();
		System.out.println("Billno" + customerId);
		try {
			Customers customer = cs.findByCustomerId(customerId);

			if (customer != null) {
				response.put("name", customer.getName());
				response.put("gst", customer.getGst());
				response.put("gstno", customer.getGstNo());
				response.put("address", customer.getAddress());
				response.put("phone", customer.getPhone());
				response.put("state", customer.getState());
				response.put("discount", customer.getDiscount());
				response.put("customerId", customer.getCustomerId());
			} else {
				response.put("error", "Customer not found.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.put("error", "An unexpected error occurred: " + e.getMessage());
		}

		return response;
	}

	@GetMapping(value = "/validateProduct", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getProductDetails(@RequestParam String pname, HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		Products product = cs.findByName(pname, companyId);

		Map<String, Object> response = new HashMap<>();
		if (product != null) {
			response.put("rate", product.getPrice());
			System.out.println("Product having :" + response);

		} else {
			response.put("error", "Product not found");
			System.out.println("Product miss");
		}
		return response;
	}

	@GetMapping("/checkStock")
	@ResponseBody
	public Map<String, Boolean> checkProductStock(@RequestParam String pname, @RequestParam int qty,
			HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");
		Products product = cs.findByName(pname, companyId);
		Map<String, Boolean> response = new HashMap<>();
		response.put("available", product != null && product.getQuantity() >= qty);
		System.out.println("Product 77miss");

		return response;
	}

	@GetMapping("/getProductNames")
	@ResponseBody
	public List<String> getAllProductNames(HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		return cs.getAllProducts(companyId).stream().map(Products::getName).collect(Collectors.toList());
	}

	public static long generateFiveDigitNumber() {
		// Generate a random UUID
		UUID uuid = UUID.randomUUID();

		// Extract least significant bits of the UUID and take the absolute value
		long leastSignificantBits = Math.abs(uuid.getLeastSignificantBits());

		// Get a 5-digit number by taking the modulo
		long randomFiveDigit = leastSignificantBits % 100000;

		return randomFiveDigit;
	}

	@SuppressWarnings("unchecked")
	@PostMapping("/saveData")
	public String saveData(@RequestBody Map<String, Object> billData, Model model) {
		try {
			System.out.println("Received billData: " + billData);

			Long companyId = billData.containsKey("companyId") ? Long.parseLong(billData.get("companyId").toString())
					: null;
			String invoiceNo = billData.containsKey("invoiceNo") ? billData.get("invoiceNo").toString() : null;
			Long billNo = billData.containsKey("billNo") ? Long.parseLong(billData.get("billNo").toString()) : null;
			String name = billData.containsKey("name") ? billData.get("name").toString() : null;
			String gst = billData.containsKey("gst") ? billData.get("gst").toString() : null;
			String discount = billData.containsKey("discount") ? billData.get("discount").toString() : null;
			String address = billData.containsKey("address") ? billData.get("address").toString() : null;
			String gstno = billData.containsKey("gstno") ? billData.get("gstno").toString() : null;
			String phone = billData.containsKey("phone") ? billData.get("phone").toString() : null;
			String state = billData.containsKey("state") ? billData.get("state").toString() : null;
			String modeOfPayment = billData.containsKey("modeOfPayment") ? billData.get("modeOfPayment").toString()
					: null;
			double paidAmount = billData.containsKey("paidAmount")
					? Double.parseDouble(billData.get("paidAmount").toString())
					: 0.0;
			Long customerId = null;

			if (billData.containsKey("customerId")) {
				String customerIdStr = billData.get("customerId").toString();
				if (customerIdStr != null && !customerIdStr.isEmpty()) {
					customerId = Long.parseLong(customerIdStr);
				} else {
					customerId = generateFiveDigitNumber();
				}
			} else {
				customerId = generateFiveDigitNumber();
			}

			String invoiceDateString = billData.containsKey("invoiceDate") ? billData.get("invoiceDate").toString()
					: null;
			LocalDate invoiceDate = invoiceDateString != null
					? LocalDate.parse(invoiceDateString, DateTimeFormatter.ISO_DATE)
					: null;

			cs.SaveCustomers(companyId, customerId, name, gst, discount, address, gstno, phone, state);
			Map<String, Object> products = (Map<String, Object>) billData.get("products");
			System.out.println("Received products data: " + products);

			if (products == null) {
				model.addAttribute("error", "Product data is missing");
				return "errorPage";
			}

			List<String> pnames = (List<String>) products.getOrDefault("pnames", new ArrayList<>());
			List<Integer> qtysInt = (List<Integer>) products.getOrDefault("qtys", new ArrayList<>());

			List<String> qtys = qtysInt.stream().map(String::valueOf).collect(Collectors.toList());
			List<String> rates = (List<String>) products.getOrDefault("rates", new ArrayList<>());
			List<String> amounts = (List<String>) products.getOrDefault("amounts", new ArrayList<>());

			// Debugging the retrieved lists
			System.out.println("Product names: " + pnames);
			System.out.println("Quantities: " + qtys);
			System.out.println("Rates: " + rates);
			System.out.println("Amounts: " + amounts);

			if (pnames.isEmpty() || qtys.isEmpty() || rates.isEmpty() || amounts.isEmpty()) {
				model.addAttribute("error", "Incomplete product data");
				return "errorPage";
			}

			for (int i = 0; i < pnames.size(); i++) {
				String qty = i < qtys.size() ? qtys.get(i) : "1";
				String rate = i < rates.size() && rates.get(i) != null ? rates.get(i) : "0";
				String amount = i < amounts.size() && amounts.get(i) != null ? amounts.get(i) : "0";

				if (pnames.get(i) == null || qty == null || rate == null || amount == null) {
					model.addAttribute("error", "Null value found in product data");
					return "errorPage";
				}
			}

			cs.saveData(companyId, customerId, invoiceNo, billNo, name, gst, discount, address, gstno, phone, state,
					invoiceDate, modeOfPayment, paidAmount, pnames, qtys, rates, amounts);

			return "redirect:/selectLayout?billNo=" + billNo + "&companyId=" + companyId;

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "An error occurred: " + e.getMessage());
			return "errorPage";
		}
	}

	@PostMapping("/savePurchase")
	public String savePurchases(@RequestBody List<Purchase> purchases, HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		if (companyId == null) {
			return "redirect:/login";
		}

		return cs.savePurchases(purchases, companyId);
	}

	@GetMapping("/viewInvoice")
	public String viewInvoice(@RequestParam("billNo") Long billNo, @RequestParam("companyId") Long companyId,
			@RequestParam("layout") String layout, Model model, HttpSession session) {
		CustomerDetails customer = cs.getInvoiceDetails(billNo);
		List<ProductDetails> products = cs.getProductsByBillNo(billNo);
		CompanyDetails company = cs.getCompanyDetails(companyId);

		if (customer == null || company == null) {
			model.addAttribute("error", "Invoice not found. Invalid Company ID or Bill No.");
			return "errorPage";
		}

		model.addAttribute("customer", customer);
		model.addAttribute("products", products);
		model.addAttribute("company", company);

		if ("invoice2".equalsIgnoreCase(layout)) {
			return "invoice2";
		} else if ("invoice1".equalsIgnoreCase(layout)) {
			return "invoice1";
		} else {
			model.addAttribute("error", "Invalid layout selected.");
			return "errorPage";
		}
	}

	@PostMapping("/calculateInvoice")
	@ResponseBody
	public Map<String, Object> calculateInvoice(@RequestBody Map<String, Object> calculationData) {
		Map<String, Object> response = new HashMap<>();

		try {
			double gst = Double.parseDouble(calculationData.get("gst").toString());
			double discount = Double.parseDouble(calculationData.get("discount").toString());

			List<Map<String, Object>> products = (List<Map<String, Object>>) calculationData.get("products");
			double totalAmount = 0;
			double subtotal = 0;
			for (Map<String, Object> product : products) {
				double amount = Double.parseDouble(product.get("amount").toString());
				totalAmount += amount;
			}
			System.out.println("Data :" + totalAmount + " " + discount);
			double sgstRate = gst / 2;
			double cgstRate = gst / 2;

			double sgst = (totalAmount * sgstRate) / 100;
			double cgst = (totalAmount * cgstRate) / 100;

			double discountAmount = (totalAmount * discount) / 100;

			double balance = totalAmount - discountAmount + sgst + cgst;
			subtotal = totalAmount - discountAmount;
			String amountInWords = NumberToWords.convertToWords((int) balance);

			response.put("sgst", sgstRate);
			response.put("cgst", cgstRate);
			response.put("totalAmount", totalAmount);
			response.put("balance", balance);
			response.put("amountInWords", amountInWords);
			response.put("subtotal", subtotal);

		} catch (Exception e) {
			e.printStackTrace();
			response.put("error", "Error during calculation: " + e.getMessage());
		}

		return response;
	}

	@GetMapping(value = "/companyLogo")
	@ResponseBody
	public byte[] getCompanyLogo(@RequestParam("companyId") Long companyId) {
		CompanyDetails company = cs.getCompanyDetails(companyId);
		if (company != null && company.getLogo() != null) {
			return company.getLogo();
		}
		return new byte[0];
	}

	@GetMapping("/gstFile")
	public String getGstFileDetails(HttpSession session, Model model) {
		Long companyId = (Long) session.getAttribute("companyId");

		if (companyId == null) {
			return "redirect:/login";
		}

		List<GstFileDTO> billDetails = cs.getBillSummaryWithGstAndTotalAmount(companyId);

		List<GstProductDTO> productGstDetails = cs.getProductGstDetails(companyId);

		model.addAttribute("billDetails", billDetails);
		model.addAttribute("productGstDetails", productGstDetails);

		return "gstFile";
	}

	@GetMapping("/downloadExcel")
	public void downloadExcel(HttpServletResponse response, HttpSession session) throws IOException {
		Long companyId = (Long) session.getAttribute("companyId");

		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=GST_Details.xlsx");

		Workbook workbook = new XSSFWorkbook();
		Sheet customerSheet = workbook.createSheet("GST of Customers");
		Sheet productSheet = workbook.createSheet("GST of Products");

		List<GstFileDTO> customerGstDetails = cs.getBillSummaryWithGstAndTotalAmount(companyId);
		createCustomerSheet(customerSheet, customerGstDetails);

		List<GstProductDTO> productGstDetails = cs.getProductGstDetails(companyId);
		createProductSheet(productSheet, productGstDetails);

		try (ServletOutputStream outputStream = response.getOutputStream()) {
			workbook.write(outputStream);
		} finally {
			workbook.close();
		}
	}

	private void createCustomerSheet(Sheet sheet, List<GstFileDTO> data) {
		Row header = sheet.createRow(0);
		header.createCell(0).setCellValue("Bill No");
		header.createCell(1).setCellValue("Date");
		header.createCell(2).setCellValue("Name");
		header.createCell(3).setCellValue("GST Amount");
		header.createCell(4).setCellValue("Total Amount");

		int rowCount = 1;
		for (GstFileDTO item : data) {
			Row row = sheet.createRow(rowCount++);
			row.createCell(0).setCellValue(item.getBillNo());
			row.createCell(1).setCellValue(item.getDate().toString());
			row.createCell(2).setCellValue(item.getName());
			row.createCell(3).setCellValue(item.getGstAmount());
			row.createCell(4).setCellValue(item.getTotalAmount());
		}
	}

	private void createProductSheet(Sheet sheet, List<GstProductDTO> data) {
		Row header = sheet.createRow(0);
		header.createCell(0).setCellValue("S.No");
		header.createCell(1).setCellValue("Product Name");
		header.createCell(2).setCellValue("GST");

		int rowCount = 1;
		int serialNo = 1;
		for (GstProductDTO item : data) {
			Row row = sheet.createRow(rowCount++);
			row.createCell(0).setCellValue(serialNo++);
			row.createCell(1).setCellValue(item.getProductName());
			row.createCell(2).setCellValue(item.getGst());
		}
	}

	@GetMapping("/newPurchase")
	public String getAllProducts(Model model, HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		if (companyId == null) {
			return "redirect:/login";
		}

		return "purchasePage";
	}

	@GetMapping("/expenses")
	public String showExpenses(HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		if (companyId == null) {
			return "redirect:/login";
		}

		return "expenses";
	}

	@GetMapping("/searchExpense")
	@ResponseBody
	public Map<String, Boolean> searchExpense(@RequestParam String category, @RequestParam String expense) {
		boolean exists = cs.expenseExists(category, expense);
		Map<String, Boolean> response = new HashMap<>();
		response.put("exists", exists);
		return response;
	}

	@GetMapping("/getExpenses")
	public String getExpensesByCategory(@RequestParam String category, Model model) {
		Set<String> uniqueExpenses = new HashSet<>(cs.getExpensesByCategory(category)); // Ensure uniqueness
		model.addAttribute("filteredExpenses", uniqueExpenses);
		return "expenses";
	}

	@GetMapping("/getExpensesByCategory")
	@ResponseBody
	public Set<String> getExpensesByCategory(@RequestParam String category) {
		System.out.println("Debug: Received request to get expenses for category: " + category);
		List<String> expenses = cs.getExpensesByCategory(category);

		Set<String> uniqueExpenses = new LinkedHashSet<>(expenses);

		return uniqueExpenses;
	}

	@PostMapping("/saveExpense")
	public String saveExpense(@RequestParam String category, @RequestParam String expense, @RequestParam double amount,
			@RequestParam String paymentMode, @RequestParam String date, Model model, HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		if (companyId == null) {
			return "redirect:/login";
		}
		CompanyDetails company = new CompanyDetails();
		company.setCompanyId(companyId);

		LocalDate expenseDate = LocalDate.parse(date);
		Expense newExpense = new Expense(expenseDate, expense, category, amount, paymentMode, company);
		cs.saveExpense(newExpense);
		model.addAttribute("message", "Expense added successfully!");
		return "redirect:/expenses";
	}

	@GetMapping("/stock")
	public String getProductsByPage(HttpSession session, @RequestParam(value = "page", defaultValue = "0") int page,
			Model model) {
		Long companyId = (Long) session.getAttribute("companyId");

		if (companyId == null) {
			return "redirect:/login";
		}

		Page<Products> productsPage = cs.getProducts(PageRequest.of(page, 10), companyId);

		model.addAttribute("products", productsPage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", productsPage.getTotalPages());
		long totalRecords = cs.getTotalRecords();
		model.addAttribute("totalRecords", totalRecords);

		return "stock";
	}

	@GetMapping("/getProductsById")
	@ResponseBody
	public Products getProductById(@RequestParam("id") Long id) {
		try {
			return invoiceService.getProductById(id);
		} catch (Exception e) {
			throw new RuntimeException("Error fetching product details.", e);
		}
	}

	@GetMapping("/settings")
	public String getSettingsPage(HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		if (companyId == null) {
			return "redirect:/login";
		}

		return "settings";
	}

	@GetMapping("/backup")
	public void downloadBackup(HttpServletResponse response) {
		String dbUsername = "root";
		String dbPassword = "Jebaraj2002@";
		String dbName = "demo";
		String outputFile = "E:\\Eclipse workspace\\Dashboard-Creation\\DBbackup\\backup2.sql";

		try {
			boolean success = DatabaseUtil.backup(dbUsername, dbPassword, dbName, outputFile);
			if (!success) {
				response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database backup failed");
				return;
			}

			File file = new File(outputFile);
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");
			response.setContentLengthLong(file.length());

			try (FileInputStream fis = new FileInputStream(file);
					ByteArrayOutputStream baos = new ByteArrayOutputStream()) {

				byte[] buffer = new byte[4096];
				int bytesRead;
				while ((bytesRead = fis.read(buffer)) != -1) {
					baos.write(buffer, 0, bytesRead);
				}

				response.getOutputStream().write(baos.toByteArray());
			}

		} catch (IOException e) {
			e.printStackTrace();
			try {
				response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
						"An error occurred while creating the backup file");
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
	}

	@GetMapping("/payment")
	public String getPaymentStatus(HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		if (companyId == null) {
			return "redirect:/login";
		}
		return "payment";
	}

	@PostMapping("/processPayment")
	public String processPayment(@RequestParam("amount") double amount, @RequestParam("pending") double pending,
			@RequestParam("paidAmount") double paidAmount, @RequestParam("billNo") Long billNo,
			@RequestParam("modeOfPayment") String modeOfPayment, @RequestParam("name") String name,

			Model model) {

		PaymentDetailsDTO paymentDetails = cs.processPayment(billNo, amount, paidAmount, pending, name);

		model.addAttribute("paymentDetails", paymentDetails);

		return "paymentCompleted";
	}

	@GetMapping("/searchPaymentStatus")
	public String searchPaymentStatus(@RequestParam("invoiceNo") String invoiceNo, Model model) {
		PaymentDetailsDTO paymentDetails = cs.getPaymentDetails(invoiceNo);
		model.addAttribute("paymentDetails", paymentDetails);
		model.addAttribute("invoiceNo", invoiceNo);
		return "payment";
	}

	@GetMapping("/customers")
	public String getCustomers(HttpSession session, Model model) {
		Long companyId = (Long) session.getAttribute("companyId");
		if (companyId == null) {
			return "redirect:/login";
		}

		List<Customers> customers = invoiceService.getCustomers(companyId);
		model.addAttribute("customers", customers);
		return "customers";
	}

	@GetMapping("/details")
	@ResponseBody
	public CustomerHistoryDTO getCustomerDetails(@RequestParam("customerId") Long customerId, HttpSession session,
			Model model) {
		Long companyId = (Long) session.getAttribute("companyId");
		System.out.println("CustomerId :" + customerId);
		CustomerHistoryDTO customerHistory = invoiceService.getCustomerHistoryById(customerId, companyId);
		return customerHistory;
	}

	@PostMapping("/upload")
	public String uploadCustomers(@RequestParam("customerFile") MultipartFile file, HttpSession session, Model model) {
		Long companyId = (Long) session.getAttribute("companyId");
		if (companyId == null) {
			return "redirect:/login";
		}

		if (file.isEmpty()
				|| !file.getContentType().equals("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")) {
			model.addAttribute("error", "Invalid file type.");
			return "customers";
		}

		try {
			byte[] fileBytes = file.getBytes();
			List<Customers> customerDetailsList = new ArrayList<>();
			List<CustomerDetails> customersList = new ArrayList<>();

			readCustomerDetailsFromExcel(fileBytes, customerDetailsList, companyId);
			if (!customerDetailsList.isEmpty()) {
				invoiceService.saveAllDetails(customerDetailsList);
			}

			readCustomersFromExcel(fileBytes, customersList, companyId);
			if (!customersList.isEmpty()) {
				invoiceService.saveAll(customersList);
			}

			return "redirect:/customers";
		} catch (IOException e) {
			model.addAttribute("error", "Failed to process the file.");
			return "error";
		}
	}

	private void readCustomerDetailsFromExcel(byte[] fileBytes, List<Customers> customerDetailsList, Long companyId)
			throws IOException {
		try (Workbook workbook = new XSSFWorkbook(new ByteArrayInputStream(fileBytes))) {
			Sheet sheet = workbook.getSheetAt(0);

			for (Row row : sheet) {
				if (row.getRowNum() == 0)
					continue; // Skip header row

				CompanyDetails companyDetails = new CompanyDetails();
				companyDetails.setCompanyId(companyId);

				Long customerId = getLongCellValue(row.getCell(0));
				Customers existingCustomer = invoiceService.findById(customerId);

				if (existingCustomer == null) {
					Customers customerDetails = new Customers();
					customerDetails.setCompany(companyDetails);
					customerDetails.setCustomerId(customerId);
					customerDetails.setName(getStringCellValue(row.getCell(1)));
					customerDetails.setAddress(getStringCellValue(row.getCell(2)));
					if (row.getCell(3).getCellType() == CellType.NUMERIC) {
						customerDetails.setPhone(String.valueOf((long) row.getCell(3).getNumericCellValue()));
					} else {
						customerDetails.setPhone(row.getCell(3).getStringCellValue());
					}
					customerDetails.setGstNo(getStringCellValue(row.getCell(4)));
					customerDetails.setState(getStringCellValue(row.getCell(5)));
					customerDetails.setDiscount(getStringCellValue(row.getCell(11)));
					customerDetails.setGst(getStringCellValue(row.getCell(10)));
					customerDetailsList.add(customerDetails);
				}
			}
		}
	}

	private void readCustomersFromExcel(byte[] fileBytes, List<CustomerDetails> customersList, Long companyId)
			throws IOException {
		try (Workbook workbook = new XSSFWorkbook(new ByteArrayInputStream(fileBytes))) {
			Sheet sheet = workbook.getSheetAt(0);

			for (Row row : sheet) {
				if (row.getRowNum() == 0)
					continue; // Skip header row

				Long customerId = getLongCellValue(row.getCell(0));
				CompanyDetails company = new CompanyDetails();
				company.setCompanyId(companyId);
				Customers customerDetails = invoiceService.findById(customerId);

				if (customerDetails != null) {
					CustomerDetails customer = new CustomerDetails();
					customer.setCompany(company);
					customer.setCustomers(customerDetails);
					customer.setName(getStringCellValue(row.getCell(1)));
					customer.setAddress(getStringCellValue(row.getCell(2)));

					if (row.getCell(3).getCellType() == CellType.NUMERIC) {
						customer.setPhone(String.valueOf((long) row.getCell(3).getNumericCellValue()));
					} else {
						customer.setPhone(row.getCell(3).getStringCellValue());
					}

					customer.setGstno(getStringCellValue(row.getCell(4)));
					customer.setState(getStringCellValue(row.getCell(5)));
					customer.setDiscount(getStringCellValue(row.getCell(11)));
					customer.setGst(getStringCellValue(row.getCell(10)));

					Long billNo = getLongCellValue(row.getCell(6)); // Extract billNo from the 6th cell (index 5)
					if (billNo != null) {
						customer.setBillNo(billNo); // Set billNo from the Excel
					}

					customer.setInvoiceNo(getStringCellValue(row.getCell(7)));
					customer.setModeOfPayment(getStringCellValue(row.getCell(8)));

					Cell dateCell = row.getCell(9);
					if (dateCell != null && DateUtil.isCellDateFormatted(dateCell)) {
						customer.setDate(dateCell.getLocalDateTimeCellValue().toLocalDate());
					}

					Cell paidAmountCell = row.getCell(12);
					if (paidAmountCell != null && paidAmountCell.getCellType() == CellType.NUMERIC) {
						customer.setPaidAmount(paidAmountCell.getNumericCellValue());
					}

					customersList.add(customer);
				}
			}
		}
	}

	private String getStringCellValue(Cell cell) {
		if (cell == null)
			return null;
		return cell.getCellType() == CellType.STRING ? cell.getStringCellValue()
				: String.valueOf(cell.getNumericCellValue());
	}

	private Long getLongCellValue(Cell cell) {
		if (cell == null || cell.getCellType() != CellType.NUMERIC)
			return null;
		return (long) cell.getNumericCellValue();
	}

	@GetMapping("/productForm")
	public String getProductForm(HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		if (companyId == null) {
			return "redirect:/login";
		}
		return "productForm";

	}

	@PostMapping("/products")
	public String saveProduct(@RequestParam("id") Long id, @RequestParam("name") String name,
			@RequestParam("quantity") int quantity, @RequestParam("price") double price,
			@RequestParam("sellingPrice") double sellingPrice, @RequestParam("costPrice") double costPrice,
			@RequestParam("gst") int gst, @RequestParam("description") String description,
			@RequestParam("photo") MultipartFile photo, HttpSession session, Model model) {
		try {
			// Create a new Products object
			Products product = new Products();
			// Set individual fields to the Products object
			product.setId(id);
			product.setName(name);
			product.setQuantity(quantity);
			product.setPrice(price);
			product.setSellingPrice(sellingPrice);
			product.setCostPrice(costPrice);
			product.setGst(gst);
			product.setDescription(description);

			// Handle the photo upload
			if (!photo.isEmpty()) {
				product.setPhoto(photo.getBytes());
			}

			// Fetch companyId from session and set CompanyDetails
			Long companyId = (Long) session.getAttribute("companyId");
			if (companyId == null) {
				model.addAttribute("errorMessage", "Company session not found.");
				return "productForm";
			}
			CompanyDetails company = cs.getCompanyDetails(companyId);
			product.setCompany(company);

			// Save the product using the service
			invoiceService.saveProduct(product);

			model.addAttribute("successMessage", "Product saved successfully!");
			return "redirect:/stock"; // Adjust redirect URL as needed
		} catch (Exception e) {
			model.addAttribute("errorMessage", "Error saving product: " + e.getMessage());
			return "productForm"; // Redirect back to the form in case of errors
		}
	}

	@GetMapping("/purchaseList")
	public String getPurchases(@RequestParam(value = "companyId", defaultValue = "1") Long companyId,
			@RequestParam(value = "page", defaultValue = "0") int page, Model model) {

		int pageSize = 30; // Number of records per page
		Page<Purchase> purchasePage = cs.getPurchasesByCompany(companyId, page, pageSize);

		model.addAttribute("purchases", purchasePage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", purchasePage.getTotalPages());
		return "purchaseTable"; // JSP page name
	}

	@GetMapping("/expenseList")
	public String getAllExpenses(Model model, HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		if (companyId == null) {
			return "redirect:/login";
		}
		List<Expense> expenses = cs.getAllExpenses(companyId);
		model.addAttribute("expenses", expenses);
		return "expenseList";
	}

	@GetMapping("/sales")
	public String getProducts(@RequestParam(defaultValue = "1") int page, Model model, HttpSession session) {
		Long companyId = (Long) session.getAttribute("companyId");

		if (companyId == null) {
			return "redirect:/login";
		}
		int pageSize = 30;
		PageRequest pageable = PageRequest.of(page - 1, pageSize);
		Page<ProductDetails> productPage = cs.getAllProductsd(pageable, companyId);

		model.addAttribute("products", productPage.getContent());
		model.addAttribute("totalPages", productPage.getTotalPages());
		model.addAttribute("currentPage", page);

		return "SalesTable";
	}

}
