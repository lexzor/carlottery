<?php
require_once 'corsHeaders.php';

$_POST = json_decode(file_get_contents('php://input'), true);

$data = $_POST;

if (!array_key_exists('id', $data)) {
    return;
}

require_once 'dbConn.php';

if ($data['cart'] == 'NULL') {
    $query = "UPDATE `accounts` SET `cart` = NULL WHERE `id` = " . $data['id'] . "";
} else {
    $query = "UPDATE `accounts` SET `cart` = '" . $data['cart'] . "' WHERE `id` = " . $data['id'] . "";
}

$result = mysqli_query($db, $query);

if (!$result) {
    print('-1');
} else {
    print json_encode($data);
}

mysqli_close($db);
die();
