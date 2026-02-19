package com.jobportal.servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import com.jobportal.dao.ApplicationDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/viewResume")
public class ViewResumeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int appId = Integer.parseInt(request.getParameter("applicationId"));

        ApplicationDao dao = new ApplicationDao();
        String resumePath = dao.markResumeViewed(appId);

        if (resumePath == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Resume not found");
            return;
        }

        // Get absolute path
        String fullPath = getServletContext().getRealPath("") + File.separator + resumePath;

        File file = new File(fullPath);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
            return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");

        Files.copy(file.toPath(), response.getOutputStream());
    }
}
