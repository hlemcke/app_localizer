// Copyright 2021,2022 djarjo@djarjo.com
// Please see the LICENSE file for details.

import 'dart:ui';

import 'package:app_localizer/src/currency.i18n.dart';
import 'package:collection/collection.dart' show IterableExtension;

import 'app_localizer.dart';
import 'currency.csv.dart';

///
/// Currency data according to ISO 4217:2015.
///
/// A currency is uniquely identified by its code of 3 uppercase characters.
///
/// Get the list of all currencies with:
/// ```
/// List<Currency> currencies = Currency.values();
/// ```
///
class Currency {
  Currency({
    required this.code,
    this.country,
    this.minor,
    required this.name,
    String? symbol,
  })  : assert(code.length == 3),
        assert(country == null || country.length == 2,
            'Currency "$code" -> country "$country" must be null or 2 uppercase chars') {
    _symbol = symbol ?? code;
  }

  /// ISO-4217 Alpha-3 code. 3 char uppercase
  final String code;

  /// ISO-3166 Alpha-2 code for country. 2 char uppercase
  final String? country;

  /// ISO-4217 Name in standard locale en
  final String name;

  /// Number of digits for minor currency (fraction)
  final int? minor;

  /// Symbol of this currency
  String _symbol = '';
  String get symbol => _symbol;

  /// Gets name translated to [locale].
  /// * If [locale] is `null` then `activeLocale` from [AppLocalizer] will be used
  /// * If no translation found then the native name will be returned
  String getTranslation([Locale? locale]) {
    Map<String, String>? entries = currencyTranslations[code];
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
  String toString() {
    return '$code - $name';
  }
}

///
/// Contains all currencies from `currency.csv.dart`.
/// Columns are: alpha-3,name,minor,symbol,country
///
class Currencies {
  static final List<Currency> _currencies = <Currency>[];

  static bool _initializing = false, _initialized = false;

  // Columns are: code, name, minor, symbol, country
  static void _initialize() {
    if (_initialized || _initializing) return;
    _initializing = true;
    const int indexCode = 0,
        indexName = 1,
        indexMinor = 2,
        indexSymbol = 3,
        indexCountry = 4;
    //--- Load currency data
    List<String> lines = csvListOfCurrencies.split('\n');
    lines.removeAt(0); // remove line with column names
    for (String line in lines) {
      if (line.isEmpty) {
        continue;
      }
      List<String> parts = line.split(',');
      _currencies.add(Currency(
        code: parts[indexCode],
        name: parts[indexName],
        minor: int.tryParse(parts[indexMinor]) ?? 0,
        symbol: parts[indexSymbol],
        country: parts[indexCountry],
      ));
    }
    //--- Ready
    _initialized = true;
  }

  ///
  /// Returns currencies having a code from [codes].
  ///
  static List<Currency> filterByCodes(List<String> codes) {
    _initialize();
    return _currencies
        .where((Currency element) => codes.contains(element.code))
        .toList();
  }

  ///
  /// Returns `null` if `code == null` or not found
  ///
  static Currency? findByCode(String? code) {
    _initialize();
    if ((code == null) || (code.length != 3)) return null;
    code = code.toUpperCase();
    return _currencies
        .firstWhereOrNull((Currency currency) => currency.code == code);
  }

  ///
  /// Returns the intersection of [currencies] and [Currencies.values()]
  ///
  static List<Currency> intersection(List<Currency> currencies) {
    _initialize();
    return _currencies.where((Currency c) {
      for (Currency cur in currencies) {
        if (c.code == cur.code) return true;
      }
      return false;
    }).toList();
  }

  ///
  /// Gets iterable list of all currencies
  ///
  static List<Currency> values() {
    _initialize();
    return _currencies;
  }

  static Currency get EUR => findByCode('EUR')!;
  static Currency get USD => findByCode('USD')!;
}