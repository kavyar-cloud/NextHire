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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String mobile = request.getParameter("mobile");
        String role = request.getParameter("role");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setMobile(mobile);
        user.setRole(role == null ? "JOB_SEEKER" : role.toUpperCase());

        userDao.saveUser(user);

        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        response.sendRedirect(request.getContextPath() + "/job-list.jsp");
    }
}
