<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Customer Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">

  <link rel="stylesheet" href="../../css/customerDashboard.css">

</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container">
    <a class="navbar-brand navbar-brand-custom" href="/customer/dashboard">
      <i class="fas fa-utensils"></i> Restaurant Reservation
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
                        <span class="nav-link nav-link-custom">
                            <i class="fas fa-user-circle"></i> ${customer.name}
                        </span>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-link-custom" href="/customer/profile">
            <i class="fas fa-id-card"></i> Profile
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-link-custom" href="/reservation/my">
            <i class="fas fa-calendar-check"></i> My Reservations
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-link-custom" href="/menu/view">
            <i class="fas fa-utensil-spoon"></i> Menu
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-link-custom" href="/offers/view">
            <i class="fas fa-tag"></i> Offers
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-link-custom" href="/review/my">
            <i class="fas fa-star"></i> Reviews
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-link-custom" href="/customer/logout">
            <i class="fas fa-sign-out-alt"></i> Logout
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="container mt-4">
  <div class="welcome-card">
    <div class="card-header">
      <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
        <div>
          <h3 class="mb-0">
            <i class="fas fa-hand-peace"></i> Welcome back, ${customer.name}!
          </h3>
          <p class="mb-0 mt-1 opacity-75">We're delighted to serve you today</p>
        </div>
        <div>
          <c:choose>
            <c:when test="${customer.customerType == 'PREMIUM'}">
                                <span class="badge-premium">
                                    <i class="fas fa-crown"></i> Premium Member
                                </span>
            </c:when>
            <c:otherwise>
                                <span class="badge-regular">
                                    <i class="fas fa-user"></i> Regular Member
                                </span>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
    <div class="card-body">
      <div class="row">
        <div class="col-md-6">
          <p><i class="fas fa-envelope"></i> <strong>Email:</strong> ${customer.email}</p>
          <p><i class="fas fa-phone"></i> <strong>Phone:</strong> ${customer.phone}</p>
        </div>
        <div class="col-md-6">
          <c:if test="${customer.customerType == 'PREMIUM'}">
            <p><i class="fas fa-gift"></i> <strong>Discount Rate:</strong> 15% on all bookings</p>
          </c:if>
          <p><i class="fas fa-star"></i> <strong>Total Points:</strong> ${customer.loyaltyPoints} points</p>
        </div>
      </div>
    </div>
  </div>

  <div class="row mb-4">
    <div class="col-md-3 col-6 mb-3">
      <div class="stats-card">
        <div class="stats-icon">
          <i class="fas fa-calendar-alt" style="color: #e74c3c;"></i>
        </div>
        <div class="stats-number">${activeReservations}</div>
        <div class="stats-label">Active Reservations</div>
      </div>
    </div>
    <div class="col-md-3 col-6 mb-3">
      <div class="stats-card">
        <div class="stats-icon">
          <i class="fas fa-check-circle" style="color: #27ae60;"></i>
        </div>
        <div class="stats-number">${completedReservations}</div>
        <div class="stats-label">Completed Bookings</div>
      </div>
    </div>
    <div class="col-md-3 col-6 mb-3">
      <div class="stats-card">
        <div class="stats-icon">
          <i class="fas fa-star" style="color: #f1c40f;"></i>
        </div>
        <div class="stats-number">${reviewsCount}</div>
        <div class="stats-label">Reviews Written</div>
      </div>
    </div>
    <div class="col-md-3 col-6 mb-3">
      <div class="stats-card">
        <div class="stats-icon">
          <i class="fas fa-chart-line" style="color: #3498db;"></i>
        </div>
        <div class="stats-number">${customer.loyaltyPoints}</div>
        <div class="stats-label">Loyalty Points</div>
      </div>
    </div>
  </div>

  <h4 class="section-title">
    <i class="fas fa-bolt"></i> Quick Actions
  </h4>
  <div class="row mb-4">
    <div class="col-md-3 col-6 mb-3">
      <div class="quick-action-card" onclick="location.href='/reservation/new'">
        <div class="card-body">
          <div class="quick-action-icon" style="background: rgba(231, 76, 60, 0.1);">
            <i class="fas fa-calendar-plus fa-2x" style="color: #e74c3c;"></i>
          </div>
          <h5 class="mt-2">Make Reservation</h5>
          <p class="text-muted small">Book your table now</p>
          <button class="btn btn-sm btn-primary action-btn">
            Book Now <i class="fas fa-arrow-right"></i>
          </button>
        </div>
      </div>
    </div>
    <div class="col-md-3 col-6 mb-3">
      <div class="quick-action-card" onclick="location.href='/menu/view'">
        <div class="card-body">
          <div class="quick-action-icon" style="background: rgba(52, 152, 219, 0.1);">
            <i class="fas fa-utensils fa-2x" style="color: #3498db;"></i>
          </div>
          <h5 class="mt-2">View Menu</h5>
          <p class="text-muted small">Explore our dishes</p>
          <button class="btn btn-sm btn-info action-btn text-white">
            View Menu <i class="fas fa-arrow-right"></i>
          </button>
        </div>
      </div>
    </div>
    <div class="col-md-3 col-6 mb-3">
      <div class="quick-action-card" onclick="location.href='/review/new'">
        <div class="card-body">
          <div class="quick-action-icon" style="background: rgba(241, 196, 15, 0.1);">
            <i class="fas fa-star fa-2x" style="color: #f1c40f;"></i>
          </div>
          <h5 class="mt-2">Write Review</h5>
          <p class="text-muted small">Share your experience</p>
          <button class="btn btn-sm btn-warning action-btn">
            Write Review <i class="fas fa-arrow-right"></i>
          </button>
        </div>
      </div>
    </div>
    <div class="col-md-3 col-6 mb-3">
      <div class="quick-action-card" onclick="location.href='/offers/view'">
        <div class="card-body">
          <div class="quick-action-icon" style="background: rgba(39, 174, 96, 0.1);">
            <i class="fas fa-tag fa-2x" style="color: #27ae60;"></i>
          </div>
          <h5 class="mt-2">Special Offers</h5>
          <p class="text-muted small">Save more today</p>
          <button class="btn btn-sm btn-success action-btn">
            View Offers <i class="fas fa-arrow-right"></i>
          </button>
        </div>
      </div>
    </div>
  </div>

  <div class="loyalty-card">
    <div class="card-body p-4">
      <div class="row align-items-center">
        <div class="col-md-8">
          <h5>
            <i class="fas fa-chart-line" style="color: #e74c3c;"></i>
            Your Loyalty Progress
          </h5>
          <p class="text-muted small mb-2">
            Earn points with every completed reservation!
            <c:if test="${customer.customerType != 'PREMIUM'}">
              <strong>Premium members get 50% bonus points!</strong>
            </c:if>
          </p>

          <!-- Progress Bar Wrapper -->
          <div class="progress loyalty-progress mt-2" style="height: 12px; border-radius: 10px; background-color: #e9ecef;">
            <div class="progress-bar loyalty-progress-bar"
                 role="progressbar"
                 style="width: ${loyaltyProgress}%; background: linear-gradient(90deg, #f1c40f, #e67e22);"
                 aria-valuenow="${loyaltyProgress}"
                 aria-valuemin="0"
                 aria-valuemax="100">
            </div>
          </div>

          <div class="row mt-3">
            <div class="col-4">
              <small class="text-muted">
                <i class="fas fa-star"></i> Total Points
              </small>
              <div class="fw-bold text-dark">${customer.loyaltyPoints}</div>
            </div>
            <div class="col-4">
              <small class="text-muted">
                <i class="fas fa-chart-line"></i> Current Level
              </small>
              <div class="fw-bold text-dark">Level ${currentLevel}</div>
            </div>
            <div class="col-4">
              <small class="text-muted">
                <i class="fas fa-arrow-up"></i> Next Level
              </small>
              <div class="fw-bold text-dark">${pointsToNextLevel} points needed</div>
            </div>
          </div>

          <div class="mt-2">
            <small class="text-muted">
              <i class="fas fa-percent"></i> Progress to next level: ${loyaltyProgress}%
            </small>
            <c:if test="${loyaltyProgress > 0}">
              <div class="progress-text mt-1">
                <small class="text-success">
                  <i class="fas fa-check-circle"></i> You have completed ${loyaltyProgress}% of Level ${currentLevel}
                </small>
              </div>
            </c:if>
          </div>

          <div class="mt-3 p-2" style="background: #f8f9fa; border-radius: 10px;">
            <small class="text-muted">
              <i class="fas fa-info-circle"></i>
              <strong>How to earn points:</strong>
              10 points per person + bonus for celebrations (Birthday: 50, Anniversary: 50)
              <c:if test="${customer.customerType == 'PREMIUM'}">
                <span class="text-success">✨ Premium members get 50% bonus!</span>
              </c:if>
            </small>
          </div>
        </div>
        <div class="col-md-4 text-center">
          <c:if test="${customer.customerType != 'PREMIUM'}">
            <a href="/customer/upgrade" class="btn-upgrade">
              <i class="fas fa-crown"></i> Upgrade to Premium
            </a>
            <small class="d-block mt-2 text-muted">Get 50% bonus points!</small>
            <div class="mt-3">
              <small class="text-warning">
                <i class="fas fa-gift"></i> Premium Benefits:
              </small>
              <ul class="text-muted small text-start mt-1">
                <li>50% bonus on all points</li>
                <li>15% discount on bookings</li>
                <li>Priority table selection</li>
              </ul>
            </div>
          </c:if>
          <c:if test="${customer.customerType == 'PREMIUM'}">
            <div class="alert alert-success mb-0">
              <i class="fas fa-trophy fa-2x"></i>
              <div class="mt-2 fw-bold">Premium Member</div>
              <small>50% bonus on all points</small>
              <hr class="my-2">
              <small>✨ 15% discount on all bookings</small>
            </div>
          </c:if>
        </div>
      </div>
    </div>
  </div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
  $(document).ready(function() {
    $('.stats-number').each(function() {
      var $this = $(this);
      var target = parseInt($this.text());
      if(target > 0 && isNaN(target) === false) {
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
  });

  $('.quick-action-card').css('cursor', 'pointer');
</script>
</body>
</html>