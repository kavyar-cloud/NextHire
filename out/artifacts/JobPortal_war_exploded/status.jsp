<%@ page import="java.util.List, com.jobportal.dao.ApplicationDao, com.jobportal.entity.Application, com.jobportal.entity.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    ApplicationDao appDao = new ApplicationDao();
    List<Application> apps = appDao.getApplicationsByUser(user.getId());
%>
<html>
<body>
<h2>My Applications</h2>
<ul>
    <% for (Application a : apps) { %>
    <li>Job ID: <%= a.getJobId() %> | Status: <%= a.getStatus() %></li>
    <% } %>
</ul>
</body>
</html>
