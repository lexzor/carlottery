<?php
$postData = file_get_contents('php://input');

$data = json_decode($postData, true);

if (
    strlen($data['password']) == 0 ||
    strlen($data['username']) == 0 ||
    strlen($data['email']) == 0
) {
    print 'The form must be completed!';
    return;
}

$db = mysqli_connect("localhost", "root", "", "loterie");

if (!$db) {
    print('Conexiunea la baza de date a esuat!');
    die();
}

$query = "INSERT INTO `accounts` (`email`, `upassword`, `username`) VALUES 
        ('" . $data['email'] . "','" . $data['password'] . "','" . $data['username'] . "')";

$result = mysqli_query($db, $query);

if (!$result) {
    print('Introducerea in baza de date a esuat! Eroare: ' . mysqli_error($db));
} else {
    print "1";
}

mysqli_close($db);
die();
