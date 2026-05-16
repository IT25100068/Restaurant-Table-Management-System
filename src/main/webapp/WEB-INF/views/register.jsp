<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>

    <title>Customer Registration</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../css/register.css">



</head>
<body>
<div class="container mt-4 pt-4 mb-4">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card register-card">
                <div class="register-header">
                    <i class="fas fa-user-plus"></i>
                    <h3>Create Account</h3>
                    <p>Join us for an amazing dining experience</p>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div id="errorMessage" data-message="${error}" style="display: none;"></div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div id="successMessage" data-message="${success}" style="display: none;"></div>
                    </c:if>

                    <form id="registerForm" action="/customer/register" method="post">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label><i class="fas fa-user"></i> Full Name</label>
                                        <input type="text" name="name" id="name" class="form-control"
                                               placeholder="Enter your full name" required autocomplete="off">
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label><i class="fas fa-envelope"></i> Email Address</label>
                                        <input type="email" name="email" id="email" class="form-control"
                                               placeholder="Enter your email" required autocomplete="off">
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><i class="fas fa-lock"></i> Password</label>
                                        <input type="password" name="password" id="password" class="form-control"
                                               placeholder="Create password" required>
                                    <div id="passwordStrength" class="password-strength"></div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label><i class="fas fa-check-circle"></i>Confirm Password</label>
                                        <input type="password" id="confirmPassword" class="form-control"
                                               placeholder="Confirm password" required>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label><i class="fas fa-phone"></i> Phone Number</label>
                                        <input type="tel" name="phone" id="phone" class="form-control"
                                               placeholder="Enter your phone number" required autocomplete="off">
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label><i class="fas fa-map-marker-alt"></i> Address</label>
                                        <textarea name="address" id="address" class="form-control" rows="2"
                                                  placeholder="Enter your address"></textarea>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="isPremium" id="isPremium">
                                        <span><i class="fas fa-crown" style="color: #f1c40f;"></i> Premium Membership</span>
                                        <span class="premium-badge">15% discount on all bookings</span>
                                    </label>
                                    <small class="text-muted d-block mt-1">
                                        Premium members get exclusive discounts and priority booking
                                    </small>
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn-register mt-2">
                            <i class="fas fa-user-plus"></i> Register Now
                        </button>
                    </form>

                    <div class="login-link">
                        <p>Already have an account? <a href="/customer/login">Sign In</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="../../js/register.js"></script>


</body>
</html>