<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Customer Details - Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <link rel="stylesheet" href="../.././../../css/viewCustomer.css">

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
        <a href="/customer/admin/list" class="nav-link active">
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
        <a href="/admin/list" class="nav-link">
          <i class="fas fa-user-shield"></i> Admin Management
        </a>
        <a href="/admin/logout" class="nav-link">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </div>
    </div>

    <div class="col-md-10 main-content">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-white"><i class="fas fa-user-circle"></i> Customer Details</h2>
        <a href="/customer/admin/list" class="btn btn-secondary">
          <i class="fas fa-arrow-left"></i> Back to List
        </a>
      </div>

      <div class="row">
        <div class="col-md-4">
          <div class="card profile-card mb-4">
            <div class="card-body text-center">
              <i class="fas fa-user-circle fa-5x mb-3"></i>
              <h3>${customer.name}</h3>
              <p class="mb-2">
                <c:choose>
                  <c:when test="${customer.customerType == 'PREMIUM'}">
                                            <span class="badge bg-warning text-dark px-3 py-2">
                                                <i class="fas fa-crown"></i> Premium Member (15% discount)
                                            </span>
                  </c:when>
                  <c:otherwise>
                                            <span class="badge bg-secondary px-3 py-2">
                                                <i class="fas fa-user"></i> Regular Member
                                            </span>
                  </c:otherwise>
                </c:choose>
              </p>
              <p class="mb-0">
                <i class="fas fa-calendar"></i> Member since: ${customer.registrationDate}
              </p>
            </div>
          </div>

          <div class="card mb-4">
            <div class="card-header bg-info text-white">
              <i class="fas fa-star"></i> Loyalty Information
            </div>
            <div class="card-body text-center">
              <h1 class="display-4 text-danger">${customer.loyaltyPoints}</h1>
              <p>Loyalty Points</p>
              <div class="progress loyalty-progress">
                <div class="progress-bar loyalty-progress-bar" style="width: ${customer.loyaltyPoints % 100}%"></div>
              </div>
              <small class="text-muted mt-2 d-block">
                ${100 - (customer.loyaltyPoints % 100)} more points to next level
              </small>
            </div>
          </div>
        </div>

        <div class="col-md-8">
          <div class="card mb-4">
            <div class="card-header bg-primary text-white">
              <i class="fas fa-info-circle"></i> Personal Information
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-md-6">
                  <div class="info-card p-3 mb-3">
                    <label class="text-muted"><i class="fas fa-user"></i> Full Name</label>
                    <h5 class="mb-0">${customer.name}</h5>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="info-card p-3 mb-3">
                    <label class="text-muted"><i class="fas fa-envelope"></i> Email Address</label>
                    <h5 class="mb-0">${customer.email}</h5>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="info-card p-3 mb-3">
                    <label class="text-muted"><i class="fas fa-phone"></i> Phone Number</label>
                    <h5 class="mb-0">${customer.phone}</h5>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="info-card p-3 mb-3">
                    <label class="text-muted"><i class="fas fa-tag"></i> Customer Type</label>
                    <h5 class="mb-0">
                      <c:choose>
                        <c:when test="${customer.customerType == 'PREMIUM'}">
                          <span class="badge bg-warning text-dark">Premium</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-secondary">Regular</span>
                        </c:otherwise>
                      </c:choose>
                    </h5>
                  </div>
                </div>
                <div class="col-md-12">
                  <div class="info-card p-3 mb-3">
                    <label class="text-muted"><i class="fas fa-map-marker-alt"></i> Address</label>
                    <h5 class="mb-0">${customer.address != null ? customer.address : 'Not provided'}</h5>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="card">
            <div class="card-header bg-warning text-dark">
              <i class="fas fa-cog"></i> Actions
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-md-6">
                  <button class="btn btn-primary w-100 action-btn" onclick="openEditModal()">
                    <i class="fas fa-edit"></i> Edit Customer
                  </button>
                </div>
                <div class="col-md-6">
                  <button class="btn btn-danger w-100 action-btn" onclick="deleteCustomer()">
                    <i class="fas fa-trash"></i> Delete Account
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="editModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title"><i class="fas fa-edit"></i> Edit Customer</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <form id="editForm" action="/customer/admin/update/${customer.id}" method="post">
        <div class="modal-body">
          <div class="mb-3">
            <label><i class="fas fa-user"></i> Full Name</label>
            <input type="text" name="name" id="editName" value="${customer.name}" class="form-control" required>
          </div>
          <div class="mb-3">
            <label><i class="fas fa-phone"></i> Phone Number</label>
            <input type="text" name="phone" id="editPhone" value="${customer.phone}" class="form-control" required>
          </div>
          <div class="mb-3">
            <label><i class="fas fa-map-marker-alt"></i> Address</label>
            <textarea name="address" id="editAddress" class="form-control" rows="3">${customer.address}</textarea>
          </div>
          <div class="mb-3">
            <label><i class="fas fa-tag"></i> Customer Type</label>
            <select name="customerType" id="editCustomerType" class="form-control">
              <option value="REGULAR" ${customer.customerType == 'REGULAR' ? 'selected' : ''}>Regular Member</option>
              <option value="PREMIUM" ${customer.customerType == 'PREMIUM' ? 'selected' : ''}>Premium Member (15% discount)</option>
            </select>
            <small class="text-muted">Premium members get 15% discount on all bookings</small>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            <i class="fas fa-times"></i> Cancel
          </button>
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Save Changes
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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

  var editModal;

  $(document).ready(function() {
    editModal = new bootstrap.Modal(document.getElementById('editModal'));
  });

  function openEditModal() {
    editModal.show();
  }

  function deleteCustomer() {
    Swal.fire({
      title: 'Delete Account?',
      text: 'This action cannot be undone! All customer data will be lost.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#e74c3c',
      cancelButtonColor: '#6c757d',
      confirmButtonText: 'Yes, delete it',
      cancelButtonText: 'Cancel'
    }).then((result) => {
      if(result.isConfirmed) {
        window.location.href = '/customer/admin/delete/${customer.id}';
      }
    });
  }


</script>
</body>
</html>