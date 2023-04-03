<?php
require_once 'corsHeaders.php';

$_POST = json_decode(file_get_contents('php://input'), true);

$data = $_POST;

if (!array_key_exists('login_key', $data)) {
    return;
}

require_once 'dbConn.php';

// $query = "SELECT * FROM `accounts` WHERE `login_key` = '" . $data['login_key'] . "';";

$query = "SELECT accounts.*, invoices.id AS invoice_id, tickets.eventId AS ticket_event_id, tickets.ticketQuantity as ticket_quantity
          FROM accounts
          LEFT JOIN invoices ON accounts.email = invoices.emailAddress
          LEFT JOIN tickets ON accounts.email = tickets.accountEmail
          WHERE accounts.login_key = '" . $data['login_key'] . "';";

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
    $uData["invoices"] = array();

    foreach ($rows as $row) {
        $found = false;

        if (sizeof($uData['tickets']) > 0) {
            $i = 0;
            foreach ($uData['tickets'] as $tickets) {
                if ($tickets['event_id'] === (int) $row->ticket_event_id) {
                    $uData['tickets'][$i]['quantity'] += (int) $row->ticket_quantity;
                    $found = true;
                    break;
                }

                $i++;
            }
        }

        if (!$found) {
            array_push($uData['tickets'], [
                "event_id" => (int) $row->ticket_event_id,
                "quantity" => (int) $row->ticket_quantity
            ]);
        }

        if (!in_array($row->invoice_id, $uData['invoices'])) {
            array_push($uData['invoices'], (int) $row->invoice_id);
        }
    }

    print json_encode($uData);
}

mysqli_close($db);
die();