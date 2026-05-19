<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Our Menu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
  <link rel="stylesheet" href="../../css/menu.css">

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
          <a class="nav-link active" href="/menu/view">
            <i class="fas fa-utensil-spoon"></i> Menu
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/review/my">
            <i class="fas fa-star"></i> Reviews
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/offers/view">
            <i class="fas fa-tag"></i> Offers
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
  <div class="menu-header">
    <i class="fas fa-utensils"></i>
    <h2>Our Delicious Menu</h2>
    <p>Discover our carefully crafted dishes made with love and the finest ingredients</p>
  </div>

  <div class="category-section">
    <div class="category-title">
      <h3><i class="fas fa-leaf"></i> Appetizers</h3>
    </div>
    <div class="row">
      <c:choose>
        <c:when test="${empty appetizers}">
          <div class="col-12">
            <div class="empty-category">
              <i class="fas fa-utensils"></i>
              <p>No appetizers available at the moment</p>
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach items="${appetizers}" var="item">
            <div class="col-md-3 col-sm-6 mb-4">
              <div class="menu-card">
                <div class="menu-badge">Popular</div>
                <div class="menu-card-body">
                  <div class="menu-icon">
                    <i class="fas fa-leaf" style="color: #27ae60;"></i>
                  </div>
                  <h4 class="menu-name">${item.name}</h4>
                  <p class="menu-description">${item.description}</p>
                  <div class="menu-price">
                    Rs.${item.price}.00 <small>/ serving</small>
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div class="category-section">
    <div class="category-title">
      <h3><i class="fas fa-hamburger"></i> Main Courses</h3>
    </div>
    <div class="row">
      <c:choose>
        <c:when test="${empty mainCourses}">
          <div class="col-12">
            <div class="empty-category">
              <i class="fas fa-utensils"></i>
              <p>No main courses available at the moment</p>
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach items="${mainCourses}" var="item">
            <div class="col-md-3 col-sm-6 mb-4">
              <div class="menu-card">
                <div class="menu-card-body">
                  <div class="menu-icon">
                    <i class="fas fa-utensils" style="color: #e74c3c;"></i>
                  </div>
                  <h4 class="menu-name">${item.name}</h4>
                  <p class="menu-description">${item.description}</p>
                  <div class="menu-price">
                    Rs.${item.price}.00 <small>/ serving</small>
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div class="category-section">
    <div class="category-title">
      <h3><i class="fas fa-ice-cream"></i> Desserts</h3>
    </div>
    <div class="row">
      <c:choose>
        <c:when test="${empty desserts}">
          <div class="col-12">
            <div class="empty-category">
              <i class="fas fa-ice-cream"></i>
              <p>No desserts available at the moment</p>
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach items="${desserts}" var="item">
            <div class="col-md-3 col-sm-6 mb-4">
              <div class="menu-card">
                <div class="menu-card-body">
                  <div class="menu-icon">
                    <i class="fas fa-cake-candles" style="color: #f1c40f;"></i>
                  </div>
                  <h4 class="menu-name">${item.name}</h4>
                  <p class="menu-description">${item.description}</p>
                  <div class="menu-price">
                    Rs.${item.price}.00 <small>/ serving</small>
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div class="category-section">
    <div class="category-title">
      <h3><i class="fas fa-coffee"></i> Beverages</h3>
    </div>
    <div class="row">
      <c:choose>
        <c:when test="${empty beverages}">
          <div class="col-12">
            <div class="empty-category">
              <i class="fas fa-coffee"></i>
              <p>No beverages available at the moment</p>
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach items="${beverages}" var="item">
            <div class="col-md-3 col-sm-6 mb-4">
              <div class="menu-card">
                <div class="menu-card-body">
                  <div class="menu-icon">
                    <i class="fas fa-mug-hot" style="color: #8B4513;"></i>
                  </div>
                  <h4 class="menu-name">${item.name}</h4>
                  <p class="menu-description">${item.description}</p>
                  <div class="menu-price">
                    Rs.${item.price}.00 <small>/ glass</small>
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div class="text-center mt-4 mb-5">
    <a href="/reservation/new" class="btn-new" style="background: linear-gradient(135deg, #e74c3c, #c0392b); color: white; padding: 12px 30px; border-radius: 50px; text-decoration: none; font-weight: 600; display: inline-block; transition: 0.3s;">
      <i class="fas fa-calendar-plus"></i> Book a Table Now
    </a>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>