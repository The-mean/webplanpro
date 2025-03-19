document.addEventListener('DOMContentLoaded', function () {
    // Tab değiştirme işlevi
    const tabs = document.querySelectorAll('.tab');
    const sections = document.querySelectorAll('.section-content');

    tabs.forEach(tab => {
        tab.addEventListener('click', function () {
            const targetTab = this.getAttribute('data-tab');

            // Tab stillerini güncelle
            tabs.forEach(t => t.classList.remove('tab-active'));
            this.classList.add('tab-active');

            // Bölümleri göster/gizle
            sections.forEach(section => {
                if (section.id === targetTab + 'Section') {
                    section.classList.remove('hidden');
                } else {
                    section.classList.add('hidden');
                }
            });
        });
    });

    // Toast mesajları
    function showToast(message, isError = false) {
        const successToast = document.getElementById('successToast');
        const errorToast = document.getElementById('errorToast');
        const successMessage = document.getElementById('successMessage');
        const errorMessage = document.getElementById('errorMessage');

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

    // Modal işlevleri
    const addTaskModal = document.getElementById('addTaskModal');
    const addBudgetModal = document.getElementById('addBudgetModal');
    const createInviteModal = document.getElementById('createInviteModal');

    window.openAddTaskModal = function () {
        addTaskModal.showModal();
    }

    window.closeAddTaskModal = function () {
        addTaskModal.close();
    }

    window.openAddBudgetModal = function () {
        addBudgetModal.showModal();
    }

    window.closeAddBudgetModal = function () {
        addBudgetModal.close();
    }

    window.openCreateInviteModal = function () {
        createInviteModal.showModal();
    }

    window.closeCreateInviteModal = function () {
        createInviteModal.close();
    }

    // API çağrıları
    async function fetchTasks() {
        try {
            const response = await fetch('/wedplanpro/backend/api/getTasks.php');
            const data = await response.json();

            if (data.success) {
                const tasksList = document.getElementById('tasksList');
                tasksList.innerHTML = data.tasks.map(task => `
                    <tr class="table-row">
                        <td>${task.task_name}</td>
                        <td>${task.due_date}</td>
                        <td>
                            <span class="badge ${task.status === 'completed' ? 'badge-success' : 'badge-warning'}">
                                ${task.status}
                            </span>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-circle btn-ghost" onclick="deleteTask(${task.id})">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
                                </svg>
                            </button>
                        </td>
                    </tr>
                `).join('');

                document.getElementById('taskCount').textContent = data.tasks.length;
            }
        } catch (error) {
            console.error('Hata:', error);
            showToast('Görevler yüklenirken bir hata oluştu!', true);
        }
    }

    async function fetchBudget() {
        try {
            const response = await fetch('/wedplanpro/backend/api/getBudget.php');
            const data = await response.json();

            if (data.success) {
                const budgetList = document.getElementById('budgetList');
                budgetList.innerHTML = data.items.map(item => `
                    <tr class="table-row">
                        <td>${item.item_name}</td>
                        <td>$${item.amount}</td>
                        <td>${new Date(item.created_at).toLocaleDateString()}</td>
                        <td>
                            <button class="btn btn-sm btn-circle btn-ghost" onclick="deleteBudgetItem(${item.id})">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
                                </svg>
                            </button>
                        </td>
                    </tr>
                `).join('');

                const total = data.items.reduce((sum, item) => sum + parseFloat(item.amount), 0);
                document.getElementById('totalBudget').textContent = '$' + total.toFixed(2);
            }
        } catch (error) {
            console.error('Hata:', error);
            showToast('Bütçe bilgileri yüklenirken bir hata oluştu!', true);
        }
    }

    async function fetchInvites() {
        try {
            const response = await fetch('/wedplanpro/backend/api/getInvite.php');
            const data = await response.json();

            if (data.success) {
                const invitesList = document.getElementById('invitesList');
                invitesList.innerHTML = data.invites.map(invite => `
                    <div class="card-container">
                        <div class="card-header">
                            <h3 class="card-title">Davetiye #${invite.id}</h3>
                        </div>
                        <div class="card-content">
                            <p>Tema: ${invite.theme}</p>
                            <p>Link: ${invite.invite_link}</p>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-primary btn-sm" onclick="copyInviteLink('${invite.invite_link}')">
                                Linki Kopyala
                            </button>
                            <button class="btn btn-ghost btn-sm" onclick="deleteInvite(${invite.id})">
                                Sil
                            </button>
                        </div>
                    </div>
                `).join('');

                document.getElementById('inviteCount').textContent = data.invites.length;
            }
        } catch (error) {
            console.error('Hata:', error);
            showToast('Davetiyeler yüklenirken bir hata oluştu!', true);
        }
    }

    // Form gönderme işlevleri
    window.saveTask = async function () {
        const taskName = document.getElementById('taskName').value;
        const taskDate = document.getElementById('taskDate').value;

        try {
            const response = await fetch('/wedplanpro/backend/api/addTask.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ task_name: taskName, due_date: taskDate })
            });

            const data = await response.json();

            if (data.success) {
                showToast('Görev başarıyla eklendi!');
                closeAddTaskModal();
                fetchTasks();
            } else {
                showToast(data.message || 'Görev eklenirken bir hata oluştu!', true);
            }
        } catch (error) {
            console.error('Hata:', error);
            showToast('Bir hata oluştu!', true);
        }
    }

    window.saveBudget = async function () {
        const itemName = document.getElementById('budgetItem').value;
        const amount = document.getElementById('budgetAmount').value;

        try {
            const response = await fetch('/wedplanpro/backend/api/addBudget.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ item_name: itemName, amount: amount })
            });

            const data = await response.json();

            if (data.success) {
                showToast('Harcama başarıyla eklendi!');
                closeAddBudgetModal();
                fetchBudget();
            } else {
                showToast(data.message || 'Harcama eklenirken bir hata oluştu!', true);
            }
        } catch (error) {
            console.error('Hata:', error);
            showToast('Bir hata oluştu!', true);
        }
    }

    window.saveInvite = async function () {
        const theme = document.getElementById('inviteTheme').value;

        try {
            const response = await fetch('/wedplanpro/backend/api/createInvite.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ theme: theme })
            });

            const data = await response.json();

            if (data.success) {
                showToast('Davetiye başarıyla oluşturuldu!');
                closeCreateInviteModal();
                fetchInvites();
            } else {
                showToast(data.message || 'Davetiye oluşturulurken bir hata oluştu!', true);
            }
        } catch (error) {
            console.error('Hata:', error);
            showToast('Bir hata oluştu!', true);
        }
    }

    // Silme işlevleri
    window.deleteTask = async function (taskId) {
        if (confirm('Bu görevi silmek istediğinizden emin misiniz?')) {
            try {
                const response = await fetch(`/wedplanpro/backend/api/deleteTask.php?id=${taskId}`, {
                    method: 'DELETE'
                });

                const data = await response.json();

                if (data.success) {
                    showToast('Görev başarıyla silindi!');
                    fetchTasks();
                } else {
                    showToast(data.message || 'Görev silinirken bir hata oluştu!', true);
                }
            } catch (error) {
                console.error('Hata:', error);
                showToast('Bir hata oluştu!', true);
            }
        }
    }

    window.deleteBudgetItem = async function (itemId) {
        if (confirm('Bu harcamayı silmek istediğinizden emin misiniz?')) {
            try {
                const response = await fetch(`/wedplanpro/backend/api/deleteBudget.php?id=${itemId}`, {
                    method: 'DELETE'
                });

                const data = await response.json();

                if (data.success) {
                    showToast('Harcama başarıyla silindi!');
                    fetchBudget();
                } else {
                    showToast(data.message || 'Harcama silinirken bir hata oluştu!', true);
                }
            } catch (error) {
                console.error('Hata:', error);
                showToast('Bir hata oluştu!', true);
            }
        }
    }

    window.deleteInvite = async function (inviteId) {
        if (confirm('Bu davetiyeyi silmek istediğinizden emin misiniz?')) {
            try {
                const response = await fetch(`/wedplanpro/backend/api/deleteInvite.php?id=${inviteId}`, {
                    method: 'DELETE'
                });

                const data = await response.json();

                if (data.success) {
                    showToast('Davetiye başarıyla silindi!');
                    fetchInvites();
                } else {
                    showToast(data.message || 'Davetiye silinirken bir hata oluştu!', true);
                }
            } catch (error) {
                console.error('Hata:', error);
                showToast('Bir hata oluştu!', true);
            }
        }
    }

    // Davetiye link kopyalama
    window.copyInviteLink = function (link) {
        navigator.clipboard.writeText(link).then(() => {
            showToast('Davetiye linki kopyalandı!');
        }).catch(() => {
            showToast('Link kopyalanırken bir hata oluştu!', true);
        });
    }

    // Sayfa yüklendiğinde verileri getir
    fetchTasks();
    fetchBudget();
    fetchInvites();
}); 