import 'dart:ui';

import 'package:app_localizer/app_localizer.dart';
import 'package:flutter/material.dart';

///
/// Manages the active locale used for translations.
///
/// Active locale can be changed both by [LanguageSelector] or through
/// platform settings.
///
/// [AppLocalizer] must be put on top of [MaterialApp] like this:
///
/// ```dart
///   Widget build(BuildContext context) => ValueListenableBuilder<Locale>(
///     valueListenable: AppLocalizer.initialize(
///       supportedLocales: supportedLocales ).notifier,
///     builder: (BuildContext context, Locale locale, Widget? child) =>
///       MaterialApp( localeListResolutionCallback:
///         (List<Locale>? devLocales, Iterable<Locale> appLocales) =>
///           AppLocalizer().localeListResolutionCallback(context,
///             devLocales, appLocales),
/// ```
///
/// [MaterialApp.localeListResolutionCallback] informs [AppLocalizer] about
/// locale changes on the platform.
/// For changes within the app use [LanguageChooser] like this:
///
/// ```dart
/// LanguageChooser(
///   onChanged: (Locale? newLang) =>
///     AppLocalizer().activeLocale = newLang,
///   selectable: supportedLocales.map((e) => e.languageCode).toList(),
///     selectionDisplay: displaySelection,
///   value: AppLocalizer().usePlatformLocale
///     ? AppLocalizer.platformLocale
///     : AppLocalizer().activeLocale,
///   withPlatform: true, )
/// ```
///
/// For a full example see folder _example_.
///
class AppLocalizer extends StatelessWidget {
  final Widget child;

  AppLocalizer({
    Locale? initialLocale,
    ValueChanged<Locale?>? onChanged,
    ValueChanged<Locale>? forward,
    required List<Locale> supportedLocales,
    required this.child,
  }) {
    AppLocalizer.supportedLocales = supportedLocales;
    AppLocalizer.onChanged = onChanged;
    if (!_initialized) {
      _initialize(initialLocale: initialLocale, forward: forward);
    }
  }

  ///
  /// Rebuilds [child] when user changes locale
  ///
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<Locale>(
      valueListenable: _notifier,
      builder: (BuildContext context, Locale locale, Widget? _) {
        return child;
      });

  ///
  /// Default locale is `en_US`.
  ///
  static Locale defaultLocale = Locale.fromSubtags(
    languageCode: 'en',
    countryCode: 'US',
  );

  ///
  /// Callback function invoked when locale changes.
  ///
  static ValueChanged<Locale?>? onChanged;

  ///
  /// List of supported locales
  ///
  static List<Locale> supportedLocales = <Locale>[
    defaultLocale,
    Locale('de', 'DE'),
    Locale('es', 'ES'),
  ];

  ///
  /// Used as value for a [ValueListenableBuilder] to redraw widgets.
  /// Will be updated by changing [activeLocale].
  ///
  static ValueNotifier<Locale> _notifier = ValueNotifier<Locale>(defaultLocale);

  ///
  /// Returns active locale of this application
  ///
  static Locale get activeLocale => _notifier.value;

  ///
  /// Sets active locale for this application by first resolving to a
  /// supported locale. Providing `null` will switch to platform locale.
  ///
  /// 1. If [newLocale] = `null` or its language code is `xx` then uses
  /// platform locale (same as [usePlatformLocale] = `true`)
  /// 1. If [newLocale] is contained in [supportedLocales] then it will be used
  /// 1. If not found then only the language code will be compared
  /// 1. If still not found then [defaultLocale] will be used
  ///
  /// Call [usePlatformLocale] to switch to platform locale.
  ///
  static set activeLocale(Locale? newLocale) {
    //--- Check usage of platform locale
    if ((newLocale == null) ||
        (newLocale.languageCode == Language.platformLanguageCode)) {
      _usePlatformLocale = true;
      _updateLocale(_resolveFromPlatform());
    } else {
      _usePlatformLocale = false;
      _updateLocale(_resolveByLocale(newLocale));
    }
  }

  ///
  /// Callback method for [MaterialApp.localeListResolutionCallback].
  ///
  /// This method is called once at startup and later when the user has
  /// changed the list of his preferred languages in the platform.
  ///
  /// Returns resolved locale.
  /// Has no effect if [usePlatformLocale] is `false`.
  ///
  static Locale localeListResolutionCallback(BuildContext context,
      List<Locale>? devLocales, Iterable<Locale> appLocales) {
    _platformLocales = window.locales; // Updates user preferred list
    if (usePlatformLocale) {
      _updateLocale(_resolveFromPlatform());
    }
    return _notifier.value;
  }


  /// Platform locales as selected and ordered by user.
  /// Updated by [localeListResolutionCallback].
  static List<Locale> _platformLocales = <Locale>[];

  /// Returns `true` if active locale is taken from platform
  static bool get usePlatformLocale => _usePlatformLocale;
  static bool _usePlatformLocale = true;

  ///
  /// `true` resolves from platform locale and notifies listeners
  /// if different from active locale.
  ///
  /// `false` just switches to use current active locale.
  /// Further changes on platform will have no effect.
  ///
  static set usePlatformLocale(bool fromPlatform) {
    if (_usePlatformLocale != fromPlatform) {
      _usePlatformLocale = fromPlatform;
      if (_usePlatformLocale) {
        _updateLocale(_resolveByLocale(window.locale));
      }
    }
  }

  static Locale _resolveByLocale(Locale newLocale) {
    //--- Lookup in supported locales
    if (supportedLocales.contains(newLocale)) {
      return newLocale;
    }
    //--- No full match => try language codes only
    for (Locale locale in supportedLocales) {
      if (newLocale.languageCode == locale.languageCode) {
        return locale;
      }
    }
    //--- Still not found => use default
    return defaultLocale;
  }

  static Locale _resolveFromPlatform() {
    for (Locale locale in _platformLocales) {
      if (supportedLocales.contains(locale)) {
        return locale;
      }
    }
    //--- No full match => try language codes only
    for (Locale locale in _platformLocales) {
      String langCode = locale.languageCode;
      for (Locale supLocale in supportedLocales) {
        if (langCode == supLocale.languageCode) {
          return supLocale;
        }
      }
    }
    //--- Still not found => use default
    return defaultLocale;
  }

  static void _updateLocale(Locale newLocale) {
    if (_notifier.value != newLocale) {
      _notifier.value = newLocale;
      Translator.activeLanguageCode = newLocale.languageCode;
      if (onChanged != null) {
        onChanged!(newLocale);
      }
    }
  }

  static bool _initialized = false;

  ///
  /// Any change will be resolved to [supportedLocales].
  ///
  /// If [initialLocale] is not provided then locale will be taken from platform.
  ///
  /// This named constructor must be called before calling any other method!
  ///
  /// [forward] can be used to set active locale directly at initialization
  /// e.g. for [Translator].
  ///
  void _initialize({
    Locale? initialLocale,
    ValueChanged<Locale>? forward,
  }) {
    AppLocalizer._platformLocales = window.locales;
    if (initialLocale != null) {
      _notifier.value = _resolveByLocale(initialLocale);
      _usePlatformLocale = false;
    } else {
      _notifier.value = _resolveByLocale(window.locale);
      _usePlatformLocale = true;
    }
//    initializeDateFormatting().then((value) =>
//       debugPrint('date formatting initialized')); // Prepare date formatters
    debugPrint('AppLocalizer.init platform=$_usePlatformLocale'
        ' active=${_notifier.value} '
        'initialLocale=$initialLocale '
        'window.locale=${window.locale} '
        'window.locales=${window.locales}');
    Translator.activeLanguageCode = _notifier.value.languageCode;
    if (forward != null) {
      forward(_notifier.value);
    }
    _initialized = true;
  }
}