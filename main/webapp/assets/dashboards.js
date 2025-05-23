// Add console log to verify script loading
console.log("Customer dashboard script loading...");

document.addEventListener("DOMContentLoaded", function() {
    console.log("DOM fully loaded");
	console.log("Dashboard script loaded successfully");
    
    // Create customerData object from form values
    const customerData = {
        get name() { return document.getElementById("customer-name-input").value; },
        get email() { return document.getElementById("customer-email-input").value; },
        get gender() { document.getElementById("gender-display").textContent.toLowerCase(); },
        get phone() { return document.getElementById("phone-input").value; },
        get address() { return document.getElementById("address-input").value; },
        get preferences() { return document.getElementById("customer-preferences-input").value; },

    };
    
    // Make customerData accessible globally
    window.customerData = customerData;

    // Load customer profile data from HTML values
 

    // Edit profile functionality
    const editProfileBtn = document.getElementById("edit-profile-btn");
    const cancelEditBtn = document.getElementById("cancel-edit-btn");
    const profileForm = document.getElementById("profile-form");

    if (editProfileBtn) {
        editProfileBtn.onclick = function(e) {
            e.preventDefault();
            console.log("Edit profile button clicked");
            toggleEditMode(true);
        };
    }

    if (cancelEditBtn) {
        cancelEditBtn.onclick = function(e) {
            e.preventDefault();
            console.log("Cancel edit button clicked");
            toggleEditMode(false);
            loadProfileData(); // Reset form fields
        };
    }

    /*if (profileForm) {
        profileForm.onsubmit = function(e) {
            e.preventDefault();
            console.log("Form submitted");
            
            
            toggleEditMode(false);
            
            // Show success message
            showNotification("Profile updated successfully!");
        };
    }*/

    // Delete profile functionality
    const deleteProfileBtn = document.getElementById("delete-profile-btn");
    const deleteConfirmationModal = document.getElementById("delete-confirmation-modal");
    const cancelModalBtn = document.querySelector(".cancel-modal-btn");
    
    // Show delete confirmation modal
    if (deleteProfileBtn) {
        deleteProfileBtn.onclick = function(e) {
            e.preventDefault();
            console.log("Delete profile button clicked");
            deleteConfirmationModal.classList.add("active");
            
            // Add slight shake animation to alert user of serious action
            document.querySelector(".modal-content").classList.add("shake");
            setTimeout(() => {
                document.querySelector(".modal-content").classList.remove("shake");
            }, 500);
        };
    }
    
    // Hide modal when cancel is clicked
    if (cancelModalBtn) {
        cancelModalBtn.onclick = function(e) {
            e.preventDefault();
            console.log("Cancel delete button clicked");
            deleteConfirmationModal.classList.remove("active");
        };
    }
    
    
    
    // Close modal when clicking outside of it
    deleteConfirmationModal.addEventListener("click", function(e) {
        if (e.target === this) {
            this.classList.remove("active");
        }
    });
    
    // Escape key to close modal
    document.addEventListener("keydown", function(e) {
        if (e.key === "Escape" && deleteConfirmationModal.classList.contains("active")) {
            deleteConfirmationModal.classList.remove("active");
        }
    });

    // Fix Logout button
    const logoutBtn = document.querySelector(".logout-btn");
    if (logoutBtn) {
        logoutBtn.onclick = function(e) {
            e.preventDefault();
            console.log("Logout button clicked");
            
            // Show confirmation or just log out directly
            if (confirm("Are you sure you want to log out?")) {
                showNotification("Logging out...");
                
                // Redirect to login page after a short delay
                setTimeout(() => {
                    window.location.href = "logoutCustomer.jsp";
                }, 1500);
            }
        };
    }
    
    // Add Change Password functionality
    const changePasswordBtn = document.getElementById("change-password-btn");
    const passwordChangeForm = document.getElementById("password-change-form");
    //const savePasswordBtn = document.getElementById("save-password-btn");
    const cancelPasswordBtn = document.getElementById("cancel-password-btn");
    const passwordDisplay = document.getElementById("password-display");
    
    if (changePasswordBtn) {
        changePasswordBtn.onclick = function(e) {
            e.preventDefault();
            console.log("Change password button clicked");
            passwordChangeForm.classList.remove("hidden");
            changePasswordBtn.classList.add("hidden");
            passwordDisplay.classList.add("hidden");
        };
    }
    
    if (cancelPasswordBtn) {
        cancelPasswordBtn.onclick = function(e) {
            e.preventDefault();
            console.log("Cancel password change clicked");
            passwordChangeForm.classList.add("hidden");
            changePasswordBtn.classList.remove("hidden");
            passwordDisplay.classList.remove("hidden");
            
            // Clear form fields
            document.getElementById("current-password").value = "";
            document.getElementById("new-password").value = "";
            document.getElementById("confirm-password").value = "";
        };
    }
    
   /*if (savePasswordBtn) {
        savePasswordBtn.onclick = function(e) {
            e.preventDefault();
            console.log("Save password button clicked");
            
            const currentPassword = document.getElementById("current-password").value;
            const newPassword = document.getElementById("new-password").value;
            const confirmPassword = document.getElementById("confirm-password").value;
            
            // Basic validation
            if (!currentPassword) {
                showNotification("Please enter your current password", "error");
                return;
            }
            
            if (!newPassword) {
                showNotification("Please enter a new password", "error");
                return;
            }
            
            if (newPassword !== confirmPassword) {
                showNotification("Passwords don't match", "error");
                return;
            }
            
            // Show loading state
            savePasswordBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
            savePasswordBtn.disabled = true;
            
            // Simulate API call
            setTimeout(() => {
                // Success
                passwordChangeForm.classList.add("hidden");
                changePasswordBtn.classList.remove("hidden");
                passwordDisplay.classList.remove("hidden");
                
                // Clear fields
                document.getElementById("current-password").value = "";
                document.getElementById("new-password").value = "";
                document.getElementById("confirm-password").value = "";
                
                // Reset button
                savePasswordBtn.innerHTML = 'Save Password';
                savePasswordBtn.disabled = false;
                
                showNotification("Password changed successfully!");
            }, 1500);
        };
    }*/
	
	// Add event listener for the file input to show selected files
	const fileInput = document.getElementById('portfolio');
	const fileInfo = document.querySelector('.file-info');
	    
	if(fileInput && fileInfo) {
	    fileInput.addEventListener('change', function() {
	        if(this.files.length > 0) {
	            if(this.files.length === 1) {
	                fileInfo.textContent = this.files[0].name;
	            } else {
	                fileInfo.textContent = `${this.files.length} files selected`;
	            }
	        } else {
	            fileInfo.textContent = 'No files selected';
  			}
        });
    }	
});

// Global handler functions for direct onclick attributes
function handleEditProfile(e) {
    e.preventDefault();
    console.log("Edit profile button clicked via inline handler");
    toggleEditMode(true);
}

function handleCancelEdit(e) {
    e.preventDefault();
    console.log("Cancel edit button clicked via inline handler");
    toggleEditMode(false);
    loadProfileData();
}

/*function handleSaveProfile(e) {
    e.preventDefault();
    console.log("Save profile button clicked via inline handler");
    document.getElementById("customer-name").textContent = 
        document.getElementById("customer-name-input").value;
    toggleEditMode(false);
    showNotification("Profile updated successfully!");
}*/

function handleDeleteProfile(e) {
    e.preventDefault();
    console.log("Delete profile button clicked via inline handler");
    const modal = document.getElementById("delete-confirmation-modal");
    modal.classList.add("active");
    
    document.querySelector(".modal-content").classList.add("shake");
    setTimeout(() => {
        document.querySelector(".modal-content").classList.remove("shake");
    }, 500);
}

function handleCancelDelete(e) {
    e.preventDefault();
    console.log("Cancel delete clicked via inline handler");
    document.getElementById("delete-confirmation-modal").classList.remove("active");
}



function loadProfileData() {
    // Set the welcome text from the input value
    document.getElementById("customer-name").textContent = 
        document.getElementById("customer-name-input").value;
    
    // Set gender display from selected radio button or default
    /*const selectedGender = document.querySelector('input[name="gender"]:checked');
    if (selectedGender) {
        document.getElementById("gender-display").textContent = capitalizeFirstLetter(selectedGender.value);
    }*/
}

function toggleEditMode(isEditable) {
    const inputs = document.querySelectorAll(".profile-field input:not([type='radio'])");
    const genderDisplay = document.getElementById("gender-display");
    const genderEdit = document.querySelector(".gender-edit");
    const formActions = document.querySelector(".form-actions");
	const profilePicture = document.querySelector(".profile-picture-overlay");
    
    // Edit-only fields
    const editOnlyFields = document.querySelectorAll(".profile-field.edit-only");
    
    inputs.forEach(input => {
        input.disabled = !isEditable;
    });
    
    if (isEditable) {
        // Show gender editing controls
        genderDisplay.classList.add("hidden");
        genderEdit.classList.remove("hidden");
        formActions.classList.remove("hidden");
		
        
        // Show edit-only fields
        editOnlyFields.forEach(field => {
            field.style.display = "block";
        });
    } else {
        // Hide gender editing controls
        genderDisplay.classList.remove("hidden");
        genderEdit.classList.add("hidden");
        formActions.classList.add("hidden");

        // Hide edit-only fields
        editOnlyFields.forEach(field => {
            field.style.display = "none";
        });
    }
}

function capitalizeFirstLetter(string) {
    if (!string) return '';
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function showNotification(message, type = "success") {
    // Create notification element
    const notification = document.createElement("div");
    notification.className = "notification";
    
    // Choose icon and background based on type
    let icon = "check-circle";
    let bgColor = "rgba(72, 187, 120, 0.9)"; // Success green
    
    if (type === "error") {
        icon = "exclamation-circle";
        bgColor = "rgba(220, 53, 69, 0.9)"; // Error red
    } else if (type === "warning") {
        icon = "exclamation-triangle";
        bgColor = "rgba(255, 193, 7, 0.9)"; // Warning yellow
    }
    
    notification.innerHTML = `<i class="fas fa-${icon}"></i> ${message}`;
    
    // Style the notification
    Object.assign(notification.style, {
        position: "fixed",
        bottom: "20px",
        right: "20px",
        background: bgColor,
        color: "white",
        padding: "12px 20px",
        borderRadius: "5px",
        boxShadow: "0 3px 10px rgba(0, 0, 0, 0.2)",
        display: "flex",
        alignItems: "center",
        gap: "8px",
        zIndex: "1000",
        opacity: "0",
        transform: "translateY(20px)",
        transition: "all 0.3s ease"
    });
    
    // Add to document
    document.body.appendChild(notification);
    
    // Animate in
    setTimeout(() => {
        notification.style.opacity = "1";
        notification.style.transform = "translateY(0)";
    }, 10);
    
    // Remove after 3 seconds
    setTimeout(() => {
        notification.style.opacity = "0";
        notification.style.transform = "translateY(20px)";
        
        setTimeout(() => {
            document.body.removeChild(notification);
        }, 300);
    }, 3000);
}


function triggerFileInput() {
    document.getElementById('profile-picture-input').click();
}

document.getElementById('profile-picture-input').addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(event) {
            document.getElementById('profile-picture-preview').src = event.target.result;
            
            // Show the save button
            document.querySelector('.picture-submit-btn').classList.remove('hidden');
            
        }
        reader.readAsDataURL(file);
    }
});