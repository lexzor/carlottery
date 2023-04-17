<?php
require_once 'corsHeaders.php';

$_POST = json_decode(file_get_contents('php://input'), true);

$data = $_POST;

if (!array_key_exists('getTerms', $data)) {
    return;
}
require_once 'dbConn.php';

$query = "SELECT * FROM `configuration` WHERE `type` = 'terms'";

$result = mysqli_query($db, $query);

if ($result) {
    print(json_encode(["be_msg_success" => json_encode(mysqli_fetch_object($result))]));
} else {
    print(json_encode(["be_msg_error" => 'Eroare la preluarea termeniilor și condițiilor.']));
}

mysqli_close($db);
die();
