<?php
require_once 'corsHeaders.php';

if($_SERVER['REQUEST_METHOD'] != 'POST') {
    echo 'Mothod not allowed';
    exit;
}

require_once 'stripe/init.php';

$_POST = json_decode(file_get_contents('php://input'), true);

$data = $_POST;

// $stripe = new \Stripe\StripeClient('sk_test_51Mnpq4LJ9kTHN7J8VexLWocqnXPRrNi2ZilMuajXpihkC9qviPedo2aE8XCyLD8s4zaI73QTc9VMGeI0L6xYCnLQ00aU5gtKYJ');
// $session = $stripe->checkout->sessions->retrieve($data['session_id']);
echo json_encode($_POST);

// require_once 'dbConn.php';

// $query = "INSERT INTO `orders` ('content') VALUES ('test')";
// $result = mysqli_query($db, $query);


// mysqli_close($db);
return;