<?php
require_once '../config/database.php';
require_once '../auth/session.php';

header('Content-Type: application/json');

// Oturum kontrolü
if (!isLoggedIn()) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'Oturum açmanız gerekiyor']);
    exit;
}

// POST verilerini al
$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['task_name']) || !isset($data['due_date'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Gerekli alanlar eksik']);
    exit;
}

try {
    $userId = $_SESSION['user_id'];
    $taskName = $data['task_name'];
    $dueDate = $data['due_date'];
    
    $stmt = $pdo->prepare("INSERT INTO tasks (user_id, task_name, due_date, status) VALUES (?, ?, ?, 'pending')");
    $stmt->execute([$userId, $taskName, $dueDate]);
    
    $taskId = $pdo->lastInsertId();
    
    echo json_encode([
        'success' => true,
        'message' => 'Görev başarıyla eklendi',
        'task_id' => $taskId
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Veritabanı hatası: ' . $e->getMessage()
    ]);
}
?> 