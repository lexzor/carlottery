<?php
$postData = file_get_contents('php://input');

$data = json_decode($postData, true);

if (!array_key_exists('id', $data)) {
    return;
}

$db = mysqli_connect("localhost", "root", "", "loterie");

if (!$db) {
    print('Conexiunea la baza de date a esuat!');
    return;
}

// $query = "INSERT INTO `accounts` (`email`, `upassword`, `username`) VALUES 
//         ('" . $data['email'] . "','" . $data['password'] . "','" . $data['username'] . "')";

$query = "UPDATE `accounts` SET `email` = '" . $data['email'] . "', `upassword` = '" . $data['upassword'] . "', `username` = '" . $data['username'] . "', `access` = " . $data['access'] . " WHERE `id` = " . $data['id'] . "";

$result = mysqli_query($db, $query);

if (!$result) {
    print('Introducerea in baza de date a esuat! Eroare: ' . mysqli_error($db));
} else {
    print "1";
}

mysqli_close($db);
return;
