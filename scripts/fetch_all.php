<?php
// fetch_all.php

ini_set('display_errors', '1');
error_reporting(E_ALL);

$options = getopt("", ["host::","port::","user::","pass::","db::","json::"]);

$host = $options['host'] ?? getenv('DB_HOST') ?: getenv('MYSQL_HOST') ?: 'db';
$port = $options['port'] ?? getenv('DB_PORT') ?: '--A COMPLETER--'; //Port à compléter
$user = $options['user'] ?? getenv('MYSQL_USER') ?: '--A COMPLETER--';//User à compléter 
$pass = $options['pass'] ?? getenv('MYSQL_PASSWORD') ?: '--A COMPLETER--';//Password à compléter
$db   = $options['db']   ?? getenv('MYSQL_DATABASE') ?: '--A COMPLETER--';//Database à compléter
$jsonFile = $options['json'] ?? null;

$dsn = "mysql:host={$host};port={$port};dbname={$db};charset=utf8mb4";

try {
    $pdo = new PDO($dsn, $user, $pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (PDOException $e) {
    fwrite(STDERR, "Connection failed: " . $e->getMessage() . PHP_EOL);
    exit(2);
}

// get list of tables in this schema
$stmt = $pdo->prepare("SELECT TABLE_NAME FROM information_schema.tables WHERE table_schema = :db");
$stmt->execute(['db' => $db]);
$tables = $stmt->fetchAll(PDO::FETCH_COLUMN);

$result = [];
foreach ($tables as $table) {
    try {
        // fetch column names first (nullable)
        $colStmt = $pdo->prepare("SELECT COLUMN_NAME FROM information_schema.columns WHERE table_schema = :db AND table_name = :table ORDER BY ORDINAL_POSITION");
        $colStmt->execute(['db' => $db, 'table' => $table]);
        $cols = $colStmt->fetchAll(PDO::FETCH_COLUMN);

        // fetch rows
        $q = $pdo->query("SELECT * FROM `" . str_replace("`","``",$table) . "`");
        $rows = $q->fetchAll();

        $result[$table] = [
            'columns' => $cols,
            'rows' => $rows,
            'count' => count($rows),
        ];
    } catch (PDOException $e) {
        // if a table cannot be read, record the error and continue
        $result[$table] = [
            'error' => $e->getMessage(),
        ];
    }
}

$output = json_encode($result, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
if ($jsonFile) {
    if (false === file_put_contents($jsonFile, $output)) {
        fwrite(STDERR, "Failed to write to $jsonFile\n");
        exit(3);
    }
    echo "Wrote JSON to $jsonFile\n";
} else {
    echo $output . PHP_EOL;
}
