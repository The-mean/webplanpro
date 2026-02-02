String dayKey(DateTime date) {
  final local = DateTime(date.year, date.month, date.day);
  final y = local.year.toString().padLeft(4, '0');
  final m = local.month.toString().padLeft(2, '0');
  final d = local.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}

DateTime dayFromKey(String key) {
  final parts = key.split('-');
  if (parts.length != 3) {
    return DateTime.now();
  }
  final y = int.tryParse(parts[0]) ?? DateTime.now().year;
  final m = int.tryParse(parts[1]) ?? DateTime.now().month;
  final d = int.tryParse(parts[2]) ?? DateTime.now().day;
  return DateTime(y, m, d);
}
