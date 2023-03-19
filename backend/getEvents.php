<?php
$postData = file_get_contents('php://input');

$data = json_decode($postData, true);

if (!array_key_exists('getEvents', $data)) {
    return;
}

require_once 'dbConn.php';

$query = "SELECT * FROM `events`";

$result = mysqli_query($db, $query);

if (!$result) {
    print('-1');
} else {
    $events = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $row['hashed_id'] = md5($row['id']);
        array_push($events, $row);
    }
    print json_encode($events);
}

mysqli_close($db);
die();
