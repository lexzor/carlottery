<?php
require_once 'corsHeaders.php';

$_POST = json_decode(file_get_contents('php://input'), true);

$data = $_POST;

if (!array_key_exists('login_key', $data) && !array_key_exists('email', $data)) {
    return;
}

require_once 'dbConn.php';

$query = "SELECT accounts.*, invoices.id AS invoice_id, tickets.eventId AS ticket_event_id, tickets.ticketQuantity as ticket_quantity
          FROM accounts
          LEFT JOIN invoices ON accounts.email = invoices.emailAddress
          LEFT JOIN tickets ON accounts.email = tickets.accountEmail ";

if (!array_key_exists('email', $data)) {
    $clause = "WHERE accounts.login_key = '" . $data['login_key'] . "';";
} else {
    $clause = "WHERE `email` = '" . $data['email'] . "' AND `upassword` = '" . $data['password'] . "';";
}

$query = $query . $clause;
$result = mysqli_query($db, $query);

if (mysqli_num_rows($result) > 0) {
    $rows = array();

    while ($row = mysqli_fetch_object($result)) {
        array_push($rows, $row);
    }
    $uData = array();

    $uData["id"] = (int) $rows[0]->id;
    $uData["email"] = $rows[0]->email;
    $uData["username"] = $rows[0]->username;
    $uData["access"] = (int) $rows[0]->access;
    $uData["cart"] = json_decode($rows[0]->cart);
    $uData["tickets"] = array();
    $uData["invoices_ids"] = array();

    foreach ($rows as $row) {
        $found = false;

        if ($row->ticket_event_id == NULL)
            continue;

        if (sizeof($uData['tickets']) > 0) {
            for ($i = 0; $i < sizeof($uData['tickets']); $i++) {
                if ($uData['tickets'][$i]['event_id'] === (int) $row->ticket_event_id) {
                    $uData['tickets'][$i][$quantity] += (int) $row->ticket_quantity;
                    $found = true;
                    break;
                }
            }
        }

        if (!$found) {
            array_push($uData['tickets'], [
                "event_id" => (int) $row->ticket_event_id,
                "quantity" => (int) $row->ticket_quantity
            ]);
        }

        if (!in_array($row->invoice_id, $uData['invoices_ids'])) {
            array_push($uData['invoices_ids'], (int) $row->invoice_id);
        }
    }

    $uData["login_key"] = md5(uniqid($uData['id'], true));
    $query = "UPDATE `accounts` SET `login_key` = '" . $uData["login_key"] . "' WHERE `id` = '" . $uData["id"] . "'";
    mysqli_query($db, $query);

    print json_encode($uData);
} else {
    print(-1);
}

mysqli_close($db);
die();
