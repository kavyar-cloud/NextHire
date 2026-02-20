<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - NextHire</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Global CSS -->
    <link rel="stylesheet" href="css/style.css">

    <!-- Register CSS -->
    <link rel="stylesheet" href="css/register.css?v=7">
</head>
<body>

<!-- NAVBAR (MATCH HOME) -->
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand text-white" href="index.jsp">NextHire</a>

        <button class="navbar-toggler bg-light" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-lg-center">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <li class="nav-item ms-lg-3">
                    <a class="btn btn-primary px-4" href="#">Register</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<section class="register-wrapper">
    <div class="container">
        <div class="row g-5">

            <!-- LEFT INFO CARD -->
            <div class="col-lg-5">
                <div class="info-card">
                    <h2>Your Career Starts Here</h2>

                    <p class="text-muted mt-3">
                        NextHire connects job seekers and recruiters through a fast,
                        reliable and secure hiring platform.
                    </p>

                    <ul class="info-list mt-4">
                        <li>Apply to verified jobs</li>
                        <li>Track applications in real-time</li>
                        <li>Recruiters hire faster</li>
                        <li>Role-based dashboards</li>
                    </ul>

                    <p class="text-muted mt-4 small">
                        Trusted by students, freshers and professionals.
                    </p>
                </div>
            </div>

            <!-- RIGHT REGISTER FORM -->
            <div class="col-lg-7">
                <div class="register-card">
                    <h3>Create Account</h3>
                    <p class="text-muted mb-4">
                        Create your account in less than a minute
                    </p>

                    <form action="register" method="post">

                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="name"
                                   class="form-control"
                                   placeholder="Enter your full name" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email"
                                   class="form-control"
                                   placeholder="Enter your email" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mobile</label>
                            <input type="tel" name="mobile"
                                   class="form-control"
                                   placeholder="Enter mobile number" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Password</label>
                            <input type="password" name="password"
                                   class="form-control"
                                   placeholder="Minimum 6 characters"
                                   minlength="6" required>
                        </div>

                        <!-- Role Selection -->
                        <div class="mb-4">
                            <label class="form-label d-block mb-2">Select Role</label>

                            <div class="role-box">
                                <input type="radio" name="role" value="JOB_SEEKER" checked>
                                Job Seeker
                            </div>

                            <div class="role-box mt-2">
                                <input type="radio" name="role" value="RECRUITER">
                                Recruiter
                            </div>
                        </div>

                        <button type="submit"
                                class="btn btn-primary w-100">
                            Register Now
                        </button>
                    </form>

                    <p class="mt-4 small">
                        Already have an account?
                        <a href="login.jsp">Login</a>
                    </p>
                </div>
            </div>

        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>