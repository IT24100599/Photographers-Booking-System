<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.userMgr.models.User" %>
<%@ page import="com.photographerMgr.models.Photographer" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parallax Photography | Home</title>
    <link rel="stylesheet" href="assets/index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="loader">
        <div class="loader-text">LOADING</div>
    </div>

    <header>
        <nav class="glass-nav">
            <div class="logo">
                <h2>Parallax<span>Studio</span></h2>
            </div>
            <ul class="nav-links">
                <li><a href="#home" class="active">Home</a></li>
                <li><a href="#samples">Portfolio</a></li>
                <li><a href="#reviews">Reviews</a></li>
                <li><a href="#photographers">Photographers</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
            
            <% Photographer photographer = (Photographer)session.getAttribute("photographer"); %>
            <% User user = (User)session.getAttribute("user");%>
            
            <div class="auth-buttons">
            	
                 <% if (user != null) { %>
                 <div class="user-avatar">                  		
                    		<img src="displayProfilePicUSER?targetName=<%= user.getUsername() %>" alt="Profile Picture" id="profile-picture" onclick="window.location.href='customer.jsp'">
                    		</div>
                 <% } else if (photographer != null) { %>
                 <div class="user-avatar">
		                    <img src="displayProfilePic?targetName=<%= photographer.getUsername() %>" alt="Profile Picture" id="profile-picture" onclick="window.location.href='photographer.jsp'">
                 </div>
            	<% } else {%>
                <button class="login-btn" onclick="window.location.href='customer-login.jsp'" >Login</button>
                <button class="register-btn" onclick="window.location.href='customer-signup.jsp'">Register</button>
                <% } %>
            </div>
            <div class="hamburger">
                <div class="line"></div>
                <div class="line"></div>
                <div class="line"></div>
            </div>
        </nav>
    </header>

    <!-- Home Section -->
    <section id="home" class="parallax-section">
        <div class="parallax-bg"></div>
        <div class="home-content">
            <h1 class="animated-text">Capture the <span class="highlight">Moment</span></h1>
            <p class="animated-text-delay">Professional photography that tells your story</p>
            <button class="cta-button animated-text-delay">Explore Our Work</button>
        </div>
        <div class="floating-shapes">
            <div class="shape shape1"></div>
            <div class="shape shape2"></div>
            <div class="shape shape3"></div>
            <div class="shape shape4"></div>
        </div>
        <div class="scroll-indicator">
            <span>Scroll</span>
            <i class="fas fa-angle-down"></i>
        </div>
    </section>

    <!-- Samples/Portfolio Section -->
    <section id="samples" class="section">
        <div class="section-header">
            <h2>Our Portfolio</h2>
            <p>Explore our latest photography projects and visual stories</p>
        </div>
        <div class="portfolio-filter">
            <button class="filter-btn active" data-filter="all">All</button>
            <button class="filter-btn" data-filter="portrait">Portrait</button>
            <button class="filter-btn" data-filter="landscape">Landscape</button>
            <button class="filter-btn" data-filter="wedding">Wedding</button>
            <button class="filter-btn" data-filter="event">Event</button>
        </div>
        <div class="portfolio-grid">
            <div class="portfolio-item portrait" data-category="portrait">
                <div class="glass-card">
                    <div class="portfolio-img">
                        <img src="https://source.unsplash.com/random/600x800/?portrait" alt="Portrait Photography">
                    </div>
                    <div class="portfolio-info">
                        <h3>Dynamic Portrait</h3>
                        <p>Artistic composition with natural lighting</p>
                    </div>
                </div>
            </div>
            <div class="portfolio-item landscape" data-category="landscape">
                <div class="glass-card">
                    <div class="portfolio-img">
                        <img src="https://source.unsplash.com/random/800x600/?landscape" alt="Landscape Photography">
                    </div>
                    <div class="portfolio-info">
                        <h3>Mountain Vista</h3>
                        <p>Sunset over mountain ranges</p>
                    </div>
                </div>
            </div>
            <div class="portfolio-item wedding" data-category="wedding">
                <div class="glass-card">
                    <div class="portfolio-img">
                        <img src="https://source.unsplash.com/random/700x700/?wedding" alt="Wedding Photography">
                    </div>
                    <div class="portfolio-info">
                        <h3>Elegant Ceremony</h3>
                        <p>Capturing moments of pure joy</p>
                    </div>
                </div>
            </div>
            <div class="portfolio-item event" data-category="event">
                <div class="glass-card">
                    <div class="portfolio-img">
                        <img src="https://source.unsplash.com/random/650x750/?event" alt="Event Photography">
                    </div>
                    <div class="portfolio-info">
                        <h3>Corporate Gala</h3>
                        <p>Professional event coverage</p>
                    </div>
                </div>
            </div>
            <div class="portfolio-item portrait" data-category="portrait">
                <div class="glass-card">
                    <div class="portfolio-img">
                        <img src="https://source.unsplash.com/random/620x820/?portrait,face" alt="Portrait Photography">
                    </div>
                    <div class="portfolio-info">
                        <h3>Creative Headshot</h3>
                        <p>Studio lighting with artistic flair</p>
                    </div>
                </div>
            </div>
            <div class="portfolio-item landscape" data-category="landscape">
                <div class="glass-card">
                    <div class="portfolio-img">
                        <img src="https://source.unsplash.com/random/820x620/?landscape,ocean" alt="Landscape Photography">
                    </div>
                    <div class="portfolio-info">
                        <h3>Ocean Horizon</h3>
                        <p>Dramatic seascapes at dawn</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Reviews Section with Parallax -->
    <section id="reviews" class="section parallax-section">
        <div class="parallax-bg reviews-bg"></div>
        <div class="section-header light">
            <h2>Client Reviews</h2>
            <p>What our clients are saying about our work</p>
        </div>
        <div class="testimonials-container">
            <div class="testimonial-slider">
                <div class="testimonial glass-card active">
                    <div class="client-info">
                        <div class="client-img">
                            <img src="https://randomuser.me/api/portraits/women/32.jpg" alt="Client">
                        </div>
                        <div class="client-details">
                            <h4>Sarah Johnson</h4>
                            <p>Wedding Client</p>
                        </div>
                    </div>
                    <div class="testimonial-content">
                        <p>"Working with Parallax Studio was the best decision we made for our wedding. The team captured every special moment and the photos exceeded our expectations. The attention to detail and the creativity shown in every shot truly impressed us."</p>
                        <div class="rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                    </div>
                </div>
                <div class="testimonial glass-card">
                    <div class="client-info">
                        <div class="client-img">
                            <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Client">
                        </div>
                        <div class="client-details">
                            <h4>Michael Brown</h4>
                            <p>Corporate Client</p>
                        </div>
                    </div>
                    <div class="testimonial-content">
                        <p>"Parallax Studio delivered exceptional quality for our corporate event. Their team was professional, unobtrusive, and managed to capture the essence of our brand in every photo. Will definitely use their services for future events."</p>
                        <div class="rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                        </div>
                    </div>
                </div>
                <div class="testimonial glass-card">
                    <div class="client-info">
                        <div class="client-img">
                            <img src="https://randomuser.me/api/portraits/women/65.jpg" alt="Client">
                        </div>
                        <div class="client-details">
                            <h4>Emily Wilson</h4>
                            <p>Portrait Session</p>
                        </div>
                    </div>
                    <div class="testimonial-content">
                        <p>"I was nervous about my first professional photoshoot, but the team at Parallax Studio made me feel comfortable and confident. The results were stunning, and I received so many compliments on my portraits. Highly recommended!"</p>
                        <div class="rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="testimonial-controls">
                <button class="prev-btn"><i class="fas fa-chevron-left"></i></button>
                <div class="testimonial-dots">
                    <span class="dot active"></span>
                    <span class="dot"></span>
                    <span class="dot"></span>
                </div>
                <button class="next-btn"><i class="fas fa-chevron-right"></i></button>
            </div>
        </div>
    </section>

    <!-- Top Photographers Section -->
    <section id="photographers" class="section">
        <div class="section-header">
            <h2>Meet Our Photographers</h2>
            <p>Talented professionals with years of experience</p>
        </div>
        <div class="photographers-grid">
            <div class="photographer-card glass-card">
                <div class="photographer-img">
                    <img src="https://randomuser.me/api/portraits/men/85.jpg" alt="Photographer">
                </div>
                <div class="photographer-info">
                    <h3>Alex Morgan</h3>
                    <p>Lead Photographer</p>
                    <p class="specialization">Specializes in: Portrait, Fashion</p>
                    <div class="social-links">
                        <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                        <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                        <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
            <div class="photographer-card glass-card">
                <div class="photographer-img">
                    <img src="https://randomuser.me/api/portraits/women/79.jpg" alt="Photographer">
                </div>
                <div class="photographer-info">
                    <h3>Jessica Chen</h3>
                    <p>Senior Photographer</p>
                    <p class="specialization">Specializes in: Wedding, Events</p>
                    <div class="social-links">
                        <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                        <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                        <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
            <div class="photographer-card glass-card">
                <div class="photographer-img">
                    <img src="https://randomuser.me/api/portraits/men/55.jpg" alt="Photographer">
                </div>
                <div class="photographer-info">
                    <h3>Marcus Lee</h3>
                    <p>Landscape Specialist</p>
                    <p class="specialization">Specializes in: Landscape, Nature</p>
                    <div class="social-links">
                        <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                        <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                        <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
            <div class="photographer-card glass-card">
                <div class="photographer-img">
                    <img src="https://randomuser.me/api/portraits/women/43.jpg" alt="Photographer">
                </div>
                <div class="photographer-info">
                    <h3>Olivia Garcia</h3>
                    <p>Creative Director</p>
                    <p class="specialization">Specializes in: Artistic, Experimental</p>
                    <div class="social-links">
                        <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                        <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                        <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section with Parallax -->
    <section id="contact" class="section parallax-section">
        <div class="parallax-bg contact-bg"></div>
        <div class="section-header light">
            <h2>Contact Us</h2>
            <p>Let's discuss your photography needs</p>
        </div>
        <div class="contact-container">
            <div class="contact-info glass-card">
                <div class="contact-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <div>
                        <h4>Our Location</h4>
                        <p>123 Photography Lane, Creative District, NY 10001</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-phone-alt"></i>
                    <div>
                        <h4>Call Us</h4>
                        <p>+1 (555) 123-4567</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-envelope"></i>
                    <div>
                        <h4>Email Us</h4>
                        <p>info@parallaxstudio.com</p>
                    </div>
                </div>
                <div class="contact-item">
                    <i class="fas fa-clock"></i>
                    <div>
                        <h4>Working Hours</h4>
                        <p>Monday - Friday: 9am - 6pm</p>
                        <p>Weekend: By appointment only</p>
                    </div>
                </div>
                <div class="social-links-large">
                    <a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                    <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                    <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="contact-form glass-card">
                <form>
                    <div class="form-group">
                        <label for="name">Your Name</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Your Email</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="service">Service Interested In</label>
                        <select id="service" name="service">
                            <option value="portrait">Portrait Photography</option>
                            <option value="wedding">Wedding Photography</option>
                            <option value="event">Event Coverage</option>
                            <option value="commercial">Commercial Photography</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="message">Your Message</label>
                        <textarea id="message" name="message" rows="5" required></textarea>
                    </div>
                    <button type="submit" class="submit-btn">Send Message</button>
                </form>
            </div>
        </div>
    </section>

    <footer>
        <div class="footer-content">
            <div class="footer-logo">
                <h2>Parallax<span>Studio</span></h2>
                <p>Capturing moments, creating memories</p>
            </div>
            <div class="footer-links">
                <div class="footer-column">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="#home">Home</a></li>
                        <li><a href="#samples">Portfolio</a></li>
                        <li><a href="#reviews">Reviews</a></li>
                        <li><a href="#photographers">Photographers</a></li>
                        <li><a href="#contact">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h4>Services</h4>
                    <ul>
                        <li><a href="#">Portrait Photography</a></li>
                        <li><a href="#">Wedding Photography</a></li>
                        <li><a href="#">Event Coverage</a></li>
                        <li><a href="#">Commercial Photography</a></li>
                        <li><a href="#">Photography Workshops</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h4>Legal</h4>
                    <ul>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms of Service</a></li>
                        <li><a href="#">Cookie Policy</a></li>
                        <li><a href="#">Licensing</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="copyright">
            <p>&copy; 2025 Parallax Studio. All rights reserved.</p>
        </div>
    </footer>

    <script src="assets/index.js"></script>
</body>
</html>