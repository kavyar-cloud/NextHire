<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.jobportal.entity.User" %>
<%
    User recruiter = (User) session.getAttribute("user");
    if (recruiter == null || !"recruiter".equals(recruiter.getRole().toLowerCase())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Recruiter Dashboard - Post Job</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/post-job.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">JobPortal</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <span class="nav-link">Welcome, <%= recruiter.getName() %></span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="logout.jsp">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="dashboard-header">
    <h2>Welcome, <%= recruiter.getName() %>!</h2>
</div>
<div class="nav-buttons">
    <a href="update-recruiter.jsp" class="btn btn-outline-primary me-2">Update Profile</a>
    <a href="recruiter-dashboard.jsp" class="btn btn-outline-warning me-2">Recruiter Dashboard</a>
    <a href="logout.jsp" class="btn btn-outline-secondary">Logout</a>
</div>

<div class="container mt-5">
    <h2 class="mb-4">Post a New Job</h2>

    <% String success = request.getParameter("success"); 
       if (success != null) { %>
       <div class="alert alert-success"><%= success %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/postJob" method="post" class="job-form">
        <div class="mb-3">
            <label for="title" class="form-label">Job Title</label>
            <input type="text" name="title" id="title" class="form-control" placeholder="Software Engineer" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Job Description</label>
            <textarea name="description" id="description" rows="5" class="form-control"
                      placeholder="Enter job responsibilities and requirements" required></textarea>
        </div>

        <div class="row">
            <div class="col-md-4 mb-3">
                <label for="location" class="form-label">Location</label>
                <input type="text" name="location" id="location" class="form-control" placeholder="City, State" required>
            </div>
            <div class="col-md-4 mb-3">
                <label for="company" class="form-label">Company</label>
                <input type="text" name="company" id="company" class="form-control" placeholder="Company Name" required>
            </div>
            <div class="col-md-4 mb-3">
                <label for="status" class="form-label">Status</label>
                <select name="status" id="status" class="form-select">
                    <option value="OPEN">Open</option>
                    <option value="CLOSED">Closed</option>
                </select>
            </div>
        </div>

        <div class="mb-3">
            <label for="experience" class="form-label">Experience (years)</label>
            <input type="number" name="experience" id="experience" class="form-control" min="0" max="50" placeholder="2">
        </div>

        <div class="mb-3">
            <label for="salary" class="form-label">Salary Range</label>
            <input type="text" name="salary" id="salary" class="form-control" placeholder="₹30000 - ₹50000">
        </div>

        <div class="mb-3">
            <label for="skills" class="form-label">Required Skills</label>
            <input type="text" name="skills" id="skills" class="form-control" placeholder="Java, Spring Boot, SQL">
        </div>

        <button type="submit" class="btn btn-primary">Post Job</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
