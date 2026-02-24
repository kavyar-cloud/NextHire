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

@WebServlet("/loadUpdateProfile")
public class LoadUpdateProfileServlet extends HttpServlet {

    private UserDao userDAO = new UserDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute("user");

        if (sessionUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Fetch fresh data from DB
        User freshUser = userDAO.getUserById(sessionUser.getId());

        // Update session with fresh user
        session.setAttribute("user", freshUser);

        request.getRequestDispatcher("update-profile.jsp")
               .forward(request, response);
    }
}