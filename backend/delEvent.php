<?php
$postData = file_get_contents('php://input');

$data = json_decode($postData, true);

if (!array_key_exists('id', $data)) {
    return;
}

print json_encode(["be_msg_success" => "deleted"]);

// $db = mysqli_connect("localhost", "root", "", "loterie");

// if (!$db) {
//     print('Conexiunea la baza de date a esuat!');
//     die();
// }

// $query = "DELETE * FROM `events` WHERE `id` = '".$data['id']."'";

// $result = mysqli_query($db, $query);

// if (!$result) {
//     print json_encode(["be_msg_error" => "not_deleted"]);
// } else {
//     print json_encode(["be_msg_success" => "deleted"]);
// }

// mysqli_close($db);
die();
