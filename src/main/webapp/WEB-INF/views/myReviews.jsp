<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Reviews</title>
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

    .review-card {
      background: white;
      border-radius: 15px;
      transition: all 0.3s ease;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      height: 100%;
    }

    .review-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    }

    .rating-star {
      color: #f1c40f;
      font-size: 18px;
    }

    .btn-edit {
      background: #3498db;
      border: none;
      border-radius: 8px;
      padding: 6px 15px;
      font-size: 12px;
      transition: 0.3s;
    }

    .btn-edit:hover {
      background: #2980b9;
    }

    .btn-delete {
      background: #e74c3c;
      border: none;
      border-radius: 8px;
      padding: 6px 15px;
      font-size: 12px;
      transition: 0.3s;
    }

    .btn-delete:hover {
      background: #c0392b;
    }

    .btn-disabled {
      background: #95a5a6;
      border: none;
      border-radius: 8px;
      padding: 6px 15px;
      font-size: 12px;
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

    .info-note {
      background: #fff3cd;
      border-left: 4px solid #ffc107;
      padding: 10px 15px;
      border-radius: 8px;
      font-size: 12px;
      color: #856404;
    }

    @media (max-width: 768px) {
      .review-header {
        padding: 20px;
      }
      .review-header i {
        font-size: 35px;
      }
      .review-header h2 {
        font-size: 22px;
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
  <div class="review-header">
    <i class="fas fa-star"></i>
    <h2>My Reviews</h2>
    <p>Manage and track your reviews</p>
  </div>

  <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
    <div class="stats-card">
      <i class="fas fa-chart-line"></i>
      <span>Total Reviews: ${reviews.size()}</span>
    </div>
    <a href="/review/new" class="btn-new">
      <i class="fas fa-plus"></i> Write New Review
    </a>
  </div>

  <div class="info-note mb-4">
    <i class="fas fa-info-circle"></i>
    <strong>Note:</strong> Once your review is approved by admin, you cannot edit or delete it. Please review carefully before submitting.
  </div>

  <c:if test="${not empty success}">
    <div id="successMsg" data-message="${success}" style="display: none;"></div>
  </c:if>

  <c:choose>
    <c:when test="${empty reviews}">
      <div class="empty-state">
        <i class="fas fa-star"></i>
        <h4>No Reviews Yet</h4>
        <p class="text-muted">You haven't written any reviews yet.</p>
        <a href="/review/new" class="btn-new mt-3">
          <i class="fas fa-plus"></i> Write Your First Review
        </a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="row">
        <c:forEach items="${reviews}" var="r">
          <div class="col-md-6 mb-4">
            <div class="review-card">
              <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-start mb-3">
                  <div>
                    <c:forEach begin="1" end="${r.rating}">
                      <i class="fas fa-star rating-star"></i>
                    </c:forEach>
                    <c:forEach begin="${r.rating+1}" end="5">
                      <i class="far fa-star rating-star"></i>
                    </c:forEach>
                  </div>
                  <small class="text-muted">
                    <i class="fas fa-calendar-alt"></i> ${r.createdAt}
                  </small>
                </div>
                <p class="card-text">"${r.comment}"</p>
                <div class="d-flex justify-content-between align-items-center mt-3">
                  <div>
                    <c:if test="${!r.approved}">
                                                <span class="badge bg-warning text-dark">
                                                    <i class="fas fa-hourglass-half"></i> Pending Approval
                                                </span>
                    </c:if>
                    <c:if test="${r.approved}">
                                                <span class="badge bg-success">
                                                    <i class="fas fa-check-circle"></i> Approved
                                                </span>
                    </c:if>
                  </div>
                  <div class="btn-group">
                    <c:if test="${!r.approved}">
                      <a href="/review/edit/${r.id}" class="btn btn-edit text-white">
                        <i class="fas fa-edit"></i> Edit
                      </a>
                      <button onclick="deleteReview(${r.id})" class="btn btn-delete text-white">
                        <i class="fas fa-trash"></i> Delete
                      </button>
                    </c:if>
                    <c:if test="${r.approved}">
                                                <span class="btn btn-disabled text-white">
                                                    <i class="fas fa-lock"></i> Locked (Approved)
                                                </span>
                    </c:if>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
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
      confirmButtonText: 'Yes, delete it',
      cancelButtonText: 'Cancel'
    }).then((result) => {
      if(result.isConfirmed && callback) {
        callback();
      }
    });
  }

  function deleteReview(id) {
    showConfirm('Delete Review', 'Are you sure you want to delete this review? This action cannot be undone.', function() {
      window.location.href = '/review/delete/' + id;
    });
  }

  $(document).ready(function() {
    var successMsg = $('#successMsg').data('message');
    if(successMsg) {
      showSuccess(successMsg);
    }
  });
</script>
</body>
</html>