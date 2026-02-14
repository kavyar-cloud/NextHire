<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Job Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body data-bs-spy="scroll" data-bs-target="#navbarNav" data-bs-offset="80" tabindex="0">


<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">JobPortal</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="#home">Home</a></li>
                <li class="nav-item"><a class="nav-link active" href="#about">About</a></li>
                <li class="nav-item"><a class="nav-link active" href="#contact">Contact</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<header id="home" class="hero-section d-flex align-items-center justify-content-center text-center">
    <div class="hero-text">
        <h1 class="display-4 fw-bold">Your Career Starts Here</h1>
        <p class="lead mb-4">
            Find jobs, apply instantly, or hire top talent with JobPortal
        </p>

    <%--        <a href="register.jsp" class="btn btn-primary btn-lg">Get Started</a>--%>
        <a href="register.jsp" class="btn btn-primary btn-lg me-2">Get Started</a>
        <a href="login.jsp" class="btn btn-outline-light btn-lg">Login</a>

    </div>
</header>

<!-- About Section -->
<section id="about" class="about-section">
    <div class="container text-center">

        <h2 class="about-title">About JobPortal</h2>

        <div class="about-text">
            <p>
                <strong>JobPortal</strong> is a next-generation recruitment platform built to simplify hiring
                and job searching. Whether you're a student, a professional, or a recruiter, our system
                helps you connect, apply, and hire with ease.
            </p>

            <p>
                We offer a seamless experience with features like resume uploads, application tracking,
                recruiter dashboards, and secure role-based access. Our mission is to empower careers
                and streamline hiring through technology.
            </p>
        </div>

        <div class="row about-cards">
            <div class="col-md-4">
                <div class="feature-card">
                    <h5>Our Purpose</h5>
                    <p>
                        To simplify the hiring process by connecting job seekers and recruiters through
                        a reliable and user-friendly platform.
                    </p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="feature-card">
                    <h5>What We Offer</h5>
                    <p>
                        A centralized system for job search, resume submission, application tracking,
                        and recruiter management.
                    </p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="feature-card">
                    <h5>Who Can Use It</h5>
                    <p>
                        Students, freshers, professionals, and recruiters looking for an efficient
                        recruitment solution.
                    </p>
                </div>
            </div>
        </div>

    </div>
</section>


            <!-- Image -->
<%--            <div class="col-lg-6 text-center">--%>
<%--                <img src="images/graphics.jpg"--%>
<%--                     alt="About JobPortal"--%>
<%--                     class="img-fluid about-img">--%>
<%--            </div>--%>


<!-- Contact Section -->
<section id="contact" class="py-5">
    <div class="container">
        <h2 class="text-center mb-4">Contact Us</h2>

        <form action="contact" method="post" class="mx-auto" style="max-width: 600px;">
            <div class="mb-3">
                <label class="form-label">Name</label>
                <input type="text" name="name" class="form-control"
                       placeholder="Your Name" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control"
                       placeholder="Your Email" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Message</label>
                <textarea name="message" class="form-control"
                          rows="4" placeholder="Your Message" required></textarea>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-success">
                    Send Message
                </button>
            </div>
        </form>
    </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-white text-center py-3">
    <p>&copy; 2026 JobPortal. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</>
</html>
