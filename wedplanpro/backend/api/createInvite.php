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

if (!isset($data['theme'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Tema seçimi gerekli']);
    exit;
}

try {
    $userId = $_SESSION['user_id'];
    $theme = $data['theme'];
    $inviteCode = bin2hex(random_bytes(16)); // Benzersiz davetiye kodu oluştur
    
    $stmt = $pdo->prepare("INSERT INTO invites (user_id, theme, invite_code) VALUES (?, ?, ?)");
    $stmt->execute([$userId, $theme, $inviteCode]);
    
    $inviteId = $pdo->lastInsertId();
    
    // Davetiye linkini oluştur
    $inviteLink = sprintf(
        "%s://%s/wedplanpro/invite.php?code=%s",
        isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off' ? 'https' : 'http',
        $_SERVER['SERVER_NAME'],
        $inviteCode
    );
    
    echo json_encode([
        'success' => true,
        'message' => 'Davetiye başarıyla oluşturuldu',
        'invite_id' => $inviteId,
        'invite_link' => $inviteLink
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Veritabanı hatası: ' . $e->getMessage()
    ]);
}
?> 