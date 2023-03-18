<?php
$postData = file_get_contents('php://input');

$data = json_decode($postData, true);

// if (!array_key_exists('getEvents', $data)) {
//     return;
// }
// publishable key : pk_test_51Mn4hYA3Z25zpPbJYxmcqYFplepWImKKGv2pbhPVL6xIZFVq8duLJnxYnuuDAQZBWIBounLovfn7bbTe86PMy2sA00NauzK0gD
// secret_key : sk_test_51Mn4hYA3Z25zpPbJJJKAAGG5gTqmPuNHwbERdGBZhWn9AXnotXIy4AYgOYIUhkHX5yx4y1KBd1AiKZHY7FWr4P5000a8MvM96N
require 'stripe-php-10.10.0/init.php';

$stripe = new \Stripe\StripeClient('sk_test_51Mn4hYA3Z25zpPbJJJKAAGG5gTqmPuNHwbERdGBZhWn9AXnotXIy4AYgOYIUhkHX5yx4y1KBd1AiKZHY7FWr4P5000a8MvM96N');

$product = $stripe->products->create([
    'name' => 'Ticket event',
    'description' => 'tickete event'
]);

echo "Success! Here is your starter subscription product id: " . $product->id . "\n";

$payment_intent = $stripe->paymentIntents->create([
    'amount' => 1999,
    'currency' => 'eur',
]);

echo $stripe;