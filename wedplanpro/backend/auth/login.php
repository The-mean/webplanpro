<?php
session_start();
header('Content-Type: application/json');

require_once '../db/db.php';

// POST verilerini al
$data = json_decode(file_get_contents('php://input'), true);

// Gerekli alanları kontrol et
if (!isset($data['email']) || !isset($data['password'])) {
    echo json_encode(['success' => false, 'message' => 'Tüm alanları doldurun!']);
    exit;
}

try {
    $database = new Database();
    $db = $database->getConnection();

    // Kullanıcıyı bul
    $stmt = $db->prepare("SELECT id, name, password_hash FROM users WHERE email = ?");
    $stmt->execute([$data['email']]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user || !password_verify($data['password'], $user['password_hash'])) {
        echo json_encode(['success' => false, 'message' => 'E-posta veya şifre hatalı!']);
        exit;
    }

    // Ödeme kontrolü
    $stmt = $db->prepare("SELECT id FROM payments WHERE user_id = ? AND status = 'active'");
    $stmt->execute([$user['id']]);
    $hasPayment = $stmt->rowCount() > 0;

    // Session'a kullanıcı bilgilerini kaydet
    $_SESSION['user_id'] = $user['id'];
    $_SESSION['user_name'] = $user['name'];
    $_SESSION['has_payment'] = $hasPayment;

    echo json_encode([
        'success' => true,
        'message' => 'Giriş başarılı!',
        'user' => [
            'name' => $user['name'],
            'has_payment' => $hasPayment
        ],
        'redirect' => $hasPayment ? '/wedplanpro/frontend/dashboard.html' : '/wedplanpro/frontend/paymentRequired.html'
    ]);

} catch(PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Veritabanı hatası: ' . $e->getMessage()]);
}
?> 