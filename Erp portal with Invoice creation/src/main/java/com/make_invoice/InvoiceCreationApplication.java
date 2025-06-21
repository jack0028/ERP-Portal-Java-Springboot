package com.make_invoice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories(basePackages = "com.make_invoice.Repository")
public class InvoiceCreationApplication {

	public static void main(String[] args) {
		SpringApplication.run(InvoiceCreationApplication.class, args);
	}

}
