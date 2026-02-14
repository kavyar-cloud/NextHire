<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, com.jobportal.entity.Job, com.jobportal.entity.User, com.jobportal.dao.JobDao" %>
<%
    User recruiter = (User) session.getAttribute("user");
    if (recruiter == null || !"recruiter".equals(recruiter.getRole().toLowerCase())) {
        response.sendRedirect("login.jsp");
        return;
    }

    JobDao jobDao = new JobDao();
    List<Job> jobs = jobDao.getJobsByRecruiter(recruiter.getId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Recruiter Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/recruiter-dashboard.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">JobPortal</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="page-content">
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Your Posted Jobs</h2>
        <a href="post-job.jsp" class="btn btn-primary">Post New Job</a>
    </div>

    <% if (jobs.isEmpty()) { %>
        <div class="alert alert-info">You haven't posted any jobs yet.</div>
    <% } else { %>
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>Job Title</th>
                    <th>Status</th>
                    <th>Applicants</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Job job : jobs) { %>
                    <tr>
                        <td><%= job.getTitle() %></td>
                        <td><%= job.getStatus() %></td>
                        <td>
                            <%
                                int count = jobDao.getApplicationCount(job.getId());
                            %>
                            <%= count %>
                        </td>
                        <td>
                            <a href="view-applicants.jsp?jobId=<%= job.getId() %>" class="btn btn-sm btn-info">View Applicants</a>
                            <a href="edit-job.jsp?jobId=<%= job.getId() %>" class="btn btn-sm btn-warning">Edit</a>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
