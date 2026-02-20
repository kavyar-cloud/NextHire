<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password - NextHire</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Global CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<!-- NAVBAR (Same as other pages) -->
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

<!-- SECTION -->
<section class="auth-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6">

                <div class="auth-card">

                    <h3>Forgot Password</h3>
                    <p class="text-muted mb-4">
                        Enter your registered email to reset your password.
                    </p>

                    <% if(request.getParameter("error") != null) { %>
                        <div class="alert alert-danger">
                            <%= request.getParameter("error") %>
                        </div>
                    <% } %>

                    <form action="forgot-password" method="post">
                        <div class="mb-3">
                            <label class="form-label">Registered Email</label>
                            <input type="email"
                                   name="email"
                                   class="form-control"
                                   placeholder="Enter your email"
                                   required>
                        </div>

                        <button type="submit"
                                class="btn btn-primary w-100">
                            Continue
                        </button>
                    </form>

                    <p class="text-center mt-4 small">
                        Remembered your password?
                        <a href="login.jsp">Back to Login</a>
                    </p>

                </div>

            </div>
        </div>
    </div>
</section>

</body>
</html>