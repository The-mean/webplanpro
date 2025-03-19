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

if (!isset($data['item_name']) || !isset($data['amount'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Gerekli alanlar eksik']);
    exit;
}

// Miktar kontrolü
if (!is_numeric($data['amount']) || $data['amount'] <= 0) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Geçerli bir miktar giriniz']);
    exit;
}

try {
    $userId = $_SESSION['user_id'];
    $itemName = $data['item_name'];
    $amount = floatval($data['amount']);
    
    $stmt = $pdo->prepare("INSERT INTO budget (user_id, item_name, amount) VALUES (?, ?, ?)");
    $stmt->execute([$userId, $itemName, $amount]);
    
    $itemId = $pdo->lastInsertId();
    
    echo json_encode([
        'success' => true,
        'message' => 'Harcama başarıyla eklendi',
        'item_id' => $itemId
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Veritabanı hatası: ' . $e->getMessage()
    ]);
}
?> 