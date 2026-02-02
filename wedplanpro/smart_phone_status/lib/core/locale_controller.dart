import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import 'services/local_store.dart';

class LocaleController extends StateNotifier<Locale?> {
  LocaleController(this._store) : super(_loadLocale(_store));

  final LocalStore _store;

  static Locale? _loadLocale(LocalStore store) {
    final code = store.localeCode;
    if (code == null || code.isEmpty) {
      return null;
    }
    return Locale(code);
  }

  void setLocale(String? code) {
    if (code == null || code.isEmpty) {
      _store.localeCode = null;
      state = null;
    } else {
      _store.localeCode = code;
      state = Locale(code);
    }
  }
}

final localeControllerProvider =
    StateNotifierProvider<LocaleController, Locale?>((ref) {
  final store = ref.read(localStoreProvider);
  return LocaleController(store);
});
