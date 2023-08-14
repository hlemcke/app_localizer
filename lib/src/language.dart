// Copyright 2021, 2022 tools@djarjo.com
// Please see the LICENSE file for details.

import 'dart:ui';

import 'package:collection/collection.dart' show IterableExtension;

import 'app_localizer.dart';
import 'language.csv.dart';
import 'language.i18n.dart';

///
/// Language data according to ISO-639.
///
/// Get [Locale] from [Language] with:
/// ```
/// Locale locale = this.toLocale();
/// ```
///
/// Get the list of all languages with:
/// ```
/// List<Language> languages = Language.values();
/// ```
class Language {
  static final Language defaultLanguage = Language(
    code: 'en',
    countryCode: 'US',
    name: 'english',
  );

  /// Special code ("xx") to use [Locale] from platform
  static final String platformLanguageCode = 'xx';

  /// Special code ("XX") for country to use [Locale] from platform
  static final String platformCountryCode = 'XX';

  /// Special entry for [LanguageChooser] to choose locale from platform
  static final Language platformLanguage = Language(
    code: platformLanguageCode,
    countryCode: platformCountryCode,
    name: 'Platform',
  );

  /// Special locale to use locale from platform
  static final Locale platformLocale = Locale(
    platformLanguageCode,
    platformCountryCode,
  );

  /// Constructor for a single language
  Language({
    required this.code,
    required this.countryCode,
    required this.name,
  });

  /// ISO-639 Alpha-2 code. 2 char lowercase
  final String code;

  /// ISO-3166 country code used to display flag
  final String countryCode;

  /// ISO-639 Name in locale [code]
  final String name;

  ///
  /// Returns language from given locale if available.
  ///
  static Language? fromLocale(Locale? locale) {
    return (locale == null) ? null : Languages.findByCode(locale.languageCode);
  }

  /// Gets name translated to [locale].
  /// * If [locale] is `null` then `activeLocale` from [AppLocalizer] will be used
  /// * If no translation found then the native name will be returned
  String getTranslation([Locale? locale]) {
    Map<String, String>? entries = languageTranslations[code];
    if (entries != null) {
      locale ??= AppLocalizer.activeLocale;
      String? translation = entries[locale.languageCode];
      if (translation != null) {
        return translation;
      }
    }
    return name;
  }

  /// Returns Dart [Locale] with [code] and [countryCode]
  Locale toLocale() {
    return Locale(code, countryCode);
  }

  @override
  String toString() {
    return '$name (${code}_$countryCode)';
  }
}

///
/// Contains all languages from `language.csv.dart`
///
class Languages {
  static final List<Language> _languages = [];

  ///
  /// Returns languages having a code from [codes].
  ///
  static List<Language> filterByCodes(List<String> codes) {
    _initialize();
    return _languages
        .where((Language element) => codes.contains(element.code))
        .toList();
  }

  ///
  /// Returns language from [langCode].
  /// Returns `null` if `code == null` or not found
  ///
  static Language? findByCode(String? langCode) {
    _initialize();
    if ((langCode == null) || (langCode.length != 2)) return null;
    langCode = langCode.toLowerCase();
    if (langCode == Language.platformLanguage.code) {
      return Language.platformLanguage;
    }
    return _languages
        .firstWhereOrNull((Language language) => language.code == langCode);
  }

  ///
  /// Returns the intersection of [languages] and [Languages.values()]
  ///
  static List<Language> intersection(List<Language> languages) {
    _initialize();
    return _languages.where((Language l) {
      for (Language lang in languages) {
        if (l.code == lang.code) return true;
      }
      return false;
    }).toList();
  }

  ///
  /// Resolves given [Locale] to an available [Language].
  ///
  /// First compares full [Locale].
  /// If not found then compares language code only.
  /// If not found then returns default language "en_US".
  ///
  static Language resolve(Locale locale) {
    for (Language lang in _languages) {
      if ((lang.code == locale.languageCode) &&
          (lang.countryCode == locale.countryCode)) {
        return lang;
      }
    }
    for (Language lang in _languages) {
      if (lang.code == locale.languageCode) {
        return lang;
      }
    }
    return Language.defaultLanguage;
  }

  ///
  /// Gets iterable list of all languages.
  /// List does not contain special entry [fromPlatform].
  ///
  static List<Language> values() {
    _initialize();
    return _languages;
  }

  static bool _initializing = false, _initialized = false;

  // Columns are: alpha-2,country,name
  static void _initialize() {
    if (_initialized || _initializing) {
      return;
    }
    _initializing = true;
    //--- Load language data
    List<String> lines = csvListOfLanguages.split('\n');
    lines.removeAt(0); // remove line with column names
    for (String line in lines) {
      if (line.isEmpty) {
        continue;
      }
      List<String> parts = line.split(',');
      _languages.add(Language(
        code: parts[0],
        countryCode: parts[1],
        name: parts[2],
      ));
    }
    _initialized = true;
  }
}