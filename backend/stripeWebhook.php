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
        require_once 'dbConn.php';
        $data = $event->data->object->metadata;
        $details = json_decode($data->customerDetails);
        $date = date('Y-m-d H:i:s');

        $query = "INSERT INTO `invoices` (`firstName`, `lastName`, `phoneNumber`, `emailAddress`, `companyName`, `country`, `streetName`, `houseNumber`, `postCode`, `city`, `notes`, `products`, `paymentStatus`, `createdAt`) VALUES
        ('" . $details->firstName . "','" . $details->lastName . "','" . $data->customerPhoneNumber . "','" . $data->customerEmail . "','" . $details->companyName . "','" . $details->country . "','" . $details->streetName . "','" . $details->houseNumber . "','" . $details->postCode . "','" . $details->city . "','" . $details->notes . "','" . json_encode($details->products) . "', 'paid', '".$date."')";
        if(mysqli_query($db, $query)) {
            $invoice_id = mysqli_insert_id($db);
            foreach($details->products as $product) {
                $queryTickets = "INSERT INTO `tickets` (`accountEmail`, `ticketQuantity`, `eventId`, `invoiceId`, `createdAt`) VALUES
                ('".$data->customerEmail."', '".$product->quantity."', '".$product->id."', ".$invoice_id.", '".$date."')";
                mysqli_query($db, $queryTickets);
            }

            mysqli_close($db);
            break;
        }
    case 'payment_intent.canceled':
        require_once 'dbConn.php';
        $data = $event->data->object->metadata;
        $details = json_decode($data->customerDetails);
        $date = date('Y-m-d H:i:s');

        $query = "INSERT INTO `invoices` (`firstName`, `lastName`, `phoneNumber`, `emailAddress`, `companyName`, `country`, `streetName`, `houseNumber`, `postCode`, `city`, `notes`, `products`, `paymentStatus`, `createdAt`) VALUES
        ('" . $details->firstName . "','" . $details->lastName . "','" . $data->customerPhoneNumber . "','" . $data->customerEmail . "','" . $details->companyName . "','" . $details->country . "','" . $details->streetName . "','" . $details->houseNumber . "','" . $details->postCode . "','" . $details->city . "','" . $details->notes . "','" . json_encode($details->products) . "', '".$date."')";
        mysqli_query($db, $query);

        mysqli_close($db);
        break;
    default:
        echo 'Received unknown event type ' . $event->type;
}

http_response_code(200);