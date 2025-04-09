document.addEventListener('DOMContentLoaded', function() {
    console.log('Portfolio script loaded');
    
    // Elements
    const imageGrid = document.querySelector('.image-grid');
    const floatingContainer = document.querySelector('.floating-image-container');
    const floatingImage = document.querySelector('.floating-image');
    const closeFloatingBtn = document.querySelector('.close-floating-btn');
    const profileSection = document.querySelector('.profile-section');
    
    // Open floating image when view button is clicked
    imageGrid.addEventListener('click', function(e) {
        if (e.target.closest('.view-btn')) {
            const imageCard = e.target.closest('.image-card');
            const img = imageCard.querySelector('img');
            
            // Get the full-size image URL (remove size constraints from pexels URL)
            const fullUrl = img.src;
            
            // Set the floating image source
            floatingImage.src = fullUrl;
            
            // Add blur to profile section
            profileSection.classList.add('with-blur');
            
            // Show the floating container
            floatingContainer.style.display = 'block';
        }
    });
    
    // Close floating image when close button is clicked
    closeFloatingBtn.addEventListener('click', function() {
        closeFloatingImage();
    });
    
    // Function to close the floating image
    function closeFloatingImage() {
        floatingContainer.style.display = 'none';
        
        // Remove blur from profile section
        profileSection.classList.remove('with-blur');
    }
    

    
    // Handle ESC key to close floating image
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && floatingContainer.style.display === 'block') {
            closeFloatingImage();
        }
    });
    
    console.log('Image floating functionality initialized');
});