<?php
require_once 'stripe/init.php';

\Stripe\Stripe::setLogger(new \Monolog\Logger('stripe'));
\Stripe\Stripe::addPlugin(new \Stripe\StripeLoggerPlugin());

$stripe = new \Stripe\StripeClient('sk_test_51Mnpq4LJ9kTHN7J8VexLWocqnXPRrNi2ZilMuajXpihkC9qviPedo2aE8XCyLD8s4zaI73QTc9VMGeI0L6xYCnLQ00aU5gtKYJ');

$endpoint_secret = 'whsec_49724b8dcd2fab4861a8556605265b5ad6b749be034ba3179ca398aa426209d5';

$payload = @file_get_contents('php://input');
$sig_header = $_SERVER['HTTP_STRIPE_SIGNATURE'];
$event = null;

try {
    $event = \Stripe\Webhook::constructEvent(
        $payload, $sig_header, $endpoint_secret
    );
} catch(\UnexpectedValueException $e) {
    // Invalid payload
    http_response_code(400);
    exit();
} catch(\Stripe\Exception\SignatureVerificationException $e) {
    // Invalid signature
    http_response_code(400);
    exit();
}

// Handle the event
switch ($event->type) {
    case 'payment_intent.succeeded':
        require_once 'dbConn.php';
        $data = $event->data->object->metadata;
        print_r($data);
        // $products = json_encode($data->customerDetails->products);

        // $query = "INSERT INTO `invoices` (`firstName`, `lastName`, `phoneNumber`, `emailAddress`, `companyName`, `country`, `streetName`, `houseNumber`, `postCode`, `city`, `notes`, `products`, `paymentStatus`) VALUES 
        // ('" . $data->customerDetails->fistName . "','" . $data->customerDetails->lastName . "','" . $data['customerPhoneNumber'] . "','" . $data->customerEmail . "','" . $data->customerDetails->companyName . "','" . $data->customerDetails->country . "','" . $data->customerDetails->streetName . "','" . $data->customerDetails->houseNumber . "','" . $data->customerDetails->postCode . "','" . $data->customerDetails->city . "','" . $data->customerDetails->notes . "','" . $products . "', 'paid')";

        // // $query = "INSERT INTO `invoices` (`firstName`, `lastName`, `phoneNumber`, `emailAddress`, `companyName`, `country`, `streetName`, `houseNumber`, `postCode`, `city`, `notes`, `products`, `paymentStatus`) VALUES 
        // // ('" . $data['customerDetails']['fistName'] . "','" . $data['customerDetails']['lastName'] . "','" . $data['customerPhoneNumber'] . "','" . $data['customerEmail'] . "','" . $data['customerDetails']['companyName'] . "','" . $data['customerDetails']['country'] . "','" . $data['customerDetails']['streetName'] . "','" . $data['customerDetails']['houseNumber'] . "','" . $data['customerDetails']['postCode'] . "','" . $data['customerDetails']['city'] . "','" . $data['customerDetails']['notes'] . "','" . $data['customerDetails']['products'] . "', 'paid')";
        // $result = mysqli_query($db, $query);
        // mysqli_close($db);
        // break;
    default:
        echo 'Received unknown event type ' . $event->type;
}

http_response_code(200);