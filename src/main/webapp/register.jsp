<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - JobPortal</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/register.css?v=3">
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">NextHire</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <li class="nav-item"><a class="nav-link active" href="register.jsp">Register</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- MAIN CONTENT -->
<div class="container register-container">
    <div class="row justify-content-center align-items-center g-4">

        <!-- LEFT INFO CARD -->
        <div class="container register-container mt-4">
            <div class="row g-4"> <!-- LEFT INFO CARD -->
                <div class="col-lg-4">
                    <div class="card info-card">
                        <div class="card-body p-4">
                            <h2>Your Career Starts Here</h2>
                            <p class="text-muted mt-3"> JobPortal connects job seekers and recruiters through a fast, reliable, and secure hiring platform. </p>
                            <ul class="info-list mt-4">
                                <li>Apply to verified jobs</li>
                                <li>Track applications in real-time</li>
                                <li>Recruiters hire faster</li>
                                <li>Role-based dashboards</li>
                            </ul>
                            <p class="mt-4 text-muted"> Trusted by students, freshers, professionals, and recruiters. </p>
                        </div>
                    </div>
                </div>

        <!-- RIGHT REGISTER CARD -->
                <div class="col-lg-8 d-flex align-items-stretch">
                    <div class="card register-card w-100">
                        <div class="card-body p-5">
                    <h3 class="text-center">User Registration</h3>
                    <p class="text-center text-muted mb-4">
                        Create your account in less than a minute
                    </p>

                    <form action="register" method="post">
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" name="name" placeholder="Enter your full name" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" placeholder="Tell us your Email ID" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mobile number</label>
                            <input type="tel" name="mobile" placeholder="Enter your mobile number" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" id="password"
                                   placeholder="(Minimum 6 characters)" class="form-control" required minlength="6">
                            <input type="text" name="password_visible" id="password_visible"
                                   placeholder="(Minimum 6 characters)" class="form-control d-none" minlength="6">
                        </div>


                        <div class="mb-4">
                            <label class="form-label">Role</label>
                            <select name="role" class="form-select">
                                <option value="JOB_SEEKER">Job Seeker</option>
                                <option value="RECRUITER">Recruiter</option>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-success w-100">
                            Register now
                        </button>
                    </form>

                    <p class="text-center mt-3">
                        Already have an account?
                        <a href="login.jsp">Login</a>
                    </p>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
