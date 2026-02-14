<%@ page contentType="text/html;charset=UTF-8" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>

<!DOCTYPE html>
<html>
<head>
    <title>Login - JobPortal</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Login-only CSS -->
    <link rel="stylesheet" href="css/login.css">
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">JobPortal</a>

        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link active" href="login.jsp">Login</a></li>
                <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- MAIN CONTAINER -->
<div class="container login-wrapper">
    <div class="row w-100 align-items-center g-4">

        <!-- LEFT INFO CARD -->
        <div class="col-md-6">
            <div class="login-info-card">
                <h2>Welcome Back</h2>
                <p>
                    Login to manage your profile, track applications,
                    and explore new job opportunities.
                </p>

                <ul>
                    <li>Secure login</li>
                    <li>Application tracking</li>
                    <li>Recruiter dashboards</li>
                    <li>Trusted by professionals</li>
                </ul>

                <p class="mt-4">
                    Don’t have an account?
                    <a href="register.jsp">Register here</a>
                </p>
            </div>
        </div>

        <!-- RIGHT LOGIN CARD -->
        <div class="col-md-6">
            <div class="login-form-card">

                <h3 class="text-center">User Login</h3>
                <p class="text-center text-muted mb-4">
                    Login with your credentials
                </p>

                <form action="login" method="post">

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" placeholder="Enter Email ID" class="form-control" required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" placeholder="Enter Password" class="form-control" required>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">
                        Login
                    </button>

                </form>
            </div>
        </div>

    </div>
</div>

</body>
</html>
