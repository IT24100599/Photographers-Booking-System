<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment History</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="assets/payments.css">
    <script>
        function fetchPayments(filterType, filterValue) {
            const xhr = new XMLHttpRequest();
            xhr.open('GET', 'payment' + (filterValue ? '?' + filterType + '=' + filterValue : ''), true);
            
            if (filterType) {
                xhr.setRequestHeader('filterMethod', filterType);
            }
            
            xhr.onload = function() {
                if (xhr.status === 200) {
                    const payments = JSON.parse(xhr.responseText);
                    displayPayments(payments);
                } else {
                    document.getElementById('paymentsTable').innerHTML = 
                        '<tr><td colspan="6" class="text-center text-red-500">Error loading payments</td></tr>';
                }
            };
            
            xhr.onerror = function() {
                document.getElementById('paymentsTable').innerHTML = 
                    '<tr><td colspan="6" class="text-center text-red-500">Request failed</td></tr>';
            };
            
            xhr.send();
        }
        
        function displayPayments(payments) {
            const tableBody = document.getElementById('paymentsTable');
            tableBody.innerHTML = '';
            
            if (payments.length === 0) {
                tableBody.innerHTML = 
                    '<tr><td colspan="6" class="text-center py-4">No payments found</td></tr>';
                return;
            }
            
            payments.forEach(payment => {
                const row = document.createElement('tr');
                row.className = 'border-b hover:bg-gray-50';
                
                row.innerHTML = `
                    <td class="px-6 py-4">${payment.name}</td>
                    <td class="px-6 py-4">${payment.cardNumber}</td>
                    <td class="px-6 py-4">${payment.expiry}</td>
                    <td class="px-6 py-4">${payment.username}</td>
                    <td class="px-6 py-4">${payment.photographer}</td>
                    <td class="px-6 py-4">${payment.amount}</td>
                `;
                
                tableBody.appendChild(row);
            });
        }
        
        function filterByPhotographer() {
            const photographer = document.getElementById('photographerFilter').value;
            if (photographer.trim() !== '') {
                fetchPayments('photographer', photographer);
            }
        }
        
        function filterByUsername() {
            const username = document.getElementById('usernameFilter').value;
            if (username.trim() !== '') {
                fetchPayments('username', username);
            }
        }
        
        function resetFilters() {
            document.getElementById('photographerFilter').value = '';
            document.getElementById('usernameFilter').value = '';
            fetchPayments();
        }
        
        // Load all payments when the page loads
        window.onload = function() {
            fetchPayments();
        };
    </script>
</head>
<body class="bg-gray-100 min-h-screen">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-6 text-center">Payment History</h1>
        
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
                <div>
                    <label for="photographerFilter" class="block text-sm font-medium text-gray-700 mb-1">Filter by Photographer</label>
                    <div class="flex">
                        <input type="text" id="photographerFilter" class="flex-1 rounded-l-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 px-4 py-2 border" placeholder="Photographer name">
                        <button onclick="filterByPhotographer()" class="bg-blue-600 text-white px-4 py-2 rounded-r-md hover:bg-blue-700">Filter</button>
                    </div>
                </div>
                
                <div>
                    <label for="usernameFilter" class="block text-sm font-medium text-gray-700 mb-1">Filter by Username</label>
                    <div class="flex">
                        <input type="text" id="usernameFilter" class="flex-1 rounded-l-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 px-4 py-2 border" placeholder="Username">
                        <button onclick="filterByUsername()" class="bg-blue-600 text-white px-4 py-2 rounded-r-md hover:bg-blue-700">Filter</button>
                    </div>
                </div>
                
                <div class="flex items-end">
                    <button onclick="resetFilters()" class="w-full bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600">Reset Filters</button>
                </div>
            </div>
        </div>
        
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Card Number</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Expiry Date</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Username</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Photographer</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                        </tr>
                    </thead>
                    <tbody id="paymentsTable" class="bg-white divide-y divide-gray-200">
                        <tr>
                            <td colspan="6" class="text-center py-4">Loading payments...</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="mt-6 text-center">
            <a href="payment.html" class="inline-block px-6 py-3 bg-green-600 text-white font-medium rounded-lg hover:bg-green-700">Make a New Payment</a>
        </div>
    </div>
</body>
</html>
