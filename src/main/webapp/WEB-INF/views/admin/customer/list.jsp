<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Management - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link rel="stylesheet" href="../../../../css/customerList.css">

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
                <a href="/customer/admin/list" class="nav-link active">
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
                <a href="/review/admin/moderation" class="nav-link">
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

            <div class="page-title">
                <h2><i class="fas fa-users"></i> Customer Management</h2>
                <p class="text-white-50">Manage and monitor all registered customers</p>
            </div>


            <div class="row mb-4">
                <div class="col-md-3 col-6 mb-3">
                    <div class="stats-card">
                        <div class="stats-icon">
                            <i class="fas fa-users" style="color: #3498db;"></i>
                        </div>
                        <div class="stats-number">${totalCustomers}</div>
                        <div class="stats-label">Total Customers</div>
                    </div>
                </div>
                <div class="col-md-3 col-6 mb-3">
                    <div class="stats-card">
                        <div class="stats-icon">
                            <i class="fas fa-crown" style="color: #f1c40f;"></i>
                        </div>
                        <div class="stats-number">${premiumCount}</div>
                        <div class="stats-label">Premium Members</div>
                    </div>
                </div>
                <div class="col-md-3 col-6 mb-3">
                    <div class="stats-card">
                        <div class="stats-icon">
                            <i class="fas fa-user" style="color: #2ecc71;"></i>
                        </div>
                        <div class="stats-number">${regularCount}</div>
                        <div class="stats-label">Regular Members</div>
                    </div>
                </div>
                <div class="col-md-3 col-6 mb-3">
                    <div class="stats-card">
                        <div class="stats-icon">
                            <i class="fas fa-chart-line" style="color: #e74c3c;"></i>
                        </div>
                        <div class="stats-number">${totalPoints}</div>
                        <div class="stats-label">Total Points</div>
                    </div>
                </div>
            </div>


            <div class="card search-card">
                <div class="card-header">
                    <i class="fas fa-search"></i> Search Customers
                </div>
                <div class="card-body">
                    <form method="get" action="/customer/admin/list" class="row g-3">
                        <div class="col-md-10">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-search"></i></span>
                                <input type="text" name="search" class="form-control"
                                       placeholder="Search by name or email..."
                                       value="${searchKeyword}">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </div>
                    </form>
                    <c:if test="${not empty searchKeyword}">
                        <div class="mt-3">
                            <a href="/customer/admin/list" class="btn btn-sm btn-secondary">
                                <i class="fas fa-times"></i> Clear Search
                            </a>
                            <span class="ms-2 text-muted">Found ${totalCustomers} results for "${searchKeyword}"</span>
                        </div>
                    </c:if>
                </div>
            </div>


            <div class="custom-table">
                <div class="table-responsive">
                    <table class="table table-bordered mb-0">
                        <thead class="table-header">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Type</th>
                            <th>Loyalty Points</th>
                            <th>Registered Date</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${customers}" var="c">
                            <tr>
                                <td>${c.id}</td>
                                <td>
                                    <i class="fas fa-user-circle" style="color: #e74c3c;"></i> ${c.name}
                                </td>
                                <td>${c.email}</td>
                                <td>${c.phone}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.customerType == 'PREMIUM'}">
                                                    <span class="badge-premium">
                                                        <i class="fas fa-crown"></i> Premium
                                                    </span>
                                        </c:when>
                                        <c:otherwise>
                                                    <span class="badge-regular">
                                                        <i class="fas fa-user"></i> Regular
                                                    </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                            <span class="badge bg-info text-dark px-2 py-1">
                                                <i class="fas fa-star"></i> ${c.loyaltyPoints} pts
                                            </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty c.registrationDate}">
                                            <fmt:parseDate value="${c.registrationDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                            <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">N/A</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>                                <td>
                                    <a href="/customer/admin/view/${c.id}" class="btn btn-view text-white">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                    <button class="btn btn-delete text-white ms-1" onclick="deleteCustomer(${c.id})">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty customers}">
                            <tr>
                                <td colspan="8" class="text-center py-5">
                                    <i class="fas fa-info-circle fa-2x text-muted mb-2 d-block"></i>
                                    <span class="text-muted">No customers found</span>
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

    function deleteCustomer(id) {
        Swal.fire({
            title: 'Delete Customer?',
            text: 'This action cannot be undone! All customer data including reservations and reviews will be permanently deleted.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#e74c3c',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Yes, delete it',
            cancelButtonText: 'Cancel'
        }).then((result) => {
            if(result.isConfirmed) {
                $.ajax({
                    url: '/customer/admin/delete/' + id,
                    type: 'DELETE',
                    success: function(response) {
                        if(response === 'success') {
                            Swal.fire({
                                icon: 'success',
                                title: 'Deleted!',
                                text: 'Customer has been deleted successfully.',
                                confirmButtonColor: '#e74c3c',
                                timer: 2000
                            }).then(() => {
                                location.reload();
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error!',
                                text: 'Failed to delete customer.',
                                confirmButtonColor: '#e74c3c'
                            });
                        }
                    },
                    error: function() {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error!',
                            text: 'An error occurred while deleting the customer.',
                            confirmButtonColor: '#e74c3c'
                        });
                    }
                });
            }
        });
    }


    $('.stats-number').each(function() {
        var $this = $(this);
        var target = parseInt($this.text());
        if(target > 0 && !isNaN(target)) {
            var current = 0;
            var interval = setInterval(function() {
                if(current <= target) {
                    $this.text(current);
                    current++;
                } else {
                    clearInterval(interval);
                }
            }, 20);
        }
    });
</script>
</body>
</html>