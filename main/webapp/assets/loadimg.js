window.onload = function() {
            fetchImages();
        };
		
		i = 0;
        
        function fetchImages() {
            fetch('upload?action=list')
                .then(response => response.json())
                .then(data => {
                    const imageContainer = document.getElementById('image-grid');
                    imageContainer.innerHTML = '';
                    
                    if (data.length === 0) {
                        imageContainer.innerHTML = '<p>No images uploaded yet.</p>';
                        return;
                    }
                    
                    data.forEach(image => {
                        const card = document.createElement('div');
                        card.className = 'image-card';
                        
                        
                        const img = document.createElement('img');
                        img.src = 'view?file=' + image.fileName;
                        img.alt = image.title;
						
						const controls = document.createElement('div');
						controls.className = 'image-controls';
						controls.innerHTML = `
						<button type="button" class="view-btn">
							<i class="fas fa-eye"></i> View
						</button>
						<form action="delete" method="post">
						    <input type="hidden" name="file" value="`+ image.fileName + `">
						    <button type="submit" class="delete-btn">
						        <i class="fas fa-trash"></i> Delete
						    </button>
						 </form>`
						
						const viewButton = document.createElement('button');
						viewButton.className = 'view-btn';
                        viewButton.innerText = '<i class="fas fa-eye"></i> View';
						viewButton.type = 'button';
						
						const delButton = document.createElement('button');
                        delButton.innerText = '<i class="fas fa-trash"></i> Delete';
						
                        card.appendChild(img);
						card.appendChild(controls);

                        
                        imageContainer.appendChild(card);
						
						i++;
                    });
                })
                .catch(error => {
                    console.error('Error fetching images:', error);
                    document.getElementById('image-container').innerHTML = 
                        '<p>Error loading images. Please try again later.</p>';
                });
        }