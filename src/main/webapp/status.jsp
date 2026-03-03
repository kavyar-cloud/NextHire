<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jobportal.dao.ApplicationDao" %>
<%@ page import="com.jobportal.dto.ApplicationView" %>
<%@ page import="com.jobportal.entity.User" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd MMM yyyy");

    ApplicationDao appDao = new ApplicationDao();
    List<ApplicationView> apps = appDao.getApplicationsByUser(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Applications</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/status.css">
</head>

<body>

    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="dashboard.jsp">NextHire</a>
    
            <div class="dropdown ms-auto">
                <a class="nav-link dropdown-toggle user-toggle"
                   href="#" data-bs-toggle="dropdown">
                    <i class="bi bi-person-circle me-2"></i>
                    <span><%= user.getName() %></span>
                </a>
    
                <ul class="dropdown-menu dropdown-menu-end custom-dropdown">
                    <li class="dropdown-header">
                        <strong><%= user.getName() %></strong><br>
                        <small class="text-muted">Track your job progress 🚀</small>
                    </li>
    
                    <li><hr class="dropdown-divider"></li>

                    <li>
                        <a class="dropdown-item" href="job-list.jsp">
                            <i class="bi bi-grid me-2"></i> Dashboard
                        </a>
                    </li>
    
                    <li>
                        <a class="dropdown-item" href="loadUpdateProfile">
                            <i class="bi bi-pencil-square me-2"></i> Update Profile
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

<div class="page-content">
<div class="container">
    <div class="container status-container">

        <div class="status-header">
            <div>
                <h3>My Applications</h3>
                <p class="text-muted mb-0">
                    Track the progress of your job applications
                </p>
            </div>
    
            <a href="job-list.jsp" class="btn btn-primary">
                <i class="bi bi-arrow-left me-2"></i> Back to Dashboard
            </a>
        </div>

    <% if (apps == null || apps.isEmpty()) { %>
        <p class="text-muted">You have not applied for any jobs yet.</p>
    <% } else { %>

        <% for (ApplicationView a : apps) { %>
            <div class="status-card">

                <div class="status-left">
                    <h5><%= a.getJobTitle() %></h5>
                    <p class="company">
                        <i class="bi bi-building me-1"></i>
                        <%= a.getCompany() %>
                    </p>
            
                    <p class="applied-date">
                        <i class="bi bi-clock me-1"></i>
                        <%= a.getAppliedAt() != null ? a.getAppliedAt().format(fmt) : "-" %>
                    </p>
                </div>
            
                <div class="status-right">
                    <% if ("SHORTLISTED".equalsIgnoreCase(a.getStatus())) { %>
                        <span class="badge-modern badge-shortlisted">
                            <i class="bi bi-star-fill me-1"></i> Shortlisted
                        </span>
                    <% } else if ("REJECTED".equalsIgnoreCase(a.getStatus())) { %>
                        <span class="badge-modern badge-rejected">
                            <i class="bi bi-x-circle me-1"></i> Rejected
                        </span>
                    <% } else if (a.isResumeViewed()) { %>
                        <span class="badge-modern badge-viewed">
                            <i class="bi bi-eye-fill me-1"></i> Viewed
                        </span>
                    <% } else { %>
                        <span class="badge-modern badge-pending">
                            <i class="bi bi-hourglass-split me-1"></i> Pending
                        </span>
                    <% } %>
            
                    <% if ("Pending".equalsIgnoreCase(a.getStatus())) { %>
                        <form action="withdrawApplication" method="post">
                            <input type="hidden" name="applicationId"
                                   value="<%= a.getApplicationId() %>">
                            <button type="submit" class="withdraw-modern">
                                Withdraw
                            </button>
                        </form>
                    <% } %>
                </div>
            
            </div>
        <% } %>

    <% } %>

</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
