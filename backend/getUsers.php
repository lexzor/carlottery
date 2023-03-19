<?php
$postData = file_get_contents('php://input');

$data = json_decode($postData, true);

if (!array_key_exists('getUsers', $data)) {
    return;
}

require_once 'dbConn.php';

$query = "SELECT * FROM `accounts`";

$result = mysqli_query($db, $query);

if (!$result) {
    print('-1');
} else {
    $udata = array();
    while ($row = mysqli_fetch_assoc($result)) {
        array_push($udata, $row);
    }
    print json_encode($udata);
}

mysqli_close($db);
die();
