
	
// DOM elements
const photographersContainer = document.getElementById('photographers-container');
const photographerModal = document.getElementById('photographer-details-modal');
const closeDetailsBtn = document.getElementById('close-details-modal');
const bookPhotographerBtn = document.getElementById('book-photographer-btn');
const messagePhotographerBtn = document.getElementById('message-photographer-btn');
const photographerSearch = document.getElementById('photographer-search');
const ratingFilter = document.getElementById('filter-by');
const imagePreviewModal = document.getElementById('image-preview-modal');
const closePreviewBtn = document.getElementById('close-preview-modal');
const previewImage = document.getElementById('preview-image');
const prevImageBtn = document.getElementById('prev-image-btn');
const nextImageBtn = document.getElementById('next-image-btn');


let currentPhotographer;
let currentImageIndex = 0;



document.addEventListener('DOMContentLoaded', () => {
	const contextPath = window.location.pathname.substring(0, 
		        window.location.pathname.indexOf('/', 2) === -1 ? 
		        window.location.pathname.length : 
		        window.location.pathname.indexOf('/', 2));

		    // Fetch photographer data from the servlet
		    fetchData("default");
   
});

ratingFilter.addEventListener('change', () => {
	const slectedRating = ratingFilter.value;
	fetchData(slectedRating);
});
	


function fetchData(filter) {
    const contextPath = window.location.pathname.substring(0, 
        window.location.pathname.indexOf('/', 2) === -1 ? 
        window.location.pathname.length : 
        window.location.pathname.indexOf('/', 2));
		
	const requestData = {
		rating: filter
	};
        
    fetch(contextPath + '/showPhotographers', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
		body: JSON.stringify(requestData)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok: ' + response.statusText);
        }
        return response.json();
    })
    .then(data => {
        const photographers = listPhotographers(data);
        displayPhotographers(photographers);
        setupEventListeners(photographers);
    })
    .catch(error => {
        console.error('Error fetching photographers:', error);
    });
}

function listPhotographers(photographers) {
	const photographersList = [];
	
	var i = 0;
	
	if (photographers && photographers.length > 0) {
	        photographers.forEach(photographer => {
				const ptgDetails = 	{
				        id: ++i,
				        name: photographer.fullName,
						username: photographer.username,
						email: photographer.email,
				        profileImage: "displayProfilePic?targetName="+photographer.username,
				        specialty: photographer.originalSkills,
				        rating: photographer.ratings,
				        reviewCount: photographer.ratings,
				        bio:photographer.description,
				        location: photographer.originalAddress,
				        experience: photographer.experience,
				        pricing: photographer.email,
				        portfolioImages: [
				            { url: "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f", caption: "Fashion Editorial" },
				            { url: "https://images.unsplash.com/photo-1483985988355-763728e1935b", caption: "Street Style" },
				            { url: "https://images.unsplash.com/photo-1496747611176-843222e1e57c", caption: "Summer Collection" },
				            { url: "https://images.unsplash.com/photo-1509631179647-0177331693ae", caption: "Urban Fashion" },
				            { url: "https://images.unsplash.com/photo-1469334031218-e382a71b716b", caption: "Model Portrait" }
				        ]
				}
			
			photographersList.push(ptgDetails);		
					
		});
	}
	
	return photographersList;
};
	

// Display photographers cards
function displayPhotographers(photographersArray) {
    photographersContainer.innerHTML = '';
    
    if (photographersArray.length === 0) {
        photographersContainer.innerHTML = `
            <div class="no-results">
                <i class="fas fa-search"></i>
                <h3>No photographers found</h3>
                <p>Try adjusting your search criteria</p>
            </div>
        `;
        return;
    }
    
    photographersArray.forEach(photographer => {
        let starsHTML = '';
        for (let i = 0; i < 5; i++) {
            if (i < Math.floor(photographer.rating)) {
                starsHTML += '<i class="fas fa-star"></i>';
            } else if (i === Math.floor(photographer.rating) && photographer.rating % 1 !== 0) {
                starsHTML += '<i class="fas fa-star-half-alt"></i>';
            } else {
                starsHTML += '<i class="far fa-star"></i>';
            }
        }
        
        const photographerCard = document.createElement('div');
        photographerCard.className = 'photographer-card glass-card';
        photographerCard.innerHTML = `
            <div class="photographer-img">
                <img src="${photographer.profileImage}" alt="${photographer.username}">
            </div>
            <div class="photographer-info">
                <h3>${photographer.name}</h3>
                <p>${photographer.specialty}</p>
                <div class="rating">
                    ${starsHTML}
                    <span>(${photographer.reviewCount} reviews)</span>
                </div>
                <button class="btn-animated view-details" data-id="${photographer.id}">
                    <i class="fas fa-info-circle"></i> View Details
                </button>
                <div class="button-group">
                    <button class="btn-animated message-btn" data-id="${photographer.id}" onclick="window.location.href='lookupUser?username=${photographer.username}&email=${photographer.email}'">
                        <i class="fas fa-envelope"></i> Message
                    </button>
                    <button class="btn-animated book-now-btn" data-id="${photographer.email}">
                        <i class="fas fa-calendar-check"></i> Book Now
                    </button>
                </div>
            </div>
        `;
        
        photographersContainer.appendChild(photographerCard);
    });
}


function setupEventListeners(photographers) {
    photographersContainer.addEventListener('click', (e) => {
        // View details button
        if (e.target.classList.contains('view-details') || 
            e.target.parentElement.classList.contains('view-details')) {
            window.location.href="PhotographerData?targetName="+photographers[e.target.dataset.id-1].username;
        }
        
        // Book now button
        if (e.target.classList.contains('book-now-btn') || 
            e.target.parentElement.classList.contains('book-now-btn')) {
            const button = e.target.closest('.book-now-btn');
            const photographerId = parseInt(button.dataset.id);
            handleBooking(photographerId, photographers);
        }
        
        // Message button
        if (e.target.classList.contains('message-btn') || 
            e.target.parentElement.classList.contains('message-btn')) {
            const button = e.target.closest('.message-btn');
            const photographerId = parseString(button.dataset.id);
            handleMessage(photographerId, photographers);
        }
    });
    
    // Close modal
    
    // Search and filter
    photographerSearch.addEventListener('input', filterPhotographers(photographers));
    specialtyFilter.addEventListener('change', filterPhotographers(photographers));
    ratingFilter.addEventListener('change', filterPhotographers(photographers));
    
   
}

// Open photographer details modal
function openPhotographerDetails(photographerId, photographers) {
    const contentSection = document.querySelector('.content-section');
    contentSection.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    disableScrolling(); // Disable scrolling when modal opens
    currentPhotographer = photographers.find(p => p.id === photographerId);
    if (!currentPhotographer) return;
    
    // Set photographer details in modal
    document.getElementById('modal-photographer-img').src = currentPhotographer.profileImage;
    document.getElementById('modal-photographer-name').textContent = currentPhotographer.name;
    document.getElementById('modal-photographer-specialty').textContent = currentPhotographer.specialty;
    document.getElementById('modal-photographer-bio').textContent = currentPhotographer.bio;
    document.getElementById('modal-photographer-location').textContent = currentPhotographer.location;
    document.getElementById('modal-photographer-experience').textContent = currentPhotographer.experience;
    document.getElementById('modal-photographer-pricing').textContent = currentPhotographer.pricing;
    
    // Create rating stars
    let ratingHTML = '';
    for (let i = 0; i < 5; i++) {
        if (i < Math.floor(currentPhotographer.rating)) {
            ratingHTML += '<i class="fas fa-star"></i>';
        } else if (i === Math.floor(currentPhotographer.rating) && currentPhotographer.rating % 1 !== 0) {
            ratingHTML += '<i class="fas fa-star-half-alt"></i>';
        } else {
            ratingHTML += '<i class="far fa-star"></i>';
        }
    }
    ratingHTML += `<span>(${currentPhotographer.rating} - ${currentPhotographer.reviewCount} reviews)</span>`;
    document.getElementById('modal-photographer-rating').innerHTML = ratingHTML;
    
    // Add portfolio samples
    const sampleImagesContainer = document.getElementById('sample-images-container');
    sampleImagesContainer.innerHTML = '';
    
    currentPhotographer.portfolioImages.forEach((image, index) => {
        const sampleImage = document.createElement('div');
        sampleImage.className = 'sample-image';
        sampleImage.dataset.index = index;
        sampleImage.innerHTML = `
            <img src="${image.url}" alt="${image.caption}">
            <div class="image-overlay">
                <h5>${image.caption}</h5>
            </div>
        `;
        
        sampleImage.addEventListener('click', () => {
            openImagePreview(index);
        });
        
        sampleImagesContainer.appendChild(sampleImage);
    });
    
    // Show modal
    photographerModal.classList.add('active');
}

// Open image preview modal
function openImagePreview(index) {
    disableScrolling(); // Disable scrolling when image preview opens
    currentImageIndex = index;
    updatePreviewImage();
    imagePreviewModal.classList.add('active');
}

// Update the preview image
function updatePreviewImage() {
    const image = currentPhotographer.portfolioImages[currentImageIndex];
    previewImage.src = image.url;
    previewImage.alt = image.caption;
}

// Show next image in preview
function showNextImage() {
    currentImageIndex = (currentImageIndex + 1) % currentPhotographer.portfolioImages.length;
    updatePreviewImage();
}

// Show previous image in preview
function showPreviousImage() {
    currentImageIndex = (currentImageIndex - 1 + currentPhotographer.portfolioImages.length) % currentPhotographer.portfolioImages.length;
    updatePreviewImage();
}

// Handle booking functionality
function handleBooking(photographerId, photographers) {
    const photographer = photographers.find(p => p.id === photographerId);
    if (photographer) {
        // For demo purposes, just redirect to a booking page
        // In a real application, you could open a booking form modal or redirect to a booking page
        alert(`You're about to book ${photographer.name}. In a real application, this would take you to a booking form.`);
        // window.location.href = `booking.html?photographer=${photographerId}`;
    }
}

// Handle messaging functionality
function handleMessage(photographerId, photographers) {
    const photographer = photographers.find(p => p.id === photographerId);
    if (photographer) {
        // For demo purposes, just show an alert
        // In a real application, you could open a chat modal or redirect to a messaging page
        window.location.href = `customer_chatList.jsp?chatModer=direct&name=${photographer.username}`;
    }
}

// Filter photographers based on search and filter criteria
function filterPhotographers(photographers) {
    const searchTerm = photographerSearch.value.toLowerCase();
    const selectedSpecialty = specialtyFilter.value.toLowerCase();
    const selectedRating = parseFloat(ratingFilter.value) || 0;
    
    const filteredPhotographers = photographers.filter(photographer => {
        // Search term filter
        const matchesSearch = 
            photographer.name.toLowerCase().includes(searchTerm) || 
            photographer.specialty.toLowerCase().includes(searchTerm) || 
            photographer.location.toLowerCase().includes(searchTerm);
        
        // Specialty filter
        const matchesSpecialty = selectedSpecialty === '' || 
            photographer.specialty.toLowerCase().includes(selectedSpecialty);
        
        // Rating filter
        const matchesRating = photographer.rating >= selectedRating;
        
        return matchesSearch && matchesSpecialty && matchesRating;
    });
    
    displayPhotographers(filteredPhotographers);
}

// Function to disable scrolling
function disableScrolling() {
    const contentSection = document.querySelector('.content-section');
    contentSection.classList.add('no-scroll');
}

// Function to enable scrolling
function enableScrolling() {
    const contentSection = document.querySelector('.content-section');
    contentSection.classList.remove('no-scroll');
}
