<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("adminUser") == null) {
        response.sendRedirect("login.jsp");
        return; // Stop further execution
    }

    // Get the admin's details from the session
    String adminName = (String) sessionObj.getAttribute("adminName");
    String adminEmail = (String) sessionObj.getAttribute("adminEmail");
    String adminFName = (String) sessionObj.getAttribute("adminFName");
    String adminLName = (String) sessionObj.getAttribute("adminLName");
    // Assuming these are available in the session; if not, you'll need to add them
    String adminUsername = (String) sessionObj.getAttribute("adminUsername");
    String adminGender = (String) sessionObj.getAttribute("adminGender");
    String adminPhone = (String) sessionObj.getAttribute("adminPhone");
    String adminAddress = (String) sessionObj.getAttribute("adminAddress");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Admin Profile for Event Photography and Videography Booking System">
    <meta name="author" content="Vinod Madhuranga">

    <title>Admin Profile</title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles -->
    <link href="css/admin.min.css" rel="stylesheet">
    <link href="css/admin.css" rel="stylesheet">
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Custom CSS for glassmorphism effect -->
    <style>
        .profile-card {
            background: rgba(78, 115, 223);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #fff;
            max-width: 900px;
            margin: 0 auto;
        }

        .profile-card h3 {
            font-size: 24px;
            font-weight: bold;
        }

        .profile-field {
            display: flex;
            align-items: center;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 10px;
            padding: 10px;
            margin-bottom: 10px;
            color: #fff;
            border: none;
        }

        .profile-field i {
            margin-right: 10px;
            color: #ccc;
        }

        .profile-field span {
            flex: 1;
        }

        .edit-btn {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: #fff;
            border-radius: 10px;
        }

        .delete-btn {
            border-radius: 10px;
        }
    </style>
</head>

<body id="page-top">
<!-- Page Wrapper -->
<div id="wrapper">
    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled" id="accordionSidebar">
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="">
            <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-laugh-wink"></i>
            </div>
        </a>
        <hr class="sidebar-divider my-0">
        <li class="nav-item">
            <a class="nav-link" href="dashboard.jsp">
                <i class="fas fa-fw fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <hr class="sidebar-divider">
        <div class="sidebar-heading">Interface</div>
        <li class="nav-item active">
            <a class="nav-link collapsed" href="profile.jsp">
                <i class="fas fa-fw fa-user"></i>
                <span>Profile</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
               aria-expanded="true" aria-controls="collapseUtilities">
                <i class="fas fa-fw fa-wrench"></i>
                <span>Utilities</span>
            </a>
            <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
                 data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">Custom Utilities:</h6>
                    <a class="collapse-item" href="utilities-color.html">Colors</a>
                    <a class="collapse-item" href="utilities-border.html">Borders</a>
                    <a class="collapse-item" href="utilities-animation.html">Animations</a>
                    <a class="collapse-item" href="utilities-other.html">Other</a>
                </div>
            </div>
        </li>
        <hr class="sidebar-divider">
        <div class="sidebar-heading">Addons</div>
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
               aria-expanded="true" aria-controls="collapsePages">
                <i class="fas fa-fw fa-folder"></i>
                <span>Pages</span>
            </a>
            <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">Login Screens:</h6>
                    <a class="collapse-item" href="login.html">Login</a>
                    <a class="collapse-item" href="register.html">Register</a>
                    <a class="collapse-item" href="forgot-password.html">Forgot Password</a>
                    <div class="collapse-divider"></div>
                    <h6 class="collapse-header">Other Pages:</h6>
                    <a class="collapse-item" href="404.html">404 Page</a>
                    <a class="collapse-item" href="blank.html">Blank Page</a>
                </div>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="charts.html">
                <i class="fas fa-fw fa-chart-area"></i>
                <span>Charts</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="tables.html">
                <i class="fas fa-fw fa-table"></i>
                <span>Tables</span>
            </a>
        </li>
        <hr class="sidebar-divider d-none d-md-block">
    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <!-- Main Content -->
        <div id="content">
            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                <button id="sidebarToggleTop" class="btn btn-link rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>
                <ul class="navbar-nav ml-auto">
                    <div class="topbar-divider d-none d-sm-block"></div>
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%= (adminName != null) ? adminName : "Admin" %></span>
                            <img class="img-profile rounded-circle" src="img/undraw_profile.svg">
                        </a>
                        <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                            <a class="dropdown-item" href="#">
                                <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                Profile
                            </a>
                            <a class="dropdown-item" href="#">
                                <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                Settings
                            </a>
                            <a class="dropdown-item" href="#">
                                <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                Activity Log
                            </a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="LogoutServlet?action=logout">
                                <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                Logout
                            </a>
                        </div>
                    </li>
                </ul>
            </nav>
            <!-- End of Topbar -->

            <!-- Profile Card -->
            <div class="container mt-6 mb-4">
                <div class="profile-card">
                    <div class="profile-img-wrapper">
                        <img id="profilePicture" src="img/undraw_profile.svg" alt="Profile Picture" class="profile-img">
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-5">
                        <h3>My Profile</h3>
                        <button class="btn edit-btn" onclick="enableEdit()">
                            <i class="fas fa-edit"></i> Edit Profile
                        </button>
                    </div>
                    <div class="row">
                        <!-- Full Name -->
                        <div class="col-md-4 mb-3">
                            <label class="form-label text-white">Full Name</label>
                            <div class="profile-field">
                                <i class="fas fa-user"></i>
                                <span><%= (adminFName != null && adminLName != null) ? adminFName + " " + adminLName : "Full Name" %></span>
                            </div>
                        </div>
                        <!-- Username -->
                        <div class="col-md-4 mb-3">
                            <label class="form-label text-white">Username</label>
                            <div class="profile-field">
                                <i class="fas fa-user-circle"></i>
                                <span><%= (adminUsername != null) ? adminUsername : "Username" %></span>
                            </div>
                        </div>
                        <!-- Email -->
                        <div class="col-md-4 mb-3">
                            <label class="form-label text-white">Email</label>
                            <div class="profile-field">
                                <i class="fas fa-envelope"></i>
                                <span><%= (adminEmail != null) ? adminEmail : "Email" %></span>
                            </div>
                        </div>
                        <!-- Gender -->
                        <div class="col-md-4 mb-3">
                            <label class="form-label text-white">Gender</label>
                            <div class="profile-field">
                                <i class="fas fa-venus-mars"></i>
                                <span><%= (adminGender != null) ? adminGender : "Gender" %></span>
                            </div>
                        </div>
                        <!-- Phone -->
                        <div class="col-md-4 mb-3">
                            <label class="form-label text-white">Phone</label>
                            <div class="profile-field">
                                <i class="fas fa-phone"></i>
                                <span><%= (adminPhone != null) ? adminPhone : "Phone" %></span>
                            </div>
                        </div>
                        <!-- Address -->
                        <div class="col-md-4 mb-3">
                            <label class="form-label text-white">Address</label>
                            <div class="profile-field">
                                <i class="fas fa-home"></i>
                                <span><%= (adminAddress != null) ? adminAddress : "Address" %></span>
                            </div>
                        </div>
                    </div>
                    <button class="btn btn-danger delete-btn mt-3" onclick="deleteProfile()">
                        <i class="fas fa-trash"></i> Delete Profile
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="js/admin.min.js"></script>

<!-- Custom JavaScript for Edit and Delete -->
<script>
    function enableEdit() {
        // Redirect to an edit page or make fields editable
        window.location.href = "editProfile.jsp"; // Replace with your edit page URL
    }

    function deleteProfile() {
        if (confirm("Are you sure you want to delete your profile? This action cannot be undone.")) {
            // Send a request to delete the profile
            $.ajax({
                url: 'DeleteProfileServlet', // Replace with your servlet URL
                type: 'POST',
                success: function(response) {
                    alert('Profile deleted successfully!');
                    window.location.href = "login.jsp"; // Redirect to login page after deletion
                },
                error: function() {
                    alert('Error deleting profile. Please try again.');
                }
            });
        }
    }
</script>

</body>
</html>