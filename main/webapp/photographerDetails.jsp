<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.userMgr.models.User" %>
<%@ page import="com.photographerMgr.models.Photographer" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Photographers</title>
    <link rel="stylesheet" href="assets/main.css">
    <link rel="stylesheet" href="assets/portfolio.css">
    <link rel="stylesheet" href="assets/dashboards.css">
    <link rel="stylesheet" href="assets/photographerDetails.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="background"></div>
    
    <div class="dashboard-container">
        <div class="sidebar glass-card">
            <h2 class="logo"><i class="fas fa-key"></i>Brand</h2>
            <ul class="nav-links">
            	<li><a href="customer-dashboard.jsp"><i class="fas fa-building"></i> Dashboard</a></li>
                <li><a href="#"><i class="fas fa-calendar"></i> My Bookings</a></li>
                <li class="active"><a href="#"><i class="fas fa-camera"></i> Find Photographers</a></li>
                <li><a href="customer_chatList.jsp"><i class="fas fa-comments"></i> Messages</a></li>
                <li><a href="customer.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                <li><a href="customer-settings.jsp"><i class="fas fa-cog"></i> Settings</a></li>
            </ul>
            <div class="sidebar-footer">
                <a href="logoutCustomer.jsp" class="logout-btn btn-animated"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
        
         <% User user = (User)session.getAttribute("user");%>
         <% Photographer photographer = (Photographer)request.getAttribute("selectedPhotographer"); %>
        
        <div class="main-content">
            <header class="glass-card">
                <h1>Find Perfect Photographers</h1>
                <div class="user-info">
                    <div class="notifications">
                        <i class="fas fa-bell"></i>
                        <span class="badge">2</span>
                    </div>
                    <div class="user-avatar">
                    	<% if (user != null) { %>                  		
                    		<img src="displayProfilePicUSER?targetName=<%= user.getUsername() %>" alt="Profile Picture" id="profile-picture">
                        <% } else { %>
		                    <img src="assets/defaults/unknown.gif" alt="Profile Picture" id="profile-picture">
               	        <% } %>
                    
                    </div>
                </div>
            </header>
            
            <div class="content-section glass-card">
            <% if (user != null) { %>
                <div class="photographer-detail-content">
                    <div id="ph_topbar">
					<button type="button" id="edit-profile-btn" class="btn-animated" onclick="window.location.href='findPhotographers.jsp'"><i class="fas fa-arrow-left"></i> Back</button>
					<h4>@<%= photographer.getUsername() %></h4>
                    </div>
                    <br>
                    
                    <div class="photographer-detail-header">
		                <div id="ph_det">
                        <img src="displayProfilePic?targetName=<%= photographer.getUsername() %>" alt="Photographer" class="photographer-profile-img" id="photographer-img">
                        <div class="photographer-header-info">
                            <h4 id="photographer-name"><%= photographer.getFullName() %></h4>
                            <p class="specialty" id="photographer-specialty"><%= photographer.getOriginalSkills() %></p>
                            <div class="rating" id="photographer-rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                                <span>(<%= photographer.getRatings() %> Ratings)</span>
                            </div>
                        </div>
                        </div>
                            <div class="header-actions">
        					<button class="btn-animated small-btn message-btn" onclick="window.location.href='lookupUser?username=<%= photographer.getUsername() %>&email=<%= photographer.getEmail() %>'">
            				<i class="fas fa-envelope"></i> Message
        					</button>
        					<button class="btn-animated small-btn book-now-btn" onclick="document.getElementById('book-photographer-btn').click()">
            				<i class="fas fa-calendar-check"></i> Book Now
        					</button>
    						</div>
                    </div>
                    <div class="photographer-detail-item">
                        <h5>About</h5>
                        <p id="photographer-bio"><%= photographer.getDescription() %></p>
                    </div>
                    <div class="photographer-detail-item">
                        <h5>Location</h5>
                        <p id="photographer-location"><%= photographer.getOriginalAddress() %></p>
                    </div>
                    <div class="photographer-detail-item">
                        <h5>Experience</h5>
                        <p id="photographer-experience"><%= photographer.getExperience() %></p>
                    </div>
                    <div class="photographer-detail-item">
                        <h5>Pricing</h5>
                        <p id="photographer-pricing">Commercial shoots from $1,200. Fashion portfolio sessions start at $600</p>
                    </div>
                    
                    <div id="photographer-gallery">
                        <h4>Portfolio Samples</h4>
                        <div class="sample-images-grid" id="sample-images-container">
                            <!-- Hard-coded sample images - Initial set (reduced to 4)
                            <div class="sample-image">
                                <img src="https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=400" alt="Fashion Editorial" onclick="openImagePreview(0)">
                            </div>
                            <div class="sample-image">
                                <img src="https://images.unsplash.com/photo-1483985988355-763728e1935b?w=400" alt="Street Style" onclick="openImagePreview(1)">
                            </div>
                            <div class="sample-image">
                                <img src="https://images.unsplash.com/photo-1496747611176-843222e1e57c?w=400" alt="Summer Collection" onclick="openImagePreview(2)">
                            </div>
                            <div class="sample-image">
                                <img src="https://images.unsplash.com/photo-1509631179647-0177331693ae?w=400" alt="Urban Fashion" onclick="openImagePreview(3)">
                            </div>
                            <!-- Additional images (initially hidden) - Now includes the 5th photo 
                            <div class="sample-image hidden-sample">
                                <img src="https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=400" alt="Model Portrait" onclick="openImagePreview(4)">
                            </div>
                            <div class="sample-image hidden-sample">
                                <img src="https://images.unsplash.com/photo-1581044777550-4cfa60707c03?w=400" alt="Fashion Week" onclick="openImagePreview(5)">
                            </div>
                            <div class="sample-image hidden-sample">
                                <img src="https://images.unsplash.com/photo-1516726817505-f5ed825624d8?w=400" alt="Studio Portrait" onclick="openImagePreview(6)">
                            </div>
                            <div class="sample-image hidden-sample">
                                <img src="https://images.unsplash.com/photo-1469460340997-2d9a4b8b27a2?w=400" alt="Runway Models" onclick="openImagePreview(7)">
                            </div>
                            <div class="sample-image hidden-sample">
                                <img src="https://images.unsplash.com/photo-1522661067900-ab829854a57f?w=400" alt="Editorial Shoot" onclick="openImagePreview(8)">
                            </div>
                            <div class="sample-image hidden-sample">
                                <img src="https://images.unsplash.com/photo-1492707892479-7bc8d5a4ee93?w=400" alt="Accessories Close-up" onclick="openImagePreview(9)">
                            </div>-->
                        </div>
                        <div class="load-more-container" id="load-more-btn">
                        </div>
                    </div>
                    
                    
                    <!-- Reviews Section (moved after portfolio) -->
                    <div class="reviews-section">
                        <h4>Client Reviews</h4>
                        <div id="reviews-container">
                            <!-- Hard-coded reviews - Page 1 -->
                            <div class="review-card" data-page="1">
                                <div class="review-header">
                                    <div class="reviewer-info">
                                        <img src="https://randomuser.me/api/portraits/men/22.jpg" alt="James Wilson" class="reviewer-avatar">
                                        <span class="reviewer-name">James Wilson</span>
                                    </div>
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                </div>
                                <span class="review-date">March 15, 2023</span>
                                <div class="review-content">
                                    Sophia is amazing! She shot my personal branding photos and they came out perfect. She made me feel comfortable and had great ideas for poses and locations. The final images are stunning.
                                </div>
                                <div class="review-photos">
                                    <img src="https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=200" alt="Review photo 1" class="review-photo">
                                    <img src="https://images.unsplash.com/photo-1483985988355-763728e1935b?w=200" alt="Review photo 2" class="review-photo">
                                </div>
                            </div>
                            
                            <div class="review-card" data-page="1">
                                <div class="review-header">
                                    <div class="reviewer-info">
                                        <img src="https://randomuser.me/api/portraits/women/33.jpg" alt="Emma Clark" class="reviewer-avatar">
                                        <span class="reviewer-name">Emma Clark</span>
                                    </div>
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                    </div>
                                </div>
                                <span class="review-date">February 3, 2023</span>
                                <div class="review-content">
                                    Had a great experience working with Sophia for our company's product photoshoot. Professional, punctual, and delivered excellent results. Would definitely work with her again!
                                </div>
                            </div>
                            
                            <div class="review-card" data-page="1">
                                <div class="review-header">
                                    <div class="reviewer-info">
                                        <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Michael Brown" class="reviewer-avatar">
                                        <span class="reviewer-name">Michael Brown</span>
                                    </div>
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                </div>
                                <span class="review-date">January 17, 2023</span>
                                <div class="review-content">
                                    Sophia shot my portfolio for modeling and the results exceeded my expectations. She has an incredible eye for lighting and composition. Highly recommended for anyone needing fashion photography!
                                </div>
                                <div class="review-photos">
                                    <img src="https://images.unsplash.com/photo-1496747611176-843222e1e57c?w=200" alt="Review photo 3" class="review-photo">
                                </div>
                            </div>
                            
                            <!-- Page 2 reviews (initially hidden) -->
                            <div class="review-card hidden-review" data-page="2">
                                <div class="review-header">
                                    <div class="reviewer-info">
                                        <img src="https://randomuser.me/api/portraits/women/54.jpg" alt="Jessica Thompson" class="reviewer-avatar">
                                        <span class="reviewer-name">Jessica Thompson</span>
                                    </div>
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                    </div>
                                </div>
                                <span class="review-date">December 12, 2022</span>
                                <div class="review-content">
                                    Worked with Sophia on a marketing campaign for our clothing line. Her vision aligned perfectly with our brand identity. The photos were delivered on time and exceeded our expectations.
                                </div>
                                <div class="review-photos">
                                    <img src="https://images.unsplash.com/photo-1509631179647-0177331693ae?w=200" alt="Review photo 4" class="review-photo">
                                </div>
                            </div>
                            
                            <div class="review-card hidden-review" data-page="2">
                                <div class="review-header">
                                    <div class="reviewer-info">
                                        <img src="https://randomuser.me/api/portraits/men/78.jpg" alt="Robert Davis" class="reviewer-avatar">
                                        <span class="reviewer-name">Robert Davis</span>
                                    </div>
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                    </div>
                                </div>
                                <span class="review-date">November 8, 2022</span>
                                <div class="review-content">
                                    Sophia did an excellent job with our e-commerce product photography. She has a keen eye for detail and knows how to showcase products in their best light. Very professional and easy to work with.
                                </div>
                            </div>
                            
                            <div class="review-card hidden-review" data-page="2">
                                <div class="review-header">
                                    <div class="reviewer-info">
                                        <img src="https://randomuser.me/api/portraits/women/28.jpg" alt="Amanda Wilson" class="reviewer-avatar">
                                        <span class="reviewer-name">Amanda Wilson</span>
                                    </div>
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                </div>
                                <span class="review-date">October 22, 2022</span>
                                <div class="review-content">
                                    I hired Sophia for a fashion editorial for my blog, and I couldn't be happier with the results! She understood my vision completely and brought creative ideas to the table. The photos received tons of positive feedback from my audience.
                                </div>
                                <div class="review-photos">
                                    <img src="https://images.unsplash.com/photo-1469460340997-2d9a4b8b27a2?w=200" alt="Review photo 5" class="review-photo">
                                    <img src="https://images.unsplash.com/photo-1522661067900-ab829854a57f?w=200" alt="Review photo 6" class="review-photo">
                                </div>
                            </div>
                            
                            <!-- Page 3 reviews (initially hidden) -->
                            <div class="review-card hidden-review" data-page="3">
                                <div class="review-header">
                                    <div class="reviewer-info">
                                        <img src="https://randomuser.me/api/portraits/men/92.jpg" alt="Thomas Garcia" class="reviewer-avatar">
                                        <span class="reviewer-name">Thomas Garcia</span>
                                    </div>
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                </div>
                                <span class="review-date">September 15, 2022</span>
                                <div class="review-content">
                                    Sophia captured our brand launch event perfectly. She was unobtrusive yet didn't miss a moment. The photos truly captured the energy and excitement of the evening. Will definitely hire again for future events.
                                </div>
                            </div>
                            
                            <div class="review-card hidden-review" data-page="3">
                                <div class="review-header">
                                    <div class="reviewer-info">
                                        <img src="https://randomuser.me/api/portraits/women/42.jpg" alt="Nicole Martinez" class="reviewer-avatar">
                                        <span class="reviewer-name">Nicole Martinez</span>
                                    </div>
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                    </div>
                                </div>
                                <span class="review-date">August 3, 2022</span>
                                <div class="review-content">
                                    As an aspiring model, having a quality portfolio is essential. Sophia understood exactly what I needed and delivered a diverse set of images that have helped me secure several bookings. She's talented, professional, and makes the shooting process enjoyable.
                                </div>
                                <div class="review-photos">
                                    <img src="https://images.unsplash.com/photo-1492707892479-7bc8d5a4ee93?w=200" alt="Review photo 7" class="review-photo">
                                </div>
                            </div>
                            
                            <div class="review-card hidden-review" data-page="3">
                                <div class="review-header">
                                    <div class="reviewer-info">
                                        <img src="https://randomuser.me/api/portraits/men/36.jpg" alt="Kevin Reynolds" class="reviewer-avatar">
                                        <span class="reviewer-name">Kevin Reynolds</span>
                                    </div>
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                    </div>
                                </div>
                                <span class="review-date">July 19, 2022</span>
                                <div class="review-content">
                                    Sophia photographed our new line of accessories and did an outstanding job. She has a great sense of style and knows how to make products look their best. The images are perfect for our online store and marketing materials.
                                </div>
                            </div>
                        </div>
                        <div class="pagination" id="reviews-pagination">
                            <button class="pagination-btn prev" disabled><i class="fas fa-chevron-left"></i></button>
                            <button class="pagination-btn active" data-page="1">1</button>
                            <button class="pagination-btn" data-page="2">2</button>
                            <button class="pagination-btn" data-page="3">3</button>
                            <button class="pagination-btn next"><i class="fas fa-chevron-right"></i></button>
                        </div>
                    </div>
                    
                    <div class="modal-actions">
                        <button class="btn-animated message-btn" id="message-photographer-btn">
                            <i class="fas fa-envelope"></i> Message
                        </button>
                        <button class="btn-animated book-now-btn" id="book-photographer-btn" onclick="window.location.href='customer-packages.jsp?name=<%= photographer.getUsername() %>'">
                            <i class="fas fa-calendar-check"></i> Book Now
                        </button>
                    </div>
                </div>
                
                <!-- Image Preview Modal - Improved version -->
                <div class="modal" id="image-preview-modal">
                    <div class="image-preview-content">
                        <div class="preview-header">
                            <h4 id="preview-title">Image Preview</h4>
                            <span id="preview-counter">1 of 10</span>
                            <button class="close-btn" id="close-preview-modal"><i class="fas fa-times"></i></button>
                        </div>
                        <div class="preview-image-container">
                            <img src="" alt="Preview Image" id="preview-image">
                            <button class="nav-btn large-nav-btn prev-btn" id="prev-image-btn"><i class="fas fa-chevron-left"></i></button>
                            <button class="nav-btn large-nav-btn next-btn" id="next-image-btn"><i class="fas fa-chevron-right"></i></button>
                        </div>
                        <div class="preview-footer">
                            <div class="preview-info">
                                <p id="preview-description"></p>
                            </div>
                            <div class="thumbnail-gallery" id="thumbnail-gallery">
                                <!-- Thumbnails will be dynamically added here -->
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="selctedName" value="<%= photographer.getUsername() %>">
                    <% } else { %>
        			<h1>No user found in session. Please <a class="refLink" href="customer-login.jsp" >login</a>.</h1>
    				<% } %>
                </div>
            </div>
        </div>
    </div>
	<script src="assets/photographerDetails.js"></script>
    <script>

    document.addEventListener('DOMContentLoaded', function() {
        // Generate pagination buttons based on review count
        generatePaginationButtons();
        
        // Show initial page
        showReviewPage(1);
        
        // Set up image preview modal functionality
        setupImagePreviewModal();
        
        // Set up portfolio "Load More" button
        setupLoadMoreButton();
        
        // Debug info
        const reviewCards = document.querySelectorAll('.review-card');
        console.log('Total review cards:', reviewCards.length);
        console.log('Pagination buttons:', document.querySelectorAll('.pagination-btn').length);
    });

    // Function to generate pagination buttons based on review count
    function generatePaginationButtons() {
        const reviewCards = document.querySelectorAll('.review-card');
        const reviewsPerPage = 3; // Adjust as needed
        const totalPages = Math.ceil(reviewCards.length / reviewsPerPage);
        
        // Get the pagination container
        const paginationContainer = document.getElementById('reviews-pagination');
        
        // Clear existing pagination buttons
        paginationContainer.innerHTML = '';
        
        // Add prev button
        const prevButton = document.createElement('button');
        prevButton.classList.add('pagination-btn', 'prev');
        prevButton.disabled = true;
        prevButton.innerHTML = '<i class="fas fa-chevron-left"></i>';
        prevButton.addEventListener('click', function() {
            const currentPage = getCurrentPage();
            if(currentPage > 1) showReviewPage(currentPage - 1);
        });
        paginationContainer.appendChild(prevButton);
        
        // Generate page number buttons
        for (let i = 1; i <= totalPages; i++) {
            const pageButton = document.createElement('button');
            pageButton.classList.add('pagination-btn');
            if (i === 1) pageButton.classList.add('active');
            pageButton.setAttribute('data-page', i);
            pageButton.textContent = i;
            
            // Add click event
            pageButton.addEventListener('click', function() {
                showReviewPage(parseInt(this.getAttribute('data-page')));
            });
            
            paginationContainer.appendChild(pageButton);
        }
        
        // Add next button
        const nextButton = document.createElement('button');
        nextButton.classList.add('pagination-btn', 'next');
        nextButton.disabled = totalPages <= 1;
        nextButton.innerHTML = '<i class="fas fa-chevron-right"></i>';
        nextButton.addEventListener('click', function() {
            const currentPage = getCurrentPage();
            const maxPage = Math.ceil(reviewCards.length / reviewsPerPage);
            if(currentPage < maxPage) showReviewPage(currentPage + 1);
        });
        paginationContainer.appendChild(nextButton);
    }

    function getCurrentPage() {
        const activeBtn = document.querySelector('.pagination-btn.active');
        return activeBtn ? parseInt(activeBtn.getAttribute('data-page')) : 1;
    }

    function showReviewPage(pageNumber) {
        const reviewCards = document.querySelectorAll('.review-card');
        const reviewsPerPage = 3; // Adjust as needed
        const startIdx = (pageNumber - 1) * reviewsPerPage;
        const endIdx = startIdx + reviewsPerPage;
        
        // Hide all reviews
        reviewCards.forEach((card, index) => {
            if (index >= startIdx && index < endIdx) {
                card.classList.remove('hidden-review');
            } else {
                card.classList.add('hidden-review');
            }
        });
        
        // Update active pagination button
        document.querySelectorAll('.pagination-btn').forEach(btn => {
            btn.classList.remove('active');
            if(btn.getAttribute('data-page') == pageNumber) {
                btn.classList.add('active');
            }
        });
        
        // Update prev/next button states
        const prevBtn = document.querySelector('.pagination-btn.prev');
        const nextBtn = document.querySelector('.pagination-btn.next');
        const maxPage = Math.ceil(reviewCards.length / reviewsPerPage);
        
        if(prevBtn) prevBtn.disabled = (pageNumber <= 1);
        if(nextBtn) nextBtn.disabled = (pageNumber >= maxPage);
        
        console.log('Showing review page:', pageNumber);
    }

    // Image Preview Modal Functions
    function setupImagePreviewModal() {
        // Image Preview Modal
        const imagePreviewModal = document.getElementById('image-preview-modal');
        const previewImage = document.getElementById('preview-image');
        const previewTitle = document.getElementById('preview-title');
        const previewCounter = document.getElementById('preview-counter');
        const previewDescription = document.getElementById('preview-description');
        const closePreviewBtn = document.getElementById('close-preview-modal');
        const nextImageBtn = document.getElementById('next-image-btn');
        const prevImageBtn = document.getElementById('prev-image-btn');
        const thumbnailGallery = document.getElementById('thumbnail-gallery');
        
        // Initialize thumbnails
        populateThumbnails();
        
        // Close modal
        closePreviewBtn.addEventListener('click', function() {
            imagePreviewModal.style.display = 'none';
        });
        
        // Navigate between images
        nextImageBtn.addEventListener('click', function() {
            currentImageIndex = (currentImageIndex + 1) % galleryImages.length;
            updatePreviewImage();
        });
        
        prevImageBtn.addEventListener('click', function() {
            currentImageIndex = (currentImageIndex - 1 + galleryImages.length) % galleryImages.length;
            updatePreviewImage();
        });
        
        // Close modal when clicking outside of content
        window.addEventListener('click', function(event) {
            if (event.target === imagePreviewModal) {
                imagePreviewModal.style.display = 'none';
            }
        });
        
        // Function to populate thumbnails
        function populateThumbnails() {
            thumbnailGallery.innerHTML = '';
            galleryImages.forEach((img, index) => {
                const thumbnail = document.createElement('div');
                thumbnail.className = 'thumbnail';
                thumbnail.innerHTML = `<img src="${img.replace('w=800', 'w=100')}" alt="Thumbnail ${index + 1}">`;
                thumbnail.addEventListener('click', function() {
                    currentImageIndex = index;
                    updatePreviewImage();
                });
                thumbnailGallery.appendChild(thumbnail);
            });
        }
    }

    // Function to update preview image
    function updatePreviewImage() {
        const previewImage = document.getElementById('preview-image');
        const previewCounter = document.getElementById('preview-counter');
        const thumbnails = document.querySelectorAll('.thumbnail');
        
        // Update image src
        previewImage.src = galleryImages[currentImageIndex];
        previewCounter.textContent = `${currentImageIndex + 1} of ${galleryImages.length}`;
        
        // Update thumbnail active state
        thumbnails.forEach((thumb, idx) => {
            if (idx === currentImageIndex) {
                thumb.classList.add('active');
            } else {
                thumb.classList.remove('active');
            }
        });
    }

    // Function to open image preview
    function openImagePreview(index) {
        const imagePreviewModal = document.getElementById('image-preview-modal');
        currentImageIndex = index;
        updatePreviewImage();
        imagePreviewModal.style.display = 'flex';
    }

    // Load More Portfolio Images
    function setupLoadMoreButton() {
        const loadMoreBtn = document.getElementById('load-more-btn');
        const hiddenSamples = document.querySelectorAll('.hidden-sample');
        
        loadMoreBtn.addEventListener('click', function() {
            hiddenSamples.forEach(sample => {
                sample.classList.remove('hidden-sample');
            });
            loadMoreBtn.style.display = 'none';
        });
    }

    // Edit Profile
    function handleEditProfile(event) {
        // Add edit profile functionality here
        console.log('Edit profile button clicked');
        alert('Edit profile functionality would open here');
    }


    </script>
</body>
</html>
