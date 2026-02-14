package com.jobportal.servlet;

import com.jobportal.dao.ContactDao;
import com.jobportal.entity.ContactMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private ContactDao contactDao = new ContactDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ContactMessage msg = new ContactMessage();
        msg.setName(request.getParameter("name"));
        msg.setEmail(request.getParameter("email"));
        msg.setMessage(request.getParameter("message"));

        contactDao.saveMessage(msg);

        response.sendRedirect("index.jsp#contact");
    }
}
