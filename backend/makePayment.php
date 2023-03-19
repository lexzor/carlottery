<?php
$postData = file_get_contents('php://input');

$data = json_decode($postData, true);

// if (!array_key_exists('getEvents', $data)) {
//     return;
// }
// publishable key : pk_test_51Mn4hYA3Z25zpPbJYxmcqYFplepWImKKGv2pbhPVL6xIZFVq8duLJnxYnuuDAQZBWIBounLovfn7bbTe86PMy2sA00NauzK0gD
// secret_key : sk_test_51Mn4hYA3Z25zpPbJJJKAAGG5gTqmPuNHwbERdGBZhWn9AXnotXIy4AYgOYIUhkHX5yx4y1KBd1AiKZHY7FWr4P5000a8MvM96N
require 'stripe-php-10.10.0/init.php';

\Stripe\Stripe::setApiKey('sk_test_51Mn4hYA3Z25zpPbJJJKAAGG5gTqmPuNHwbERdGBZhWn9AXnotXIy4AYgOYIUhkHX5yx4y1KBd1AiKZHY7FWr4P5000a8MvM96N');


$customer = \stripe\Customer::create(array(
    "email" => "super.alexx@yahoo.com",
    "source" => "4242 4242 4242 4242"
));

$charge = \Stripe\Charge::create(array(
    "amount" => 5000,
    "currency" => "eur",
    "description" => "Some payment",
    "customer" => $customed->id
));

print_r($charge);
