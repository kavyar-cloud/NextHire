<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.jobportal.entity.User" %>
<%@ page import="com.jobportal.entity.RecruiterProfile" %>
<%@ page import="com.jobportal.dao.RecruiterProfileDao" %>

<%
    User recruiter = (User) session.getAttribute("user");

    if (recruiter == null || !"recruiter".equalsIgnoreCase(recruiter.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    RecruiterProfileDao dao = new RecruiterProfileDao();
    RecruiterProfile profile = dao.findByUserId(recruiter.getId());

    if (profile == null) {
        profile = new RecruiterProfile();
        profile.setUser(recruiter);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Recruiter Profile | Job Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/update-recruiter.css">
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">JobPortal</a>
        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <a class="nav-link" href="logout.jsp">Logout</a>
            </li>
        </ul>
    </div>
</nav>

<div class="profile-wrapper">

    <!-- Sidebar -->
    <aside class="profile-sidebar">
        <div class="profile-box">
            <!-- Company Logo -->
            <img src="<%= profile.getLogo() != null 
                          ? request.getContextPath() + "/" + profile.getLogo() 
                          : request.getContextPath() + "/images/white.jpg" %>" 
                 class="profile-img" alt="Company Logo">

            <h5 class="mt-3">
                <%= profile.getCompanyName() != null ? profile.getCompanyName() : "Company Name" %>
            </h5>
            <p class="text-muted mb-0">Recruiter</p>
            <hr>
            <p class="small text-muted">Keep your company profile updated to attract top talent.</p>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="profile-content">

        <% if ("true".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success text-center">Profile updated successfully!</div>
        <% } else if ("true".equals(request.getParameter("error"))) { %>
            <div class="alert alert-danger text-center">Failed to update profile. Please try again.</div>
        <% } %>

        <div class="profile-card">
        <form action="updateRecruiterProfile" method="post" enctype="multipart/form-data">

            <!-- Company Info -->
            <div class="section">
                <h6 class="section-title">Company Information</h6>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Company Name</label>
                        <input type="text" name="companyName" class="form-control"
                               value="<%= profile.getCompanyName() != null ? profile.getCompanyName() : "" %>" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Website</label>
                        <input type="url" name="website" class="form-control"
                               value="<%= profile.getWebsite() != null ? profile.getWebsite() : "" %>">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Location</label>
                        <input type="text" name="location" class="form-control"
                               value="<%= profile.getLocation() != null ? profile.getLocation() : "" %>">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Industry</label>
                        <input type="text" name="industry" class="form-control"
                               value="<%= profile.getIndustry() != null ? profile.getIndustry() : "" %>">
                    </div>
                </div>
            </div>

            <!-- Contact Info -->
            <div class="section">
                <h6 class="section-title">Contact Information</h6>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Recruiter Name</label>
                        <input type="text" name="name" class="form-control"
                               value="<%= profile.getName() != null ? profile.getName() : "" %>" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control"
                               value="<%= recruiter.getEmail() %>" readonly>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Phone</label>
                        <input type="tel" name="phone" class="form-control"
                               value="<%= profile.getPhone() != null ? profile.getPhone() : "" %>" pattern="[0-9]{10}">
                    </div>
                </div>
            </div>

            <!-- Summary -->
            <div class="section">
                <h6 class="section-title">About Company</h6>
                <textarea name="summary" rows="4" class="form-control"
                          placeholder="Brief summary about your company"><%= profile.getSummary() != null ? profile.getSummary() : "" %></textarea>
            </div>

            <!-- Uploads -->
            <div class="section">
                <h6 class="section-title">Documents</h6>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Company Logo</label>
                        <input type="file" name="logo" class="form-control" accept="image/*">
                        <% if (profile.getLogo() != null) { %>
                            <small class="text-muted">
                                Current: <a href="<%= request.getContextPath() + "/" + profile.getLogo() %>" target="_blank">
                                    View Logo
                                </a>
                            </small>
                        <% } %>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Company Profile (PDF)</label>
                        <input type="file" name="profileDoc" class="form-control" accept="application/pdf">
                        <% if (profile.getProfileDoc() != null) { %>
                            <small class="text-muted">
                                Current: <a href="<%= request.getContextPath() + "/" + profile.getProfileDoc() %>" target="_blank">
                                    View Company Profile
                                </a>
                            </small>
                        <% } %>
                    </div>
                </div>
            </div>

            <div class="text-end mt-4">
                <button type="submit" class="btn btn-primary px-4">Save Changes</button>
            </div>

        </form>
        </div>
    </main>
</div>

</body>
</html>
