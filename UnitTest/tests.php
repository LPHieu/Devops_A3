<?php
require_once 'functions.php';

$allTestCount = 0;
$passTestCount = 0;
$failArr = array();

function pass(&$passTestCount){
    echo "PASS\n";
    $passTestCount = ++$passTestCount;
}

function fail($testCase, &$failArr){
    echo "FAIL: $testCase fail\n";
    array_push($failArr, "Test $testCase fail");
}

echo "UNIT TESTING\n";

$link = mysqli_connect(
    getenv("DBHost"),
    "db_admin",
    "rmit_password",
    "rmit_store_db",
    getenv("DBPort")
);


if (!$link) {
    array_push($failArr, "Database connection error");
    echo "ERROR: " . mysqli_connect_errno() . ": " . mysqli_connect_error() . "\n";
}else {
    $testId1 = 8388606;
    $testId2 = 8388607;
    $testName1 = 'testName1';
    $testName2 = 'testName2';

    // Before: Setup
    mysqli_query($link, "INSERT INTO store (id, Name, Price, ImageUrl) VALUES ('$testId1','$testName1', '10', 'p-1.jpg'), ('$testId2', '$testName2', '20', 'p-2.jpg');");

    // TEST 1
    $testCase = "Get all product";
    echo "Test case 1: $testCase\n";
    $allTestCount = ++$allTestCount;
    $expected = 2;
    $actual = count(getAllProd($link));
    if($actual >= $expected){
        pass($passTestCount);
    }else {
        fail($testCase, $failArr);
    }

    // TEST 2
    $testCase = "Get product by id '$testId1'";
    echo "Test case 2: $testCase\n";
    $allTestCount = ++$allTestCount;
    $expectedCount = 1;
    $expectedName = $testName1;
    $expectedPrice = 10;

    $actual = getProdById($link, $testId1);
    $actualCount = count($actual);
    $actualName = $actual[0]["Name"];
    $actualPrice = $actual[0]["Price"];

    if($actualCount == $expectedCount &&  $actualName == $expectedName && $actualPrice == $expectedPrice){
        pass($passTestCount);
    }else {
        fail($testCase, $failArr);
    }

    // TEST 3
    $testCase = "Get product by id '$testId2'";
    echo "Test case 3: $testCase\n";
    $allTestCount = ++$allTestCount;
    $expectedCount = 1;
    $expectedName = $testName2;
    $expectedPrice = 20;

    $actual = getProdById($link, $testId2);
    $actualCount = count($actual);
    $actualName = $actual[0]["Name"];
    $actualPrice = $actual[0]["Price"];

    if($actualCount == $expectedCount &&  $actualName == $expectedName && $actualPrice == $expectedPrice){
        pass($passTestCount);
    }else {
        fail($testCase, $failArr);
    }

    // TEST 4
    $testCase = "Find product by name 'test'";
    echo "Test case 4: $testCase\n";
    $allTestCount = ++$allTestCount;
    $expectedCount = 2;

    $actual = findProdByName($link, "test");
    $actualCount = count($actual);

    if($actualCount >= $expectedCount){
        pass($passTestCount);
    }else {
        fail($testCase, $failArr);
    }

    // TEST 5
    $testCase = "Find product by name '$testName1'";
    echo "Test case 5: $testCase\n";
    $allTestCount = ++$allTestCount;
    $expectedCount = 1;

    $actual = findProdByName($link, $testName1);
    $actualCount = count($actual);

    if($actualCount == $expectedCount){
        pass($passTestCount);
    }else {
        fail($testCase, $failArr);
    }
    // After: delete testing data
    mysqli_query($link, "DELETE FROM store WHERE id='$testId1' OR id='$testId2';");
}

// Result
echo "\n";
$passPercent = $passTestCount/$allTestCount*100;
echo "Unit test result: pass $passTestCount/$allTestCount test ($passPercent%)\n";
echo "$passPercent\n";
echo "FAIL: " . implode('; ', $failArr) . "\n";

?>