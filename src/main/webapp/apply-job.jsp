<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.jobportal.dao.JobDao,
                 com.jobportal.entity.Job,
                 com.jobportal.entity.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int jobId = Integer.parseInt(request.getParameter("jobId"));
    JobDao jobDao = new JobDao();
    Job job = jobDao.getJobById(jobId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Apply for Job</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/applyJob.css">
</head>

<body>
    <div class="container apply-container">

    <!-- NAVBAR -->
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
                        <small class="text-muted">Apply for this opportunity</small>
                    </li>
    
                    <li><hr class="dropdown-divider"></li>
    
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


<!-- Job Details Card -->
<div class="job-card-modern">

    <div class="job-header">
        <div>
            <h3><%= job.getTitle() %></h3>
            <p class="company">
                <i class="bi bi-building"></i>
                <%= job.getCompany() != null ? job.getCompany() : "Not specified" %>
            </p>
        </div>
    </div>

    <div class="job-meta">
        <span><i class="bi bi-briefcase"></i>
            <%= job.getExperience() != null ? job.getExperience() + " yrs" : "Not specified" %>
        </span>

        <span><i class="bi bi-geo-alt"></i>
            <%= job.getLocation() != null ? job.getLocation() : "Not specified" %>
        </span>

        <span><i class="bi bi-currency-dollar"></i>
            <%= job.getSalaryRange() != null ? job.getSalaryRange() : "Not disclosed" %>
        </span>
    </div>

    <div class="job-description-modern">
        <h6>Description</h6>
        <p><%= job.getDescription() %></p>
    </div>

</div>  
    

<hr>

<div class="apply-form-card">

    <h4 class="mb-4">
        <i class="bi bi-send me-2"></i>Submit Your Application
    </h4>

    <form action="apply" method="post" enctype="multipart/form-data">

        <input type="hidden" name="jobId" value="<%= job.getId() %>">

<form action="apply" method="post" enctype="multipart/form-data" class="p-4 bg-light rounded shadow-sm">

    <input type="hidden" name="jobId" value="<%= job.getId() %>">

    <div class="mb-3">
        <label for="fullName" class="form-label">Full Name</label>
        <input type="text" id="fullName" name="fullName" class="form-control" required>
    </div>

    <div class="mb-3">
        <label for="email" class="form-label">Email Address</label>
        <input type="email" id="email" name="email" class="form-control" required>
    </div>

    <div class="mb-3">
        <label for="phone" class="form-label">Phone Number</label>
        <input type="text" id="phone" name="phone" class="form-control" required>
    </div>

    <div class="mb-3">
        <label for="experience" class="form-label">Experience (years)</label>
        <input type="number" id="experience" name="experience" class="form-control" min="0" required>
    </div>

    <div class="mb-3">
        <label for="skills" class="form-label">Skills</label>
        <textarea id="skills" name="skills" class="form-control" placeholder="Java, SQL, Spring Boot" required></textarea>
    </div>

    <div class="mb-3">
        <label for="coverNote" class="form-label">Cover Note (optional)</label>
        <textarea id="coverNote" name="coverNote" class="form-control"></textarea>
    </div>

    <div class="mb-3">
        <label for="resume" class="form-label">Upload Resume (PDF)</label>
        <input type="file" id="resume" name="resume" class="form-control" accept="application/pdf" required>
    </div>

    <div class="mt-4">
        <button type="submit" class="btn btn-primary px-4">
            Submit Application
        </button>
        <a href="job-list.jsp" class="btn btn-outline-secondary ms-2">
            Cancel
        </a>
    </div>

</form>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
