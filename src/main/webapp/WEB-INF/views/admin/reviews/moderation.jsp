<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Review Moderation</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <link rel="stylesheet" href="../../../../css/moderationReview.css">

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
        <a href="/reservation/admin/list" class="nav-link">
          <i class="fas fa-calendar-alt"></i> Reservations
        </a>
        <a href="/review/admin/moderation" class="nav-link active">
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
        <h2><i class="fas fa-star"></i> Review Moderation Panel</h2>
        <p class="text-white-50">Approve or reject customer reviews</p>
      </div>


      <div class="row mb-4">
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-star" style="color: #f1c40f;"></i>
            </div>
            <div class="stats-number">
              ${stats.averageRating != null ? String.format("%.1f", stats.averageRating) : 'N/A'}
            </div>
            <div class="stats-label">Average Rating</div>
          </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-comments" style="color: #3498db;"></i>
            </div>
            <div class="stats-number">${stats.totalReviews}</div>
            <div class="stats-label">Total Reviews</div>
          </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-gem" style="color: #f1c40f;"></i>
            </div>
            <div class="stats-number">${stats.fiveStarCount}</div>
            <div class="stats-label">5-Star Reviews</div>
          </div>
        </div>
        <div class="col-md-3 col-6 mb-3">
          <div class="stats-card">
            <div class="stats-icon">
              <i class="fas fa-clock" style="color: #e74c3c;"></i>
            </div>
            <div class="stats-number">${pendingReviews.size()}</div>
            <div class="stats-label">Pending Approval</div>
          </div>
        </div>
      </div>


      <div class="section-title">
        <i class="fas fa-hourglass-half"></i> Pending Reviews
      </div>

      <c:choose>
        <c:when test="${empty pendingReviews}">
          <div class="empty-state">
            <i class="fas fa-check-circle"></i>
            <h4>No Pending Reviews</h4>
            <p class="text-muted">All reviews have been moderated</p>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach items="${pendingReviews}" var="review">
            <div class="card review-card pending">
              <div class="card-body">
                <div class="review-header">
                  <div class="customer-name">
                    <i class="fas fa-user-circle"></i> ${review.customerName}
                  </div>
                  <div class="rating-stars">
                    <c:forEach begin="1" end="${review.rating}">
                      <i class="fas fa-star"></i>
                    </c:forEach>
                    <c:forEach begin="${review.rating+1}" end="5">
                      <i class="far fa-star"></i>
                    </c:forEach>
                  </div>
                </div>
                <div class="review-comment">
                  "${review.comment}"
                </div>
                <div class="review-meta">
                  <i class="fas fa-calendar-alt"></i> Submitted: ${review.createdAtStr}
                </div>
                <div class="d-flex gap-2">
                  <button class="btn-approve text-white" onclick="approveReview(${review.id})">
                    <i class="fas fa-check"></i> Approve Review
                  </button>
                  <button class="btn-reject text-white" onclick="rejectReview(${review.id})">
                    <i class="fas fa-times"></i> Reject Review
                  </button>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>


      <div class="section-title mt-4">
        <i class="fas fa-list"></i> All Reviews
      </div>

      <div class="review-table">
        <div class="table-responsive">
          <table class="table table-bordered mb-0">
            <thead class="table-header">
            <tr>
              <th>Customer</th>
              <th>Rating</th>
              <th>Comment</th>
              <th>Status</th>
              <th>Date</th>
              <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${allReviews}" var="review">
              <tr>
                <td>
                  <i class="fas fa-user-circle" style="color: #e74c3c;"></i> ${review.customerName}
                </td>
                <td class="rating-stars">
                  <c:forEach begin="1" end="${review.rating}">
                    <i class="fas fa-star star-icon"></i>
                  </c:forEach>
                  <c:forEach begin="${review.rating+1}" end="5">
                    <i class="far fa-star star-icon"></i>
                  </c:forEach>
                </td>
                <td>${review.comment}</td>
                <td>
                  <c:choose>
                    <c:when test="${review.approved}">
                      <span class="badge-approved"><i class="fas fa-check-circle"></i> Approved</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge-pending-table"><i class="fas fa-clock"></i> Pending</span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>${review.createdAtStr}</td>
                <td>
                  <div class="d-flex gap-2">
                    <c:if test="${!review.approved}">
                      <button class="btn-approve text-white" style="padding: 4px 12px; font-size: 11px;" onclick="approveReview(${review.id})">
                        <i class="fas fa-check"></i> Approve
                      </button>
                    </c:if>
                    <button class="btn-reject text-white" style="padding: 4px 12px; font-size: 11px;" onclick="rejectReview(${review.id})">
                      <i class="fas fa-trash"></i> Delete
                    </button>
                  </div>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty allReviews}">
              <tr>
                <td colspan="6" class="text-center py-5">
                  <i class="fas fa-info-circle fa-2x text-muted mb-2 d-block"></i>
                  <span class="text-muted">No reviews found</span>
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

  function approveReview(id) {
    Swal.fire({
      title: 'Approve Review?',
      text: 'This review will be published on the website.',
      icon: 'question',
      showCancelButton: true,
      confirmButtonColor: '#27ae60',
      cancelButtonColor: '#6c757d',
      confirmButtonText: 'Yes, approve it',
      cancelButtonText: 'Cancel'
    }).then((result) => {
      if(result.isConfirmed) {
        Swal.fire({
          title: 'Processing...',
          text: 'Please wait',
          allowOutsideClick: false,
          didOpen: () => {
            Swal.showLoading();
          }
        });
        window.location.href = '/review/admin/approve/' + id;
      }
    });
  }

  function rejectReview(id) {
    Swal.fire({
      title: 'Reject/Delete Review?',
      text: 'This action cannot be undone. The review will be permanently deleted.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#e74c3c',
      cancelButtonColor: '#6c757d',
      confirmButtonText: 'Yes, delete it',
      cancelButtonText: 'Cancel'
    }).then((result) => {
      if(result.isConfirmed) {
        Swal.fire({
          title: 'Processing...',
          text: 'Please wait',
          allowOutsideClick: false,
          didOpen: () => {
            Swal.showLoading();
          }
        });
        window.location.href = '/review/admin/reject/' + id;
      }
    });
  }


  $('.stats-number').each(function() {
    var $this = $(this);
    var text = $this.text();
    var target = parseFloat(text);
    if(!isNaN(target) && target > 0) {
      var current = 0;
      var isFloat = text.includes('.');
      var interval = setInterval(function() {
        if(current <= target) {
          if(isFloat) {
            $this.text(current.toFixed(1));
          } else {
            $this.text(Math.floor(current));
          }
          current += isFloat ? 0.1 : 1;
        } else {
          clearInterval(interval);
          if(isFloat) {
            $this.text(target.toFixed(1));
          }
        }
      }, 30);
    }
  });
</script>
</body>
</html>