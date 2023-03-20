<?php
require_once 'corsHeaders.php';

if($_SERVER['REQUEST_METHOD'] != 'POST') {
    echo 'Mothod not allowed';
    exit;
}

$_POST = json_decode(file_get_contents('php://input'), true);

$data = $_POST;

require_once 'stripe/init.php';
require_once 'dbConn.php';

$event_id = $_POST['event_id'];

$query = "SELECT * FROM `events` WHERE `id` = '$event_id'";
$result = mysqli_query($db, $query);
$event = $result->fetch_assoc();

$stripe = new \Stripe\StripeClient('sk_test_51Mnpq4LJ9kTHN7J8VexLWocqnXPRrNi2ZilMuajXpihkC9qviPedo2aE8XCyLD8s4zaI73QTc9VMGeI0L6xYCnLQ00aU5gtKYJ');

$session = $stripe->checkout->sessions->create([
    'success_url' => 'http://localhost:5173/success',
    'cancel_url' => 'http://localhost:5173/cancel',
    'payment_method_types' => ['card'],
    'line_items' => [
        [
            'price_data' => [
                'currency' => 'eur',
                'unit_amount' => $event['price'],
                'product_data' => [
                    'name' => 'bilet'
                ]
            ],
            'quantity' => $_POST['quantity'],
        ],
    ],
    'mode' => 'payment',
]);

echo $session['url'];

mysqli_close($db);
return;
