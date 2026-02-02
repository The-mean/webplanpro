import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../core/locale_controller.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final subscription = ref.watch(subscriptionServiceProvider);
    final locale = ref.watch(localeControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(loc.settings)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.screenPadding),
        children: [
          if (!subscription.isPro)
            _SettingsTile(
              icon: Icons.star,
              title: loc.upgrade,
              subtitle: loc.proRequired,
              onTap: () => context.go('/pro'),
            ),
          _SettingsTile(
            icon: Icons.language,
            title: loc.language,
            subtitle: _languageLabel(loc, locale),
            onTap: () => _showLanguageSheet(context, ref),
          ),
          _SettingsTile(
            icon: Icons.restore,
            title: loc.restorePurchases,
            subtitle: loc.restoreHint,
            onTap: () => subscription.restorePurchases(),
          ),
          _SettingsTile(
            icon: Icons.privacy_tip,
            title: loc.privacy,
            subtitle: loc.privacyShort,
            onTap: () => _showPrivacyDialog(context),
          ),
          _SettingsTile(
            icon: Icons.info,
            title: loc.about,
            subtitle: loc.aboutShort,
            onTap: () => showAboutDialog(
              context: context,
              applicationName: loc.appTitle,
              applicationVersion: '0.1.0',
            ),
          ),
        ],
      ),
    );
  }

  String _languageLabel(AppLocalizations loc, Locale? locale) {
    final code = locale?.languageCode;
    switch (code) {
      case 'tr':
        return loc.langTr;
      case 'es':
        return loc.langEs;
      case 'de':
        return loc.langDe;
      case 'fr':
        return loc.langFr;
      case 'en':
        return loc.langEn;
      default:
        return loc.langSystem;
    }
  }

  void _showLanguageSheet(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LanguageItem(
                label: loc.langSystem,
                onTap: () => _setLocale(ref, null, context),
              ),
              _LanguageItem(
                label: loc.langEn,
                onTap: () => _setLocale(ref, 'en', context),
              ),
              _LanguageItem(
                label: loc.langTr,
                onTap: () => _setLocale(ref, 'tr', context),
              ),
              _LanguageItem(
                label: loc.langEs,
                onTap: () => _setLocale(ref, 'es', context),
              ),
              _LanguageItem(
                label: loc.langDe,
                onTap: () => _setLocale(ref, 'de', context),
              ),
              _LanguageItem(
                label: loc.langFr,
                onTap: () => _setLocale(ref, 'fr', context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _setLocale(WidgetRef ref, String? code, BuildContext context) {
    ref.read(localeControllerProvider.notifier).setLocale(code);
    Navigator.of(context).pop();
  }

  void _showPrivacyDialog(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.privacy),
        content: Text(loc.privacyDetail),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(loc.close),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius),
          side: const BorderSide(color: AppColors.border),
        ),
        tileColor: AppColors.surface,
        leading: Icon(icon, color: AppColors.neonSoft),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}

class _LanguageItem extends StatelessWidget {
  const _LanguageItem({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      onTap: onTap,
    );
  }
}
