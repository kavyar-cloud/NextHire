package com.jobportal.servlet;

import java.io.IOException;

import com.jobportal.dao.UserDao;
import com.jobportal.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDao.getUserByEmailAndPassword(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            String role = user.getRole().toLowerCase();

            if ("job_seeker".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/job-list.jsp");
            } else if ("recruiter".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/post-job.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=Unknown role");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Invalid credentials");
        }
    }
}
