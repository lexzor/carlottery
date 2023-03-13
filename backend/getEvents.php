<?php
$db = mysqli_connect("localhost", "root", "", "loterie");

if (!$db) {
    print('Conexiunea la baza de date a esuat!');
    die();
}

$query = "SELECT * FROM `events`";

$result = mysqli_query($db, $query);

if (!$result) {
    print('-1');
} else {
    print json_encode(mysqli_fetch_assoc($result));
}

mysqli_close($db);
die();