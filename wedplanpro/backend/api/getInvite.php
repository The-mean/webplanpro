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
    
    $stmt = $pdo->prepare("SELECT * FROM invites WHERE user_id = ? ORDER BY created_at DESC");
    $stmt->execute([$userId]);
    $invites = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Her davetiye için paylaşım linkini oluştur
    foreach ($invites as &$invite) {
        $invite['invite_link'] = sprintf(
            "%s://%s/wedplanpro/invite.php?code=%s",
            isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off' ? 'https' : 'http',
            $_SERVER['SERVER_NAME'],
            $invite['invite_code']
        );
    }
    
    echo json_encode([
        'success' => true,
        'invites' => $invites
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Veritabanı hatası: ' . $e->getMessage()
    ]);
}
?> 