package com.jobportal.servlet;

import java.io.IOException;

import com.jobportal.dao.ApplicationDao;
import com.jobportal.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateApplicationStatus")
public class UpdateApplicationStatusServlet extends HttpServlet {

    private ApplicationDao appDao = new ApplicationDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User recruiter = (User) session.getAttribute("user");

        if (recruiter == null || !"RECRUITER".equals(recruiter.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int applicationId = Integer.parseInt(request.getParameter("applicationId"));
        String status = request.getParameter("status");

        appDao.updateStatus(applicationId, status);

        response.sendRedirect("view-applicants.jsp");
    }
}
