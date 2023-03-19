<?php
$db = mysqli_connect("185.234.69.234", "carlottery", "gwug4JJAhyFwBVzY", "carloterry");

if (!$db) {
    print('Conexiunea la baza de date a esuat!');
    die();
}
