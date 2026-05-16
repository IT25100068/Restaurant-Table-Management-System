<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Make a Reservation</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <link rel="stylesheet" href="../../css/makeReservation.css">

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
        <a class="nav-link" href="/customer/logout">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </div>
    </div>
  </div>
</nav>

<div class="container mt-4">
  <div class="row justify-content-center">
    <div class="col-lg-9">
      <div class="reservation-card">
        <div class="card-header text-white">
          <h4><i class="fas fa-calendar-plus"></i> Make a Reservation</h4>
          <p class="mb-0 mt-1 small">Book your table for an amazing dining experience</p>
        </div>

        <div class="card-body p-4">
          <c:if test="${not empty error}">
            <div id="errorMsg" data-message="${error}" style="display: none;"></div>
          </c:if>

          <form id="reservationForm" action="/reservation/create" method="post">
            <div class="mb-4">
              <label class="form-label">
                <i class="fas fa-chair"></i> Choose Your Table
              </label>
              <div id="tablesContainer" class="tables-grid">
                <div class="loading-spinner">
                  <div class="spinner-border text-danger" role="status">
                    <span class="visually-hidden">Loading...</span>
                  </div>
                  <p class="mt-2 text-muted small">Loading tables...</p>
                </div>
              </div>
              <input type="hidden" name="tableId" id="tableId" required>
              <div id="tableAvailabilityMsg" class="mt-2"></div>
            </div>

            <div class="row">
              <div class="col-md-4 mb-3">
                <label class="form-label">
                  <i class="fas fa-calendar"></i> Reservation Date
                </label>
                <input type="date" name="date" id="date" class="form-control"
                       min="${minDate}" required>
              </div>
              <div class="col-md-4 mb-3">
                <label class="form-label">
                  <i class="fas fa-clock"></i> Reservation Time
                </label>
                <select name="time" id="time" class="form-select" required>
                  <option value="">Select time</option>
                  <option value="11:00">11:00 AM</option>
                  <option value="12:00">12:00 PM</option>
                  <option value="13:00">01:00 PM</option>
                  <option value="14:00">02:00 PM</option>
                  <option value="17:00">05:00 PM</option>
                  <option value="18:00">06:00 PM</option>
                  <option value="19:00">07:00 PM</option>
                  <option value="20:00">08:00 PM</option>
                  <option value="21:00">09:00 PM</option>
                </select>
              </div>
              <div class="col-md-4 mb-3">
                <label class="form-label">
                  <i class="fas fa-users"></i> Number of Guests
                </label>
                <input type="number" name="partySize" id="partySize" class="form-control"
                       min="1" max="20" placeholder="Enter number" required>
              </div>
            </div>

            <div class="mb-3">
              <label class="form-label">
                <i class="fas fa-comment"></i> Special Requests
              </label>
              <textarea name="specialRequests" class="form-control" rows="2"
                        placeholder="Any special requests? (Allergies, celebrations, dietary restrictions, etc.)"></textarea>
            </div>

            <button type="submit" class="btn btn-book text-white" id="submitBtn" disabled>
              <i class="fas fa-check-circle"></i> Confirm Reservation
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
  var allTables = [
    <c:forEach items="${tables}" var="t" varStatus="status">
    {
      id: ${t.id},
      tableNumber: ${t.tableNumber},
      seatingCapacity: ${t.seatingCapacity},
      location: '${t.location}',
      pricePerHour: ${t.pricePerHour}
    }${not status.last ? ',' : ''}
    </c:forEach>
  ];
</script>

<script src="../../js/makeReservation.js"></script>

</body>
</html>