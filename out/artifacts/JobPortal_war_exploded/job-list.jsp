<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, com.jobportal.dao.JobDao, com.jobportal.entity.Job, com.jobportal.entity.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    JobDao jobDao = new JobDao();
    List<Job> jobs = jobDao.getAllJobs();
%>
<html>
<head>
    <title>Job Seeker Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>

<body><div class="dashboard-header">
    <h2>Welcome, <%= user.getName() %>!</h2>
    <p class="text-muted">You are logged in as <strong><%= user.getRole() %></strong></p>
</div>

<div class="nav-buttons">
    <a href="status.jsp" class="btn btn-outline-primary me-2">My Applications</a>
    <a href="logout.jsp" class="btn btn-outline-secondary">Logout</a>
</div>

<h3 class="mb-4">Available Jobs</h3>

<% for (Job job : jobs) { %>
<div class="job-card">
    <h4 class="job-title"><%= job.getTitle() %></h4>
    <p><%= job.getDescription() %></p>
    <p><strong>Company:</strong> <%= job.getCompany() != null ? job.getCompany() : "Not specified" %></p>
    <p><strong>Status:</strong> <%= job.getStatus() != null ? job.getStatus() : "Open" %></p>

    <form action="apply" method="post" enctype="multipart/form-data">
        <input type="hidden" name="jobId" value="<%= job.getId() %>">
        <div class="mb-2">
            <label for="resume" class="form-label">Upload Resume (PDF):</label>
            <input type="file" name="resume" accept="application/pdf" required class="form-control">
        </div>
        <button type="submit" class="btn btn-success btn-apply">Apply</button>
    </form>
</div>
<% } %>

</body>
</html>
