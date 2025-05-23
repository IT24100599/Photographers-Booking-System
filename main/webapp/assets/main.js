document.addEventListener('DOMContentLoaded', function() {
    
    
    // Password visibility toggle
    const passwordField = document.getElementById('password');
    const showPasswordToggle = document.getElementById('show-password');
	
    
    if (passwordField && showPasswordToggle) {
        showPasswordToggle.addEventListener('click', function() {
            // Toggle password visibility
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                showPasswordToggle.innerHTML = '<i class="fas fa-eye-slash"></i>';
            } else {
                passwordField.type = 'password';
                showPasswordToggle.innerHTML = '<i class="fas fa-eye"></i>';
            }
        });
    }
	
	document.querySelector('form').onsubmit = function(e) {
	            const password = document.getElementById('password-input').value;
	            const confirmPassword = document.getElementById('confirm-password-input').value;
	            const passwordError = document.getElementById('password-error');
	            
	            if (password !== confirmPassword) {
	                passwordError.style.display = 'block';
	                e.preventDefault();
	                return false;
	            } else {
	                passwordError.style.display = 'none';
	                return true;
	            }
	        };

	        // Real-time validation
	        document.getElementById('confirm-password-input').addEventListener('input', function() {
	            const password = document.getElementById('password-input').value;
	            const confirmPassword = this.value;
	            const passwordError = document.getElementById('password-error');
	            
	            if (confirmPassword && password !== confirmPassword) {
	                passwordError.style.display = 'block';
	            } else {
	                passwordError.style.display = 'none';
	            }
	        });
    
    // Check for URL hash to determine which form to show
    const checkHashAndSwitchTab = function() {
        const hash = window.location.hash.substring(1); // Remove the # character
        
        if (hash === 'photographer') {
            // Find the photographer tab button and click it
            const photographerTabBtn = document.querySelector('.tab-btn[data-target="photographer-signup"]') || 
                                      document.querySelector('.tab-btn[data-target="photographer-login"]');
            if (photographerTabBtn) {
                photographerTabBtn.click();
            }
        } else if (hash === 'customer') {
            // Find the customer tab button and click it
            const customerTabBtn = document.querySelector('.tab-btn[data-target="user-signup"]') || 
                                  document.querySelector('.tab-btn[data-target="user-login"]');
            if (customerTabBtn) {
                customerTabBtn.click();
            }
        }
    };
    
    // Execute on page load
    checkHashAndSwitchTab();
    
    // Tab switching functionality
    const tabBtns = document.querySelectorAll('.tab-btn');
    const formContainers = document.querySelectorAll('.form-container');
    
    if (tabBtns.length > 0 && formContainers.length > 0) {
        // Show only non-active tab initially (hide the active one)
        updateTabVisibility();
        
        tabBtns.forEach(btn => {
            btn.addEventListener('click', function() {
                const target = this.getAttribute('data-target');
                
                // Update active tab
                tabBtns.forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                
                // Show target form container
                formContainers.forEach(container => {
                    container.classList.remove('active');
                    if (container.id === target) {
                        container.classList.add('active');
                    }
                });
                
                // Update tab visibility
                updateTabVisibility();
            });
        });
    }
    
    // Function to update tab visibility and question text
    function updateTabVisibility() {
        const questionElement = document.getElementById('user-type-question');
        const activeTab = document.querySelector('.tab-btn.active');
        const inactiveTab = document.querySelector('.tab-btn:not(.active)');
        
        if (activeTab && inactiveTab && questionElement) {
            // First show all buttons
            tabBtns.forEach(btn => {
                btn.classList.remove('hide');
            });
            
            // Then hide the active one
            activeTab.classList.add('hide');
            
            // Update the question text based on the visible button
            if (inactiveTab.textContent.includes('Customer')) {
                questionElement.textContent = 'Are you a Customer?';
            } else if (inactiveTab.textContent.includes('Photographer')) {
                questionElement.textContent = 'Are you a Photographer?';
            }
        }
    }

    // Main user type tabs (Customer/Photographer)
    const mainTabs = document.querySelectorAll('.main-tab');
    const userTypeContainers = document.querySelectorAll('.user-type-container');

    mainTabs.forEach(tab => {
        tab.addEventListener('click', () => {
            const target = document.getElementById(tab.dataset.target);
            
            // Deactivate all tabs and containers
            mainTabs.forEach(t => t.classList.remove('active'));
            userTypeContainers.forEach(c => c.classList.remove('active'));
            
            // Activate the clicked tab and its container
            tab.classList.add('active');
            target.classList.add('active');
        });
    });

    // Auth mode tabs (Login/Signup) within each user type section
    const authTabs = document.querySelectorAll('.auth-tab');
    
    authTabs.forEach(tab => {
        tab.addEventListener('click', () => {
            const target = document.getElementById(tab.dataset.target);
            
            // Find the parent section
            const parentSection = tab.closest('.user-type-container');
            
            // Find all tabs and containers within this section
            const sectionTabs = parentSection.querySelectorAll('.auth-tab');
            const authContainers = parentSection.querySelectorAll('.auth-container');
            
            // Deactivate all tabs and containers within this section
            sectionTabs.forEach(t => t.classList.remove('active'));
            authContainers.forEach(c => c.classList.remove('active'));
            
            // Activate the clicked tab and its container
            tab.classList.add('active');
            target.classList.add('active');
        });
    });

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

// Function to create bokeh lights with realistic appearance
/*function createBokehLights(count = 40) {
    const bokehContainer = document.createElement('div');
    bokehContainer.className = 'bokeh-container';
    
    // Even more transparent color variations for bokeh lights
    const colors = [
        'rgba(255, 255, 255, 0.06)',  // Reduced from 0.1
        'rgba(255, 240, 220, 0.05)',  // Reduced from 0.09
        'rgba(220, 240, 255, 0.04)',  // Reduced from 0.08
        'rgba(255, 220, 220, 0.05)',  // Reduced from 0.09
        'rgba(220, 255, 240, 0.04)'   // Reduced from 0.08
    ];
    
    for (let i = 0; i < count; i++) {
        const bokeh = document.createElement('div');
        bokeh.className = 'bokeh';
        
        // Create different layers of bokeh for depth effect
        const depthCategory = Math.random();
        
        if (depthCategory < 0.25) {
            // Foreground - larger, sharper bokeh
            bokeh.classList.add('realistic-large', 'foreground');
            const size = Math.random() * 30 + 40; // 40-70px
            bokeh.style.width = `${size}px`;
            bokeh.style.height = `${size}px`;
        } else if (depthCategory < 0.6) {
            // Middle ground - medium bokeh
            bokeh.classList.add('realistic-medium');
            const size = Math.random() * 20 + 20; // 20-40px
            bokeh.style.width = `${size}px`;
            bokeh.style.height = `${size}px`;
        } else {
            // Background - smaller, blurrier bokeh
            bokeh.classList.add('realistic-small', 'background');
            const size = Math.random() * 15 + 5; // 5-20px
            bokeh.style.width = `${size}px`;
            bokeh.style.height = `${size}px`;
        }
        
        // Random position with better distribution
        bokeh.style.top = `${Math.random() * 110 - 5}%`;
        bokeh.style.left = `${Math.random() * 110 - 5}%`;
        
        // Random color with proper gradient
        const colorIndex = Math.floor(Math.random() * colors.length);
        const baseColor = colors[colorIndex];
        
        // Create a unique gradient for each bokeh - more transparent
        const brightness = Math.random() * 10 + 70; // Reduced from 90-100% to 70-80%
        bokeh.style.background = `radial-gradient(circle at ${Math.random() * 30 + 35}% ${Math.random() * 30 + 35}%, 
                                 rgba(255, 255, 255, 0.25) 0%, 
                                 ${baseColor.replace(')', ', 0.15)')} 40%, 
                                 ${baseColor.replace(')', ', 0.01)')} 100%)`;
        
        // Random opacity with lower values for more transparency
        const opacity = Math.random() * 0.12 + 0.08; // Range 0.08-0.20 (reduced from 0.15-0.35)
        bokeh.style.opacity = opacity.toString();
        
        // Add bokeh to container
        bokehContainer.appendChild(bokeh);
    }
    
    // Add container right after the background div
    const backgroundDiv = document.querySelector('.background');
    if (backgroundDiv) {
        backgroundDiv.parentNode.insertBefore(bokehContainer, backgroundDiv.nextSibling);
    }
}

// Mouse position tracking variables
let mouseX = -1000; // Start offscreen
let mouseY = -1000; // Start offscreen
let prevMouseX = -1000; // For tracking mouse velocity
let prevMouseY = -1000;
let mouseVelocityX = 0;
let mouseVelocityY = 0;
let mousePresent = false;
const interactionRadius = 300; // Smaller interaction radius for subtler effect
const maxForce = 30; // Reduced from 50 for slower movement
let bokehElements = [];
let animationFrameId = null;
let windowWidth = window.innerWidth;
let windowHeight = window.innerHeight;
let lastFrameTime = 0;
// Global time scaling factor - lower makes all animations slower
const globalTimeScale = 0.5; // New: 50% slower overall

// Initialize cursor interaction with bokeh lights
function initCursorInteraction() {
    // Cancel any existing animation frame
    if (animationFrameId) {
        cancelAnimationFrame(animationFrameId);
    }
    
    // Store window dimensions first
    windowWidth = window.innerWidth;
    windowHeight = window.innerHeight;
    
    // Store all bokeh elements for quick access
    bokehElements = document.querySelectorAll('.bokeh');
    
    if (bokehElements.length === 0) {
        console.log("No bokeh elements found. Retrying in 500ms...");
        setTimeout(initCursorInteraction, 500);
        return;
    }
    
    // For each bokeh element, store its original position and physics properties
    bokehElements.forEach(bokeh => {
        const rect = bokeh.getBoundingClientRect();
        
        // Convert percentage to pixels for calculations
        let leftPercent = parseFloat(bokeh.style.left) || 0;
        let topPercent = parseFloat(bokeh.style.top) || 0;
        
        // Remove % if present
        leftPercent = leftPercent.toString().replace('%', '');
        topPercent = topPercent.toString().replace('%', '');
        
        // Use direct getBoundingClientRect values if styles aren't reliable
        bokeh.originalX = leftPercent ? (leftPercent / 100) * windowWidth : rect.left + rect.width / 2;
        bokeh.originalY = topPercent ? (topPercent / 100) * windowHeight : rect.top + rect.height / 2;
        bokeh.currentX = bokeh.originalX;
        bokeh.currentY = bokeh.originalY;
        
        // Realistic physics properties - varied by depth layer for parallax effect
        bokeh.velocityX = 0;
        bokeh.velocityY = 0;
        
        if (bokeh.classList.contains('foreground')) {
            // Foreground bokeh - even less responsive for slower movement
            bokeh.mass = 3.0 + Math.random() * 2.0; // Increased from 2.5
            bokeh.responsiveness = 0.15 + Math.random() * 0.15; // Reduced from 0.3-0.5
            bokeh.friction = 0.99; // Higher friction for slower movement (from 0.98)
            bokeh.returnForce = 0.002; // Reduced from 0.003
            bokeh.driftAmplitude = 0.01; // Reduced from 0.02
        } else if (bokeh.classList.contains('background')) {
            // Background bokeh - extremely slow movement
            bokeh.mass = 1.0 + Math.random() * 0.8; // Slightly increased from 0.8-1.3
            bokeh.responsiveness = 0.02 + Math.random() * 0.03; // Reduced from 0.05-0.1
            bokeh.friction = 0.995; // Higher friction (increased from 0.99)
            bokeh.returnForce = 0.005; // Reduced from 0.01
            bokeh.driftAmplitude = 0.03; // Reduced from 0.07
        } else {
            // Middle ground
            bokeh.mass = 1.8 + Math.random() * 1.0; // Increased from 1.2-2.0
            bokeh.responsiveness = 0.08 + Math.random() * 0.07; // Reduced from 0.15-0.3
            bokeh.friction = 0.992; // Higher friction (from 0.985)
            bokeh.returnForce = 0.003; // Reduced from 0.005
            bokeh.driftAmplitude = 0.02; // Reduced from 0.05
        }
        
        // Unique drift pattern - much slower
        bokeh.driftPhaseX = Math.random() * Math.PI * 2;
        bokeh.driftPhaseY = Math.random() * Math.PI * 2;
        bokeh.driftSpeed = 0.00002 + Math.random() * 0.00003; // Further reduced from 0.00005-0.0001
    });
    
    // Track mouse with improved detection
    document.addEventListener('mousemove', handleMouseMove);
    document.addEventListener('mouseenter', handleMouseEnter);
    document.addEventListener('mouseleave', handleMouseOut);
    document.addEventListener('touchmove', handleTouchMove, { passive: true });
    document.addEventListener('touchend', handleMouseOut);
    window.addEventListener('resize', handleWindowResize);
    
    // Start animation loop
    lastFrameTime = performance.now();
    animateBokeh(lastFrameTime);
}

// Handle mouse movement with velocity detection
const handleMouseMove = function(e) {
    // Calculate velocity
    if (mousePresent) {
        mouseVelocityX = e.clientX - mouseX;
        mouseVelocityY = e.clientY - mouseY;
    }
    
    mouseX = e.clientX;
    mouseY = e.clientY;
    prevMouseX = mouseX;
    prevMouseY = mouseY;
    mousePresent = true;
};

// Handle mouse enter
function handleMouseEnter(e) {
    mouseX = e.clientX;
    mouseY = e.clientY;
    mousePresent = true;
}

// Handle touch movement
function handleTouchMove(e) {
    if (e.touches && e.touches[0]) {
        mouseX = e.touches[0].clientX;
        mouseY = e.touches[0].clientY;
        mousePresent = true;
    }
}

// Handle mouse/touch out
function handleMouseOut() {
    mousePresent = false;
}

// Handle window resize
function handleWindowResize() {
    const newWidth = window.innerWidth;
    const newHeight = window.innerHeight;
    
    // Scale factor for positions based on window resize
    const widthRatio = newWidth / windowWidth;
    const heightRatio = newHeight / windowHeight;
    
    // Update stored dimensions
    windowWidth = newWidth;
    windowHeight = newHeight;
    
    // Update all bokeh original positions based on new window size
    bokehElements.forEach(bokeh => {
        bokeh.originalX = bokeh.originalX * widthRatio;
        bokeh.originalY = bokeh.originalY * heightRatio;
    });
}

// Update bokeh positions with realistic physics
function updateBokehPositions(timestamp) {
    if (!bokehElements.length) return;
    
    // Calculate time delta for frame-rate independent animation
    const deltaTime = timestamp - lastFrameTime;
    // Apply global time scaling to slow everything down
    const timeScale = Math.min(deltaTime / (1000 / 60), 2) * globalTimeScale;
    lastFrameTime = timestamp;
    
    // Calculate mouse influence - even weaker effect for slower movement
    const mouseSpeed = Math.sqrt(mouseVelocityX * mouseVelocityX + mouseVelocityY * mouseVelocityY);
    const mouseInfluence = mousePresent ? Math.min(0.4, mouseSpeed / 25) : 0; // Reduced from 0.7 and 20
    
    // Reduce mouse velocity more (faster decay for even slower movement)
    mouseVelocityX *= 0.9; // Increased decay from 0.92
    mouseVelocityY *= 0.9; // Increased decay from 0.92
    
    bokehElements.forEach(bokeh => {
        // Natural drift motion (extremely slow undulating movement)
        bokeh.driftPhaseX += bokeh.driftSpeed * timeScale;
        bokeh.driftPhaseY += bokeh.driftSpeed * 1.3 * timeScale;
        
        const driftX = Math.sin(bokeh.driftPhaseX) * bokeh.driftAmplitude;
        const driftY = Math.cos(bokeh.driftPhaseY) * bokeh.driftAmplitude;
        
        // Calculate distance from mouse
        const dx = bokeh.currentX - mouseX;
        const dy = bokeh.currentY - mouseY;
        const distance = Math.sqrt(dx * dx + dy * dy);
        
        // Add mouse influence force - gentle push away from mouse direction
        let forceX = 0;
        let forceY = 0;
        
        if (mousePresent && distance < interactionRadius) {
            // Calculate how close we are to the mouse (0-1)
            const closeness = 1 - Math.min(1, distance / interactionRadius);
            
            // Use the closeness and mouse velocity to create a realistic push effect
            // This creates a gentle "air current" effect as mouse moves
            forceX = mouseVelocityX * closeness * bokeh.responsiveness;
            forceY = mouseVelocityY * closeness * bokeh.responsiveness;
            
            // Add a subtle radial force (push away from cursor)
            const angle = Math.atan2(dy, dx);
            const radialForce = closeness * maxForce * 0.05; // Very subtle
            forceX += Math.cos(angle) * radialForce;
            forceY += Math.sin(angle) * radialForce;
        }
        
        // Add return force toward original position (creates stability)
        const offsetX = bokeh.currentX - bokeh.originalX;
        const offsetY = bokeh.currentY - bokeh.originalY;
        forceX -= offsetX * bokeh.returnForce;
        forceY -= offsetY * bokeh.returnForce;
        
        // Add the drift force
        forceX += driftX;
        forceY += driftY;
        
        // Update velocity using realistic physics
        bokeh.velocityX += forceX / bokeh.mass;
        bokeh.velocityY += forceY / bokeh.mass;
        
        // Apply friction to gradually slow movement
        bokeh.velocityX *= bokeh.friction;
        bokeh.velocityY *= bokeh.friction;
        
        // Update position with the scaled time factor
        bokeh.currentX += bokeh.velocityX * timeScale;
        bokeh.currentY += bokeh.velocityY * timeScale;
        
        // Apply the new position using transform
        const translateX = bokeh.currentX - bokeh.originalX;
        const translateY = bokeh.currentY - bokeh.originalY;
        bokeh.style.transform = `translate3d(${translateX}px, ${translateY}px, 0)`;
        
        // Apply subtle opacity changes based on movement for added realism
        // With more subtle effect for increased transparency
        const movementAmount = Math.sqrt(bokeh.velocityX * bokeh.velocityX + bokeh.velocityY * bokeh.velocityY);
        const baseOpacity = parseFloat(bokeh.style.opacity) || 0.15;
        
        // Make bokeh slightly more visible when moving, but maintain overall transparency
        const dynamicOpacity = Math.max(0.08, Math.min(0.25, baseOpacity + movementAmount * 0.05)); // Reduced multiplier from 0.1
        bokeh.style.opacity = dynamicOpacity.toString();
    });
}

// Smooth animation loop
function animateBokeh(timestamp) {
    updateBokehPositions(timestamp);
    animationFrameId = requestAnimationFrame(animateBokeh);
} */

// Clean up function to remove event listeners (good practice)
/*function cleanupCursorInteraction() {
    if (animationFrameId) {
        cancelAnimationFrame(animationFrameId);
    }
    
    document.removeEventListener('mousemove', handleMouseMove);
    document.removeEventListener('mouseout', handleMouseOut);
    document.removeEventListener('touchmove', handleTouchMove);
    document.removeEventListener('touchend', handleMouseOut);
    window.removeEventListener('resize', handleWindowResize);
}*/

function showAuthNotification(message, type = "success") {
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