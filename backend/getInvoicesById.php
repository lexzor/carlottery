<?php
require_once 'corsHeaders.php';

$_POST = json_decode(file_get_contents('php://input'), true);

$data = $_POST;

if (!array_key_exists('email', $data)) {
    return;
}
require_once 'dbConn.php';

$query =    "SELECT * FROM `invoices` WHERE emailAddress = '" . $data['email'] . "'";
$result = mysqli_query($db, $query);

if (mysqli_num_rows($result) > 0) {
    $invoices = array();

    while ($row = mysqli_fetch_object($result)) {
        array_push($invoices, $row);
    }

    print json_encode($invoices);
}

mysqli_close($db);
die();
