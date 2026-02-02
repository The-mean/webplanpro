import 'package:hive/hive.dart';

import '../models/daily_snapshot.dart';
import '../utils/date_utils.dart';

class LocalStore {
  static const String _snapshotsBoxName = 'snapshots';
  static const String _settingsBoxName = 'settings';

  late Box<DailySnapshot> _snapshotsBox;
  late Box _settingsBox;

  Future<void> init() async {
    _snapshotsBox = await Hive.openBox<DailySnapshot>(_snapshotsBoxName);
    _settingsBox = await Hive.openBox(_settingsBoxName);
  }

  List<DailySnapshot> getAllSnapshots() {
    final list = _snapshotsBox.values.toList();
    list.sort((a, b) => a.day.compareTo(b.day));
    return list;
  }

  List<DailySnapshot> getRecentSnapshots(int days) {
    final start = _dayStart(DateTime.now().subtract(Duration(days: days - 1)));
    return getAllSnapshots().where((s) => !s.day.isBefore(start)).toList();
  }

  DailySnapshot? getSnapshotForDay(DateTime day) {
    return _snapshotsBox.get(dayKey(day));
  }

  DailySnapshot? getSnapshotDaysAgo(int days) {
    final target = _dayStart(DateTime.now().subtract(Duration(days: days)));
    return _snapshotsBox.get(dayKey(target));
  }

  Future<void> upsertSnapshot(DailySnapshot snapshot, int retentionDays) async {
    await _snapshotsBox.put(dayKey(snapshot.day), snapshot);
    await _trimSnapshots(retentionDays);
  }

  Future<void> _trimSnapshots(int retentionDays) async {
    final cutoff = _dayStart(
      DateTime.now().subtract(Duration(days: retentionDays - 1)),
    );
    final keysToRemove = <dynamic>[];
    for (final entry in _snapshotsBox.toMap().entries) {
      if (entry.value.day.isBefore(cutoff)) {
        keysToRemove.add(entry.key);
      }
    }
    if (keysToRemove.isNotEmpty) {
      await _snapshotsBox.deleteAll(keysToRemove);
    }
  }

  DateTime getFirstSeenDay() {
    final existing = _settingsBox.get('first_seen_day') as String?;
    if (existing != null) {
      return dayFromKey(existing);
    }
    final todayKey = dayKey(DateTime.now());
    _settingsBox.put('first_seen_day', todayKey);
    return dayFromKey(todayKey);
  }

  String? get lastTipDayKey =>
      _settingsBox.get('last_tip_day') as String?;
  set lastTipDayKey(String? value) {
    if (value == null) {
      _settingsBox.delete('last_tip_day');
    } else {
      _settingsBox.put('last_tip_day', value);
    }
  }

  String? get lastTipKey => _settingsBox.get('last_tip_key') as String?;
  set lastTipKey(String? value) {
    if (value == null) {
      _settingsBox.delete('last_tip_key');
    } else {
      _settingsBox.put('last_tip_key', value);
    }
  }

  bool get isPro => _settingsBox.get('is_pro') as bool? ?? false;
  set isPro(bool value) => _settingsBox.put('is_pro', value);

  int? get proValidUntilMillis =>
      _settingsBox.get('pro_valid_until') as int?;
  set proValidUntilMillis(int? value) {
    if (value == null) {
      _settingsBox.delete('pro_valid_until');
    } else {
      _settingsBox.put('pro_valid_until', value);
    }
  }

  int? get lastEntitlementCheckMillis =>
      _settingsBox.get('last_entitlement_check') as int?;
  set lastEntitlementCheckMillis(int? value) {
    if (value == null) {
      _settingsBox.delete('last_entitlement_check');
    } else {
      _settingsBox.put('last_entitlement_check', value);
    }
  }

  String? get localeCode => _settingsBox.get('locale_code') as String?;
  set localeCode(String? value) {
    if (value == null) {
      _settingsBox.delete('locale_code');
    } else {
      _settingsBox.put('locale_code', value);
    }
  }

  DateTime _dayStart(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}
