<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("adminUser") == null) {
        response.sendRedirect("login.jsp");
        return; // Stop further execution
    }

    // Get the admin's details from the session
    String fullName = (String) sessionObj.getAttribute("fullName");
    String userName = (String) sessionObj.getAttribute("userName");
    String email = (String) sessionObj.getAttribute("email");
    String gender = (String) sessionObj.getAttribute("gender");
    String phone = (String) sessionObj.getAttribute("phone");
    String address = (String) sessionObj.getAttribute("address");
    String password = (String) sessionObj.getAttribute("password");
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
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
          rel="stylesheet">

    <!-- Custom styles -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="css/admin.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

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

        .profile-field-2 {
            flex: 1;
            align-items: center;
            background: rgba(255, 255, 255, 0.4);
            border-radius: 10px;
            color: #fff;
            border: none;
            text-align: center;
        }

        .profile-select {
            flex: 1;
            align-items: center;
            background: rgba(255, 255, 255, 0.4);
            border-radius: 10px;
            color: #fff;
            border: none;
            text-align: center;
            cursor: pointer;
        }

        .profile-select option {
            flex: 1;
            align-items: center;
            background: rgba(0, 0, 0, 0.14);
            border-radius: 10px;
            color: #000000;
            border: none;
            text-align: center;
            cursor: pointer;
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
        <hr class="sidebar-divider">
        <div class="sidebar-heading">
            Interface
        </div>
        <li class="nav-item">
            <a class="nav-link" href="dashboard.jsp">
                <i class="fas fa-fw fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item active">
            <a class="nav-link collapsed" href="profile.jsp">
                <i class="fas fa-fw fa-user"></i>
                <span>Profile</span>
            </a>
        </li>
        <hr class="sidebar-divider">
        <div class="sidebar-heading">
            Management
        </div>
        <li class="nav-item">
            <a class="nav-link" href="bookings.jsp">
                <i class="fas fa-fw fa-calendar"></i>
                <span>View All Bookings</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="users.jsp">
                <i class="fas fa-fw fa-users"></i>
                <span>Manage <br>Users</span>
            </a>
        </li>
        <hr class="sidebar-divider">
        <div class="sidebar-heading">
            Analytics
        </div>
        <li class="nav-item">
            <a class="nav-link" href="analytics.jsp">
                <i class="fas fa-fw fa-chart-line"></i>
                <span>Analytics</span>
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
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%= (userName != null) ? userName : "Admin" %></span>
                            <img class="img-profile rounded-circle" src="img/undraw_profile.svg">
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- End of Topbar -->

            <!-- Profile Card -->
            <div class="container mt-6 mb-4">
                <div class="profile-card">
                    <form action="EditProfileServlet" method="post">
                        <div class="profile-img-wrapper">
                            <img id="profilePicture" src="img/undraw_profile.svg" alt="Profile Picture" class="profile-img">
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-5">
                            <h3>Edit Profile</h3>
                            <button type="submit" class="btn edit-btn">
                                <i class="fas fa-edit"></i> Save Changes
                            </button>
                        </div>
                        <div class="row">
                            <!-- Full Name -->
                            <div class="col-md-4 mb-3">
                                <label class="form-label text-white">Full Name</label>
                                <div class="profile-field">
                                    <i class="fas fa-user"></i>
                                    <input type="text" class="profile-field-2" id="fullName" name="fullName"
                                           value="<%= (fullName != null) ? fullName : "Full Name" %>">
                                </div>
                            </div>
                            <!-- Username -->
                            <div class="col-md-4 mb-3">
                                <label class="form-label text-white">Username</label>
                                <div class="profile-field">
                                    <i class="fas fa-user-circle"></i>
                                    <span><%= (userName != null) ? userName : "Username" %></span>
                                </div>
                            </div>
                            <!-- Email -->
                            <div class="col-md-4 mb-3">
                                <label class="form-label text-white">Email</label>
                                <div class="profile-field">
                                    <i class="fas fa-envelope"></i>
                                    <input type="email" class="profile-field-2" id="email" name="email"
                                           value="<%= (email != null) ? email : "Email" %>">
                                </div>
                            </div>
                            <!-- Gender -->
                            <div class="col-md-4 mb-3">
                                <label class="form-label text-white">Gender</label>
                                <div class="profile-field">
                                    <i class="fas fa-venus-mars"></i>
                                    <select class="profile-select" id="gender" name="gender">
                                        <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
                                        <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <!-- Phone -->
                            <div class="col-md-4 mb-3">
                                <label class="form-label text-white">Phone</label>
                                <div class="profile-field">
                                    <i class="fas fa-phone"></i>
                                    <input type="text" class="profile-field-2" id="phone" name="phone"
                                           value="<%= (phone != null) ? phone : "Phone" %>">
                                </div>
                            </div>
                            <!-- Password -->
                            <div class="col-md-4 mb-3">
                                <label class="form-label text-white">Password</label>
                                <div class="profile-field">
                                    <i class="fas fa-home"></i>
                                    <input type="password" class="profile-field-2" id="password" name="password"
                                           value="<%= (password != null) ? password : "Password" %>">
                                </div>
                            </div>
                        </div>
                        <a href="profile.jsp" class="btn btn-danger delete-btn mt-3">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- JavaScript Dependencies -->
<script src="js/admin.min.js"></script>

</body>
</html>