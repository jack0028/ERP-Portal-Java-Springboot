package com.make_invoice.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/settings")
public class QueryController {

    @Autowired
    private JavaMailSender emailSender;


    @PostMapping("/queryAndBackup")
    public String submitQuery(@RequestParam("email") String email,
                              @RequestParam("subject") String subject,
                              @RequestParam("message") String message,
                              @RequestParam("cname") String cname, 
                              Model model) {

        // Send the auto-response email
        sendConfirmationEmail(email, cname, subject, message);

        model.addAttribute("emailSuccess", "Thank you for your query, " + cname + ". Our customer care will reach you soon.");
        return "settings"; // Redirect back to the same page
    }

    private void sendConfirmationEmail(String userEmail, String cname, String subject, String messageContent) {
        String body = "Dear " + cname + ",\n\n"
                + "Thank you for reaching out to us. We have received your query regarding: " + subject + ".\n\n"
                + "Message:\n" + messageContent + "\n\n"
                + "Our customer care team will get back to you soon.\n\n"
                + "Best regards,\n Care Executive ";

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("jackjustin909@gmail.com"); // Your email address
        message.setTo(userEmail);
        message.setSubject("Query Received: " + subject);
        message.setText(body);

        emailSender.send(message);
    }
}

