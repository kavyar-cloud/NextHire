<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jobportal.entity.Application" %>
<%@ page import="com.jobportal.dao.ApplicationDao" %>
<%@ page import="com.jobportal.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Applicants</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <h2 class="mb-4">Applicants for My Jobs</h2>
    <%
        User recruiter = (User) session.getAttribute("user");
        ApplicationDao appDao = new ApplicationDao();
        List<Application> apps = appDao.getApplicationsByRecruiter(recruiter.getId());
        for (Application app : apps) {
    %>
    <div class="card mb-3">
        <div class="card-body">
            <p><strong>Job ID:</strong> <%= app.getJobId() %></p>
            <p><strong>Applicant User ID:</strong> <%= app.getUserId() %></p>
            <p><strong>Status:</strong> <%= app.getStatus() %></p>
            <a href="<%= app.getResumePath() %>" class="btn btn-sm btn-primary">Download Resume</a>
        </div>
    </div>
    <% } %>
</div>
</body>
</html>
