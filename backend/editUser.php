<?php
require_once 'corsHeaders.php';

// $postData = file_get_contents('php://input');

$data = $_POST;

if (!array_key_exists('id', $data)) {
    return;
}

require_once 'dbConn.php';

$query = "UPDATE `accounts` SET `email` = '" . $data['email'] . "', `upassword` = '" . $data['upassword'] . "', `username` = '" . $data['username'] . "', `access` = " . $data['access'] . " WHERE `id` = " . $data['id'] . "";

$result = mysqli_query($db, $query);

if (!$result) {
    print('Introducerea in baza de date a esuat! Eroare: ' . mysqli_error($db));
} else {
    print "1";
}

mysqli_close($db);
return;
