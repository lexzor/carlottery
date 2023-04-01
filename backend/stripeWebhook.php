<?php
require_once 'stripe/init.php';

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
        $paymentIntent = $event->data->object;
    // ... handle other event types
    default:
        echo 'Received unknown event type ' . $event->type;
}

http_response_code(200);