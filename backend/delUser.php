<?php
$postData = file_get_contents('php://input');

$data = json_decode($postData, true);

if (!array_key_exists('id', $data)) {
    return;
}

$db = mysqli_connect("localhost", "root", "", "loterie");

if (!$db) {
    print json_encode(["be_msg_error" => "db_conn_error"]);
    die();
}

$query = "DELETE FROM `accounts` WHERE `id` = '" . $data['id'] . "'";

$result = mysqli_query($db, $query);

if (!$result) {
    print("-1");
    return;
}

print "1";

mysqli_close($db);
die();
