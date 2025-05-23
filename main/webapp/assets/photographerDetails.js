window.onload = function() {
			const selectedName = document.getElementById("selctedName").value;
            fetchImages(selectedName);
        };
		
		i = 0;
        
        function fetchImages(selectedName) {
            fetch('upload?action=target&targetName=' + selectedName)
                .then(response => response.json())
                .then(data => {
					const moreButton = document.getElementById('load-more-btn');
                    const imageContainer = document.getElementById('sample-images-container');
                    imageContainer.innerHTML = '';
                    
                    if (data.length === 0) {
                        imageContainer.innerHTML = '<p>No images uploaded yet.</p>';
                        return;
                    }
					
					if (data.length > 4) {
						moreButton.innerHTML= `
						<button class="btn-animated load-more-btn" id="load-more-btn">
							<i class="fas fa-plus"></i> Load More
						</button>`;
						}
                    
                    data.forEach(image => {
                        const card = document.createElement('div');
						
						if(i > 4) {
                        	card.classList.add('sample-image', 'hidden');					
						} else {
							card.classList.add('sample-image');						
						}
						

                        
                        const img = document.createElement('img');
                        img.src = 'view?file=' + image.fileName + '&action=target&targetName=' + selectedName;
                        img.alt = image.title;

                        card.appendChild(img);

                        imageContainer.appendChild(card);
						
						i++;
                    });
					
					
                })
                .catch(error => {
                    console.error('Error fetching images:', error);
                    document.getElementById('sample-images-container').innerHTML = 
                        '<p>Error loading images. Please try again later.</p>';

                });
        }