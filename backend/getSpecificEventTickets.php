<?php
require_once 'corsHeaders.php';

$_POST = json_decode(file_get_contents('php://input'), true);

$data = $_POST;

if (!array_key_exists('id', $data)) {
    return;
}
require_once 'dbConn.php';

$query =    "SELECT tickets.accountEmail, tickets.ticketQuantity, accounts.firstName, accounts.lastName FROM tickets
             LEFT JOIN accounts ON accounts.email = tickets.accountEmail WHERE tickets.eventId = " . $data['id'] . "";

$result = mysqli_query($db, $query);
$events = array();

if (mysqli_num_rows($result) > 0) {

    while ($row = mysqli_fetch_object($result)) {
        for ($i = 1; $i <= (int) $row->ticketQuantity; $i++) {
            array_push($events, [
                // "ticketId" => $i,
                "firstName" => $row->firstName,
                "lastName" => $row->lastName
            ]);
        }
    }

    foreach($events as $key => $event) {
        $events[$key]['ticketId'] = $key + 1;
    }

    print json_encode($events);
} else {
    print json_encode($events);
}

mysqli_close($db);
die();
