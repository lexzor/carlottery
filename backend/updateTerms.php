<?php
require_once 'corsHeaders.php';

$_POST = json_decode(file_get_contents('php://input'), true);

$data = $_POST;

if (!array_key_exists('terms_content', $data)) {
    return;
}
require_once 'dbConn.php';

$query = "UPDATE `configuration` SET `content` = '" . $data['terms_content'] . "' WHERE `type` = 'terms'";

$result = mysqli_query($db, $query);

$affRows = mysqli_affected_rows($db);

if ($affRows == 1) {
    print(json_encode(["be_msg_success" => 1]));
} else {
    print(json_encode(["be_msg_error" => 'Numarul de coloane schimbate in baza de date: ' . $affRows]));
}

mysqli_close($db);
die();
