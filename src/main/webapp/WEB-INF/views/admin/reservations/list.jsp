<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>All Reservations - Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <link rel="stylesheet" href="../../../../css/reservationList.css">

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
        <a href="/reservation/admin/list" class="nav-link active">
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
      <div class="back-link">
        <a href="/admin/dashboard">
          <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
      </div>

      <div class="page-title">
        <h2><i class="fas fa-calendar-alt"></i> All Reservations</h2>
        <p class="text-white-50">Manage and monitor all customer bookings</p>
      </div>


      <div class="card search-card">
        <div class="card-header">
          <i class="fas fa-search"></i> Search Filters
        </div>
        <div class="card-body">
          <form method="get" action="/reservation/admin/list" class="row g-3">
            <div class="col-md-3">
              <label class="form-label">Date</label>
              <input type="date" name="date" class="form-control" value="${param.date}">
            </div>
            <div class="col-md-3">
              <label class="form-label">Customer Name</label>
              <input type="text" name="customerName" class="form-control"
                     placeholder="Search by name" value="${param.customerName}">
            </div>
            <div class="col-md-3">
              <label class="form-label">Table Number</label>
              <select name="tableId" class="form-control">
                <option value="">All Tables</option>
                <option value="1" ${param.tableId == 1 ? 'selected' : ''}>Table 1</option>
                <option value="2" ${param.tableId == 2 ? 'selected' : ''}>Table 2</option>
                <option value="3" ${param.tableId == 3 ? 'selected' : ''}>Table 3</option>
                <option value="4" ${param.tableId == 4 ? 'selected' : ''}>Table 4</option>
                <option value="5" ${param.tableId == 5 ? 'selected' : ''}>Table 5</option>
                <option value="6" ${param.tableId == 6 ? 'selected' : ''}>Table 6</option>
                <option value="7" ${param.tableId == 7 ? 'selected' : ''}>Table 7</option>
              </select>
            </div>
            <div class="col-md-3">
              <label>&nbsp;</label>
              <button type="submit" class="btn btn-primary w-100">
                <i class="fas fa-search"></i> Search
              </button>
            </div>
          </form>
          <c:if test="${not empty param.date or not empty param.customerName or not empty param.tableId}">
            <div class="mt-3">
              <a href="/reservation/admin/list" class="btn btn-sm btn-secondary">
                <i class="fas fa-times"></i> Clear Filters
              </a>
            </div>
          </c:if>
        </div>
      </div>


      <div class="row mb-4">
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-calendar-alt" style="color: #3498db;"></i>
            </div>
            <div class="stats-number" id="totalCount">0</div>
            <div class="stats-label">Total Reservations</div>
          </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-check-circle" style="color: #27ae60;"></i>
            </div>
            <div class="stats-number" id="confirmedCount">0</div>
            <div class="stats-label">Confirmed</div>
          </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-clock" style="color: #f1c40f;"></i>
            </div>
            <div class="stats-number" id="pendingCount">0</div>
            <div class="stats-label">Pending</div>
          </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-times-circle" style="color: #e74c3c;"></i>
            </div>
            <div class="stats-number" id="cancelledCount">0</div>
            <div class="stats-label">Cancelled</div>
          </div>
        </div>
      </div>


      <div class="reservation-table">
        <div class="table-responsive">
          <table class="table table-bordered mb-0">
            <thead class="table-header">
            <tr>
              <th>ID</th>
              <th>Customer</th>
              <th>Table</th>
              <th>Date</th>
              <th>Time</th>
              <th>Guests</th>
              <th>Status</th>
              <th>Special Requests</th>
              <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${reservations}" var="r">
              <tr>
                <td>${r.id}</td>
                <td>${r.customerName}</td>
                <td>Table ${r.tableNumber}</td>
                <td>${r.reservationDate}</td>
                <td>${r.reservationTime}</td>
                <td>${r.partySize}</td>
                <td>
                  <c:choose>
                    <c:when test="${r.status == 'CONFIRMED'}">
                      <span class="badge-confirmed"><i class="fas fa-check-circle"></i> Confirmed</span>
                    </c:when>
                    <c:when test="${r.status == 'PENDING'}">
                      <span class="badge-pending"><i class="fas fa-clock"></i> Pending</span>
                    </c:when>
                    <c:when test="${r.status == 'CANCELLED'}">
                      <span class="badge-cancelled"><i class="fas fa-times-circle"></i> Cancelled</span>
                    </c:when>
                    <c:when test="${r.status == 'COMPLETED'}">
                      <span class="badge-completed"><i class="fas fa-check-double"></i> Completed</span>
                    </c:when>
                  </c:choose>
                </td>
                <td>${r.specialRequests}</td>
                <td>
                  <div class="action-buttons">
                    <c:if test="${r.status == 'CONFIRMED'}">
                      <button class="btn-complete text-white" onclick="completeReservation(${r.id})">
                        <i class="fas fa-check-double"></i> Complete & Add Points
                      </button>
                    </c:if>
                    <a href="/reservation/admin/edit/${r.id}" class="btn-edit text-decoration-none">
                      <i class="fas fa-edit"></i> Edit
                    </a>
                    <c:if test="${r.status != 'CANCELLED' && r.status != 'COMPLETED'}">
                      <button class="btn-cancel text-white" onclick="cancelReservation(${r.id})">
                        <i class="fas fa-times"></i> Cancel
                      </button>
                    </c:if>
                  </div>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty reservations}">
              <tr>
                <td colspan="9" class="text-center py-5">
                  <i class="fas fa-info-circle fa-2x text-muted mb-2 d-block"></i>
                  <span class="text-muted">No reservations found</span>
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


  var reservations = [
    <c:forEach items="${reservations}" var="r" varStatus="status">
    {status: '${r.status}'}${not status.last ? ',' : ''}
    </c:forEach>
  ];

  var totalCount = reservations.length;
  var confirmedCount = reservations.filter(r => r.status === 'CONFIRMED').length;
  var pendingCount = reservations.filter(r => r.status === 'PENDING').length;
  var cancelledCount = reservations.filter(r => r.status === 'CANCELLED').length;

  $('#totalCount').text(totalCount);
  $('#confirmedCount').text(confirmedCount);
  $('#pendingCount').text(pendingCount);
  $('#cancelledCount').text(cancelledCount);

  function completeReservation(id) {
    Swal.fire({
      title: 'Complete Reservation?',
      text: 'This will mark the reservation as completed and add loyalty points to the customer.',
      icon: 'question',
      showCancelButton: true,
      confirmButtonColor: '#27ae60',
      cancelButtonColor: '#6c757d',
      confirmButtonText: 'Yes, complete it',
      cancelButtonText: 'Cancel'
    }).then((result) => {
      if(result.isConfirmed) {
        window.location.href = '/reservation/admin/complete/' + id;
      }
    });
  }

  function cancelReservation(id) {
    Swal.fire({
      title: 'Cancel Reservation?',
      text: 'This action cannot be undone.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#e74c3c',
      cancelButtonColor: '#6c757d',
      confirmButtonText: 'Yes, cancel it',
      cancelButtonText: 'No, keep it'
    }).then((result) => {
      if(result.isConfirmed) {
        window.location.href = '/reservation/admin/delete/' + id;
      }
    });
  }


  function animateNumber(element, target) {
    if(target > 0) {
      var current = 0;
      var interval = setInterval(function() {
        if(current <= target) {
          $(element).text(current);
          current++;
        } else {
          clearInterval(interval);
        }
      }, 30);
    }
  }

  animateNumber('#totalCount', totalCount);
  animateNumber('#confirmedCount', confirmedCount);
  animateNumber('#pendingCount', pendingCount);
  animateNumber('#cancelledCount', cancelledCount);
</script>
</body>
</html>