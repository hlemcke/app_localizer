// Copyright 2021 djarjo@djarjo.com
// Please see the LICENSE file for details.

import 'dart:ui';

import 'package:app_localizer/app_localizer.dart';
import 'package:collection/collection.dart' show IterableExtension;

import 'country.csv.dart';
import 'country.i18n.dart';

/// Country data according to ISO-3166.
///
/// Get the flag image with:
/// ```
/// Image.asset(
/// 'assets/packages/app_localizer/' + country.alpha2 + '.png',
/// package: 'app_localizer',
/// );
/// ```
///
/// Get a Locale with:
/// ```
/// Locale locale = Locale( country.language, country.alpha2 );
/// ```
///
/// Get the list of all countries with:
/// ```
/// List<Country> countries = Countries.values();
/// ```
class Country {
  /// Unknown country
  static final Country unknown = Country(
    alpha2: Language.platformCountryCode,
    language: Language.platformLanguageCode,
    name: '<unknown>',
  );

  /// Constructor
  Country({
    required this.alpha2,
    this.alpha3,
    this.currency,
    this.language,
    required this.name,
    this.num3,
    this.predial,
    this.timezone,
  })  : assert(alpha2.length == 2),
        assert(alpha3 == null || alpha3.length == 3,
            'Country "$alpha2" -> alpha3 "$alpha3" must be null or 3 uppercase chars');

  /// ISO-3166 Alpha-2 code. 2 char uppercase
  final String alpha2;

  /// ISO-3166 Alpha-3 code. 3 char uppercase
  final String? alpha3;

  /// Official currency. ISO-4217 currency code. 3 char uppercase
  final String? currency;

  /// Official language. ISO-639-1 code. 2 char lowercase.
  final String? language;

  /// ISO-3166 Name in standard locale en
  final String name;

  /// ISO-3166 numerical code. up to 3 digits
  final int? num3;

  /// International phone predial code
  final int? predial;

  /// Timezone of this country.
  /// Returns mean timezone if the country covers multiple lines of latitude.
  final double? timezone;

  /// Gets name translated to [locale].
  /// * If [locale] is `null` then `activeLocale` from [AppLocalizer] will be used
  /// * If no translation found then the native name will be returned
  String getTranslation([Locale? locale]) {
    Map<String, String>? entries = countryTranslations[alpha2];
    if (entries != null) {
      locale ??= AppLocalizer.activeLocale;
      String? translation = entries[locale.languageCode];
      if (translation != null) {
        return translation;
      }
    }
    return name;
  }

  @override
  String toString() => '$alpha2 - $name';
}

///
/// List of all countries from `country.csv.dart`
///
class Countries {
  static final List<Country> _countries = [];

  ///
  /// Returns currencies having a code from [codes].
  ///
  static List<Country> filterByCodes(List<String> codes) {
    _initialize();
    return _countries
        .where(
            (Country c) => codes.contains(c.alpha2) || codes.contains(c.alpha3))
        .toList();
  }

  static Country? find(String searchValue) {
    _initialize();
    return _countries.firstWhereOrNull((Country c) =>
        ((searchValue == c.alpha2) ||
            (searchValue == c.alpha3) ||
            (searchValue == '${c.num3}')));
  }

  /// Returns `null` if `code2 == null` or not found
  static Country? findByCode2(String? code2) {
    _initialize();
    if ((code2 == null) || (code2.length != 2)) {
      return null;
    }
    code2 = code2.toUpperCase();
    return _countries
        .firstWhereOrNull((Country country) => country.alpha2 == code2);
  }

  /// Returns `null` if `code3 == null` or not found
  static Country? findByCode3(String? code3) {
    _initialize();
    if ((code3 == null) || (code3.length != 3)) {
      return null;
    }
    code3 = code3.toUpperCase();
    return _countries.firstWhereOrNull((country) => country.alpha3 == code3);
  }

  /// Returns `null` if `number == null` or not found
  static Country? findByPredial(int? number) {
    _initialize();
    if (number == null) return null;
    return _countries.firstWhereOrNull((country) => country.predial == number);
  }

  ///
  /// Returns the intersection of [countries] and [Countries.values()]
  ///
  static List<Country> intersection(List<Country> countries) {
    _initialize();
    return _countries.where((Country c) {
      for (Country ctry in countries) {
        if (c.alpha2 == ctry.alpha2) return true;
      }
      return false;
    }).toList();
  }

  /// Gets iterable list of all countries
  static List<Country> values() {
    _initialize();
    return _countries;
  }

  static bool _initializing = false, _initialized = false;

  // Columns are: alpha-2,alpha-3,num-3,name,currency,language,predial,timezone
  static void _initialize() {
    if (_initialized || _initializing) {
      return;
    }
    _initializing = true;
    //--- Load country data
    List<String> lines = csvListOfCountries.split('\n');
    lines.removeAt(0); // remove line with column names
    for (String line in lines) {
      if (line.isEmpty) {
        continue;
      }
      List<String> parts = line.split(',');
      _countries.add(Country(
        alpha2: parts[0],
        alpha3: parts[1],
        num3: int.tryParse(parts[2]) ?? 0,
        name: parts[3],
        currency: parts[4],
        language: parts[5],
        predial: int.tryParse(parts[6]) ?? 0,
        timezone: double.tryParse(parts[7]) ?? 0,
      ));
    }
    //--- Ready
    _initialized = true;
  }
}