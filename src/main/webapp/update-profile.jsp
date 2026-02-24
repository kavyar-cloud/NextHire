<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.jobportal.entity.User" %>

<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma","no-cache"); // HTTP 1.0
    response.setDateHeader ("Expires", 0); // Proxies
%>

<%
    Integer completion = (Integer) request.getAttribute("profileCompletion");
    if (completion == null) {
        completion = 0;
    }
%>


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
    <title>Update Profile | NextHire</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/updateProfile.css">
</head>

<body>

<!-- ===== NAVBAR ===== -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="job-list.jsp">NextHire</a>

        <div class="dropdown ms-auto">
            <a class="nav-link dropdown-toggle user-toggle"
               href="#" data-bs-toggle="dropdown">
                <i class="bi bi-person-circle me-2"></i>
                <span><%= user.getName() %></span>
            </a>
        
            <ul class="dropdown-menu dropdown-menu-end custom-dropdown">
                <li class="dropdown-header">
                    <strong><%= user.getName() %></strong><br>
                    <small class="text-muted">Manage your profile 👤</small>
                </li>

                <li><hr class="dropdown-divider"></li>
            

                <!-- Other relevant options -->
                <li>
                    <a class="dropdown-item" href="job-list.jsp">
                        <i class="bi bi-grid me-2"></i> Dashboard
                    </a>
                </li>

                <li>
                    <a class="dropdown-item" href="status.jsp">
                        <i class="bi bi-briefcase me-2"></i> My Applications
                    </a>
                </li>

                <li><hr class="dropdown-divider"></li>

                <li>
                    <a class="dropdown-item logout-item" href="logout.jsp">
                        <i class="bi bi-box-arrow-right me-2"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>



<!-- ===== MAIN LAYOUT ===== -->
<div class="profile-wrapper">

    <!-- ===== SIDEBAR ===== -->
    <aside class="profile-box">

        <img src="<%= (user.getPhoto() != null && !user.getPhoto().isEmpty()) 
            ? request.getContextPath() + "/" + user.getPhoto()
            : request.getContextPath() + "/images/profile.jpg" %>"
            class="profile-img">

        <h3><%= user.getName() %></h3>
        <p class="role"><%= user.getRole() != null ? user.getRole() : "Job Seeker" %></p>

        <div class="progress-fill" style="width:<%= completion %>%"></div>
        Profile Strength: <%= user.getProfileCompletion() %>%
        
        
    </aside>

    <!-- ===== FORM CONTENT ===== -->
    <main class="profile-content">

        <form action="updateProfile" method="post" enctype="multipart/form-data">

            <div class="section">
                <div class="section-title">Basic Information</div>

                <div class="row">
                    <div class="col">
                        <label>Full Name</label>
                        <input type="text" name="name" class="form-control"
                               value="<%= user.getName() != null ? user.getName() : "" %>" required>
                    </div>

                    <div class="col">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control"
                               value="<%= user.getEmail() != null ? user.getEmail() : "" %>" readonly>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label>Mobile</label>
                        <input type="text" name="mobile" class="form-control"
                               value="<%= user.getMobile() != null ? user.getMobile() : "" %>">
                    </div>

                    <div class="col">
                        <label>Location</label>
                        <input type="text" name="location" class="form-control"
                               value="<%= user.getLocation() != null ? user.getLocation() : "" %>">
                    </div>
                </div>
            </div>

            <div class="section">
                <div class="section-title">Professional Summary</div>
                <textarea name="summary" rows="4" class="form-control"><%= user.getSummary() != null ? user.getSummary() : "" %></textarea>
            </div>

            <div class="section">
                <div class="section-title">Skills</div>
                <input type="text" name="skills" class="form-control"
                       value="<%= user.getSkills() != null ? user.getSkills() : "" %>">
            </div>

            <div class="section">
                <div class="section-title">Experience</div>
                <textarea name="experience" rows="3" class="form-control"><%= user.getExperience() != null ? user.getExperience() : "" %></textarea>
            </div>

            <div class="section">
                <div class="section-title">Education</div>
                <textarea name="education" rows="3" class="form-control"><%= user.getEducation() != null ? user.getEducation() : "" %></textarea>
            </div>

            <div class="section">
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label">Profile Photo</label>
                    <input type="file" name="photo" class="form-control">
                </div>
            
                <div class="col-md-6">
                    <label class="form-label">Resume (PDF)</label>
                    <input type="file" name="resume" class="form-control">
                </div>
            </div>
        </div>

        <div class="save-wrapper d-flex gap-3">

            <a href="job-list.jsp" class="btn btn-outline-secondary btn-back">
                ← Back to Dashboard
            </a>
            
        
            <button type="submit" class="btn-save">
                Save Changes
            </button>
        
        </div>

        </form>
    </main>
</div>

<script>
    function toggleDropdown() {
        document.getElementById("dropdownMenu").classList.toggle("show");
    }

    window.onclick = function(e) {
        if (!e.target.matches('.profile-btn')) {
            document.getElementById("dropdownMenu").classList.remove("show");
        }
    }
</script>

</body>
</html>