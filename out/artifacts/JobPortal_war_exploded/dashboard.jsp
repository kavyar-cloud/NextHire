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
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-primary">Welcome, <%= user.getName() %>!</h2>
    <p>You are logged in as <strong><%= user.getRole() %></strong>.</p>

    <div class="mt-4">
        <% if ("job_seeker".equals(user.getRole())) { %>
        <a href="job-list.jsp" class="btn btn-success">Browse Jobs</a>
        <a href="status.jsp" class="btn btn-info">My Applications</a>
        <% } else if ("recruiter".equals(user.getRole())) { %>
        <a href="post-job.jsp" class="btn btn-primary">Post a Job</a>
        <a href="view-applicants.jsp" class="btn btn-warning">View Applicants</a>
        <% } %>
        <a href="logout.jsp" class="btn btn-secondary">Logout</a>
    </div>
</div>
</body>
</html>
