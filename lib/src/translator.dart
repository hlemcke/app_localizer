import 'package:flutter/foundation.dart';

final String _splitter1 = '\uFFFF';
final String _splitter2 = '\uFFFE';

///
/// Translates given [key] to [langCode].
///
/// Uses [Translator.activeLanguageCode] for target language.
/// Can be overwritten by providing optional [langCode].
///
String translate(String key, Translator translator, [String? langCode]) {
  //--- Get all translations for given key
  Map<String, String>? _txns4key = translator.translations[key];
  if (_txns4key == null) {
    Translator.recordMissingKey(key);
  } else {
    String _lang =
        langCode ?? translator.langCode ?? Translator.activeLanguageCode;
    String? _txn = _txns4key[_lang];
    if (_txn != null) {
      return _txn;
    }
    Translator.recordMissingTranslation(key, translator, _lang);
  }
  return key;
}

///
/// Replaces `%d` and `%s` in `template` with values
///
String sprintf(String template, List<dynamic> values) {
  int i = 0;
  return template.replaceAllMapped(
    RegExp(r"%[sd]"),
    (_) => values[i++].toString(),
  );
}

///
/// Calls [translate()] then [sprintf()] to replace parameters with [values].
///
String translateFill(
  String key,
  Translator translator,
  List<dynamic> values, [
  String? langCode,
]) => sprintf(translate(key, translator, langCode), values);

///
/// Translates into plural specific texts (see [Plural]).
///
/// All occurrences of "%d" will be replaced by `plural`.
///
String translatePlural(
  String key,
  Translator translator,
  int plural, [
  String? langCode,
]) {
  //--- Splits one translation into its plural variants. Key is "plural"
  Map<String?, String> _splitIntoPlurals(String allPluralsInOneString) {
    if (!allPluralsInOneString.startsWith(_splitter1)) {
      return {null: allPluralsInOneString};
    }
    List<String> plurals = allPluralsInOneString.split(_splitter1);
    Map<String?, String> all = {null: plurals[1]};
    for (int i = 2; i < plurals.length; i++) {
      String plural = plurals[i];
      List<String> parts = plural.split(_splitter2);
      if (parts.length != 2 || parts[0].isEmpty || parts[1].isEmpty) {
        throw TranslatorException(
          'Invalid plural "$plural" found in'
          '$allPluralsInOneString',
        );
      }
      all[parts[0]] = parts[1];
    }
    return all;
  }

  // ---
  String _txnPlurals = translate(key, translator, langCode);
  if (_txnPlurals == key) {
    return key;
  }
  Map<String?, String> _plurals = _splitIntoPlurals(_txnPlurals);
  String? _txn;
  switch (plural) {
    case 0: // plural(0) returns version 0, otherwise version many, else unversioned
      _txn = _plurals['0'] ?? _plurals['M'] ?? _plurals[null];
      break;
    case 1: // plural(1) returns version 1, else unversioned
      _txn = _plurals['1'] ?? _plurals[null];
      break;
    case 2: // plural(2) returns version 2, else version 2-3-4, else many, else unversioned
      _txn = _plurals['2'] ?? _plurals['C'] ?? _plurals['M'] ?? _plurals[null];
      break;
    case 3: // plural(3) returns version 3, else version 2-3-4, else version many, else unversioned
      _txn = _plurals['3'] ?? _plurals['C'] ?? _plurals['M'] ?? _plurals[null];
      break;
    case 4: // plural(4) returns version 4, else version 2-3-4, else version many, else unversioned
      _txn = _plurals['3'] ?? _plurals['C'] ?? _plurals['M'] ?? _plurals[null];
      break;
    case 5: // plural(5) returns version 5, else version many, else unversioned
      _txn = _plurals['5'] ?? _plurals['M'] ?? _plurals[null];
      break;
    case 6: // plural(6) returns version 6, else version many, else unversioned
      _txn = _plurals['6'] ?? _plurals['M'] ?? _plurals[null];
      break;
    case 10: // plural(10) returns version T, else version many, else unversioned
      _txn = _plurals['T'] ?? _plurals['M'] ?? _plurals[null];
      break;
    default: // For plural(<0 or >6), returns version many, else unversioned
      _txn = _plurals['$plural'] ?? _plurals['M'] ?? _plurals[null];
  }
  return (_txn == null) ? key : _txn.replaceAll('%d', '$plural');
}

///
/// Translates strings to a target language through string extension.
/// Following extensions can be used:
///
class Translator {
  ///
  /// Code of active language. This code is used to get the translation
  /// from the map obtained by the translation key.
  ///
  /// This value will be automatically updated from [AppLocalizer].
  ///
  static String activeLanguageCode = 'en';

  // --- Start of static configuration variables for [Translator] ---
  ///
  /// Replace this function to also log missing keys
  /// outside of [Translator].
  ///
  static void Function(String) missingKeyCallback = (String key) =>
      debugPrint('➜ Key "$key" not found in translations');

  /// `false` will not record missing keys
  static bool missingKeyRecording = true;

  /// Set of missing keys
  static Set<String> missingKeys = <String>{};

  ///
  /// Replace this function to also log missing translations
  /// outside of [Translator].
  ///
  static void Function(String, String) missingTranslationCallback =
      (String key, String langCode) =>
          debugPrint('➜ Key "$key" has no translation to "$langCode"');

  /// `false` will not record missing translations
  static bool missingTranslationRecording = true;

  /// Set of missing translations. Each entry is a string '$key $langCode'
  /// separated by one space.
  static Set<String> missingTranslations = <String>{};

  // ---- End of static configuration variables for [Translator] ----

  /// If not empty then specifies the target language of the keys themselves.
  String keyIsTranslationTo;

  /// Specifies the target language used in this translations map.
  /// Overrides global setting of [Translator.activeLanguageCode].
  String? langCode;

  /// Map of all translations
  final Map<String, Map<String, String>> translations;

  /// Each translation map is wrapped by a [Translator] object.
  Translator({
    required this.translations,
    this.keyIsTranslationTo = '',
    this.langCode,
  });

  /// Returns number of keys in translation map
  int get length => translations.length;

  ///
  /// Invokes [missingKeyCallback] and adds [key] to [missingKeys]
  ///
  static void recordMissingKey(String key) {
    missingKeyCallback(key);
    if (missingKeyRecording) {
      missingKeys.add(key);
    }
  }

  ///
  /// Invokes [missingTranslationCallback]
  /// and adds `$key $langCode` to [missingTranslations].
  ///
  /// Nothing will be done here if [langCode] == [keyIsTranslationTo].
  ///
  static void recordMissingTranslation(
    String key,
    Translator translator,
    String langCode,
  ) {
    if (langCode != translator.keyIsTranslationTo) {
      missingTranslationCallback(key, langCode);
      if (missingTranslationRecording) {
        missingTranslations.add('$key $langCode');
      }
    }
  }
}

class TranslatorException {
  String message;

  TranslatorException(this.message);

  @override
  String toString() => message;
}

///
/// Plural extensions must be prepared inside the translation file like:
/// ```dart
/// static Translator _t = Translator(translations: {
///   'key' : {
///     'de': 'Du hast den Knopf %d mal gedrückt'
///         .zero('Du hast den Knopf nicht gedrückt')
///         .one('Du hast den Knopf einmal gedrückt')
///         .two('Du hast den Knopf zweimal gedrückt')
///         .many('Du hast %d mal gedrückt')
///         .times(12, 'Du hast ein dutzend mal gedrückt'),
///     'en': 'You clicked the button %d times'
///         .zero('You haven't clicked the button')
///         .one('You clicked it once')
///         .two('You clicked it twice')
///         .many('You clicked %d times')
///         .times(12, 'You clicked a dozen times'),
///   };
///
/// String plural(int count) => translatePlural(this, _t, count);
/// ```
/// Then use as:
/// ```
/// int count = 3;
/// return Text("You clicked the button %d times".plural(count));
/// ```
extension Plural on String {
  String modifier(String key, String text) {
    return ((!startsWith(_splitter1)) ? _splitter1 : '') +
        '${this}$_splitter1$key$_splitter2$text';
  }

  /// Plural modifier for zero elements.
  String zero(String text) => modifier('0', text);

  /// Plural modifier for 1 element.
  String one(String text) => modifier('1', text);

  /// Plural modifier for 2 elements.
  String two(String text) => modifier('2', text);

  /// Plural modifier for 3 elements.
  String three(String text) => modifier('3', text);

  /// Plural modifier for 4 elements.
  String four(String text) => modifier('4', text);

  /// Plural modifier for 5 elements.
  String five(String text) => modifier('5', text);

  /// Plural modifier for 6 elements.
  String six(String text) => modifier('6', text);

  /// Plural modifier for 10 elements.
  String ten(String text) => modifier('T', text);

  /// Plural modifier for any number of elements, except 0, 1 and 2.
  String times(int numberOfTimes, String text) =>
      modifier('$numberOfTimes', text);

  /// Plural modifier for 2, 3 or 4 elements (especially for Czech language).
  String twoThreeFour(String text) => modifier('C', text);

  /// Plural modifier for any number of elements, except 1.
  String many(String text) => modifier('M', text);
}
