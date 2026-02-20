package com.jobportal.servlet;

import java.io.IOException;

import com.jobportal.dao.UserDao;
import com.jobportal.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        User user = userDao.getUserByEmail(email);

        if (user != null) {

            // redirect to reset page with email
            response.sendRedirect(
                    request.getContextPath()
                    + "/reset-password.jsp?email="
                    + email
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/forgot-password.jsp?error=Email not registered"
            );
        }
    }
}