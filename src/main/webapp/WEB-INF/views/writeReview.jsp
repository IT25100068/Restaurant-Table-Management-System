<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Write a Review</title>
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

    .review-header {
      background: linear-gradient(135deg, #e74c3c, #c0392b);
      padding: 30px;
      text-align: center;
      color: white;
      border-radius: 20px;
      margin-bottom: 30px;
    }

    .review-header i {
      font-size: 50px;
      margin-bottom: 15px;
    }

    .review-header h2 {
      font-size: 28px;
      font-weight: 600;
      margin-bottom: 10px;
    }

    .review-card {
      background: white;
      border-radius: 20px;
      overflow: hidden;
      box-shadow: 0 15px 35px rgba(0,0,0,0.2);
    }

    .form-label {
      font-weight: 600;
      color: #2c3e50;
      margin-bottom: 8px;
    }

    .form-label i {
      color: #e74c3c;
      margin-right: 8px;
    }

    .form-select, .form-control {
      border-radius: 12px;
      border: 2px solid #e9ecef;
      padding: 12px 15px;
      transition: all 0.3s;
    }

    .form-select:focus, .form-control:focus {
      border-color: #e74c3c;
      box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1);
    }

    /* Star Rating */
    .rating {
      display: flex;
      flex-direction: row-reverse;
      justify-content: flex-start;
      gap: 5px;
      margin: 15px 0;
    }

    .rating input {
      display: none;
    }

    .rating label {
      font-size: 45px;
      color: #ddd;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .rating label:hover,
    .rating label:hover ~ label,
    .rating input:checked ~ label {
      color: #f1c40f;
      transform: scale(1.1);
    }

    .btn-submit {
      background: linear-gradient(135deg, #e74c3c, #c0392b);
      border: none;
      border-radius: 12px;
      padding: 14px;
      font-weight: 600;
      width: 100%;
      transition: 0.3s;
    }

    .btn-submit:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
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

    .empty-state h4 {
      color: #2c3e50;
      margin-bottom: 10px;
    }

    .reservation-option {
      padding: 10px;
      border-bottom: 1px solid #eee;
    }

    .reservation-option:last-child {
      border-bottom: none;
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
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="/customer/dashboard">
            <i class="fas fa-tachometer-alt"></i> Dashboard
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/reservation/my">
            <i class="fas fa-calendar-check"></i> My Reservations
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/menu/view">
            <i class="fas fa-utensil-spoon"></i> Menu
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="/review/my">
            <i class="fas fa-star"></i> My Reviews
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/customer/logout">
            <i class="fas fa-sign-out-alt"></i> Logout
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="container mt-4">
  <div class="row justify-content-center">
    <div class="col-lg-7">
      <div class="review-header">
        <i class="fas fa-star"></i>
        <h2>Write a Review</h2>
        <p>Share your dining experience with us</p>
      </div>

      <div class="review-card">
        <div class="card-body p-4">
          <c:if test="${not empty error}">
            <div id="errorMsg" data-message="${error}" style="display: none;"></div>
          </c:if>

          <c:choose>
            <c:when test="${empty reservations}">
              <div class="empty-state">
                <i class="fas fa-utensils"></i>
                <h4>No Completed Reservations</h4>
                <p class="text-muted">You don't have any completed reservations to review yet.</p>
                <a href="/reservation/new" class="btn-submit text-white text-decoration-none d-inline-block mt-3" style="padding: 10px 25px; width: auto;">
                  <i class="fas fa-calendar-plus"></i> Make a Reservation
                </a>
              </div>
            </c:when>
            <c:otherwise>
              <form id="reviewForm" action="/review/submit" method="post">
                <div class="mb-4">
                  <label class="form-label">
                    <i class="fas fa-calendar-check"></i> Select Your Reservation
                  </label>
                  <select name="reservationId" id="reservationId" class="form-select" required>
                    <option value="">-- Choose a reservation --</option>
                    <c:forEach items="${reservations}" var="r">
                      <option value="${r.id}" data-table="${r.tableNumber}" data-date="${r.reservationDate}" data-time="${r.reservationTime}" data-guests="${r.partySize}">
                        Table ${r.tableNumber} - ${r.reservationDate} at ${r.reservationTime} (${r.partySize} guests)
                      </option>
                    </c:forEach>
                  </select>
                  <small class="text-muted">Select the reservation you want to review</small>
                </div>

                <div id="selectedReservationPreview" class="alert alert-light mb-4" style="display: none; border-radius: 12px;">
                  <div class="d-flex align-items-center gap-3">
                    <i class="fas fa-receipt fa-2x" style="color: #e74c3c;"></i>
                    <div>
                      <strong>Selected Reservation:</strong>
                      <span id="previewText"></span>
                    </div>
                  </div>
                </div>

                <div class="mb-4 text-center">
                  <label class="form-label d-block">
                    <i class="fas fa-star"></i> Your Rating
                  </label>
                  <div class="rating d-flex justify-content-center flex-row-reverse">
                    <input type="radio" name="rating" value="5" id="star5">
                    <label for="star5"><i class="fas fa-star"></i></label>

                    <input type="radio" name="rating" value="4" id="star4">
                    <label for="star4"><i class="fas fa-star"></i></label>

                    <input type="radio" name="rating" value="3" id="star3">
                    <label for="star3"><i class="fas fa-star"></i></label>

                    <input type="radio" name="rating" value="2" id="star2">
                    <label for="star2"><i class="fas fa-star"></i></label>

                    <input type="radio" name="rating" value="1" id="star1">
                    <label for="star1"><i class="fas fa-star"></i></label>
                  </div>
                  <small class="text-muted">Click on the stars to rate your experience</small>
                </div>

                <div class="mb-4">
                  <label class="form-label">
                    <i class="fas fa-comment"></i> Your Review
                  </label>
                  <textarea name="comment" id="comment" class="form-control" rows="5"
                            placeholder="Tell us about your experience... (Food quality, service, ambiance, etc.)" required></textarea>
                </div>

                <button type="submit" class="btn-submit text-white">
                  <i class="fas fa-paper-plane"></i> Submit Review
                </button>
              </form>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
  $(document).ready(function() {
    var errorMsg = $('#errorMsg').data('message');
    if(errorMsg) {
      Swal.fire({
        icon: 'error',
        title: 'Cannot Submit Review',
        text: errorMsg,
        confirmButtonColor: '#e74c3c'
      });
    }

    $('#reservationId').on('change', function() {
      var selected = $(this).find('option:selected');
      if(selected.val()) {
        var table = selected.data('table');
        var date = selected.data('date');
        var time = selected.data('time');
        var guests = selected.data('guests');
        $('#previewText').html(`Table ${table} on ${date} at ${time} (${guests} guests)`);
        $('#selectedReservationPreview').show();
      } else {
        $('#selectedReservationPreview').hide();
      }
    });

    $('#reviewForm').on('submit', function(e) {
      var reservationId = $('#reservationId').val();
      var rating = $('input[name="rating"]:checked').val();
      var comment = $('#comment').val().trim();

      if(!reservationId) {
        e.preventDefault();
        Swal.fire({
          icon: 'warning',
          title: 'No Reservation Selected',
          text: 'Please select a reservation to review',
          confirmButtonColor: '#e74c3c'
        });
        return false;
      }

      if(!rating) {
        e.preventDefault();
        Swal.fire({
          icon: 'warning',
          title: 'Rating Required',
          text: 'Please select a rating for your experience',
          confirmButtonColor: '#e74c3c'
        });
        return false;
      }

      if(!comment) {
        e.preventDefault();
        Swal.fire({
          icon: 'warning',
          title: 'Review Required',
          text: 'Please write your review',
          confirmButtonColor: '#e74c3c'
        });
        return false;
      }

      if(comment.length < 10) {
        e.preventDefault();
        Swal.fire({
          icon: 'warning',
          title: 'Review Too Short',
          text: 'Please write at least 10 characters for your review',
          confirmButtonColor: '#e74c3c'
        });
        return false;
      }

      Swal.fire({
        title: 'Submitting Review...',
        text: 'Please wait',
        allowOutsideClick: false,
        didOpen: () => {
          Swal.showLoading();
        }
      });

      return true;
    });
  });
</script>
</body>
</html>