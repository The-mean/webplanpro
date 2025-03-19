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

try {
    $userId = $_SESSION['user_id'];
    
    $stmt = $pdo->prepare("SELECT * FROM budget WHERE user_id = ? ORDER BY created_at DESC");
    $stmt->execute([$userId]);
    $items = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Toplam bütçeyi hesapla
    $total = 0;
    foreach ($items as $item) {
        $total += floatval($item['amount']);
    }
    
    echo json_encode([
        'success' => true,
        'items' => $items,
        'total' => $total
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Veritabanı hatası: ' . $e->getMessage()
    ]);
}
?> 