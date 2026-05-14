<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Table</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <link rel="stylesheet" href="../../../../css/editTable.css">

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
        <a href="/admin/dashboard" class="nav-link">Dashboard</a>
        <a href="/customer/admin/list" class="nav-link">Customer Management</a>
        <a href="/admin/tables/list" class="nav-link active">Table Management</a>
        <a href="/offers/admin/list" class="nav-link">Special Offers</a>
        <a href="/reservation/admin/list" class="nav-link">Reservations</a>
        <a href="/review/admin/moderation" class="nav-link">Review Moderation</a>
        <a href="/admin/list" class="nav-link">Admin Management</a>
        <a href="/admin/logout" class="nav-link">Logout</a>
      </div>
    </div>

    <div class="col-md-10 main-content">
      <div class="page-title">
        <h2><i class="fas fa-edit"></i> Edit Table #${table.tableNumber}</h2>
        <p class="text-white-50">Modify table details and availability</p>
      </div>

      <div class="row justify-content-center">
        <div class="col-lg-7">
          <div class="card form-card">
            <div class="card-header">
              <i class="fas fa-chair"></i> Edit Table Details
            </div>
            <div class="card-body">
              <form id="editForm" action="/admin/tables/edit/${table.id}" method="post">
                <div class="row">
                  <div class="col-md-6">
                    <div class="mb-3">
                      <label class="form-label">
                        <i class="fas fa-users"></i> Seating Capacity
                      </label>
                      <div class="input-icon">
                        <input type="number" name="seatingCapacity" value="${table.seatingCapacity}"
                               class="form-control" min="1" max="20" required>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="mb-3">
                      <label class="form-label">
                        <i class="fas fa-dollar-sign"></i> Price per Hour (Rs.)
                      </label>
                      <div class="input-icon">
                        <input type="number" name="pricePerHour" value="${table.pricePerHour}"
                               class="form-control" step="0.01" min="0" required>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="mb-3">
                  <label class="form-label">
                    <i class="fas fa-map-marker-alt"></i> Location
                  </label>
                  <div class="input-icon">
                    <i class="fas fa-building"></i>
                    <select name="location" class="form-control" required>
                      <option value="INDOOR" ${table.location == 'INDOOR' ? 'selected' : ''}> Indoor (Air-conditioned)</option>
                      <option value="OUTDOOR" ${table.location == 'OUTDOOR' ? 'selected' : ''}> Outdoor (Garden View)</option>
                    </select>
                  </div>
                </div>

                <div class="mb-3 form-check">
                  <input type="checkbox" name="isAvailable" class="form-check-input" id="isAvailable" ${table.available ? 'checked' : ''}>
                  <label class="form-check-label" for="isAvailable">
                    <i class="fas fa-check-circle"></i> Available for booking
                  </label>
                </div>

                <div class="row mt-4">
                  <div class="col-md-6">
                    <button type="submit" class="btn-update">
                      <i class="fas fa-save"></i> Update Table
                    </button>
                  </div>
                  <div class="col-md-6">
                    <a href="/admin/tables/list" class="btn-back text-white">
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
    var capacity = $('input[name="seatingCapacity"]').val();
    var price = $('input[name="pricePerHour"]').val();

    if(!capacity || capacity < 1) {
      e.preventDefault();
      Swal.fire({
        icon: 'warning',
        title: 'Invalid Capacity',
        text: 'Please enter seating capacity (1-20)',
        confirmButtonColor: '#e67e22'
      });
      return false;
    }

    if(!price || price <= 0) {
      e.preventDefault();
      Swal.fire({
        icon: 'warning',
        title: 'Invalid Price',
        text: 'Please enter a valid price per hour',
        confirmButtonColor: '#e67e22'
      });
      return false;
    }

    Swal.fire({
      title: 'Updating Table...',
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