import '../app_localizer.dart';

extension Localization on String {
  String get i18n => translate(this, _t);

  // --- This technique allows integration of existing translations
  static Translator _t = Translator(translations: languageTranslations);
}

Map<String, Map<String, String>> languageTranslations = {
  'de': {
    'de': 'deutsch',
    'en': 'german',
    'es': 'alemán',
    'fr': 'allemand',
    'it': 'tedesco',
  },
  'en': {
    'de': 'englisch',
    'en': 'english',
    'es': 'inglés',
    'fr': 'anglais',
    'it': 'inglese',
  },
  'es': {
    'de': 'spanisch',
    'en': 'spanish',
    'es': 'español',
    'fr': 'espagnol',
    'it': 'spagnolo',
  },
  'fr': {
    'de': 'französisch',
    'en': 'french',
    'es': 'francés',
    'fr': 'français',
    'it': 'francese',
  },
  'it': {
    'de': 'italienisch',
    'en': 'italian',
    'es': 'italiano',
    'fr': 'italien',
    'it': 'italiano',
  },
  'ja': {
    'de': 'japanisch',
    'en': 'japanese',
    'es': 'japonés',
    'fr': 'japonais',
    'it': 'giapponese',
    'ja': '日本語',
  },
  'nl': {
    'de': 'niederländisch',
    'en': 'netherlands',
    'es': 'holandés',
    'fr': 'néerlandais',
    'it': 'olandese',
  },
  'ru': {
    'de': 'russisch',
    'en': 'russian',
    'es': 'ruso',
    'fr': 'russej',
    'it': 'russo',
    'ru': 'Русский',
  },
  'th': {
    'de': 'thailändisch',
    'en': 'thai',
    'es': 'tailandésj',
    'fr': 'thaïlandais',
    'it': 'tailandese',
    'th': 'ไทย',
  },
  'xx': {
    'de': 'vom Gerät',
    'en': 'from platform',
    'es': 'desde dispositivo',
    'fr': 'depuis appareil',
    'it': 'dal dispositivo',
  },
  'zh': {
    'de': 'chinesisch',
    'en': 'chinese',
    'es': 'chino',
    'fr': 'chinois',
    'it': 'cinese',
    'zh': '中文',
  },
};
