<?php
$postData = file_get_contents('php://input');

$data = json_decode($postData, true);

if (!array_key_exists('getEvents', $data)) {
    return;
}

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
    $events = array();
    while ($row = mysqli_fetch_assoc($result)) {
        array_push($events, $row);
    }
    print json_encode($events);
}

mysqli_close($db);
die();