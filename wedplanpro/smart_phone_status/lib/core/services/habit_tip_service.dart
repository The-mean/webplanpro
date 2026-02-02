import '../models/device_stats.dart';
import '../utils/date_utils.dart';
import 'local_store.dart';

class HabitTipService {
  HabitTipService(this._store);

  final LocalStore _store;

  String? getTipKeyForToday(DeviceStats stats) {
    final todayKey = dayKey(DateTime.now());
    if (_store.lastTipDayKey == todayKey && _store.lastTipKey != null) {
      return _store.lastTipKey;
    }

    final tipKey = _selectTip(stats);
    _store.lastTipDayKey = todayKey;
    _store.lastTipKey = tipKey;
    return tipKey;
  }

  String _selectTip(DeviceStats stats) {
    if (stats.batteryLevel < 25) {
      return 'tipCharge';
    }
    if (stats.storageUsedPercent > 85) {
      return 'tipStorage';
    }
    if (stats.memoryUsedPercent > 80) {
      return 'tipMemory';
    }
    if (stats.temperatureC != null && stats.temperatureC! > 38) {
      return 'tipHeat';
    }
    return 'tipGeneral';
  }
}
