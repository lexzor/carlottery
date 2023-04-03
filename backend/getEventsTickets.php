<?php
require_once 'corsHeaders.php';

$_POST = json_decode(file_get_contents('php://input'), true);

$data = $_POST;

// if (!array_key_exists('getEventsTickets', $data)) {
//     return;
// }

require_once 'dbConn.php';

$query = "SELECT ticketQuantity AS quantity, eventId AS event_id FROM `tickets`";

$result = mysqli_query($db, $query);

if (mysqli_num_rows($result) > 0) {
    $events = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $found = false;

        if (sizeof($events) > 0) {
            for ($i = 0; $i < sizeof($events); $i++) {
                if ($events[$i]['event_id'] === (int) $row['event_id']) {
                    $events[$i]['quantity'] += (int) $row['quantity'];
                    $found = true;
                    break;
                }
            }
        }

        if (!$found) {
            array_push($events, [
                "event_id" => (int) $row['event_id'],
                "quantity" => (int) $row['quantity']
            ]);
        }
    }
    print json_encode($events);
} else

    mysqli_close($db);
die();
