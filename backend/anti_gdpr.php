<?php
require_once 'corsHeaders.php';


$array = array();

array_push($array, [
    "question" => "Intrebare 1",
    "a" => "1Raspuns a",
    "b" => "1Raspuns b",
    "c" => "1Raspuns c (corect)"
]);

array_push($array, [
    "question" => "Intrebare 2",
    "a" => "2Raspuns a",
    "b" => "2Raspuns b",
    "c" => "2Raspuns c (corect)"
]);

array_push($array, [
    "question" => "Intrebare 3",
    "a" => "3Raspuns a",
    "b" => "3Raspuns b",
    "c" => "3Raspuns c (corect)"
]);

print json_encode($array);

die();