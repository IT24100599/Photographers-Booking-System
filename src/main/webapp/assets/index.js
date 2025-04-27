// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', () => {
    // Initialize page loading animation
    const loader = document.querySelector('.loader');
    
    setTimeout(() => {
        loader.classList.add('hidden');
        // Enable scrolling after loader is hidden
        document.body.style.overflow = 'visible';
    }, 2000);

    // Navigation menu functionality
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');
    const authButtons = document.querySelector('.auth-buttons');
    const navItems = document.querySelectorAll('.nav-links a');
    
    hamburger.addEventListener('click', () => {
        navLinks.classList.toggle('active');
        authButtons.classList.toggle('active');
        hamburger.classList.toggle('active');
    });
    
    // Close mobile menu when clicking on a nav item
    navItems.forEach(item => {
        item.addEventListener('click', () => {
            navLinks.classList.remove('active');
            authButtons.classList.remove('active');
            hamburger.classList.remove('active');
        });
    });

    // Navigation active state on scroll
    const sections = document.querySelectorAll('section');
    const header = document.querySelector('header');
    
    window.addEventListener('scroll', () => {
        // Add or remove 'scrolled' class to header
        if (window.scrollY > 100) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
        
        // Update active menu item based on scroll position
        let current = '';
        
        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;
            
            if (window.scrollY >= (sectionTop - sectionHeight/3)) {
                current = section.getAttribute('id');
            }
        });
        
        navItems.forEach(item => {
            item.classList.remove('active');
            if (item.getAttribute('href').substring(1) === current) {
                item.classList.add('active');
            }
        });
    });

    // Parallax effect
    const parallaxBgs = document.querySelectorAll('.parallax-bg');
    
    window.addEventListener('scroll', () => {
        let scrollPosition = window.pageYOffset;
        
        parallaxBgs.forEach(bg => {
            const parent = bg.parentElement;
            const parentTop = parent.offsetTop;
            const parentHeight = parent.offsetHeight;
            
            // Only apply parallax if the section is in view
            if (scrollPosition + window.innerHeight > parentTop && 
                scrollPosition < parentTop + parentHeight) {
                // Calculate parallax offset - slower scrolling for background
                const speed = 0.5;
                const yPos = (scrollPosition - parentTop) * speed;
                
                bg.style.transform = `translateY(${yPos}px)`;
            }
        });
    });

    // Portfolio filter functionality
    const filterBtns = document.querySelectorAll('.filter-btn');
    const portfolioItems = document.querySelectorAll('.portfolio-item');
    
    filterBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            // Remove active class from all buttons
            filterBtns.forEach(b => b.classList.remove('active'));
            // Add active class to clicked button
            btn.classList.add('active');
            
            const filterValue = btn.getAttribute('data-filter');
            
            // Filter the portfolio items
            portfolioItems.forEach(item => {
                if (filterValue === 'all' || item.getAttribute('data-category') === filterValue) {
                    item.style.display = 'block';
                    setTimeout(() => {
                        item.style.opacity = '1';
                        item.style.transform = 'scale(0.98)';
                    }, 100);
                } else {
                    item.style.opacity = '0';
                    item.style.transform = 'scale(0.8)';
                    setTimeout(() => {
                        item.style.display = 'none';
                    }, 300);
                }
            });
        });
    });

    // Testimonial slider functionality
    const testimonials = document.querySelectorAll('.testimonial');
    const dots = document.querySelectorAll('.dot');
    const prevBtn = document.querySelector('.prev-btn');
    const nextBtn = document.querySelector('.next-btn');
    let currentTestimonial = 0;
    
    // Function to show a specific testimonial
    function showTestimonial(index) {
        testimonials.forEach(testimonial => {
            testimonial.classList.remove('active');
        });
        
        dots.forEach(dot => {
            dot.classList.remove('active');
        });
        
        testimonials[index].classList.add('active');
        dots[index].classList.add('active');
    }
    
    // Initialize testimonial slider
    showTestimonial(currentTestimonial);
    
    // Event listeners for navigation buttons
    nextBtn.addEventListener('click', () => {
        currentTestimonial++;
        if (currentTestimonial >= testimonials.length) {
            currentTestimonial = 0;
        }
        showTestimonial(currentTestimonial);
    });
    
    prevBtn.addEventListener('click', () => {
        currentTestimonial--;
        if (currentTestimonial < 0) {
            currentTestimonial = testimonials.length - 1;
        }
        showTestimonial(currentTestimonial);
    });
    
    // Event listeners for dots
    dots.forEach((dot, index) => {
        dot.addEventListener('click', () => {
            showTestimonial(index);
            currentTestimonial = index;
        });
    });
    
    // Auto-advance testimonials
    let testimonialInterval = setInterval(() => {
        currentTestimonial++;
        if (currentTestimonial >= testimonials.length) {
            currentTestimonial = 0;
        }
        showTestimonial(currentTestimonial);
    }, 5000);
    
    // Pause auto-advance on hover
    const testimonialSlider = document.querySelector('.testimonial-slider');
    testimonialSlider.addEventListener('mouseenter', () => {
        clearInterval(testimonialInterval);
    });
    
    testimonialSlider.addEventListener('mouseleave', () => {
        testimonialInterval = setInterval(() => {
            currentTestimonial++;
            if (currentTestimonial >= testimonials.length) {
                currentTestimonial = 0;
            }
            showTestimonial(currentTestimonial);
        }, 5000);
    });

    // Animate elements when they come into view
    const animateOnScroll = () => {
        const elements = document.querySelectorAll('.section-header, .portfolio-item, .glass-card, .photographer-card');
        
        elements.forEach(element => {
            const elementPosition = element.getBoundingClientRect().top;
            const screenPosition = window.innerHeight * 0.85;
            
            if (elementPosition < screenPosition) {
                element.classList.add('fadeIn');
                element.style.opacity = '1';
                element.style.transform = element.classList.contains('portfolio-item') ? 'scale(0.98)' : 'translateY(0)';
            }
        });
    };
    
    // Add initial styles for scroll animations
    const setupAnimations = () => {
        const elements = document.querySelectorAll('.section-header, .portfolio-item, .glass-card, .photographer-card');
        
        elements.forEach(element => {// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', () => {
    // Initialize page loading animation
    const loader = document.querySelector('.loader');
    
    setTimeout(() => {
        loader.classList.add('hidden');
        // Enable scrolling after loader is hidden
        document.body.style.overflow = 'visible';
    }, 2500);

    // Navigation menu functionality
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');
    const authButtons = document.querySelector('.auth-buttons');
    const navItems = document.querySelectorAll('.nav-links a');
    
    hamburger.addEventListener('click', () => {
        navLinks.classList.toggle('active');
        authButtons.classList.toggle('active');
        hamburger.classList.toggle('active');
    });
    
    // Close mobile menu when clicking on a nav item
    navItems.forEach(item => {
        item.addEventListener('click', () => {
            navLinks.classList.remove('active');
            authButtons.classList.remove('active');
            hamburger.classList.remove('active');
        });
    });

    // Navigation active state on scroll
    const sections = document.querySelectorAll('section');
    const header = document.querySelector('header');
    
    window.addEventListener('scroll', () => {
        // Add or remove 'scrolled' class to header
        if (window.scrollY > 100) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
        
        // Update active menu item based on scroll position
        let current = '';
        
        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;
            
            if (window.scrollY >= (sectionTop - sectionHeight/3)) {
                current = section.getAttribute('id');
            }
        });
        
        navItems.forEach(item => {
            item.classList.remove('active');
            if (item.getAttribute('href').substring(1) === current) {
                item.classList.add('active');
            }
        });
    });

    // Enhanced Parallax Effects
    const handleParallax = () => {
        // Background parallax
        const parallaxBgs = document.querySelectorAll('.parallax-bg');
        let scrollPosition = window.pageYOffset;
        
        parallaxBgs.forEach(bg => {
            const parent = bg.parentElement;
            const parentTop = parent.offsetTop;
            const parentHeight = parent.offsetHeight;
            
            // Only apply parallax if the section is in view
            if (scrollPosition + window.innerHeight > parentTop && 
                scrollPosition < parentTop + parentHeight) {
                // Calculate parallax offset - slower scrolling for background
                const speed = 0.4;
                const yPos = (scrollPosition - parentTop) * speed;
                
                bg.style.transform = `translateY(${yPos}px)`;
            }
        });

        // Individual element parallax
        const parallaxItems = document.querySelectorAll('.parallax-item');
        
        parallaxItems.forEach(item => {
            const section = item.closest('section');
            const sectionTop = section.offsetTop;
            const itemOffsetTop = item.offsetTop;
            const scrollRelative = (scrollPosition - sectionTop + window.innerHeight);
            
            if (scrollPosition + window.innerHeight > sectionTop) {
                const speed = parseFloat(item.getAttribute('data-speed') || 0.1);
                const yPos = (scrollRelative - itemOffsetTop) * speed;
                
                // Apply transform with limited range to avoid excessive movement
                const limitedYPos = Math.max(-50, Math.min(50, yPos));
                item.style.transform = `translateY(${limitedYPos}px)`;
            }
        });
    };
    
    // Initialize parallax and add scroll event listener
    handleParallax();
    window.addEventListener('scroll', handleParallax);
    window.addEventListener('resize', handleParallax);

    // Portfolio filter functionality with smooth transitions
    const filterBtns = document.querySelectorAll('.filter-btn');
    const portfolioItems = document.querySelectorAll('.portfolio-item');
    
    filterBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            // Remove active class from all buttons
            filterBtns.forEach(b => b.classList.remove('active'));
            // Add active class to clicked button
            btn.classList.add('active');
            
            const filterValue = btn.getAttribute('data-filter');
            
            // Filter the portfolio items with staggered animation
            portfolioItems.forEach((item, index) => {
                const delay = index * 100; // Stagger effect
                
                if (filterValue === 'all' || item.getAttribute('data-category') === filterValue) {
                    setTimeout(() => {
                        item.style.display = 'block';
                        setTimeout(() => {
                            item.style.opacity = '1';
                            item.style.transform = 'translateY(0) scale(0.98)';
                        }, 50);
                    }, delay);
                } else {
                    item.style.opacity = '0';
                    item.style.transform = 'translateY(20px) scale(0.9)';
                    setTimeout(() => {
                        item.style.display = 'none';
                    }, 400);
                }
            });
        });
    });

    // Improved Testimonial slider functionality
    const testimonials = document.querySelectorAll('.testimonial');
    const dots = document.querySelectorAll('.dot');
    const prevBtn = document.querySelector('.prev-btn');
    const nextBtn = document.querySelector('.next-btn');
    let currentTestimonial = 0;
    let isAnimating = false;
    
    // Function to show a specific testimonial with smoother transition
    function showTestimonial(index, direction = 1) {
        if (isAnimating) return;
        isAnimating = true;
        
        // Prepare the new testimonial
        const nextTestimonial = testimonials[index];
        const currentActive = document.querySelector('.testimonial.active');
        
        // Set initial position for the next testimonial
        nextTestimonial.style.transform = `translateX(${direction * 60}px)`;
        nextTestimonial.style.opacity = '0';
        nextTestimonial.style.visibility = 'visible';
        
        // Animate current testimonial out
        currentActive.style.transform = `translateX(${direction * -60}px)`;
        currentActive.style.opacity = '0';
        
        // Update dots
        dots.forEach(dot => dot.classList.remove('active'));
        dots[index].classList.add('active');
        
        // After a short delay, complete the animation
        setTimeout(() => {
            // Remove active class from all testimonials
            testimonials.forEach(testimonial => {
                testimonial.classList.remove('active');
                if (testimonial !== nextTestimonial && testimonial !== currentActive) {
                    testimonial.style.visibility = 'hidden';
                }
            });
            
            // Animate the next testimonial in
            nextTestimonial.classList.add('active');
            nextTestimonial.style.transform = 'translateX(0)';
            nextTestimonial.style.opacity = '1';
            
            setTimeout(() => {
                isAnimating = false;
            }, 300);
            
        }, 300);
    }
    
    // Initialize testimonial slider
    showTestimonial(currentTestimonial, 1);
    
    // Event listeners for navigation buttons
    nextBtn.addEventListener('click', () => {
        if (isAnimating) return;
        
        currentTestimonial++;
        if (currentTestimonial >= testimonials.length) {
            currentTestimonial = 0;
        }
        showTestimonial(currentTestimonial, 1);
    });
    
    prevBtn.addEventListener('click', () => {
        if (isAnimating) return;
        
        currentTestimonial--;
        if (currentTestimonial < 0) {
            currentTestimonial = testimonials.length - 1;
        }
        showTestimonial(currentTestimonial, -1);
    });
    
    // Event listeners for dots
    dots.forEach((dot, index) => {
        dot.addEventListener('click', () => {
            if (isAnimating || currentTestimonial === index) return;
            
            const direction = index > currentTestimonial ? 1 : -1;
            showTestimonial(index, direction);
            currentTestimonial = index;
        });
    });
    
    // Auto-advance testimonials
    let testimonialInterval = setInterval(() => {
        if (!isAnimating) {
            currentTestimonial++;
            if (currentTestimonial >= testimonials.length) {
                currentTestimonial = 0;
            }
            showTestimonial(currentTestimonial, 1);
        }
    }, 6000);
    
    // Pause auto-advance on hover
    const testimonialSlider = document.querySelector('.testimonial-slider');
    testimonialSlider.addEventListener('mouseenter', () => {
        clearInterval(testimonialInterval);
    });
    
    testimonialSlider.addEventListener('mouseleave', () => {
        testimonialInterval = setInterval(() => {
            if (!isAnimating) {
                currentTestimonial++;
                if (currentTestimonial >= testimonials.length) {
                    currentTestimonial = 0;
                }
                showTestimonial(currentTestimonial, 1);
            }
        }, 6000);
    });

    // Enhanced animations for elements when they come into view
    const animateOnScroll = () => {
        // Intersection Observer options
        const options = {
            root: null,
            rootMargin: '0px',
            threshold: 0.15
        };
        
        const handleIntersect = (entries, observer) => {
            entries.forEach((entry, index) => {
                if (entry.isIntersecting) {
                    const delay = index % 3 * 150; // Stagger animation by row
                    setTimeout(() => {
                        entry.target.classList.add('fadeIn');
                    }, delay);
                    observer.unobserve(entry.target);
                }
            });
        };
        
        const observer = new IntersectionObserver(handleIntersect, options);
        
        // Observe portfolio items
        document.querySelectorAll('.portfolio-item').forEach(item => {
            observer.observe(item);
        });
        
        // Observe photographer cards
        document.querySelectorAll('.photographer-card').forEach(card => {
            observer.observe(card);
        });
        
        // Observe glass cards with natural staggering
        document.querySelectorAll('.glass-card').forEach((card, index) => {
            if (!card.closest('.portfolio-item') && !card.closest('.photographer-card')) {
                observer.observe(card);
            }
        });
    };
    
    // Initialize animations
    animateOnScroll();

    // Smooth cursor effects for interactive elements
    const cursorEffect = () => {
        const interactiveElements = document.querySelectorAll('a, button, .glass-card');
        
        interactiveElements.forEach(element => {
            element.addEventListener('mouseenter', () => {
                element.style.transition = 'transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1)';
                if (element.classList.contains('glass-card') && 
                    !element.closest('.portfolio-item') && 
                    !element.closest('.testimonial-slider')) {
                    element.style.transform = 'scale(1.02)';
                }
            });
            
            element.addEventListener('mouseleave', () => {
                element.style.transition = 'transform 0.5s cubic-bezier(0.165, 0.84, 0.44, 1)';
                if (element.classList.contains('glass-card') && 
                    !element.closest('.portfolio-item') && 
                    !element.closest('.testimonial-slider')) {
                    element.style.transform = 'scale(1)';
                }
            });
        });
    };
    
    cursorEffect();

    // Form submission handling with animation
    const contactForm = document.querySelector('.contact-form form');
    
    if (contactForm) {
        contactForm.addEventListener('submit', (e) => {
            e.preventDefault();
            
            // Get form elements
            const submitBtn = contactForm.querySelector('.submit-btn');
            const formGroups = contactForm.querySelectorAll('.form-group');
            const name = document.getElementById('name').value;
            
            // Simple form validation
            let isValid = true;
            formGroups.forEach(group => {
                const input = group.querySelector('input, textarea, select');
                if (input.hasAttribute('required') && !input.value.trim()) {
                    isValid = false;
                    input.classList.add('error');
                    
                    input.addEventListener('input', () => {
                        input.classList.remove('error');
                    }, { once: true });
                }
            });
            
            if (isValid) {
                // Animate button and show success
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                submitBtn.disabled = true;
                
                setTimeout(() => {
                    // Simulate successful form submission
                    submitBtn.innerHTML = '<i class="fas fa-check"></i> Sent';
                    submitBtn.style.backgroundColor = '#28a745';
                    
                    // Add success animation to form
                    contactForm.classList.add('submitted');
                    
                    // Reset form after delay
                    setTimeout(() => {
                        contactForm.reset();
                        submitBtn.innerHTML = 'Send Message';
                        submitBtn.style.backgroundColor = '';
                        submitBtn.disabled = false;
                        contactForm.classList.remove('submitted');
                        
                        // Show success message
                        alert(`Thank you, ${name}! Your message has been sent. We'll get back to you soon.`);
                    }, 1500);
                }, 1500);
            } else {
                alert('Please fill in all required fields.');
            }
        });
    }

    // Dynamic floating shapes animation
    const createFloatingElements = () => {
        const floatingShapes = document.querySelector('.floating-shapes');
        if (!floatingShapes) return;
        
        // Add additional dynamic shapes
        for (let i = 0; i < 5; i++) {
            const shape = document.createElement('div');
            shape.className = 'shape dynamic-shape';
            
            // Random size between 20px and 80px
            const size = Math.random() * 60 + 20;
            shape.style.width = `${size}px`;
            shape.style.height = `${size}px`;
            
            // Random position
            shape.style.top = `${Math.random() * 100}%`;
            shape.style.left = `${Math.random() * 100}%`;
            
            // Random color gradient
            const hue1 = Math.floor(Math.random() * 60) + 240; // Blues and purples
            const hue2 = Math.floor(Math.random() * 60) + 180; // Blues and cyans
            shape.style.background = `linear-gradient(${Math.random() * 360}deg, hsl(${hue1}, 70%, 50%), hsl(${hue2}, 70%, 60%))`;
            
            // Random animation duration
            const duration = Math.random() * 20 + 15;
            shape.style.animation = `floating ${duration}s infinite cubic-bezier(0.47, 0, 0.745, 0.715) ${Math.random() * 5}s`;
            
            // Add to DOM
            floatingShapes.appendChild(shape);
        }
    };
    
    createFloatingElements();

    // Explore button scroll to portfolio section with emphasis animation
    const exploreBtn = document.querySelector('.cta-button');
    
    if (exploreBtn) {
        exploreBtn.addEventListener('click', () => {
            const portfolioSection = document.getElementById('samples');
            
            // Add emphasis animation to section header
            const sectionHeader = portfolioSection.querySelector('.section-header');
            sectionHeader.classList.add('emphasis');
            
            // Smooth scroll to section
            portfolioSection.scrollIntoView({ 
                behavior: 'smooth',
                block: 'start'
            });
            
            // Remove emphasis class after animation completes
            setTimeout(() => {
                sectionHeader.classList.remove('emphasis');
            }, 2000);
        });
    }
    
    // Add CSS for error state and form submission animation
    const style = document.createElement('style');
    style.textContent = `
        .error {
            border-color: #ff4136 !important;
            box-shadow: 0 0 0 2px rgba(255, 65, 54, 0.2) !important;
        }
        
        .submitted .form-group {
            animation: formSuccess 0.5s forwards;
        }
        
        @keyframes formSuccess {
            0% { transform: translateX(0); }
            20% { transform: translateX(-10px); }
            40% { transform: translateX(10px); }
            60% { transform: translateX(-5px); }
            80% { transform: translateX(5px); }
            100% { transform: translateX(0); }
        }
        
        .emphasis {
            animation: emphasis 2s;
        }
        
        @keyframes emphasis {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        .dynamic-shape {
            position: absolute;
            border-radius: 50%;
            opacity: 0.12;
            filter: blur(15px);
        }
    `;
    document.head.appendChild(style);
});
            if (!element.classList.contains('fadeIn')) {
                element.style.opacity = '0';
                element.style.transform = element.classList.contains('portfolio-item') ? 'scale(0.8)' : 'translateY(20px)';
                element.style.transition = 'all 0.5s ease';
            }
        });
        
        // Run once on load
        animateOnScroll();
    };
    
    setupAnimations();
    window.addEventListener('scroll', animateOnScroll);

    // Form submission handling
    const contactForm = document.querySelector('.contact-form form');
    
    if (contactForm) {
        contactForm.addEventListener('submit', (e) => {
            e.preventDefault();
            
            // Get form values
            const name = document.getElementById('name').value;
            const email = document.getElementById('email').value;
            const service = document.getElementById('service').value;
            const message = document.getElementById('message').value;
            
            // Simple form validation
            if (name && email && message) {
                // Here you would typically send the form data to a server
                // For demo, just show success and reset form
                alert(`Thank you, ${name}! Your message has been sent. We'll get back to you soon.`);
                contactForm.reset();
            } else {
                alert('Please fill in all required fields.');
            }
        });
    }

    // Explore button scroll to portfolio section
    const exploreBtn = document.querySelector('.cta-button');
    
    if (exploreBtn) {
        exploreBtn.addEventListener('click', () => {
            const portfolioSection = document.getElementById('samples');
            portfolioSection.scrollIntoView({ behavior: 'smooth' });
        });
    }
});