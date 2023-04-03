<?php
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
require_once 'corsHeaders.php';

// $_POST = json_decode(file_get_contents('php://input'), true);

// echo json_encode($_POST);

if (!isset($_POST['title'])) {
    return;
}

require_once 'dbConn.php';

$eventFolder = $_POST['imageFolder'];

if (array_key_exists("deleteImages", $_POST)) {
    foreach ($_POST['deleteImages'] as $image) {
        if (file_exists($image)) {
            unlink($image);
        }
    }
}


$imagesArr = array();

if (array_key_exists("notDeletedImgs", $_POST)) {
    foreach ($_POST['notDeletedImgs'] as $image) {
        array_push($imagesArr, $image);
    }
}

$query = '';

if (array_key_exists("images", $_FILES)) {
    $errorObj = array("be_msg_error" => "uploaded_file_errors", "errors" => array());

    foreach ($_FILES['images']['tmp_name'] as $key => $tmp_name) {
        $file_name = $_FILES['images']['name'][$key];
        $file_tmp = $_FILES['images']['tmp_name'][$key];

        $dynamicPath = "./events_images/" . $eventFolder . "/" . $key . $eventFolder . $file_name;

        if (!move_uploaded_file($file_tmp, $dynamicPath)) {
            $fileErr = "File " . $file_name . " has encountered an error while trying to be moved in " . substr($dynamicPath, 2);
            array_push($errorObj["errors"], $fileErr);
        } else {
            array_push($imagesArr, substr($dynamicPath, 2));
        }
    }

    if (sizeof($errorObj["errors"]) > 0) {
        print(json_encode($errorObj));
        return;
    }

    $query = "UPDATE `events` SET `title` = '" . $_POST['title'] . "', `start` = '" . $_POST['start'] . "', `end` = '" . $_POST['end'] . "', `max_tickets` = " . $_POST['max_tickets'] . ", `price` = " . $_POST['price'] . ", `description` = '" . $_POST['description'] . "', `images` = '" . json_encode($imagesArr) . "' WHERE `id` = " . $_POST['id'] . "";
} else {
    $query = "UPDATE `events` SET `title` = '" . $_POST['title'] . "', `start` = '" . $_POST['start'] . "', `end` = '" . $_POST['end'] . "', `max_tickets` = " . $_POST['max_tickets'] . ", `price` = " . $_POST['price'] . ", `description` = '" . $_POST['description'] . "' WHERE `id` = " . $_POST['id'] . "";
}

$result = mysqli_query($db, $query);

if (!$result) {
    print(json_encode(["be_msg_error" => "database_insert_error", "error" => mysqli_error($db)]));
} else {
    print(json_encode(array("be_msg_success" => "success")));
}

mysqli_close($db);
return;