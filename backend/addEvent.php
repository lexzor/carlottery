<?php
$postData = file_get_contents('php://input');

if (!isset($_POST['title'])) {
    return;
}

$db = mysqli_connect("localhost", "root", "", "loterie");

if (!$db) {
    print json_encode(array(["be_msg_error" => "fail_create_main_dir"]));
    return;
}


if (!file_exists('events_images')) {
    if (!mkdir('events_images')) {
        print json_encode(array(["be_msg_error" => "fail_create_main_dir"]));
        return;
    }
}

$folder = './events_images/' . time();

if (!file_exists($folder)) {
    mkdir($folder);
}

$errorObj = array("be_msg_error" => "uploaded_file_errors", "errors" => array());
$imagesArr = array();

foreach ($_FILES['images']['tmp_name'] as $key => $tmp_name) {
    $file_name = $_FILES['images']['name'][$key];
    $file_tmp = $_FILES['images']['tmp_name'][$key];

    $dynamicPath = $folder . "/" . time() . $key . $file_name;

    if (!move_uploaded_file($file_tmp, $dynamicPath)) {
        $fileErr = "File " . $file_name . " has encountered an error while trying to be moved in " . substr($dynamicPath, 2);
        array_push($errorObj["errors"], $fileErr);
    } else {
        array_push($imagesArr, substr($dynamicPath, 2));
    }
}

if (sizeof($errorObj["errors"]) > 0) {
    print(json_encode($errorObj));
}

$query = "INSERT INTO `events` (`title`, `start`, `end`, `max_tickets`, `description`, `images`, `price`) VALUES 
        ('" . $_POST['title'] . "','" . $_POST['start'] . "','" . $_POST['end'] . "','" . $_POST['max_tickets'] . "','" . $_POST['description'] . "','" . json_encode($imagesArr) . "', " . $_POST['price'] . ")";


$result = mysqli_query($db, $query);

if (!$result) {
    print(json_encode(["be_msg_error" => "database_insert_error", "error" => mysqli_error($db)]));
} else {
    print(json_encode(array("be_msg_success" => "success", "images" => json_encode($imagesArr), "eventId" => $db->insert_id)));
}

mysqli_close($db);
return;
