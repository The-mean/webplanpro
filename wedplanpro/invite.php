<?php
require_once 'backend/config/database.php';

// Davetiye kodunu kontrol et
if (!isset($_GET['code'])) {
    header('Location: index.php');
    exit;
}

$inviteCode = $_GET['code'];

try {
    // Davetiyeyi veritabanından al
    $stmt = $pdo->prepare("SELECT i.*, u.name as user_name FROM invites i JOIN users u ON i.user_id = u.id WHERE i.invite_code = ?");
    $stmt->execute([$inviteCode]);
    $invite = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$invite) {
        header('Location: index.php');
        exit;
    }
} catch (PDOException $e) {
    header('Location: index.php');
    exit;
}
?>
<!DOCTYPE html>
<html lang="tr" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Düğün Davetiyesi - WedPlanPro</title>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@3.9.4/dist/full.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2/dist/tailwind.min.css" rel="stylesheet">
    <link href="frontend/style.css" rel="stylesheet">
</head>
<body class="min-h-screen bg-base-200">
    <div class="container mx-auto px-4 py-8">
        <div class="card bg-base-100 shadow-xl max-w-2xl mx-auto">
            <div class="card-body text-center">
                <h1 class="text-4xl font-bold mb-6">Düğünümüze Davetlisiniz</h1>
                
                <div class="divider"></div>
                
                <div class="space-y-4">
                    <p class="text-xl"><?php echo htmlspecialchars($invite['user_name']); ?></p>
                    <p class="text-lg">Düğünümüze katılmanızdan mutluluk duyarız.</p>
                    
                    <?php if ($invite['theme'] === 'classic'): ?>
                    <div class="bg-base-200 p-6 rounded-lg">
                        <p class="text-2xl font-serif mb-4">Sevgi ve Mutlulukla</p>
                        <p class="text-lg">Sizleri düğünümüzde görmekten onur duyacağız.</p>
                    </div>
                    <?php elseif ($invite['theme'] === 'modern'): ?>
                    <div class="bg-gradient-to-r from-purple-500 to-pink-500 p-6 rounded-lg text-white">
                        <p class="text-2xl font-sans mb-4">Modern & Şık</p>
                        <p class="text-lg">Hayatımızın en özel gününde sizleri aramızda görmekten mutluluk duyacağız.</p>
                    </div>
                    <?php else: ?>
                    <div class="bg-base-200 p-6 rounded-lg">
                        <p class="text-2xl mb-4">Özel Davet</p>
                        <p class="text-lg">Bu mutlu günümüzde sizleri aramızda görmekten mutluluk duyacağız.</p>
                    </div>
                    <?php endif; ?>
                    
                    <div class="mt-8">
                        <p class="text-lg">Tarih: <?php echo date('d.m.Y', strtotime($invite['created_at'])); ?></p>
                        <p class="text-lg">Saat: 19:00</p>
                        <p class="text-lg">Yer: Düğün Salonu</p>
                    </div>
                </div>
                
                <div class="divider"></div>
                
                <div class="flex justify-center space-x-4">
                    <button class="btn btn-primary" onclick="confirmAttendance()">Katılıyorum</button>
                    <button class="btn btn-ghost" onclick="declineAttendance()">Katılamıyorum</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function confirmAttendance() {
            alert('Katılımınız için teşekkür ederiz!');
        }
        
        function declineAttendance() {
            alert('Katılamayacağınız için üzgünüz. Başka bir zaman görüşmek dileğiyle!');
        }
    </script>
</body>
</html> 