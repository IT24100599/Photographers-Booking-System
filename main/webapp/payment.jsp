<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%@ page import="com.userMgr.models.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Event Studio</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/html2canvas@1.4.1/dist/html2canvas.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: url('https://picsum.photos/1600/900') no-repeat;
            background-size: cover;
            background-position: center;
        }

        .background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
        }

        .container {
            position: relative;
            width: 950px;
            height: 600px;
            border-radius: 20px;
            display: flex;
            z-index: 2;
            background: rgb(255 255 255 / 11%);;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(85px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
            overflow: hidden;
            }

        .content {
            position: absolute;
            top: 0;
            left: 0;
            width: 55%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            flex-direction: column;
            padding: 40px;
            color: white;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 30px;
        }

        .brand i {
            font-size: 24px;
        }

        .text-sci h2 {
            font-size: 2.5em;
            line-height: 1.2;
            margin-bottom: 15px;
        }

        .text-sci h2 span {
            font-size: 0.7em;
            opacity: 0.8;
        }

        .text-sci p {
            font-size: 1em;
            margin-bottom: 20px;
            opacity: 0.8;
        }

        .payment-details {
            background: rgba(255, 255, 255, 0.05);
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
            width: 100%;
        }

        .payment-details ul {
            list-style: none;
        }

        .payment-details li {
            margin: 10px 0;
            display: flex;
            justify-content: space-between;
        }

        .logreg-box {
            position: absolute;
            top: 0;
            right: 0;
            width: 45%;
            height: 100%;
            padding: 40px;
            background: rgba(255, 255, 255, 0.02);
        }

        .form-box h2 {
            color: white;
            font-size: 1.8em;
            margin-bottom: 30px;
        }

        .input-box {
            position: relative;
            margin: 25px 0;
        }

        .input-box input {
            width: 100%;
            height: 50px;
            background: transparent;
            border: none;
            outline: none;
            border-bottom: 2px solid rgba(255, 255, 255, 0.2);
            padding: 0 35px 0 5px;
            color: white;
            font-size: 1em;
            transition: 0.3s;
        }

        .input-box label {
            position: absolute;
            top: 50%;
            left: 5px;
            transform: translateY(-50%);
            font-size: 1em;
            color: rgba(255, 255, 255, 0.7);
            pointer-events: none;
            transition: 0.3s;
        }

        .input-box input:focus ~ label,
        .input-box input:valid ~ label {
            top: -5px;
            color: white;
        }

        .input-box input:focus,
        .input-box input:valid {
            border-bottom-color: white;
        }

        .input-box .icon {
            position: absolute;
            right: 8px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.7);
            font-size: 1.2em;
        }
        
        #amount, #photographer {
        border-bottom-color: white;
        top: -5px;
        color: white;
        }

        .btn {
            width: 100%;
            height: 45px;
            background: rgba(255, 255, 255, 0.1);
            border: none;
            outline: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1em;
            color: white;
            font-weight: 500;
            margin-top: 30px;
            transition: 0.3s;
        }

        .btn:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            font-size: 0.9em;
            transition: 0.3s;
        }

        .back-link a:hover {
            color: white;
        }

        @media (max-width: 850px) {
            .container {
                width: 90%;
                height: auto;
                flex-direction: column;
            }

            .content {
                position: relative;
                width: 100%;
                padding: 30px;
                text-align: center;
                align-items: center;
            }

            .logreg-box {
                position: relative;
                width: 100%;
                height: auto;
                padding: 30px;
            }
        }
    </style>
</head>
<body>
<div class="background"></div>
<% User user = (User)session.getAttribute("user");%>

<div class="container">
    <div class="content">
        <div class="brand">
            <i class="fas fa-camera"></i>
            <h2>Event Studio</h2>
        </div>
        <div class="text-sci">
            <h2>Complete Payment<br><span>Secure Transaction</span></h2>
            <p>Please enter your payment details to confirm your booking</p>
            <h3 id="payData"></h3>
            <script>
				const urlParams = new URLSearchParams(window.location.search);

  					if (urlParams.has('photographer') && urlParams.has('amount')) {
   						 const userValue = urlParams.get('photographer');
  						 const amount = urlParams.get('amount');
					    document.getElementById('payData').innerHTML = "Photographer: "+ userValue + "<br> Amount: Rs." + amount;
  					} else {
  			        	document.getElementById('payData').innerHTML = "Please select a photographer and a package";
  			        	
  			        }
					</script>
        </div>
    </div>

    <div class="logreg-box">
        <div class="form-box">
            <h2>Payment Details</h2>
            <form id="paymentForm" action="payment" method="post" autocomplete="off">
            	<input type="hidden" name="username" value="<%= user.getUsername() %>">
                <div class="input-box">
                    <input type="text" id="name" name="name" required>
                    <label>Card Holder Name</label>
                    <i class="fas fa-user icon"></i>
                </div>

                <div class="input-box">
                    <input type="text" id="cardNumber" name="cardNumber" maxlength="16" required>
                    <label>Card Number</label>
                    <i class="fas fa-credit-card icon"></i>
                </div>

                <div class="input-box">
                    <input type="text" id="expiry" name="expiry" maxlength="5" required>
                    <label>Expiry Date (MM/YY)</label>
                    <i class="fas fa-calendar icon"></i>
                </div>

                <div class="input-box">
                    <input type="text" id="cvv" name="cvv" maxlength="4" required>
                    <label>CVV</label>
                    <i class="fas fa-lock icon"></i>
                </div>
                
                <div class="input-box">
                    <input type="hidden" id="amount" name="amount" value="" required>
			    </div>
			    <script>
  					if (urlParams.has('amount')) {
   						 const amount = urlParams.get('amount');
					    document.getElementById('amount').value = amount;
  			        } else {
  			        	document.getElementById('amount').value = null;
  			        }
					</script>
    
                <div class="input-box">
                    <input type="hidden" id="photographer" name="photographer" value="" required>
			    </div>
			    <script>
  					if (urlParams.has('photographer')) {
   						 const userValue = urlParams.get('photographer');
					    document.getElementById('photographer').value = userValue;
  			        } else {
  			        	document.getElementById('photographer').value = null;
  			        	
  			        }
					</script>
			    
			    
                <button type="submit" class="btn">Process Payment</button>

                <div class="error-message" id="error"></div>

                <div class="back-link">
                    <a href="index.html"><i class="fas fa-arrow-left"></i> Back to Home</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.getElementById('paymentForm').onsubmit = function(e) {
        e.preventDefault();
        let card = document.getElementById('cardNumber').value.trim();
        let expiry = document.getElementById('expiry').value.trim();
        let cvv = document.getElementById('cvv').value.trim();
        let name = document.getElementById('name').value.trim();
        let error = "";

        // Card number validation (16 digits)
        if (!/^\d{16}$/.test(card)) error += "Please enter a valid 16-digit card number.<br>";

        // Expiry validation (MM/YY and not in the past)
        if (!/^\d{2}\/\d{2}$/.test(expiry)) {
            error += "Please enter a valid expiry date in MM/YY format.<br>";
        } else {
            let [mm, yy] = expiry.split('/').map(Number);
            let now = new Date();
            let expDate = new Date(2000 + yy, mm - 1);
            if (mm < 1 || mm > 12) {
                error += "Please enter a valid expiration month (01-12).<br>";
            } else if (expDate < new Date(now.getFullYear(), now.getMonth())) {
                error += "Card has expired.<br>";
            }
        }

        // CVV validation (3 or 4 digits)
        if (!/^\d{3,4}$/.test(cvv)) error += "Please enter a valid 3 or 4 digit CVV.<br>";

        // Name validation
        if (name === "") error += "Please enter the card holder's name.<br>";

        document.getElementById('error').innerHTML = error;

        if (!error) {
            // Show loading state
            const btn = document.querySelector('button[type="submit"]');
            const originalText = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            btn.disabled = true;

            // Option 1: Traditional form submission
            this.submit();
        }
    };
</script>
</body>
</html>




