<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Table Management</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <link rel="stylesheet" href="../../../../css/tableList.css">

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
        <a href="/admin/tables/list" class="nav-link active">
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
      <div class="page-title">
        <h2><i class="fas fa-chair"></i> Table Management</h2>
        <p class="text-white-50">Manage restaurant tables, seating capacity, and pricing</p>
      </div>


      <div class="row mb-4">
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-chair" style="color: #3498db;"></i>
            </div>
            <div class="stats-number">${tables.size()}</div>
            <div class="stats-label">Total Tables</div>
          </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-check-circle" style="color: #27ae60;"></i>
            </div>
            <div class="stats-number">
              ${tables.stream().filter(t -> t.available).count()}
            </div>
            <div class="stats-label">Available</div>
          </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-building" style="color: #3498db;"></i>
            </div>
            <div class="stats-number">
              ${tables.stream().filter(t -> t.location == 'INDOOR').count()}
            </div>
            <div class="stats-label">Indoor Tables</div>
          </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-umbrella-beach" style="color: #f1c40f;"></i>
            </div>
            <div class="stats-number">
              ${tables.stream().filter(t -> t.location == 'OUTDOOR').count()}
            </div>
            <div class="stats-label">Outdoor Tables</div>
          </div>
        </div>
      </div>


      <div class="action-buttons">
        <a href="/admin/tables/add" class="btn-add">
          <i class="fas fa-plus"></i> Add New Table
        </a>
        <a href="/admin/dashboard" class="btn-back">
          <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
      </div>


      <div class="table-container">
        <div class="table-responsive">
          <table class="table table-bordered mb-0">
            <thead class="table-header">
            <tr>
              <th>ID</th>
              <th>Table #</th>
              <th>Capacity</th>
              <th>Location</th>
              <th>Price/Hour</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${tables}" var="t">
              <tr>
                <td>${t.id}</td>
                <td>
                  <i class="fas fa-chair" style="color: #e74c3c;"></i> ${t.tableNumber}
                </td>
                <td>${t.seatingCapacity} seats</span></td>
                <td>
                  <c:choose>
                    <c:when test="${t.location == 'INDOOR'}">
                                                    <span class="location-badge-indoor">
                                                        <i class="fas fa-building"></i> Indoor
                                                    </span>
                    </c:when>
                    <c:otherwise>
                                                    <span class="location-badge-outdoor">
                                                        <i class="fas fa-umbrella-beach"></i> Outdoor
                                                    </span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td class="price-cell">$${t.pricePerHour} <small class="text-muted">/hour</small></td>
                <td>
                  <c:choose>
                    <c:when test="${t.available}">
                      <span class="badge-available"><i class="fas fa-check-circle"></i> Available</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge-booked"><i class="fas fa-times-circle"></i> Booked</span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <div class="d-flex gap-2">
                    <a href="/admin/tables/edit/${t.id}" class="btn-edit text-decoration-none">
                      <i class="fas fa-edit"></i> Edit
                    </a>
                    <button class="btn-delete text-white" onclick="deleteTable(${t.id})">
                      <i class="fas fa-trash"></i> Delete
                    </button>
                  </div>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty tables}">
              <tr>
                <td colspan="7" class="text-center py-5">
                  <i class="fas fa-info-circle fa-2x text-muted mb-2 d-block"></i>
                  <span class="text-muted">No tables found. Click "Add New Table" to create one.</span>
                </td>
              </tr>
            </c:if>
            </tbody>
          </table>
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

  function deleteTable(id) {
    Swal.fire({
      title: 'Delete Table?',
      text: 'This action cannot be undone. The table will be permanently removed.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#e74c3c',
      cancelButtonColor: '#6c757d',
      confirmButtonText: 'Yes, delete it',
      cancelButtonText: 'Cancel'
    }).then((result) => {
      if(result.isConfirmed) {
        window.location.href = '/admin/tables/delete/' + id;
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