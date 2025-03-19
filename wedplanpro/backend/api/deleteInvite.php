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
    echo json_encode(['success' => false, 'message' => 'Davetiye ID\'si gerekli']);
    exit;
}

try {
    $userId = $_SESSION['user_id'];
    $inviteId = $_GET['id'];
    
    // Önce davetiyenin kullanıcıya ait olduğunu kontrol et
    $stmt = $pdo->prepare("SELECT user_id FROM invites WHERE id = ?");
    $stmt->execute([$inviteId]);
    $invite = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$invite || $invite['user_id'] != $userId) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'Bu davetiyeyi silme yetkiniz yok']);
        exit;
    }
    
    // Davetiyeyi sil
    $stmt = $pdo->prepare("DELETE FROM invites WHERE id = ? AND user_id = ?");
    $stmt->execute([$inviteId, $userId]);
    
    if ($stmt->rowCount() > 0) {
        echo json_encode([
            'success' => true,
            'message' => 'Davetiye başarıyla silindi'
        ]);
    } else {
        http_response_code(404);
        echo json_encode([
            'success' => false,
            'message' => 'Davetiye bulunamadı'
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