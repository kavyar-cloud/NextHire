<%@ page contentType="text/html;charset=UTF-8" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Login - NextHire</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Global Theme -->
    <link rel="stylesheet" href="css/style.css">

    <!-- Login Page CSS -->
    <link rel="stylesheet" href="css/login.css">
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">NextHire</a>

        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="login.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-primary ms-3" href="register.jsp">Register</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- LOGIN SECTION -->
<section class="login-section">
    <div class="container">
        <div class="row g-5">

            <!-- LEFT INFO -->
            <div class="col-lg-5">
                <div class="login-info-card">
                    <h2>Welcome Back</h2>
                    <p class="text-muted mt-3">
                        Login to manage your profile, track applications,
                        and explore new opportunities.
                    </p>

                    <ul class="feature-list mt-4">
                        <li>Secure authentication</li>
                        <li>Application tracking</li>
                        <li>Recruiter dashboards</li>
                        <li>Trusted by professionals</li>
                    </ul>

                    <p class="mt-4 small text-muted">
                        Don’t have an account?
                        <a href="register.jsp">Create one here</a>
                    </p>
                </div>
            </div>

            <!-- RIGHT FORM -->
            <div class="col-lg-7">
                <div class="login-form-card">
                    <h3>Sign In</h3>
                    <p class="text-muted mb-4">
                        Enter your credentials to continue
                    </p>

                    <form action="login" method="post">

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email"
                                   name="email"
                                   class="form-control"
                                   placeholder="Enter your email"
                                   required>
                        </div>

                        <div class="mb-3 position-relative">
                            <label class="form-label">Password</label>
                        
                            <input type="password"
                                   name="password"
                                   id="passwordField"
                                   class="form-control pe-5"
                                   placeholder="Enter your password"
                                   required>
                        
                            <span class="password-toggle" onclick="togglePassword()">
                                <i class="bi bi-eye" id="toggleIcon"></i>
                            </span>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <input type="checkbox" id="remember">
                                <label for="remember" class="small">Remember me</label>
                            </div>

                            <a href="forgot-password.jsp" class="small text-decoration-none">
                                Forgot Password?
                            </a>
                        </div>

                        <button type="submit"
                                class="btn btn-primary w-100">
                            Login
                        </button>
                    </form>
                </div>
            </div>

        </div>
    </div>
</section>

<!-- Bootstrap JS -->
<script>
    function togglePassword() {
        const password = document.getElementById("passwordField");
        const icon = document.getElementById("toggleIcon");
    
        if (password.type === "password") {
            password.type = "text";
            icon.classList.remove("bi-eye");
            icon.classList.add("bi-eye-slash");
        } else {
            password.type = "password";
            icon.classList.remove("bi-eye-slash");
            icon.classList.add("bi-eye");
        }
    }
    </script>

</body>
</html>