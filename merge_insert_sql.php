<?php

set_time_limit(0);
ini_set("memory_limit", "8G");

$old_file_path = fopen("/mnt/dc1/MySQL/DT/fp.sql", 'r');
$new_file_path = fopen("/mnt/dc1/MySQL/DT/666.sql", 'w');

$fsql = "INSERT INTO `fp` VALUES ";

$ct = 1;
$thr = 10000;
while (!feof($old_file_path)) {
	$sql = fgets($old_file_path);
	if ($ct % $thr != 0) {
		$sql = str_replace(";\r\n", ",", $sql);
		$sql = str_replace("INSERT INTO `fp` VALUES ", "", $sql);
		$fsql .= $sql;
	} else {
		fwrite($new_file_path, rtrim($fsql, ',') . ';' . "\n");
		$fsql = "INSERT INTO `fp` VALUES ";
	}
	$ct++;
}

fclose($old_file_path);
fclose($new_file_path);
