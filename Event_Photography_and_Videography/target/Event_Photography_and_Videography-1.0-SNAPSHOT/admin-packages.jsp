<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 18/05/2025
  Time: 12:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Manage Packages</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="container py-5">
  <div class="d-flex justify-content-between align-items-center mb-5">
    <h1>Manage Photography Packages</h1>
    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addPackageModal">
      <i class="bi bi-plus-lg"></i> Add New Package
    </button>
  </div>

  <table class="table table-striped table-hover">
    <thead class="table-dark">
    <tr>
      <th>Package Name</th>
      <th>Description</th>
      <th>Price</th>
      <th>Hours</th>
      <th>Photographers</th>
      <th>Editing</th>
      <th>Video</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${packages}" var="pkg">
      <tr>
        <td>${pkg.packageName}</td>
        <td>${pkg.description}</td>
        <td>$${pkg.price}</td>
        <td>${pkg.hoursCoverage}</td>
        <td>${pkg.photographers}</td>
        <td>
                        <span class="badge ${pkg.editingEnabled ? 'bg-success' : 'bg-secondary'}">
                            ${pkg.editingEnabled ? 'Yes' : 'No'}
                        </span>
        </td>
        <td>
                        <span class="badge ${pkg.videoIncluded ? 'bg-success' : 'bg-secondary'}">
                            ${pkg.videoIncluded ? 'Yes' : 'No'}
                        </span>
        </td>
        <td>
          <button class="btn btn-sm btn-warning edit-btn"
                  data-pkg-id="${pkg.packageId}"
                  data-pkg-name="${pkg.packageName}"
                  data-description="${pkg.description}"
                  data-price="${pkg.price}"
                  data-hours="${pkg.hoursCoverage}"
                  data-photographers="${pkg.photographers}"
                  data-editing="${pkg.editingEnabled}"
                  data-video="${pkg.videoIncluded}">
            <i class="bi bi-pencil"></i> Edit
          </button>
          <form action="packages" method="post" style="display:inline;">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="packageId" value="${pkg.packageId}">
            <button type="submit" class="btn btn-sm btn-danger">
              <i class="bi bi-trash"></i> Delete
            </button>
          </form>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>

<!-- Add Package Modal -->
<div class="modal fade" id="addPackageModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form action="packages" method="post">
        <input type="hidden" name="action" value="add">
        <div class="modal-header">
          <h5 class="modal-title">Add New Package</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label class="form-label">Package Name</label>
            <input type="text" name="packageName" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" required></textarea>
          </div>
          <div class="mb-3">
            <label class="form-label">Price ($)</label>
            <input type="number" step="0.01" name="price" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Hours Coverage</label>
            <input type="number" name="hoursCoverage" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Number of Photographers</label>
            <input type="number" name="photographers" class="form-control" required>
          </div>
          <div class="mb-3 form-check">
            <input type="checkbox" name="editingEnabled" class="form-check-input">
            <label class="form-check-label">Includes Photo Editing</label>
          </div>
          <div class="mb-3 form-check">
            <input type="checkbox" name="videoIncluded" class="form-check-input">
            <label class="form-check-label">Includes Videography</label>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-primary">Save Package</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Edit Package Modal -->
<div class="modal fade" id="editPackageModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form action="packages" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="packageId" id="editPackageId">
        <div class="modal-header">
          <h5 class="modal-title">Edit Package</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label class="form-label">Package Name</label>
            <input type="text" name="packageName" id="editPackageName" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" id="editDescription" class="form-control" required></textarea>
          </div>
          <div class="mb-3">
            <label class="form-label">Price ($)</label>
            <input type="number" step="0.01" name="price" id="editPrice" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Hours Coverage</label>
            <input type="number" name="hoursCoverage" id="editHours" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Number of Photographers</label>
            <input type="number" name="photographers" id="editPhotographers" class="form-control" required>
          </div>
          <div class="mb-3 form-check">
            <input type="checkbox" name="editingEnabled" id="editEditing" class="form-check-input">
            <label class="form-check-label">Includes Photo Editing</label>
          </div>
          <div class="mb-3 form-check">
            <input type="checkbox" name="videoIncluded" id="editVideo" class="form-check-input">
            <label class="form-check-label">Includes Videography</label>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-primary">Update Package</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Handle edit button clicks
  document.querySelectorAll('.edit-btn').forEach(btn => {
    btn.addEventListener('click', function() {
      const modal = new bootstrap.Modal(document.getElementById('editPackageModal'));

      // Populate form with package data
      document.getElementById('editPackageId').value = this.dataset.pkgId;
      document.getElementById('editPackageName').value = this.dataset.pkgName;
      document.getElementById('editDescription').value = this.dataset.description;
      document.getElementById('editPrice').value = this.dataset.price;
      document.getElementById('editHours').value = this.dataset.hours;
      document.getElementById('editPhotographers').value = this.dataset.photographers;
      document.getElementById('editEditing').checked = this.dataset.editing === 'true';
      document.getElementById('editVideo').checked = this.dataset.video === 'true';

      modal.show();
    });
  });
</script>
</body>
</html>
