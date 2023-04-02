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

$metadata = $_POST['metadata'];

$events = $_POST['events'];
$eventsData = [];

foreach($events as $event) {
    $query = "SELECT * FROM `events` WHERE `id` = '".$event['id']."'";
    $result = mysqli_query($db, $query);
    $eventRes = $result->fetch_assoc();

    $eventData = [
        'price_data' => [
            'currency' => 'eur',
            'unit_amount' => $eventRes['price'] * 100,
            'product_data' => [
                'name' => $eventRes['title']
            ]
        ],
        'quantity' => $event['quantity'],
    ];
    array_push($eventsData, $eventData);
}

$stripe = new \Stripe\StripeClient('sk_test_51Mnpq4LJ9kTHN7J8VexLWocqnXPRrNi2ZilMuajXpihkC9qviPedo2aE8XCyLD8s4zaI73QTc9VMGeI0L6xYCnLQ00aU5gtKYJ');

$customerDetails = [
    'firstName' => $metadata['customerDetails']['firstName'],
    'lastName' => $metadata['customerDetails']['lastName'],
    'companyName' => $metadata['customerDetails']['companyName'],
    'country' => $metadata['customerDetails']['country'],
    'streetName' => $metadata['customerDetails']['streetName'],
    'houseNumber' => $metadata['customerDetails']['houseNumber'],
    'postCode' => $metadata['customerDetails']['postCode'],
    'city' => $metadata['customerDetails']['city'],
    'notes' => $metadata['customerDetails']['notes'],
    'products' => $metadata['customerDetails']['products'],
];

$session = $stripe->checkout->sessions->create([
    'success_url' => "http://localhost:5173/order/success?session_id={CHECKOUT_SESSION_ID}",
    'cancel_url' => "http://localhost:5173/order/declined?session_id={CHECKOUT_SESSION_ID}",
    'payment_method_types' => ['card'],
    'line_items' => $eventsData,
    'mode' => 'payment',
    'payment_intent_data' => [
        'metadata' => [
            'customerEmail' => $metadata['customerEmail'],
            'customerPhoneNumber' => $metadata['customerPhoneNumber'],
            'customerDetails' => json_encode($customerDetails)
        ]
    ]
]);

// echo json_encode($metadata['customerDetails']['firstName']);

echo $session['id'];

mysqli_close($db);
return;
