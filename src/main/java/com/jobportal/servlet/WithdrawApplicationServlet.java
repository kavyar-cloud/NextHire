package com.jobportal.servlet;
import java.io.IOException;

import com.jobportal.dao.ApplicationDao;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/withdrawApplication")
public class WithdrawApplicationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int applicationId = Integer.parseInt(request.getParameter("applicationId"));

        ApplicationDao dao = new ApplicationDao();
        dao.withdrawApplication(applicationId);

        response.sendRedirect("status.jsp");
    }
}
