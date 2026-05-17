<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Admins</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <link rel="stylesheet" href="../../../css/adminList.css">

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
        <h2><i class="fas fa-user-shield"></i> Admin Management</h2>
        <p class="text-white-50">Manage administrator accounts and permissions</p>
      </div>


      <div class="row mb-4">
        <div class="col-md-4 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-users" style="color: #3498db;"></i>
            </div>
            <div class="stats-number">${admins.size()}</div>
            <div class="stats-label">Total Admins</div>
          </div>
        </div>
        <div class="col-md-4 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-user-check" style="color: #27ae60;"></i>
            </div>
            <div class="stats-number" id="activeCount">0</div>
            <div class="stats-label">Active Admins</div>
          </div>
        </div>
        <div class="col-md-4 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-user-shield" style="color: #e74c3c;"></i>
            </div>
            <div class="stats-number" id="superAdminCount">0</div>
            <div class="stats-label">Super Admins</div>
          </div>
        </div>
      </div>


      <div class="action-buttons">
        <a href="/admin/add" class="btn-add">
          <i class="fas fa-plus"></i> Add New Admin
        </a>
        <a href="/admin/dashboard" class="btn-back">
          <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
      </div>

      <c:if test="${not empty param.error}">
        <div id="errorMsg" data-message="${param.error}" style="display: none;"></div>
      </c:if>


      <div class="admin-table">
        <div class="table-responsive">
          <table class="table table-bordered mb-0">
            <thead class="table-header">
            <tr>
              <th>ID</th>
              <th>Username</th>
              <th>Email</th>
              <th>Full Name</th>
              <th>Role</th>
              <th>Status</th>
              <th>Last Login</th>
              <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${admins}" var="a">
              <c:set var="activeCount" value="${activeCount + (a.active ? 1 : 0)}" scope="page" />
              <c:set var="superAdminCount" value="${superAdminCount + (a.role == 'SUPER_ADMIN' ? 1 : 0)}" scope="page" />
              <tr>
                <td>${a.id}</td>
                <td>
                  <i class="fas fa-user-circle" style="color: #e74c3c;"></i> ${a.username}
                </td>
                <td>${a.email}</td>
                <td>${a.fullName}</td>
                <td>
                  <c:choose>
                    <c:when test="${a.role == 'SUPER_ADMIN'}">
                                                    <span class="badge-super-admin">
                                                        <i class="fas fa-crown"></i> Super Admin
                                                    </span>
                    </c:when>
                    <c:when test="${a.role == 'MODERATOR'}">
                                                    <span class="badge-moderator">
                                                        <i class="fas fa-user-shield"></i> Moderator
                                                    </span>
                    </c:when>
                    <c:otherwise>
                                                    <span class="badge-viewer">
                                                        <i class="fas fa-eye"></i> Viewer
                                                    </span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${a.active}">
                                                    <span class="badge-active">
                                                        <i class="fas fa-check-circle"></i> Active
                                                    </span>
                    </c:when>
                    <c:otherwise>
                                                    <span class="badge-inactive">
                                                        <i class="fas fa-times-circle"></i> Inactive
                                                    </span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${not empty a.lastLoginStr}">
                      ${a.lastLoginStr}
                    </c:when>
                    <c:otherwise>
                      <span class="text-muted">Never</span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:if test="${a.role != 'SUPER_ADMIN' or sessionScope.loggedAdmin.id != a.id}">
                    <button class="btn-delete text-white" onclick="deleteAdmin(${a.id})">
                      <i class="fas fa-trash"></i> Delete
                    </button>
                  </c:if>
                  <c:if test="${a.role == 'SUPER_ADMIN' and sessionScope.loggedAdmin.id == a.id}">
                    <span class="text-muted">Current Account</span>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty admins}">
              <tr>
                <td colspan="8" class="text-center py-5">
                  <i class="fas fa-info-circle fa-2x text-muted mb-2 d-block"></i>
                  <span class="text-muted">No admin accounts found</span>
                </td>
              </tr>
            </c:if>
            </tbody>
            <tr>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>

  var activeCount = 0;
  var superAdminCount = 0;
  <c:forEach items="${admins}" var="a">
  <c:if test="${a.active}">activeCount++;</c:if>
  <c:if test="${a.role == 'SUPER_ADMIN'}">superAdminCount++;</c:if>
  </c:forEach>

  $('#activeCount').text(activeCount);
  $('#superAdminCount').text(superAdminCount);


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
      confirmButtonColor: '#e74c3c'
    });
  }

  function deleteAdmin(id) {
    Swal.fire({
      title: 'Delete Admin?',
      text: 'This action cannot be undone. The admin account will be deactivated.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#e74c3c',
      cancelButtonColor: '#6c757d',
      confirmButtonText: 'Yes, delete it',
      cancelButtonText: 'Cancel'
    }).then((result) => {
      if(result.isConfirmed) {
        window.location.href = '/admin/delete/' + id;
      }
    });
  }


  $('.stats-number').each(function() {
    var $this = $(this);
    var target = parseInt($this.text());
    if(target > 0 && !isNaN(target)) {
      var current = 0;
      var interval = setInterval(function() {
        if(current <= target) {
          $this.text(current);
          current++;
        } else {
          clearInterval(interval);
        }
      }, 30);
    }
  });
</script>
</body>
</html>