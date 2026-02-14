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
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">JobPortal</a>
    
            <!-- Toggle button -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
    
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <span class="nav-link active">
                            Welcome, <%= user.getName() %>
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">
                            Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
<div class="container mt-5">
    <h2 class="text-primary">Welcome, <%= user.getName() %>!</h2>
    <p>You are logged in as <strong><%= user.getRole() %></strong>.</p>

    <div class="mt-4">
        <% if ("user".equals(user.getRole())) { %>
        <a href="job-list.jsp" class="btn btn-success">Browse Jobs</a>
        <a href="status.jsp" class="btn btn-info">My Applications</a>
        <% } else if ("recruiter".equals(user.getRole())) { %>
        <% } %>
        <a href="logout.jsp" class="btn btn-secondary">Logout</a>
    </div>
</div>
</body>
</html>
