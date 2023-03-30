<?php
require_once 'corsHeaders.php';

$_POST = json_decode(file_get_contents('php://input'), true);

$data = $_POST;

if (!array_key_exists('login_key', $data)) {
    return;
}

require_once 'dbConn.php';

$query = "SELECT * FROM `accounts` WHERE `login_key` = '" . $data['login_key'] . "';";

$result = mysqli_query($db, $query);

if (!$result) {
    print('-1');
} else {
    print json_encode(mysqli_fetch_assoc($result));
}

mysqli_close($db);
die();
