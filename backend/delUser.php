<?php
$postData = file_get_contents('php://input');

$data = json_decode($postData, true);

if (!array_key_exists('id', $data)) {
    return;
}

require_once 'dbConn.php';

$query = "DELETE FROM `accounts` WHERE `id` = '" . $data['id'] . "'";

$result = mysqli_query($db, $query);

if (!$result) {
    print("-1");
    return;
}

print "1";

mysqli_close($db);
die();
