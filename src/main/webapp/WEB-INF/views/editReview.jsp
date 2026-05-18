<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Review</title>
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

    .edit-header {
      background: linear-gradient(135deg, #e74c3c, #c0392b);
      padding: 30px;
      text-align: center;
      color: white;
      border-radius: 20px;
      margin-bottom: 30px;
    }

    .edit-header i {
      font-size: 50px;
      margin-bottom: 15px;
    }

    .edit-header h2 {
      font-size: 28px;
      font-weight: 600;
      margin-bottom: 10px;
    }

    .edit-card {
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

    .form-control {
      border-radius: 12px;
      border: 2px solid #e9ecef;
      padding: 12px 15px;
      transition: all 0.3s;
    }

    .form-control:focus {
      border-color: #e74c3c;
      box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1);
    }

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

    .btn-update {
      background: linear-gradient(135deg, #e74c3c, #c0392b);
      border: none;
      border-radius: 12px;
      padding: 14px;
      font-weight: 600;
      width: 100%;
      transition: 0.3s;
    }

    .btn-update:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
    }

    .warning-banner {
      background: #fff3cd;
      border-left: 4px solid #ffc107;
      padding: 12px 15px;
      border-radius: 10px;
      margin-bottom: 20px;
    }

    @media (max-width: 768px) {
      .edit-header {
        padding: 20px;
      }
      .edit-header i {
        font-size: 35px;
      }
      .edit-header h2 {
        font-size: 22px;
      }
      .rating label {
        font-size: 35px;
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
  <div class="row justify-content-center">
    <div class="col-lg-7">
      <div class="edit-header">
        <i class="fas fa-edit"></i>
        <h2>Edit Your Review</h2>
        <p>Update your dining experience</p>
      </div>

      <div class="edit-card">
        <div class="card-body p-4">
          <div class="warning-banner">
            <i class="fas fa-info-circle"></i>
            <strong>Note:</strong> Once your review is approved by admin, you cannot edit it. Make sure your review is final before submitting.
          </div>

          <form id="editForm" action="/review/update/${review.id}" method="post">
            <div class="mb-4 text-center">
              <label class="form-label d-block">
                <i class="fas fa-star"></i> Your Rating
              </label>
              <div class="rating d-flex justify-content-center">
                <input type="radio" name="rating" value="5" id="star5" ${review.rating == 5 ? 'checked' : ''}>
                <label for="star5">★</label>
                <input type="radio" name="rating" value="4" id="star4" ${review.rating == 4 ? 'checked' : ''}>
                <label for="star4">★</label>
                <input type="radio" name="rating" value="3" id="star3" ${review.rating == 3 ? 'checked' : ''}>
                <label for="star3">★</label>
                <input type="radio" name="rating" value="2" id="star2" ${review.rating == 2 ? 'checked' : ''}>
                <label for="star2">★</label>
                <input type="radio" name="rating" value="1" id="star1" ${review.rating == 1 ? 'checked' : ''}>
                <label for="star1">★</label>
              </div>
              <small class="text-muted">Click on the stars to update your rating</small>
            </div>

            <div class="mb-4">
              <label class="form-label">
                <i class="fas fa-comment"></i> Your Review
              </label>
              <textarea name="comment" id="comment" class="form-control" rows="5"
                        placeholder="Update your review..." required>${review.comment}</textarea>
            </div>

            <button type="submit" class="btn-update text-white">
              <i class="fas fa-save"></i> Update Review
            </button>
            <a href="/review/my" class="btn btn-secondary w-100 mt-3" style="border-radius: 12px; padding: 12px;">
              <i class="fas fa-times"></i> Cancel
            </a>
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
  $(document).ready(function() {
    $('#editForm').on('submit', function(e) {
      var rating = $('input[name="rating"]:checked').val();
      var comment = $('#comment').val().trim();

      if(!rating) {
        e.preventDefault();
        Swal.fire({
          icon: 'warning',
          title: 'Rating Required',
          text: 'Please select a rating',
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
          text: 'Please write at least 10 characters',
          confirmButtonColor: '#e74c3c'
        });
        return false;
      }

      Swal.fire({
        title: 'Updating Review...',
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