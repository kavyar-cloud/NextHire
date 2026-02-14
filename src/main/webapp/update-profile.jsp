<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.jobportal.entity.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Profile | Job Portal</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/updateProfile.css">
</head>

<body>

    <body><nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">JobPortal</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

<div class="profile-wrapper">

    <!-- ===== SIDEBAR ===== -->
    <aside class="profile-sidebar">
        <div class="profile-box">

            <!-- PROFILE IMAGE -->
            <img src="<%= user.getPhoto() != null 
              ? request.getContextPath() + "/" + user.getPhoto() 
              : request.getContextPath() + "/images/profile.jpg" %>" 
                class="profile-img" alt="Profile Photo">


            <h5 class="mt-3"><%= user.getName() %></h5>
            <p class="text-muted mb-0"><%= user.getRole() != null ? user.getRole() : "Job Seeker" %></p>

            <hr>
            <p class="small text-muted">
                Keep your profile updated to get better job matches.
            </p>
        </div>
    </aside>

    <!-- ===== MAIN CONTENT ===== -->
    <main class="profile-content">

        <!-- Success / Error Messages -->
        <% if ("true".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success text-center">Profile updated successfully!</div>
        <% } else if ("true".equals(request.getParameter("error"))) { %>
            <div class="alert alert-danger text-center">Failed to update profile. Please try again.</div>
        <% } %>
        

        <form action="updateProfile" method="post" enctype="multipart/form-data">

            <!-- BASIC INFO -->
            <div class="section">
                <h6 class="section-title">Basic Information</h6>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="name" class="form-control"
                               value="<%= user.getName() != null ? user.getName() : "" %>" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control"
                               value="<%= user.getEmail() != null ? user.getEmail() : "" %>" readonly>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Mobile Number</label>
                        <input type="tel" name="mobile" class="form-control"
                               value="<%= user.getMobile() != null ? user.getMobile() : "" %>" 
                                pattern="[0-9]{10}" maxlength="10">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Location</label>
                        <input type="text" name="location" class="form-control"
                               value="<%= user.getLocation() != null ? user.getLocation() : "" %>">
                    </div>
                </div>
            </div>

            <!-- SUMMARY -->
            <div class="section">
                <h6 class="section-title">Professional Summary</h6>
                <textarea name="summary" rows="4" class="form-control"
                          placeholder="Brief summary highlighting your skills and career goals"><%= user.getSummary() != null ? user.getSummary() : "" %></textarea>
            </div>

            <!-- SKILLS -->
            <div class="section">
                <h6 class="section-title">Key Skills</h6>
                <input type="text" name="skills" class="form-control"
                       value="<%= user.getSkills() != null ? user.getSkills() : "" %>"
                       placeholder="(Java, Spring Boot, SQL, HTML, CSS)">
                <small class="text-muted">Separate skills with commas</small>
            </div>

            <!-- EXPERIENCE -->
            <div class="section">
                <h6 class="section-title">Experience</h6>
                <textarea name="experience" rows="3" class="form-control"
                          placeholder="(Internships, projects, or work experience)"><%= user.getExperience() != null ? user.getExperience() : "" %></textarea>
            </div>

            <!-- EDUCATION -->
            <div class="section">
                <h6 class="section-title">Education</h6>
                <textarea name="education" rows="3" class="form-control"
                          placeholder="(Degree, College, Year)"><%= user.getEducation() != null ? user.getEducation() : "" %></textarea>
            </div>

            <!-- UPLOADS -->
            <div class="section">
                <h6 class="section-title">Documents</h6>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Profile Photo (optional)</label>
                        <input type="file" name="photo" class="form-control" accept="image/*">
                        <% if (user.getPhoto() != null) { %>
                        <small class="text-muted">
                            Current: <a href="<%= request.getContextPath() + "/" + user.getPhoto() %>" target="_blank">
                            View Photo
                            </a>
                        </small>
                        <% } %>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Resume (PDF)</label>
                        <input type="file" name="resume" class="form-control" accept="application/pdf">
                        <% if (user.getResume() != null) { %>
                        <small class="text-muted">
                            Current: <a href="<%= request.getContextPath() + "/" + user.getResume() %>" target="_blank">
                            View Resume
                        </a>
                        </small>
                        <% } %>
                    </div>
                </div>
            </div>


            <!-- SAVE -->
            <div class="text-end mt-4">
                <button type="submit" class="btn btn-primary px-4">
                    Save Changes
                </button>
            </div>

        </form>
    </main>
</div>

</body>
</html>
