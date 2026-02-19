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

    ApplicationDao appDao = new ApplicationDao();
    List<ApplicationView> apps = appDao.getApplicationsByUser(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Applications</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/status.css">
</head>

<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top py-2">
        <div class="container">
            <a class="navbar-brand" href="#">NextHire</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

<div class="page-content">
<div class="container">

    <div class="header">
        <h2>My Applications</h2>
        <a href="job-list.jsp" class="back-btn">← Back to Jobs</a>
    </div>

    <% if (apps == null || apps.isEmpty()) { %>
        <p class="text-muted">You have not applied for any jobs yet.</p>
    <% } else { %>

        <% for (ApplicationView a : apps) { %>
            <div class="app-card">

                <div class="app-title">
                    <%= a.getJobTitle() %>
                </div>

                <div class="app-details">
                    <p><strong>Company:</strong> <%= a.getCompany() %></p>
                    <%DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");%>
                    <p>
                        <strong>Applied On:</strong>
                        <%= a.getAppliedAt() != null ? a.getAppliedAt().format(fmt) : "-" %>
                    </p>


                    <p>
                        <strong>Status:</strong>
                    
                        <% 
                            if ("SHORTLISTED".equalsIgnoreCase(a.getStatus())) { 
                        %>
                            <span class="status-badge status-shortlisted">
                                Shortlisted
                            </span>
                    
                        <% 
                            } else if ("REJECTED".equalsIgnoreCase(a.getStatus())) { 
                        %>
                            <span class="status-badge status-rejected">
                                Rejected
                            </span>
                    
                        <% 
                            } else if (a.isResumeViewed()) { 
                        %>
                            <span class="status-badge status-viewed">
                                Viewed
                            </span>
                    
                        <% 
                            } else { 
                        %>
                            <span class="status-badge status-pending">
                                Pending
                            </span>
                        <% } %>
                    </p>
                    
                </div>

                <% if ("Pending".equalsIgnoreCase(a.getStatus())) { %>
                    <div class="actions">
                        <form action="withdrawApplication" method="post">
                            <input type="hidden" name="applicationId" value="<%= a.getApplicationId() %>">
                            <button type="submit" class="btn-withdraw">
                                Withdraw
                            </button>
                        </form>
                    </div>
                <% } %>

            </div>
        <% } %>

    <% } %>

</div>
</div>

</body>
</html>
