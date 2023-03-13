<?php
$postData = file_get_contents('php://input');

$data = json_decode($postData, true);

$db = mysqli_connect("localhost", "root", "", "loterie");

if (!$db) {
    print('Conexiunea la baza de date a esuat!');
    return;
}

if (!isset($_FILES['images[]'])) {
    print json_encode(["be_msg" => "no_images"]);
    return;
}

if (!file_exists('events_images')) {
    if (!mkdir('events_images')) {
        print json_encode(array(["be_msg" => "fail_create_main_dir"]));
        return;
    }
}

$query = "SELECT MAX(id) FROM `events`";

$result = mysqli_query($db, $query);

$db_id = mysqli_fetch_assoc($result);

$id = 1;

if ($db_id['MAX(id)']) {
    $id = $db_id['MAX(id)'] + 1;
}

$folder = './events_images/' . $id;

if (!file_exists($folder)) {
    if (!mkdir($folder)) {
        print json_encode(["be_msg" => "fail_create_event_dir", "dir_name" => $id]);
        return;
    }
}
//  else {
//     print json_encode(["be_msg" => "event_dir_exists"]);
//     return;
// }

print $_FILES['file'];

return;

$query = "INSERT INTO `events` (`title`, `start`, `end`, `max_tickets`, `description`, `images`) VALUES 
        ('" . $data['title'] . "','" . $data['start'] . "','" . $data['end'] . "','" . $data['max_tickets'] . "','" . $data['description'] . "','" . $data['end'] . "')";

$result = mysqli_query($db, $query);

if (!$result) {
    print('Introducerea in baza de date a esuat! Eroare: ' . mysqli_error($db));
} else {
    print "1";
}

mysqli_close($db);
return;