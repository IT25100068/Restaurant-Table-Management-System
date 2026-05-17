<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">

  <link rel="stylesheet" href="../../../css/adminDashboard.css">


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
        <a href="/admin/dashboard" class="nav-link active">
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
        <a href="/admin/list" class="nav-link">
          <i class="fas fa-user-shield"></i> Admin Management
        </a>
        <a href="/admin/logout" class="nav-link">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </div>
    </div>


    <div class="col-md-10 main-content">

      <div class="welcome-banner">
        <h3><i class="fas fa-hand-peace"></i> Welcome back, ${admin.fullName}!</h3>
        <p>Here's what's happening with your restaurant today.</p>
      </div>


      <div class="row mb-4">
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-users"></i>
            </div>
            <div class="stats-number" id="totalCustomers">0</div>
            <div class="stats-label">Total Customers</div>
          </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-calendar-check"></i>
            </div>
            <div class="stats-number" id="todayReservations">0</div>
            <div class="stats-label">Today's Reservations</div>
          </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-chair"></i>
            </div>
            <div class="stats-number" id="totalTables">0</div>
            <div class="stats-label">Total Tables</div>
          </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-star"></i>
            </div>
            <div class="stats-number" id="totalReviews">0</div>
            <div class="stats-label">Total Reviews</div>
          </div>
        </div>
      </div>


      <div class="row">
        <div class="col-md-4 mb-4">
          <div class="dashboard-card" onclick="location.href='/customer/admin/list'">
            <div class="card-body">
              <div class="dashboard-icon" style="background: rgba(52, 152, 219, 0.1);">
                <i class="fas fa-users fa-3x" style="color: #3498db;"></i>
              </div>
              <h5>Customer Management</h5>
              <p class="text-muted">Manage customers, view profiles, delete accounts</p>
            </div>
          </div>
        </div>

        <div class="col-md-4 mb-4">
          <div class="dashboard-card" onclick="location.href='/admin/tables/list'">
            <div class="card-body">
              <div class="dashboard-icon" style="background: rgba(46, 204, 113, 0.1);">
                <i class="fas fa-chair fa-3x" style="color: #2ecc71;"></i>
              </div>
              <h5>Table Management</h5>
              <p class="text-muted">Add, edit, delete tables</p>
            </div>
          </div>
        </div>

        <div class="col-md-4 mb-4">
          <div class="dashboard-card" onclick="location.href='/offers/admin/list'">
            <div class="card-body">
              <div class="dashboard-icon" style="background: rgba(241, 196, 15, 0.1);">
                <i class="fas fa-tag fa-3x" style="color: #f1c40f;"></i>
              </div>
              <h5>Special Offers</h5>
              <p class="text-muted">Manage promotions and discounts</p>
            </div>
          </div>
        </div>

        <div class="col-md-4 mb-4">
          <div class="dashboard-card" onclick="location.href='/reservation/admin/list'">
            <div class="card-body">
              <div class="dashboard-icon" style="background: rgba(155, 89, 182, 0.1);">
                <i class="fas fa-calendar-alt fa-3x" style="color: #9b59b6;"></i>
              </div>
              <h5>Reservations</h5>
              <p class="text-muted">View all bookings</p>
            </div>
          </div>
        </div>

        <div class="col-md-4 mb-4">
          <div class="dashboard-card" onclick="location.href='/review/admin/moderation'">
            <div class="card-body">
              <div class="dashboard-icon" style="background: rgba(231, 76, 60, 0.1);">
                <i class="fas fa-star fa-3x" style="color: #e74c3c;"></i>
              </div>
              <h5>Review Moderation</h5>
              <p class="text-muted">Approve or reject customer reviews</p>
            </div>
          </div>
        </div>

        <div class="col-md-4 mb-4">
          <div class="dashboard-card" onclick="location.href='/admin/list'">
            <div class="card-body">
              <div class="dashboard-icon" style="background: rgba(52, 73, 94, 0.1);">
                <i class="fas fa-user-shield fa-3x" style="color: #34495e;"></i>
              </div>
              <h5>Admin Management</h5>
              <p class="text-muted">Manage admin accounts</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

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


  function animateNumber(element, target) {
    if(target > 0) {
      let current = 0;
      let interval = setInterval(function() {
        if(current <= target) {
          $(element).text(current);
          current++;
        } else {
          clearInterval(interval);
        }
      }, 20);
    }
  }


  $.ajax({
    url: '/admin/stats',
    method: 'GET',
    success: function(data) {
      animateNumber('#totalCustomers', data.totalCustomers);
      animateNumber('#todayReservations', data.todayReservations);
      animateNumber('#totalTables', data.totalTables);
      animateNumber('#totalReviews', data.totalReviews);
    }
  });
</script>
</body>
</html>