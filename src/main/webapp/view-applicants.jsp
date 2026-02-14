<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jobportal.dao.ApplicationDao" %>
<%@ page import="com.jobportal.dto.ApplicationView" %>
<%@ page import="com.jobportal.entity.User" %>

<%
    User recruiter = (User) session.getAttribute("user");
    if (recruiter == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ApplicationDao dao = new ApplicationDao();
    List<ApplicationView> apps = dao.getApplicationsByRecruiter(recruiter.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Applicants</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body { padding-top: 70px; }
        .action-btns form { display: inline; }
    </style>
</head>

<body class="bg-light">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
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

<div class="container">

    <h2 class="mb-4">Applicants for My Jobs</h2>

    <% if (apps == null || apps.isEmpty()) { %>
        <div class="alert alert-info">
            No applications received yet.
        </div>
    <% } else { %>

        <% for (ApplicationView app : apps) { %>

            <div class="card mb-3 shadow-sm">
                <div class="card-body">

                    <!-- JOB TITLE -->
                    <h5 class="card-title">
                        <%= app.getJobTitle() %>
                        <small class="text-muted">at <%= app.getCompany() %></small>
                    </h5>

                    <!-- APPLICANT DETAILS -->
                    <p class="mb-1">
                        <strong>Applicant:</strong> <%= app.getApplicantName() %>
                    </p>

                    <p class="mb-1">
                        <strong>Email:</strong> <%= app.getApplicantEmail() %>
                    </p>

                    <!-- STATUS -->
                    <p class="mb-2">
                        <strong>Status:</strong>
                        <span class="badge bg-secondary">
                            <%= app.getStatus() %>
                        </span>
                    </p>

                    <!-- DATE -->
                    <p class="text-muted small mb-3">
                        Applied on: <%= app.getAppliedAt() %>
                    </p>

                    <!-- ACTIONS -->
                    <div class="action-btns">

                        <!-- DOWNLOAD RESUME -->
                        <a href="viewResume?applicationId=<%= app.getApplicationId() %>"
                           target="_blank"
                           class="btn btn-sm btn-primary">
                            Download Resume
                        </a>

                        <% if ("Pending".equalsIgnoreCase(app.getStatus())) { %>

                            <!-- SHORTLIST -->
                            <form action="updateApplicationStatus" method="post" class="d-inline">
                                <input type="hidden" name="applicationId" value="<%= app.getApplicationId() %>">
                                <input type="hidden" name="status" value="Shortlisted">
                                <button type="submit" class="btn btn-sm btn-success">
                                    Shortlist
                                </button>
                            </form>
                            
                            <form action="updateApplicationStatus" method="post" class="d-inline ms-2">
                                <input type="hidden" name="applicationId" value="<%= app.getApplicationId() %>">
                                <input type="hidden" name="status" value="Rejected">
                                <button type="submit" class="btn btn-sm btn-danger">
                                    Reject
                                </button>
                            </form>
                            

                        <% } %>

                    </div>

                </div>
            </div>

        <% } %>

    <% } %>

</div>

</body>
</html>
