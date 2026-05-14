<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Profile</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <link rel="stylesheet" href="../../css/profile.css">


</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container">
    <a class="navbar-brand" href="/customer/dashboard">
      <i class="fas fa-utensils"></i> Restaurant Reservation
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <div class="navbar-nav ms-auto">
        <a class="nav-link" href="/customer/dashboard">
          <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
        <a class="nav-link" href="/reservation/my">
          <i class="fas fa-calendar-check"></i> My Reservations
        </a>
        <a class="nav-link" href="/menu/view">
          <i class="fas fa-utensil-spoon"></i> Menu
        </a>
        <a class="nav-link active" href="/customer/profile">
          <i class="fas fa-user-circle"></i> Profile
        </a>
        <a class="nav-link" href="/customer/logout">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </div>
    </div>
  </div>
</nav>

<div class="container mt-4">
  <div class="row justify-content-center">
    <div class="col-lg-6">
      <div class="profile-card">
        <div class="profile-header">
          <i class="fas fa-user-circle"></i>
          <h3>My Profile</h3>
          <p>Manage your personal information</p>
        </div>

        <div class="card-body p-4">
          <form id="profileForm" action="/customer/updateProfile" method="post">
            <div class="mb-3">
              <label class="form-label">
                <i class="fas fa-user"></i> Full Name
              </label>
                <input type="text" name="name" id="name" value="${customer.name}"
                       class="form-control" required>
            </div>

            <div class="mb-3">
              <label class="form-label">
                <i class="fas fa-envelope"></i> Email Address
              </label>
                <input type="email" value="${customer.email}" class="form-control" disabled>
              <small class="text-muted">Email cannot be changed</small>
            </div>

            <div class="mb-3">
              <label class="form-label">
                <i class="fas fa-phone"></i> Phone Number
              </label>
                <input type="tel" name="phone" id="phone" value="${customer.phone}"
                       class="form-control" required>
            </div>

            <div class="mb-3">
              <label class="form-label">
                <i class="fas fa-map-marker-alt"></i> Address
              </label>
                <textarea name="address" id="address" class="form-control" rows="2">${customer.address}</textarea>
            </div>

            <div class="mb-3">
              <label class="form-label">
                <i class="fas fa-lock"></i> New Password
              </label>
                <input type="password" name="password" id="password" class="form-control"
                       placeholder="Leave blank to keep same">
              <small class="text-muted">Enter new password only if you want to change it</small>
            </div>

            <div class="info-note">
              <i class="fas fa-star"></i>
              <c:choose>
                <c:when test="${customer.customerType == 'PREMIUM'}">
                  <strong>Premium Member</strong> - You enjoy 15% discount on all bookings!
                </c:when>
                <c:otherwise>
                  <strong>Regular Member</strong> - <a href="#" style="color: #e74c3c;">Upgrade to Premium</a> to get 15% discount
                </c:otherwise>
              </c:choose>
            </div>

            <button type="submit" class="btn-update mt-3">
              <i class="fas fa-save"></i> Update Profile
            </button>
          </form>

          <hr>

          <button id="deleteBtn" class="btn-delete">
            <i class="fas fa-trash-alt"></i> Delete Account
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
  $(document).ready(function() {
    <c:if test="${not empty success}">
    Swal.fire({
      icon: 'success',
      title: 'Profile Updated!',
      text: '${success}',
      confirmButtonColor: '#e74c3c',
      timer: 3000
    });
    </c:if>

    <c:if test="${not empty error}">
    Swal.fire({
      icon: 'error',
      title: 'Update Failed!',
      text: '${error}',
      confirmButtonColor: '#e74c3c'
    });
    </c:if>



    $('#deleteBtn').on('click', function() {
      Swal.fire({
        title: 'Delete Account?',
        text: 'This action cannot be undone! All your data including reservations and reviews will be lost permanently.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#e74c3c',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Yes, delete my account',
        cancelButtonText: 'Cancel'
      }).then(function(result) {
        if(result.isConfirmed) {
          Swal.fire({
            title: 'Deleting Account...',
            text: 'Please wait',
            allowOutsideClick: false,
            didOpen: function() {
              Swal.showLoading();
            }
          });
          $('<form>', {
            'method': 'POST',
            'action': '/customer/deleteAccount'
          }).appendTo(document.body).submit();
        }
      });
    });
  });
</script>
</body>
</html>