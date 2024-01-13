<?php

function getAllProd($link){
    $res = mysqli_query($link, "SELECT * FROM store;");
    return mysqli_fetch_all($res, MYSQLI_ASSOC);
}

function getProdById($link, $id){
    $res = mysqli_query($link, "SELECT * FROM store WHERE id='$id';");
    return mysqli_fetch_all($res, MYSQLI_ASSOC);
}

function findProdByName($link, $string){
    $res = mysqli_query($link, "SELECT * FROM store WHERE name LIKE '%$string%';");
    return mysqli_fetch_all($res, MYSQLI_ASSOC);
}
