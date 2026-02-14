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
    <link rel="stylesheet" href="css/applyJob.css">
</head>

<body class="container mt-5">

    <!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">JobPortal</a>
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


<!-- Job Details Card -->
<div class="card mb-4 shadow-sm">
    <div class="card-body">
      <h3 class="card-title text-primary"><%= job.getTitle() %></h3>
      <h6 class="card-subtitle mb-2 text-muted">
        <i class="bi bi-building"></i> <%= job.getCompany() != null ? job.getCompany() : "Not specified" %>
      </h6>
      <hr>
  
      <p><i class="bi bi-briefcase"></i> <b>Experience:</b>
        <%= job.getExperience() != null ? job.getExperience() + " years" : "Not specified" %>
      </p>
  
      <p><i class="bi bi-geo-alt"></i> <b>Location:</b>
        <%= job.getLocation() != null ? job.getLocation() : "Not specified" %>
      </p>
  
      <p><i class="bi bi-currency-dollar"></i> <b>Salary:</b>
        <%= job.getSalaryRange() != null ? job.getSalaryRange() : "Not disclosed" %>
      </p>
  
      <p><i class="bi bi-lightbulb"></i> <b>Skills:</b>
        <%= job.getSkills() != null ? job.getSkills() : "As per JD" %>
      </p>
  
      <hr>
      <h5>Description</h5>
      <p><%= job.getDescription() %></p>
    </div>
  </div>  
    

<hr>

<h5 class="mt-4">Apply for this job</h5>

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

    <button type="submit" class="btn btn-success">Submit Application</button>
    <a href="job-list.jsp" class="btn btn-outline-secondary ms-2">Cancel</a>
</form>

</form>



</body>
</html>
