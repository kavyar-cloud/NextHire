<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Recruiter Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<h2>Post a New Job</h2>
<%--<form action="postJob" method="post">--%>
<form action="${pageContext.request.contextPath}/postJob" method="post">
    Job Title: <input type="text" name="title" required><br>
    Description: <textarea name="description" required></textarea><br>
    Location: <input type="text" name="location" required><br>
    Company: <input type="text" name="company" required><br>
    Status:
    <select name="status">
        <option value="OPEN">Open</option>
        <option value="CLOSED">Closed</option>
    </select><br>

    <button type="submit">Post Job</button>
</form>
</body>
</html>
