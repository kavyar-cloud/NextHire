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

    String jobIdParam = request.getParameter("jobId");
    if (jobIdParam == null) {
        response.sendRedirect("recruiterDashboard.jsp");
        return;
    }

    int jobId = Integer.parseInt(jobIdParam);

    ApplicationDao dao = new ApplicationDao();
    List<ApplicationView> apps = dao.getApplicationsByJobAndRecruiter(jobId, recruiter.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Applicants</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/view-applicants.css">
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="recruiterDashboard.jsp">NextHire</a>
        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <a class="nav-link" href="logout.jsp">Logout</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container main-container">

    <h2 class="page-title mb-4">Applicants for This Job</h2>

    <% if (apps == null || apps.isEmpty()) { %>

        <div class="alert alert-info">
            No applications received for this job yet.
        </div>

    <% } else { %>

        <% for (ApplicationView app : apps) { %>

            <div class="card applicant-card mb-4 shadow-sm">
                <div class="card-body">

                    <!-- Job Title -->
                    <h5 class="card-title">
                        <%= app.getJobTitle() %>
                        <small class="text-muted">at <%= app.getCompany() %></small>
                    </h5>

                    <hr>

                    <!-- Applicant Details -->
                    <div class="row mb-2">
                        <div class="col-md-6">
                            <p><strong>Name:</strong> <%= app.getApplicantName() %></p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Email:</strong> <%= app.getApplicantEmail() %></p>
                        </div>
                    </div>

                    <%
                        String statusClass = "badge-pending";

                        if ("SHORTLISTED".equalsIgnoreCase(app.getStatus())) {
                            statusClass = "badge-shortlisted";
                        } else if ("REJECTED".equalsIgnoreCase(app.getStatus())) {
                            statusClass = "badge-rejected";
                        } else if ("WITHDRAWN".equalsIgnoreCase(app.getStatus())) {
                            statusClass = "badge-withdrawn";
                        }
                    %>

                    <p>
                        <strong>Status:</strong>
                        <span class="badge badge-status <%= statusClass %>">
                            <%= app.getStatus() %>
                        </span>
                    </p>

                    <p class="text-muted small">
                        Applied on: <%= app.getAppliedAt() %>
                    </p>

                    <!-- ACTION BUTTONS -->
                    <div class="mt-3">

                        <a href="viewResume?applicationId=<%= app.getApplicationId() %>"
                           target="_blank"
                           class="btn btn-primary btn-sm">
                            Download Resume
                        </a>

                        <% if ("PENDING".equalsIgnoreCase(app.getStatus())) { %>

                            <form action="updateApplicationStatus" method="post" class="d-inline">
                                <input type="hidden" name="applicationId" value="<%= app.getApplicationId() %>">
                                <input type="hidden" name="status" value="SHORTLISTED">
                                <button type="submit" class="btn btn-success btn-sm ms-2">
                                    Shortlist
                                </button>
                            </form>

                            <form action="updateApplicationStatus" method="post" class="d-inline">
                                <input type="hidden" name="applicationId" value="<%= app.getApplicationId() %>">
                                <input type="hidden" name="status" value="REJECTED">
                                <button type="submit" class="btn btn-danger btn-sm ms-2">
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
