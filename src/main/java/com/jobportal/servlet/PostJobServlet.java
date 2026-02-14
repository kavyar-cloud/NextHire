package com.jobportal.servlet;

import java.io.IOException;

import com.jobportal.dao.JobDao;
import com.jobportal.entity.Job;
import com.jobportal.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/postJob")
public class PostJobServlet extends HttpServlet {
    private JobDao jobDao = new JobDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)

            throws ServletException, IOException {

        System.out.println("✅ PostJobServlet triggered");
        HttpSession session = request.getSession();
        User recruiter = (User) session.getAttribute("user");

        System.out.println("Recruiter: " + recruiter);
        System.out.println("Role: " + (recruiter != null ? recruiter.getRole() : "null"));

        if (recruiter == null || !"recruiter".equals(recruiter.getRole().toLowerCase())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }


        // ✅ Get form parameters
        String title = request.getParameter("title");
        String company = request.getParameter("company");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        // ✅ Create Job object
        Job job = new Job();
        job.setTitle(title);
        job.setCompany(company);
        job.setLocation(location);
        job.setDescription(description);
        job.setStatus("OPEN");
        System.out.println("🔥 FINAL STATUS VALUE = [" + job.getStatus() + "]");
        job.setPostedBy(recruiter.getId());

        // ✅ Save to DB
        jobDao.saveJob(job);

        // ✅ Redirect with success message
        response.sendRedirect(request.getContextPath() + "/post-job.jsp?success=Job posted successfully");
        System.out.println("Calling saveJob for: " + title);

    }
}
