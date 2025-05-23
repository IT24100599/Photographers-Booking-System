<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Success - Event Studio</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            background: rgba(0, 0, 0, 0.85);
        }

        .container {
            position: relative;
            width: 800px;
            padding: 40px;
            border-radius: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            z-index: 2;
            background: rgba(28, 28, 28, 0.9);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
        }

        .success-icon {
            font-size: 80px;
            color: #4BB543;
            margin-bottom: 20px;
        }

        h1 {
            color: white;
            font-size: 2.5em;
            margin-bottom: 20px;
            text-align: center;
        }

        .payment-details {
            background: rgba(255, 255, 255, 0.05);
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
            width: 100%;
            color: white;
        }

        .payment-details p {
            margin: 10px 0;
            font-size: 1.1em;
        }

        .payment-details span {
            font-weight: 600;
        }

        .buttons {
            display: flex;
            gap: 20px;
            margin-top: 20px;
        }

        .btn {
            padding: 12px 24px;
            background: rgba(255, 255, 255, 0.1);
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1em;
            color: white;
            font-weight: 500;
            text-decoration: none;
            transition: 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .btn-primary {
            background: rgba(75, 181, 67, 0.2);
        }

        .btn-primary:hover {
            background: rgba(75, 181, 67, 0.3);
        }
    </style>
</head>
<body>
<div class="background"></div>

<div class="container">
    <i class="fas fa-check-circle success-icon"></i>
    <h1>Payment Successful!</h1>

    <div class="payment-details">
        <p><span>Cardholder:</span> ${payment.cardholderName}</p>
        <p><span>Card Number:</span> ${payment.maskedCardNumber}</p>
        <p><span>Date:</span> ${payment.submissionDate}</p>
        <p><span>Time:</span> ${payment.submissionTime}</p>
    </div>

    <div class="buttons">
        <a href="index.html" class="btn"><i class="fas fa-home"></i> Home</a>
        <a href="payment?action=view" class="btn btn-primary"><i class="fas fa-list"></i> View All Payments</a>
    </div>
</div>
</body>
</html>