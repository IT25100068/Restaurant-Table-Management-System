<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Reservations</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      background: url('https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=1600') no-repeat center center fixed;
      background-size: cover;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body::before {
      content: '';
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.6);
      z-index: -1;
    }

    .navbar {
      background: rgba(0, 0, 0, 0.85) !important;
      backdrop-filter: blur(5px);
    }

    .navbar-brand {
      font-weight: 600;
      color: #e74c3c !important;
    }

    .nav-link {
      color: white !important;
      transition: 0.3s;
    }

    .nav-link:hover {
      color: #e74c3c !important;
    }

    .reservation-header {
      background: linear-gradient(135deg, #e74c3c, #c0392b);
      padding: 30px;
      text-align: center;
      color: white;
      border-radius: 20px;
      margin-bottom: 30px;
    }

    .reservation-header i {
      font-size: 50px;
      margin-bottom: 15px;
    }

    .reservation-header h3 {
      font-size: 28px;
      font-weight: 600;
      margin-bottom: 10px;
    }

    .reservation-header p {
      opacity: 0.9;
      font-size: 14px;
    }

    .stats-card {
      background: white;
      border-radius: 12px;
      padding: 15px 25px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      display: inline-flex;
      align-items: center;
      gap: 10px;
    }

    .stats-card i {
      font-size: 24px;
      color: #e74c3c;
    }

    .stats-card .count {
      font-size: 24px;
      font-weight: 700;
      color: #2c3e50;
    }

    .stats-card .label {
      color: #6c757d;
      font-size: 14px;
    }

    .btn-new {
      background: linear-gradient(135deg, #e74c3c, #c0392b);
      border: none;
      border-radius: 12px;
      padding: 12px 25px;
      font-weight: 600;
      color: white;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      transition: 0.3s;
    }

    .btn-new:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
      color: white;
    }

    .reservation-item {
      background: white;
      border-radius: 16px;
      margin-bottom: 20px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      transition: all 0.3s ease;
      overflow: hidden;
    }

    .reservation-item:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    }

    .reservation-status {
      padding: 6px 14px;
      border-radius: 30px;
      font-size: 12px;
      font-weight: 600;
      display: inline-flex;
      align-items: center;
      gap: 5px;
    }

    .status-confirmed { background: #27ae60; color: white; }
    .status-pending { background: #f1c40f; color: #333; }
    .status-cancelled { background: #e74c3c; color: white; }
    .status-completed { background: #3498db; color: white; }

    .reservation-details {
      padding: 25px;
    }

    .info-row {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 12px;
    }

    .info-icon {
      width: 40px;
      height: 40px;
      background: #f8f9fa;
      border-radius: 12px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      color: #e74c3c;
    }

    .info-label {
      font-size: 11px;
      color: #6c757d;
    }

    .info-value {
      font-weight: 600;
      color: #2c3e50;
      font-size: 14px;
    }

    .special-request {
      background: #f8f9fa;
      padding: 12px 15px;
      border-radius: 12px;
      margin-top: 15px;
      font-size: 13px;
    }

    .btn-cancel {
      background: #e74c3c;
      border: none;
      border-radius: 10px;
      padding: 10px 20px;
      font-weight: 600;
      transition: 0.3s;
    }

    .btn-cancel:hover {
      background: #c0392b;
      transform: translateY(-2px);
    }

    .btn-review {
      background: #f1c40f;
      border: none;
      border-radius: 10px;
      padding: 10px 20px;
      font-weight: 600;
      color: #333;
      transition: 0.3s;
    }

    .btn-review:hover {
      background: #e67e22;
      transform: translateY(-2px);
      color: white;
    }

    .btn-reviewed {
      background: #95a5a6;
      border: none;
      border-radius: 10px;
      padding: 10px 20px;
      font-weight: 600;
      color: white;
      cursor: not-allowed;
    }

    .empty-state {
      text-align: center;
      padding: 60px 20px;
      background: white;
      border-radius: 20px;
    }

    .empty-state i {
      font-size: 60px;
      color: #e74c3c;
      margin-bottom: 20px;
      opacity: 0.5;
    }

    .action-buttons {
      display: flex;
      gap: 10px;
      justify-content: flex-end;
    }

    @media (max-width: 768px) {
      .reservation-header {
        padding: 20px;
      }
      .reservation-header i {
        font-size: 35px;
      }
      .reservation-header h3 {
        font-size: 22px;
      }
      .info-row {
        flex-direction: column;
        align-items: flex-start;
        gap: 5px;
      }
      .action-buttons {
        flex-direction: column;
      }
      .btn-cancel, .btn-review, .btn-reviewed {
        width: 100%;
        text-align: center;
      }
    }
  </style>
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
        <a class="nav-link active" href="/reservation/my">
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
    <div class="col-lg-10">
      <div class="reservation-header">
        <i class="fas fa-calendar-alt"></i>
        <h3>My Reservations</h3>
        <p>View and manage your table bookings</p>
      </div>

      <div class="d-flex justify-content-between align-items-center my-4 flex-wrap gap-3">
        <div class="stats-card">
          <i class="fas fa-chart-line"></i>
          <div>
            <span class="count">${reservations.size()}</span>
            <span class="label"> Total Bookings</span>
          </div>
        </div>
        <a href="/reservation/new" class="btn-new">
          <i class="fas fa-plus"></i> New Reservation
        </a>
      </div>

      <c:if test="${not empty success}">
        <div id="successMsg" data-message="${success}" style="display: none;"></div>
      </c:if>

      <c:choose>
        <c:when test="${empty reservations}">
          <div class="empty-state">
            <i class="fas fa-calendar-times"></i>
            <h4>No Reservations Yet</h4>
            <p class="text-muted">You haven't made any reservations yet.</p>
            <a href="/reservation/new" class="btn-new mt-3" style="padding: 10px 25px;">
              <i class="fas fa-plus"></i> Book Your First Table
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach items="${reservations}" var="r">
            <div class="reservation-item">
              <div class="reservation-details">
                <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
                  <div>
                    <h4 class="mb-0">
                      <i class="fas fa-chair" style="color: #e74c3c;"></i>
                      Table ${r.tableNumber}
                    </h4>
                    <small class="text-muted">Reservation #${r.id}</small>
                  </div>
                  <div>
                    <c:choose>
                      <c:when test="${r.status == 'CONFIRMED'}">
                                                    <span class="reservation-status status-confirmed">
                                                        <i class="fas fa-check-circle"></i> Confirmed
                                                    </span>
                      </c:when>
                      <c:when test="${r.status == 'PENDING'}">
                                                    <span class="reservation-status status-pending">
                                                        <i class="fas fa-clock"></i> Pending
                                                    </span>
                      </c:when>
                      <c:when test="${r.status == 'CANCELLED'}">
                                                    <span class="reservation-status status-cancelled">
                                                        <i class="fas fa-times-circle"></i> Cancelled
                                                    </span>
                      </c:when>
                      <c:when test="${r.status == 'COMPLETED'}">
                                                    <span class="reservation-status status-completed">
                                                        <i class="fas fa-check-double"></i> Completed
                                                    </span>
                      </c:when>
                    </c:choose>
                  </div>
                </div>

                <div class="row g-3">
                  <div class="col-md-6">
                    <div class="info-row">
                      <div class="info-icon">
                        <i class="fas fa-calendar-day"></i>
                      </div>
                      <div>
                        <div class="info-label">Reservation Date</div>
                        <div class="info-value">${r.reservationDate}</div>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="info-row">
                      <div class="info-icon">
                        <i class="fas fa-clock"></i>
                      </div>
                      <div>
                        <div class="info-label">Reservation Time</div>
                        <div class="info-value">${r.reservationTime}</div>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="info-row">
                      <div class="info-icon">
                        <i class="fas fa-users"></i>
                      </div>
                      <div>
                        <div class="info-label">Number of Guests</div>
                        <div class="info-value">${r.partySize} people</div>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="info-row">
                      <div class="info-icon">
                        <i class="fas fa-calendar-week"></i>
                      </div>
                      <div>
                        <div class="info-label">Booked On</div>
                        <div class="info-value">${r.createdAt}</div>
                      </div>
                    </div>
                  </div>
                </div>

                <c:if test="${not empty r.specialRequests}">
                  <div class="special-request">
                    <i class="fas fa-comment" style="color: #e74c3c;"></i>
                    <strong>Special Request:</strong> ${r.specialRequests}
                  </div>
                </c:if>


                <div class="action-buttons mt-3">
                  <c:if test="${r.status != 'CANCELLED' && r.status != 'COMPLETED'}">
                    <button class="btn-cancel text-white" onclick="cancelReservation(${r.id})">
                      <i class="fas fa-times"></i> Cancel Reservation
                    </button>
                  </c:if>

                  <c:if test="${r.status == 'COMPLETED'}">
                    <c:set var="hasReviewed" value="false" />
                    <c:forEach items="${reviewedReservationIds}" var="reviewedId">
                      <c:if test="${reviewedId == r.id}">
                        <c:set var="hasReviewed" value="true" />
                      </c:if>
                    </c:forEach>

                    <c:if test="${!hasReviewed}">
                      <a href="/review/new?reservationId=${r.id}" class="btn-review text-decoration-none">
                        <i class="fas fa-star"></i> Write a Review
                      </a>
                    </c:if>
                    <c:if test="${hasReviewed}">
                                                <span class="btn-reviewed">
                                                    <i class="fas fa-check-circle"></i> Review Submitted
                                                </span>
                    </c:if>
                  </c:if>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
  function showSuccess(message) {
    Swal.fire({
      icon: 'success',
      title: 'Success!',
      text: message,
      confirmButtonColor: '#e74c3c',
      timer: 3000
    });
  }

  function showConfirm(title, message, callback) {
    Swal.fire({
      title: title,
      text: message,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#e74c3c',
      cancelButtonColor: '#6c757d',
      confirmButtonText: 'Yes, cancel it',
      cancelButtonText: 'No, keep it'
    }).then((result) => {
      if(result.isConfirmed && callback) {
        callback();
      }
    });
  }

  function showLoading(message) {
    Swal.fire({
      title: message,
      text: 'Please wait',
      allowOutsideClick: false,
      didOpen: () => {
        Swal.showLoading();
      }
    });
  }

  $(document).ready(function() {
    var successMsg = $('#successMsg').data('message');
    if(successMsg) {
      showSuccess(successMsg);
    }
  });

  function cancelReservation(id) {
    showConfirm('Cancel Reservation', 'Are you sure you want to cancel this reservation? This action cannot be undone.', function() {
      showLoading('Cancelling reservation...');
      $('<form>', {
        'method': 'POST',
        'action': '/reservation/cancel/' + id
      }).appendTo(document.body).submit();
    });
  }
</script>
</body>
</html>