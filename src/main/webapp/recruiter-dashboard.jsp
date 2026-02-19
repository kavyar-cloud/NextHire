<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, com.jobportal.entity.Job, com.jobportal.entity.User, com.jobportal.dao.JobDao" %>
<%
    User recruiter = (User) session.getAttribute("user");
    if (recruiter == null || !"recruiter".equalsIgnoreCase(recruiter.getRole())) {
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
    <title>Recruiter Dashboard | NextHire</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/recruiter-dashboard.css">
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm custom-navbar">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">NextHire</a>
        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <a class="nav-link" href="logout">Logout</a>
            </li>
        </ul>
    </div>
</nav>

<!-- PAGE CONTENT -->
<div class="dashboard-wrapper">
    <div class="container">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold">Your Posted Jobs</h2>
            <a href="post-job.jsp" class="btn btn-primary shadow-sm px-4">
                + Post New Job
            </a>
        </div>

        <% if (jobs.isEmpty()) { %>
            <div class="alert alert-info text-center shadow-sm">
                You haven't posted any jobs yet.
            </div>
        <% } else { %>

        <div class="card shadow-lg border-0">
            <div class="card-body p-0">

                <div class="table-responsive">
                    <table class="table align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>Job Title</th>
                                <th>Status</th>
                                <th>Applicants</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% for (Job job : jobs) { 
                               int count = jobDao.getApplicationCount(job.getId());
                        %>
                            <tr>
                                <td class="fw-semibold">
                                    <%= job.getTitle() %>
                                </td>

                                <td>
                                    <span class="badge bg-success px-3 py-2">
                                        <%= job.getStatus() %>
                                    </span>
                                </td>

                                <td>
                                    <span class="badge bg-secondary px-3 py-2">
                                        <%= count %>
                                    </span>
                                </td>

                                <td class="text-end">
                                    <a href="view-applicants.jsp?jobId=<%= job.getId() %>" 
                                        class="btn btn-sm btn-primary">
                                        View Applicants
                                     </a>
                                     

                                    <a href="edit-job.jsp?jobId=<%= job.getId() %>"
                                       class="btn btn-sm btn-warning">
                                        Edit
                                    </a>
                                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>

        <% } %>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
