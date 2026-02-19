<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,
                 com.jobportal.dao.JobDao,
                 com.jobportal.dao.ApplicationDao,
                 com.jobportal.entity.Job,
                 com.jobportal.entity.User" %>

<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    JobDao jobDao = new JobDao();
    ApplicationDao appDao = new ApplicationDao();
    List<Job> jobs = jobDao.getAllJobs();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Job Seeker Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet" href="css/jobList.css">
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">NextHire</a>

        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <span class="nav-link">Welcome, <%= user.getName() %></span>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="logout.jsp">Logout</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container main-content">

    <!-- HEADER -->
    <div class="dashboard-header">
        <h2>Welcome, <%= user.getName() %> 👋</h2>
    </div>

    <!-- ACTION BUTTONS -->
    <div class="text-center action-buttons">
        <a href="status.jsp" class="btn btn-outline-primary me-2">My Applications</a>
        <a href="update-profile.jsp" class="btn btn-outline-warning me-2">Update Profile</a>
        <a href="logout.jsp" class="btn btn-outline-secondary">Logout</a>
    </div>

    <h3 class="mb-4 mt-4">Available Jobs</h3>

    <% if (jobs.isEmpty()) { %>
        <div class="alert alert-info">
            No jobs available right now.
        </div>
    <% } %>

    <% for (Job job : jobs) {
           boolean alreadyApplied =
               appDao.hasUserApplied(job.getId(), user.getId());
    %>

    <!-- JOB CARD -->
    <div class="card mb-4 shadow-sm">
        <div class="card-body">

            <h4 class="card-title"><%= job.getTitle() %></h4>

            <p>
                <strong>Company:</strong>
                <%= job.getCompany() != null ? job.getCompany() : "Not specified" %>
            </p>

            <p>
                <strong>Status:</strong>
                <%= job.getStatus() != null ? job.getStatus() : "Open" %>
            </p>

            <!-- APPLY / APPLIED -->
            <div class="applied-container mt-3">
                <% if (alreadyApplied) { %>
                    <span class="job-btn btn-applied">
                        Applied
                    </span>
                <% } else { %>
                    <a href="apply-job.jsp?jobId=<%= job.getId() %>"
                       class="job-btn btn-apply">
                        Apply Now
                    </a>
                <% } %>
            </div>
            
            

        </div>
    </div>

    <% } %>

</div>

</body>
</html>
