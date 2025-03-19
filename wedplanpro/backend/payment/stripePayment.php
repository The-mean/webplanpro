<?php
session_start();
header('Content-Type: application/json');

require_once '../db/db.php';
require_once 'vendor/autoload.php';

// Stripe API anahtarını ayarla
\Stripe\Stripe::setApiKey('YOUR_SECRET_KEY'); // Stripe secret key'inizi buraya ekleyin

// Oturum kontrolü
if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'Oturum açmanız gerekiyor!']);
    exit;
}

// POST verilerini al
$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['amount'])) {
    echo json_encode(['success' => false, 'message' => 'Geçersiz istek!']);
    exit;
}

try {
    // Stripe Checkout oturumu oluştur
    $checkout_session = \Stripe\Checkout\Session::create([
        'payment_method_types' => ['card'],
        'line_items' => [[
            'price_data' => [
                'currency' => 'usd',
                'product_data' => [
                    'name' => 'WedPlanPro Premium Üyelik',
                    'description' => '1 yıllık premium üyelik',
                ],
                'unit_amount' => $data['amount'],
            ],
            'quantity' => 1,
        ]],
        'mode' => 'payment',
        'success_url' => 'https://your-domain.com/wedplanpro/frontend/paymentSuccess.html?session_id={CHECKOUT_SESSION_ID}',
        'cancel_url' => 'https://your-domain.com/wedplanpro/frontend/paymentRequired.html',
        'client_reference_id' => $_SESSION['user_id'],
    ]);

    echo json_encode([
        'success' => true,
        'sessionId' => $checkout_session->id
    ]);

} catch(Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Ödeme oturumu oluşturulamadı: ' . $e->getMessage()
    ]);
}
?> 