<?php
require_once 'corsHeaders.php';

$_POST = json_decode(file_get_contents('php://input'), true);

$data = $_POST;

if (!array_key_exists('email', $data)) {
    return;
}

require_once 'dbConn.php';

$query = "SELECT * FROM `accounts` WHERE `email` = '" . $data['email'] . "' AND `upassword` = '" . $data['password'] . "';";

$result = mysqli_query($db, $query);

if (!$result) {
    print('-1');
} else {
    $data = mysqli_fetch_assoc($result);
    $data["login_key"] = md5(uniqid($data['id'], true));
    $query = "UPDATE `accounts` SET `login_key` = '" . $data["login_key"] . "' WHERE `id` = '" . $data["id"] . "'";
    mysqli_query($db, $query);
    print json_encode($data);
}

mysqli_close($db);
die();
