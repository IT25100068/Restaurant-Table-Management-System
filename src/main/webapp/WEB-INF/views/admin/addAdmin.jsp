<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Add New Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <link rel="stylesheet" href="../../../css/addAdmin.css">

</head>
<body>

<button class="menu-toggle" id="menuToggle">
  <i class="fas fa-bars"></i> Menu
</button>

<div class="container-fluid">
  <div class="row">

    <div class="col-md-2 p-0 sidebar" id="sidebar">
      <div class="brand">
        <h4><i class="fas fa-utensils"></i> Admin Panel</h4>
        <p>Restaurant Management</p>
      </div>
      <div class="nav flex-column">
        <a href="/admin/dashboard" class="nav-link">
          <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
        <a href="/customer/admin/list" class="nav-link">
          <i class="fas fa-users"></i> Customer Management
        </a>
        <a href="/admin/tables/list" class="nav-link">
          <i class="fas fa-chair"></i> Table Management
        </a>
        <a href="/offers/admin/list" class="nav-link">
          <i class="fas fa-tag"></i> Special Offers
        </a>
        <a href="/reservation/admin/list" class="nav-link">
          <i class="fas fa-calendar-alt"></i> Reservations
        </a>
        <a href="/review/admin/moderation" class="nav-link">
          <i class="fas fa-star"></i> Review Moderation
        </a>
        <a href="/admin/list" class="nav-link active">
          <i class="fas fa-user-shield"></i> Admin Management
        </a>
        <a href="/admin/logout" class="nav-link">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </div>
    </div>


    <div class="col-md-10 main-content">
      <div class="page-title">
        <h2><i class="fas fa-user-plus"></i> Add New Admin</h2>
        <p class="text-white-50">Create a new administrator account</p>
      </div>

      <div class="row justify-content-center">
        <div class="col-lg-7">
          <div class="card form-card">
            <div class="card-header">
              <i class="fas fa-user-shield"></i> Admin Account Details
            </div>
            <div class="card-body">
              <c:if test="${not empty error}">
                <div id="errorMsg" data-message="${error}" style="display: none;"></div>
              </c:if>

              <form id="adminForm" action="/admin/add" method="post">
                <div class="row">
                  <div class="col-md-6">
                    <div class="mb-3">
                      <label class="form-label">
                        <i class="fas fa-user"></i> Username
                      </label>
                      <div class="input-icon">
                        <i class="fas fa-user"></i>
                        <input type="text" name="username" id="username" class="form-control"
                               placeholder="Enter username" required>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="mb-3">
                      <label class="form-label">
                        <i class="fas fa-envelope"></i> Email Address
                      </label>
                      <div class="input-icon">
                        <i class="fas fa-envelope"></i>
                        <input type="email" name="email" id="email" class="form-control"
                               placeholder="Enter email" required>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col-md-6">
                    <div class="mb-3">
                      <label class="form-label">
                        <i class="fas fa-lock"></i> Password
                      </label>
                      <div class="input-icon">
                        <i class="fas fa-lock"></i>
                        <input type="password" name="password" id="password" class="form-control"
                               placeholder="Enter password" required>
                      </div>
                      <div id="passwordStrength" class="password-strength"></div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="mb-3">
                      <label class="form-label">
                        <i class="fas fa-user-tag"></i> Full Name
                      </label>
                      <div class="input-icon">
                        <i class="fas fa-user"></i>
                        <input type="text" name="fullName" id="fullName" class="form-control"
                               placeholder="Enter full name" required>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="mb-3">
                  <label class="form-label">
                    <i class="fas fa-user-shield"></i> Role
                  </label>
                  <div class="input-icon">
                    <i class="fas fa-tag"></i>
                    <select name="role" id="role" class="form-control" required>
                      <option value="MODERATOR"> Moderator</option>
                      <option value="VIEWER"> Viewer</option>
                    </select>
                  </div>
                  <small class="text-muted">
                    <i class="fas fa-info-circle"></i>
                    Super Admin role can only be assigned manually in the database
                  </small>
                </div>

                <div class="alert alert-info mt-3">
                  <i class="fas fa-info-circle"></i>
                  <strong>Role Permissions:</strong>
                  <ul class="mb-0 mt-2">
                    <li><strong>Moderator:</strong> Can manage customers, tables, offers, reservations, and reviews</li>
                    <li><strong>Viewer:</strong> Can only view data, cannot edit or delete</li>
                  </ul>
                </div>

                <div class="row mt-4">
                  <div class="col-md-6">
                    <button type="submit" class="btn-submit text-white">
                      <i class="fas fa-save"></i> Create Admin
                    </button>
                  </div>
                  <div class="col-md-6">
                    <a href="/admin/list" class="btn-cancel text-white">
                      <i class="fas fa-times"></i> Cancel
                    </a>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>

  $('#menuToggle').click(function() {
    $('#sidebar').toggleClass('show');
  });

  $(document).click(function(event) {
    if (!$(event.target).closest('#sidebar').length && !$(event.target).closest('#menuToggle').length) {
      if ($('#sidebar').hasClass('show')) {
        $('#sidebar').removeClass('show');
      }
    }
  });


  var errorMsg = $('#errorMsg').data('message');
  if(errorMsg) {
    Swal.fire({
      icon: 'error',
      title: 'Error!',
      text: errorMsg,
      confirmButtonColor: '#3498db'
    });
  }


  $('#password').on('keyup', function() {
    var password = $(this).val();
    var strength = checkPasswordStrength(password);
    $('#passwordStrength').html(strength.message).removeClass('strength-weak strength-medium strength-strong').addClass(strength.class);
  });

  function checkPasswordStrength(password) {
    if(password.length === 0) {
      return { message: '', class: '' };
    }
    if(password.length < 6) {
      return { message: '⚠️ Weak password (minimum 6 characters)', class: 'strength-weak' };
    }
    var strength = 0;
    if(password.length >= 8) strength++;
    if(password.match(/[a-z]+/)) strength++;
    if(password.match(/[A-Z]+/)) strength++;
    if(password.match(/[0-9]+/)) strength++;
    if(password.match(/[$@#&!]+/)) strength++;

    if(strength < 2) {
      return { message: '⚠️ Weak password', class: 'strength-weak' };
    } else if(strength < 4) {
      return { message: '⚡ Medium password', class: 'strength-medium' };
    } else {
      return { message: '✅ Strong password', class: 'strength-strong' };
    }
  }


  $('#adminForm').on('submit', function(e) {
    var username = $('#username').val().trim();
    var email = $('#email').val().trim();
    var password = $('#password').val();
    var fullName = $('#fullName').val().trim();
    var role = $('#role').val();

    if(username === '') {
      e.preventDefault();
      Swal.fire({
        icon: 'warning',
        title: 'Username Required',
        text: 'Please enter a username',
        confirmButtonColor: '#3498db'
      });
      return false;
    }

    if(email === '') {
      e.preventDefault();
      Swal.fire({
        icon: 'warning',
        title: 'Email Required',
        text: 'Please enter an email address',
        confirmButtonColor: '#3498db'
      });
      return false;
    }

    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if(!emailRegex.test(email)) {
      e.preventDefault();
      Swal.fire({
        icon: 'error',
        title: 'Invalid Email',
        text: 'Please enter a valid email address',
        confirmButtonColor: '#3498db'
      });
      return false;
    }

    if(password === '') {
      e.preventDefault();
      Swal.fire({
        icon: 'warning',
        title: 'Password Required',
        text: 'Please enter a password',
        confirmButtonColor: '#3498db'
      });
      return false;
    }

    if(password.length < 6) {
      e.preventDefault();
      Swal.fire({
        icon: 'warning',
        title: 'Weak Password',
        text: 'Password must be at least 6 characters long',
        confirmButtonColor: '#3498db'
      });
      return false;
    }

    if(fullName === '') {
      e.preventDefault();
      Swal.fire({
        icon: 'warning',
        title: 'Full Name Required',
        text: 'Please enter full name',
        confirmButtonColor: '#3498db'
      });
      return false;
    }

    Swal.fire({
      title: 'Creating Admin...',
      text: 'Please wait',
      allowOutsideClick: false,
      didOpen: () => {
        Swal.showLoading();
      }
    });

    return true;
  });
</script>
</body>
</html>