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

    String keyword = request.getParameter("keyword");
    String location = request.getParameter("location");

    JobDao jobDao = new JobDao();
    ApplicationDao appDao = new ApplicationDao();
    List<Job> jobs;

    if ((keyword != null && !keyword.trim().isEmpty()) ||
        (location != null && !location.trim().isEmpty())) {

        jobs = jobDao.searchJobs(keyword, location);

    } else {
        jobs = jobDao.getAllJobs();
    }

    int totalJobs = jobs.size();
    int appliedCount = appDao.countApplicationsByUser(user.getId());
%>

<%
    com.jobportal.dao.UserDao userDao = new com.jobportal.dao.UserDao();
    user = userDao.getUserById(user.getId());
    session.setAttribute("user", user);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - NextHire</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/jobList.css">
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">NextHire</a>

        <div class="dropdown ms-auto">
            <a class="nav-link dropdown-toggle user-toggle"
               href="#" data-bs-toggle="dropdown">
                <i class="bi bi-person-circle me-2"></i>
                <span><%= user.getName() %></span>
            </a>
        
            <ul class="dropdown-menu dropdown-menu-end custom-dropdown">
                <li class="dropdown-header">
                    <strong><%= user.getName() %></strong><br>
                    <small class="text-muted">Welcome back 👋</small>
                </li>
        
                <li><hr class="dropdown-divider"></li>
        
                <li>
                    <a class="dropdown-item" href="loadUpdateProfile">
                        <i class="bi bi-pencil-square me-2"></i> Update Profile
                    </a>
                </li>
        
                <li>
                    <a class="dropdown-item" href="status.jsp">
                        <i class="bi bi-briefcase me-2"></i> My Applications
                    </a>
                </li>
        
                <li><hr class="dropdown-divider"></li>
        
                <li>
                    <a class="dropdown-item logout-item" href="logout.jsp">
                        <i class="bi bi-box-arrow-right me-2"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container dashboard-container">

    <!-- STAT CARDS -->
    <div class="row g-4 mb-4">

        <div class="col-md-4">
            <div class="card stat-card">
                <div class="stat-icon bg-primary">
                    <i class="bi bi-briefcase-fill"></i>
                </div>
                <div>
                    <h6>Total Jobs</h6>
                    <h3><%= totalJobs %></h3>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card stat-card">
                <div class="stat-icon bg-success">
                    <i class="bi bi-check-circle-fill"></i>
                </div>
                <div>
                    <h6>Applied Jobs</h6>
                    <h3><%= appliedCount %></h3>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card stat-card">
                <div class="stat-icon bg-warning">
                    <i class="bi bi-person-fill"></i>
                </div>
                <div>
                    <h6>Profile Completion</h6>
                    <h3><%= user.getProfileCompletion() %>%</h3>
                </div>
            </div>
        </div>

    </div>

    <!-- SEARCH BAR -->
    <div class="card search-card mb-4">
        <form method="get" action="job-list.jsp">
            <div class="row g-3 p-4">
    
                <div class="col-md-5">
                    <input type="text"
                           name="keyword"
                           value="<%= keyword != null ? keyword : "" %>"
                           class="form-control"
                           placeholder="Search job title...">
                </div>
    
                <div class="col-md-4">
                    <input type="text"
                           name="location"
                           value="<%= location != null ? location : "" %>"
                           class="form-control"
                           placeholder="Location">
                </div>
    
                <div class="col-md-3">
                    <button class="btn btn-primary w-100 search-btn">
                        Search Jobs
                    </button>
                </div>
    
            </div>
        </form>
    </div>

    <!-- JOB LIST -->
    <% for (Job job : jobs) {
           boolean alreadyApplied =
               appDao.hasUserApplied(job.getId(), user.getId());
    %>

    <div class="card job-card mb-3">
        <div class="row align-items-center">

            <div class="col-md-8">
                <h5 class="job-title"><%= job.getTitle() %></h5>
                <p class="text-muted mb-1">
                    <i class="bi bi-building me-1"></i>
                    <%= job.getCompany() %>
                </p>
                <p class="text-muted small">
                    <i class="bi bi-geo-alt me-1"></i>
                    <%= job.getLocation() != null ? job.getLocation() : "Not specified" %>
                </p>
            </div>

            <div class="col-md-4 text-end">
                <% if (alreadyApplied) { %>
                    <button class="applied-badge" disabled>
                        <i class="bi bi-check-circle-fill"></i>
                        Applied
                    </button>
                <% } else { %>
                    <a href="apply-job.jsp?jobId=<%= job.getId() %>"
                       class="btn btn-primary btn-sm apply-btn">
                        Apply Now
                    </a>
                <% } %>
            </div>

        </div>
    </div>

    <% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>