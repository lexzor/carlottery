<?php
require_once 'corsHeaders.php';

// $postData = file_get_contents('php://input');

$_POST = json_decode(file_get_contents('php://input'), true);

$data = $_POST;

if (!array_key_exists('email', $data)) {
    return;
}

require_once 'dbConn.php';

$query = "INSERT INTO `accounts` (`email`, `upassword`, `username`) VALUES 
        ('" . $data['email'] . "','" . $data['password'] . "','" . $data['username'] . "')";

$result = mysqli_query($db, $query);

if (!$result) {
    print('Introducerea in baza de date a esuat! Eroare: ' . mysqli_error($db));
} else {
    print "1";
}

mysqli_close($db);
return;
