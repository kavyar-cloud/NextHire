    package com.jobportal.servlet;

    import java.io.IOException;

    import com.jobportal.dao.UserDao;
    import com.jobportal.entity.User;
    import com.jobportal.util.FileUploadUtil;

    import jakarta.servlet.ServletException;
    import jakarta.servlet.annotation.MultipartConfig;
    import jakarta.servlet.annotation.WebServlet;
    import jakarta.servlet.http.HttpServlet;
    import jakarta.servlet.http.HttpServletRequest;
    import jakarta.servlet.http.HttpServletResponse;
    import jakarta.servlet.http.HttpSession;
    import jakarta.servlet.http.Part;

    @WebServlet("/updateProfile")
    @MultipartConfig
    public class UpdateProfileServlet extends HttpServlet {

        private UserDao userDao = new UserDao();

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // 🔥 ALWAYS LOAD FRESH DATA FROM DB
            User freshUser = userDao.getUserById(user.getId());
            session.setAttribute("user", freshUser);

            request.getRequestDispatcher("update-profile.jsp").forward(request, response);
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            HttpSession session = request.getSession();
            User sessionUser = (User) session.getAttribute("user");

            if (sessionUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // 🔥 LOAD USER FROM DB (IMPORTANT)
            User user = userDao.getUserById(sessionUser.getId());

            // ===== FORM DATA =====
            user.setName(request.getParameter("name"));
            user.setMobile(request.getParameter("mobile"));
            user.setLocation(request.getParameter("location"));
            user.setSummary(request.getParameter("summary"));
            user.setSkills(request.getParameter("skills"));
            user.setExperience(request.getParameter("experience"));
            user.setEducation(request.getParameter("education"));

            // ===== FILE UPLOADS =====
            Part photo = request.getPart("photo");
            Part resume = request.getPart("resume");

            if (photo != null && photo.getSize() > 0) {
                String photoPath = FileUploadUtil.save(photo, getServletContext());

                user.setPhoto(photoPath);
            }

            if (resume != null && resume.getSize() > 0) {
                String resumePath = FileUploadUtil.save(resume, getServletContext());

                user.setResume(resumePath);
            }

            // ===== UPDATE =====
            userDao.updateProfile(user);

            // 🔥 UPDATE SESSION WITH FRESH USER
            session.setAttribute("user", user);

            // 🔥 FORWARD (NOT REDIRECT)
            request.setAttribute("success", true);
            request.getRequestDispatcher("update-profile.jsp").forward(request, response);
        }
    }
