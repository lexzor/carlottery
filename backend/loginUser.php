<?php
$postData = file_get_contents('php://input');

$data = json_decode($postData, true);

if (!array_key_exists('email', $data)) {
    return;
}

$db = mysqli_connect("localhost", "root", "", "loterie");

if (!$db) {
    print('Conexiunea la baza de date a esuat!');
    die();
}

$query = "SELECT * FROM `accounts` WHERE `email` = '" . $data['email'] . "' AND `upassword` = '" . $data['password'] . "';";

$result = mysqli_query($db, $query);

if (!$result) {
    print('-1');
} else {
    print json_encode(mysqli_fetch_assoc($result));
}

mysqli_close($db);
die();
