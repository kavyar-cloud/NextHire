package com.jobportal.servlet;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;

import com.jobportal.dao.ApplicationDao;
import com.jobportal.entity.Application;
import com.jobportal.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/apply")
@MultipartConfig
public class ApplyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"job_seeker".equals(user.getRole().toLowerCase())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String jobIdStr = request.getParameter("jobId");
        if (jobIdStr == null || jobIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/job-list.jsp?error=Missing job ID");
            return;
        }
        int jobId = Integer.parseInt(jobIdStr);

        Part resumePart = request.getPart("resume");
        String fileName = resumePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("") + File.separator + "resumes";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        resumePart.write(filePath);

        Application app = new Application();
        app.setJobId(jobId);
        app.setUserId(user.getId());
        app.setResumePath("resumes/" + fileName);
        app.setStatus("Pending");
        app.setAppliedAt(LocalDateTime.now());
        app.setFullName(request.getParameter("fullName"));
        app.setEmail(request.getParameter("email"));
        app.setPhone(request.getParameter("phone"));
        app.setExperience(Integer.parseInt(request.getParameter("experience")));
        app.setSkills(request.getParameter("skills"));
        app.setCoverNote(request.getParameter("coverNote"));

        ApplicationDao appDao = new ApplicationDao();
        // ✅ CHECK BEFORE APPLY
        if (appDao.hasUserApplied(jobId, user.getId())        ) {
            response.sendRedirect(
                request.getContextPath() +
                "/job-details.jsp?id=" + jobId + "&error=already_applied"
            );
            return;
        }
        appDao.saveApplication(app);

        response.sendRedirect(request.getContextPath() + "/status.jsp?success=Application submitted successfully");
    }
}
