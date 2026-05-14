<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>

  <title>Customer Login</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <link rel="stylesheet" href="../../css/login.css">

</head>


<body>

<div class="container mt-5 pt-5">
  <div class="row justify-content-center">
    <div class="col-md-5">
      <div class="card login-card">
        <div class="login-header">
          <i class="fas fa-utensils"></i>
          <h3>Welcome Back!</h3>
          <p>Sign in to continue to your account</p>
        </div>
        <div class="card-body p-4">

          <c:if test="${not empty error}">
            <div id="errorMessage" data-message="${error}" style="display: none;"></div>
          </c:if>
          <c:if test="${not empty success}">
            <div id="successMessage" data-message="${success}" style="display: none;"></div>
          </c:if>

          <form id="loginForm" action="/customer/login" method="post">
            <div class="form-group">
              <label><i class="fas fa-envelope"></i> Email Address</label>
                <input type="email" name="email" id="email" class="form-control"
                       placeholder="Enter your email" required autocomplete="off">
            </div>

            <div class="form-group">
              <label><i class="fas fa-lock"></i> Password</label>
                <input type="password" name="password" id="password" class="form-control"
                       placeholder="Enter your password" required autocomplete="off">
            </div>

            <div class="checkbox-container">
              <label class="checkbox-label">
                <input type="checkbox" id="showPassword">
                <i class="fas fa-eye"></i> Show Password
              </label>
              <a href="#" class="forgot-link">Forgot Password?</a>
            </div>

            <button type="submit" class="btn-login">
              <i class="fas fa-sign-in-alt"></i> Login
            </button>
          </form>

          <div class="register-link">
            <p>Don't have an account? <a href="/customer/register">Create Account</a></p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script src="../../js/login.js"></script>

</body>
</html>