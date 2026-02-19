package com.jobportal.servlet;

import java.io.IOException;

import com.jobportal.dao.RecruiterProfileDao;
import com.jobportal.entity.RecruiterProfile;
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

@WebServlet("/updateRecruiterProfile")
@MultipartConfig
public class UpdateRecruiterProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"recruiter".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect("login.jsp");
            return;
        }

        RecruiterProfileDao dao = new RecruiterProfileDao();
        RecruiterProfile profile = dao.findByUserId(user.getId());

        if (profile == null) {
            profile = new RecruiterProfile();
            profile.setUser(user);
        }

        // ===== FORM DATA =====
        profile.setCompanyName(req.getParameter("companyName"));
        profile.setWebsite(req.getParameter("website"));
        profile.setLocation(req.getParameter("location"));
        profile.setIndustry(req.getParameter("industry"));
        profile.setName(req.getParameter("name"));
        profile.setPhone(req.getParameter("phone"));
        profile.setSummary(req.getParameter("summary"));

        // ===== FILE UPLOADS =====
        Part logo = req.getPart("logo");
        Part profileDoc = req.getPart("profileDoc");

        // 🔥 SAVE LOGO
        if (logo != null && logo.getSize() > 0) {
            String logoPath = FileUploadUtil.save(logo, getServletContext());
            profile.setLogo(logoPath);
        }

        // 🔥 SAVE PROFILE DOCUMENT
        if (profileDoc != null && profileDoc.getSize() > 0) {
            String docPath = FileUploadUtil.save(profileDoc, getServletContext());
            profile.setProfileDoc(docPath);
        }

        // ===== SAVE OR UPDATE =====
        dao.saveOrUpdate(profile);

        // 🔥 REFRESH PROFILE IN SESSION
        RecruiterProfile updatedProfile = dao.findByUserId(user.getId());
        session.setAttribute("recruiterProfile", updatedProfile);

        resp.sendRedirect("update-recruiter.jsp?success=true");
    }
}
    
