<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>NextHire | Smart Job Portal</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Global Styles -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/index.css">
    <style>
        html {
            scroll-behavior: smooth;
        }

        /* Adjust scroll position because navbar is fixed */
        section {
            scroll-margin-top: 90px;
        }

        header {
            scroll-margin-top: 90px;
        }
    </style>
</head>

<body data-bs-spy="scroll"
      data-bs-target="#navbarNav"
      data-bs-offset="100"
      tabindex="0">

<!-- ================= NAVBAR ================= -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#home">NextHire</a>

        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">

                <li class="nav-item">
                    <a class="nav-link" href="#home">Home</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#about">About</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#contact">Contact</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>

                <li class="nav-item">
                    <a class="btn btn-primary ms-3" href="register.jsp">Register</a>
                </li>

            </ul>
        </div>
    </div>
</nav>


<!-- ================= HERO ================= -->
<header id="home"
        class="hero-section d-flex align-items-center justify-content-center text-center">

    <div class="hero-text container">
        <h1 class="display-4 fw-bold">
            Find Your Dream Job Today
        </h1>

        <p class="lead mt-3 mb-4">
            Connecting Talent with Opportunity. Apply faster. Hire smarter.
        </p>

        <div class="mt-4">
            <a href="register.jsp" class="btn btn-primary btn-lg me-3">
                Get Started
            </a>

            <a href="login.jsp" class="btn btn-outline-light btn-lg">
                Login
            </a>
        </div>
    </div>
</header>


<!-- ================= ABOUT ================= -->
<section id="about" class="py-5">
    <div class="container">

        <h2 class="section-title text-center mb-4">
            About NextHire
        </h2>

        <p class="text-center mb-5 text-muted">
            NextHire is a next-generation recruitment platform designed to simplify
            hiring and job searching for professionals and recruiters.
        </p>

        <div class="row g-4">

            <div class="col-md-4">
                <div class="custom-card text-center h-100">
                    <h5 class="fw-semibold">Our Mission</h5>
                    <p class="text-muted">
                        Empowering careers through seamless hiring solutions powered by modern technology.
                    </p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="custom-card text-center h-100">
                    <h5 class="fw-semibold">For Job Seekers</h5>
                    <p class="text-muted">
                        Build your profile, upload resumes, and track applications easily.
                    </p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="custom-card text-center h-100">
                    <h5 class="fw-semibold">For Recruiters</h5>
                    <p class="text-muted">
                        Post jobs, manage applications, and hire top talent efficiently.
                    </p>
                </div>
            </div>

        </div>
    </div>
</section>


<!-- ================= CONTACT ================= -->
<section id="contact" class="py-5 bg-light">
    <div class="container">

        <h2 class="section-title text-center mb-4">
            Get in Touch
        </h2>

        <div class="row justify-content-center">
            <div class="col-md-8">

                <div class="custom-card">

                    <form action="contact" method="post">

                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="name"
                                   class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <input type="email" name="email"
                                   class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Message</label>
                            <textarea name="message"
                                      rows="4"
                                      class="form-control"
                                      required></textarea>
                        </div>

                        <button type="submit"
                                class="btn btn-primary w-100">
                            Send Message
                        </button>

                    </form>

                </div>

            </div>
        </div>
    </div>
</section>


<!-- ================= FOOTER ================= -->
<footer class="text-white text-center py-3">
    <p class="mb-0">
        &copy; 2026 NextHire. All rights reserved.
    </p>
</footer>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>