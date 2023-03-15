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

$query = "DELETE FROM `events` WHERE `id` = '" . $data['id'] . "'";

$result = mysqli_query($db, $query);

if (!$result) {
    print json_encode(["be_msg_error" => "not_deleted"]);
    return;
}

foreach ($data['imgs'] as $folder) {
    $path = './events_images/' . $folder;
    if (file_exists($path)) {
        $it = new RecursiveDirectoryIterator($path, RecursiveDirectoryIterator::SKIP_DOTS);

        $files = new RecursiveIteratorIterator($it, RecursiveIteratorIterator::CHILD_FIRST);

        foreach ($files as $file) {
            unlink($file->getRealPath());
        }

        if (!rmdir($path)) {
            print json_encode(["cant_delete" => "folder_not_exists", "path" => $path]);
            return;
        }
    } else {
        print json_encode(["be_msg_error" => "folder_not_exists", "path" => $path]);
        return;
    }
}

print json_encode(["be_msg_success" => "success"]);

mysqli_close($db);
die();
