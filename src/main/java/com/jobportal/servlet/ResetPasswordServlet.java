package com.jobportal.servlet;

import java.io.IOException;

import com.jobportal.dao.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("password");

        boolean updated = userDao.updatePassword(email, newPassword);

        if (updated) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?success=Password updated successfully"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/reset-password.jsp?email="
                    + email
                    + "&error=Something went wrong"
            );
        }
    }
}