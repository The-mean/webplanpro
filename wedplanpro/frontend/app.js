document.addEventListener('DOMContentLoaded', function () {
    // Form elementleri
    const loginForm = document.getElementById('loginForm');
    const registerForm = document.getElementById('registerForm');
    const tabs = document.querySelectorAll('.tab');
    const paymentButton = document.getElementById('paymentButton');

    // Toast elementleri
    const successToast = document.getElementById('successToast');
    const errorToast = document.getElementById('errorToast');
    const successMessage = document.getElementById('successMessage');
    const errorMessage = document.getElementById('errorMessage');

    // Stripe başlatma
    const stripe = Stripe('YOUR_PUBLISHABLE_KEY'); // Stripe public key'inizi buraya ekleyin

    // Toast gösterme fonksiyonu
    function showToast(message, isError = false) {
        if (isError) {
            errorMessage.textContent = message;
            errorToast.classList.remove('hidden');
            setTimeout(() => errorToast.classList.add('hidden'), 3000);
        } else {
            successMessage.textContent = message;
            successToast.classList.remove('hidden');
            setTimeout(() => successToast.classList.add('hidden'), 3000);
        }
    }

    // Tab değiştirme işlevi
    if (tabs.length > 0) {
        tabs.forEach(tab => {
            tab.addEventListener('click', function () {
                const targetTab = this.getAttribute('data-tab');

                // Tab stillerini güncelle
                tabs.forEach(t => t.classList.remove('tab-active'));
                this.classList.add('tab-active');

                // Formları göster/gizle
                if (targetTab === 'login') {
                    loginForm.classList.remove('hidden');
                    registerForm.classList.add('hidden');
                } else {
                    loginForm.classList.add('hidden');
                    registerForm.classList.remove('hidden');
                }
            });
        });
    }

    // Giriş formu gönderimi
    if (loginForm) {
        loginForm.addEventListener('submit', async function (e) {
            e.preventDefault();
            const formData = new FormData(this);
            const data = Object.fromEntries(formData.entries());

            try {
                const response = await fetch('/wedplanpro/backend/auth/login.php', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(data)
                });

                const result = await response.json();

                if (result.success) {
                    showToast('Giriş başarılı! Yönlendiriliyorsunuz...');
                    setTimeout(() => {
                        window.location.href = result.redirect;
                    }, 1500);
                } else {
                    showToast(result.message || 'Giriş başarısız!', true);
                }
            } catch (error) {
                console.error('Hata:', error);
                showToast('Bir hata oluştu!', true);
            }
        });
    }

    // Kayıt formu gönderimi
    if (registerForm) {
        registerForm.addEventListener('submit', async function (e) {
            e.preventDefault();
            const formData = new FormData(this);
            const data = Object.fromEntries(formData.entries());

            try {
                const response = await fetch('/wedplanpro/backend/auth/register.php', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(data)
                });

                const result = await response.json();

                if (result.success) {
                    showToast('Kayıt başarılı! Giriş yapabilirsiniz.');
                    this.reset();
                    document.querySelector('[data-tab="login"]').click();
                } else {
                    showToast(result.message || 'Kayıt başarısız!', true);
                }
            } catch (error) {
                console.error('Hata:', error);
                showToast('Bir hata oluştu!', true);
            }
        });
    }

    // Ödeme butonu işlevi
    if (paymentButton) {
        paymentButton.addEventListener('click', async function () {
            try {
                // Ödeme oturumu oluştur
                const response = await fetch('/wedplanpro/backend/payment/stripePayment.php', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        amount: 4900 // 49$ (cent cinsinden)
                    })
                });

                const result = await response.json();

                if (result.success) {
                    // Stripe Checkout'a yönlendir
                    const { error } = await stripe.redirectToCheckout({
                        sessionId: result.sessionId
                    });

                    if (error) {
                        showToast('Ödeme başlatılamadı!', true);
                    }
                } else {
                    showToast(result.message || 'Ödeme başlatılamadı!', true);
                }
            } catch (error) {
                console.error('Hata:', error);
                showToast('Bir hata oluştu!', true);
            }
        });
    }
}); 