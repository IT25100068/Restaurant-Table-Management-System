<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>

  <title>Admin Login</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">

  <link rel="stylesheet" href="../../../css/adminLogin.css">

</head>
<body>
<div class="container mt-5 pt-5">
  <div class="row justify-content-center">
    <div class="col-md-5">
      <div class="card login-card">
        <div class="login-header">
          <i class="fas fa-user-shield"></i>
          <h3>Admin Portal</h3>
          <p>Secure access for restaurant administrators</p>
        </div>
        <div class="card-body p-4">
          <c:if test="${not empty error}">
            <div id="errorMessage" data-message="${error}" style="display: none;"></div>
          </c:if>

          <form id="loginForm" action="/admin/login" method="post">
            <div class="form-group">
              <label><i class="fas fa-envelope"></i> Email Address</label>
              <div class="input-icon">
                <i class="fas fa-envelope"></i>
                <input type="email" name="email" id="email" class="form-control"
                       placeholder="Enter your admin email" required autocomplete="off">
              </div>
            </div>

            <div class="form-group">
              <label><i class="fas fa-lock"></i> Password</label>
              <div class="input-icon">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" id="password" class="form-control"
                       placeholder="Enter your password" required autocomplete="off">
              </div>
            </div>

            <div class="checkbox-container">
              <label>
                <input type="checkbox" id="showPassword">
                <i class="fas fa-eye"></i> Show Password
              </label>
            </div>

            <button type="submit" class="btn-login">
              <i class="fas fa-sign-in-alt"></i> Login as Admin
            </button>
          </form>

          <div class="back-link">
            <a href="/customer/login">
              <i class="fas fa-arrow-left"></i> Back to Customer Login
            </a>
          </div>

          <div class="security-badge">
            <i class="fas fa-shield-alt"></i> Secure Admin Area | All activities are logged
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
  $(document).ready(function() {
    var errorMsg = $('#errorMessage').data('message');
    if(errorMsg && errorMsg !== '') {
      Swal.fire({
        icon: 'error',
        title: 'Login Failed!',
        text: errorMsg,
        confirmButtonColor: '#2c3e50',
        confirmButtonText: 'Try Again',
        showConfirmButton: true,
        allowOutsideClick: false
      }).then((result) => {
        if(result.isConfirmed) {
          window.history.replaceState({}, document.title, window.location.pathname);
        }
      });
      $('#errorMessage').remove();
    }

    $('#showPassword').change(function() {
      var type = $(this).is(':checked') ? 'text' : 'password';
      $('#password').attr('type', type);
    });

    $('#loginForm').on('submit', function(e) {


      Swal.fire({
        title: 'Authenticating...',
        text: 'Please wait',
        allowOutsideClick: false,
        didOpen: () => {
          Swal.showLoading();
        }
      });

      return true;
    });

    $('#password').on('keypress', function(e) {
      if(e.which === 13) {
        $('#loginForm').submit();
      }
    });
  });

  if(window.history.replaceState) {
    var url = new URL(window.location.href);
    if(url.searchParams.has('error')) {
      url.searchParams.delete('error');
      window.history.replaceState({}, document.title, url.toString());
    }
  }
</script>
</body>
</html>