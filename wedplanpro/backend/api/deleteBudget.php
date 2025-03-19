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

// ID parametresini kontrol et
if (!isset($_GET['id'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Harcama ID\'si gerekli']);
    exit;
}

try {
    $userId = $_SESSION['user_id'];
    $itemId = $_GET['id'];
    
    // Önce harcamanın kullanıcıya ait olduğunu kontrol et
    $stmt = $pdo->prepare("SELECT user_id FROM budget WHERE id = ?");
    $stmt->execute([$itemId]);
    $item = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$item || $item['user_id'] != $userId) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Bu harcamayı silme yetkiniz yok']);
        exit;
    }
    
    // Harcamayı sil
    $stmt = $pdo->prepare("DELETE FROM budget WHERE id = ? AND user_id = ?");
    $stmt->execute([$itemId, $userId]);
    
    if ($stmt->rowCount() > 0) {
        echo json_encode([
            'success' => true,
            'message' => 'Harcama başarıyla silindi'
        ]);
    } else {
        http_response_code(404);
        echo json_encode([
            'success' => false,
            'message' => 'Harcama bulunamadı'
        ]);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Veritabanı hatası: ' . $e->getMessage()
    ]);
}
?> 