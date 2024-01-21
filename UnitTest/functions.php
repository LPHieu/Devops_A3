<!-- RMIT University Vietnam
Course: COSC2767 Systems Deployment and Operations
Semester: 2023C
Assessment: Assignment 3
Author: Group 3
Created  date: 02/01/2023
Last modified: 20/01/2023
Acknowledgement: None -->

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
