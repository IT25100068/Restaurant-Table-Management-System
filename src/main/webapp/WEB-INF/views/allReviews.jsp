<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Customer Reviews</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <style>
    .review-card {
      border: none;
      border-radius: 15px;
      transition: all 0.3s ease;
      background: white;
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    }
    .review-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 30px rgba(0,0,0,0.15);
    }
    .rating-star {
      color: #f1c40f;
      font-size: 18px;
    }
    .review-header {
      border-bottom: 1px solid #eee;
      padding-bottom: 15px;
      margin-bottom: 15px;
    }
    .reviewer-avatar {
      width: 50px;
      height: 50px;
      background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-weight: bold;
      font-size: 20px;
    }
    .stats-card {
      background: white;
      border-radius: 15px;
      padding: 20px;
      text-align: center;
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
      border: none;
    }
    .average-rating {
      font-size: 48px;
      font-weight: 700;
      color: #e74c3c;
    }
  </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark navbar-custom">
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
          <a class="nav-link nav-link-custom" href="/customer/dashboard">
            <i class="fas fa-tachometer-alt"></i> Dashboard
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
          <a class="nav-link active nav-link-custom" href="/review/my">
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
  <div class="welcome-card mb-4 fade-in">
    <div class="card-header-custom">
      <i class="fas fa-star"></i>
      <h3>Customer Reviews</h3>
      <p>What our valued customers say about us</p>
    </div>
  </div>

  <div class="row mb-4">
    <div class="col-md-3">
      <div class="stats-card">
        <div class="average-rating">4.8</div>
        <div class="rating-star">
          ★★★★★
        </div>
        <div class="stats-label mt-2">Average Rating</div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="stats-card">
        <i class="fas fa-users fa-2x" style="color: #e74c3c;"></i>
        <div class="stats-number">${reviews.size()}</div>
        <div class="stats-label">Total Reviews</div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="stats-card">
        <i class="fas fa-smile fa-2x" style="color: #f1c40f;"></i>
        <div class="stats-number">95%</div>
        <div class="stats-label">Satisfaction Rate</div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="stats-card">
        <i class="fas fa-certificate fa-2x" style="color: #e74c3c;"></i>
        <div class="stats-number">5+ Years</div>
        <div class="stats-label">Excellence</div>
      </div>
    </div>
  </div>

  <c:choose>
    <c:when test="${empty reviews}">
      <div class="alert alert-info text-center fade-in">
        <i class="fas fa-info-circle"></i> No reviews yet.
        <a href="/review/new" class="text-decoration-none fw-bold">Be the first to write a review!</a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="row">
        <c:forEach items="${reviews}" var="r">
          <div class="col-md-6 mb-4">
            <div class="review-card card h-100 fade-in">
              <div class="card-body">
                <div class="review-header d-flex align-items-center gap-3">
                  <div class="reviewer-avatar">
                      ${fn:substring(r.customerName, 0, 1)}
                  </div>
                  <div>
                    <h5 class="mb-0">${r.customerName}</h5>
                    <small class="text-muted">
                      <i class="fas fa-calendar-alt"></i> ${r.createdAt}
                    </small>
                  </div>
                </div>
                <div class="mb-3">
                  <c:forEach begin="1" end="${r.rating}">
                    <i class="fas fa-star rating-star"></i>
                  </c:forEach>
                  <c:forEach begin="${r.rating+1}" end="5">
                    <i class="far fa-star rating-star"></i>
                  </c:forEach>
                </div>
                <p class="card-text">"${r.comment}"</p>
                <c:if test="${r.approved}">
                  <span class="badge bg-success"><i class="fas fa-check-circle"></i> Verified Review</span>
                </c:if>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>

  <div class="text-center mt-4">
    <a href="/review/new" class="btn-primary-custom" style="padding: 12px 30px; text-decoration: none; display: inline-block;">
      <i class="fas fa-pen"></i> Write Your Review
    </a>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>