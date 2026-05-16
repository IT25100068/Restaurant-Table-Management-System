<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Reservation</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <link rel="stylesheet" href="../../../../css/editReservation.css">


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
      <div class="page-title">
        <h2><i class="fas fa-edit"></i> Edit Reservation #${reservation.id}</h2>
        <p class="text-white-50">Modify reservation details</p>
      </div>

      <div class="row justify-content-center">
        <div class="col-lg-8">
          <div class="card form-card">
            <div class="card-header">
              <i class="fas fa-calendar-alt"></i> Reservation Details
            </div>
            <div class="card-body">
              <form id="editForm" action="/reservation/admin/update/${reservation.id}" method="post">
                <div class="row">
                  <div class="col-md-6">
                    <div class="mb-3">
                      <label class="form-label">
                        <i class="fas fa-calendar-day"></i> Reservation Date
                      </label>
                      <div class="input-icon">
                        <i class="fas fa-calendar"></i>
                        <input type="date" name="date" value="${reservation.reservationDate}" class="form-control" required>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="mb-3">
                      <label class="form-label">
                        <i class="fas fa-clock"></i> Reservation Time
                      </label>
                      <div class="input-icon">
                        <i class="fas fa-clock"></i>
                        <input type="time" name="time" value="${reservation.reservationTime}" class="form-control" required>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col-md-6">
                    <div class="mb-3">
                      <label class="form-label">
                        <i class="fas fa-users"></i> Party Size
                      </label>
                      <div class="input-icon">
                        <i class="fas fa-user-friends"></i>
                        <input type="number" name="partySize" value="${reservation.partySize}" class="form-control" min="1" max="20" required>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="mb-3">
                      <label class="form-label">
                        <i class="fas fa-tag"></i> Status
                      </label>
                      <div class="input-icon">
                        <i class="fas fa-info-circle"></i>
                        <select name="status" class="form-control">
                          <option value="PENDING" ${reservation.status == 'PENDING' ? 'selected' : ''}> Pending</option>
                          <option value="CONFIRMED" ${reservation.status == 'CONFIRMED' ? 'selected' : ''}> Confirmed</option>
                          <option value="COMPLETED" ${reservation.status == 'COMPLETED' ? 'selected' : ''}> Completed</option>
                          <option value="CANCELLED" ${reservation.status == 'CANCELLED' ? 'selected' : ''}> Cancelled</option>
                        </select>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="mb-3">
                  <label class="form-label">
                    <i class="fas fa-comment-dots"></i> Special Requests
                  </label>
                  <div class="input-icon">
                    <i class="fas fa-pen"></i>
                    <textarea name="specialRequests" class="form-control" rows="4">${reservation.specialRequests}</textarea>
                  </div>
                </div>

                <div class="row mt-4">
                  <div class="col-md-6">
                    <button type="submit" class="btn-update text-white">
                      <i class="fas fa-save"></i> Update Reservation
                    </button>
                  </div>
                  <div class="col-md-6">
                    <a href="/reservation/admin/list" class="btn-back text-white">
                      <i class="fas fa-arrow-left"></i> Back to List
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

  $('#editForm').on('submit', function(e) {
    var date = $('input[name="date"]').val();
    var time = $('input[name="time"]').val();
    var partySize = $('input[name="partySize"]').val();

    if(!date) {
      e.preventDefault();
      Swal.fire({
        icon: 'warning',
        title: 'Date Required',
        text: 'Please select a reservation date',
        confirmButtonColor: '#e74c3c'
      });
      return false;
    }

    if(!time) {
      e.preventDefault();
      Swal.fire({
        icon: 'warning',
        title: 'Time Required',
        text: 'Please select a reservation time',
        confirmButtonColor: '#e74c3c'
      });
      return false;
    }

    if(!partySize || partySize < 1) {
      e.preventDefault();
      Swal.fire({
        icon: 'warning',
        title: 'Invalid Party Size',
        text: 'Please enter a valid number of guests',
        confirmButtonColor: '#e74c3c'
      });
      return false;
    }

    Swal.fire({
      title: 'Updating Reservation...',
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