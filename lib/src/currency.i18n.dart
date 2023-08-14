import '../app_localizer.dart';

extension Localization on String {
  String get i18n => translate(this, _t);

  // --- This technique allows integration of existing translations
  static Translator _t = Translator(translations: currencyTranslations);
}

Map<String, Map<String, String>> currencyTranslations = {
  'ALL': {
    'de': 'Albanische Lek',
    'en': 'Lek',
  },
  'ARS': {
    'de': 'Argentinische Peso',
    'en': 'Argentine Peso',
  },
  'AUD': {
    'de': 'Australische Dollar',
    'en': 'Australian Dollar',
  },
  'CAD': {
    'de': 'Kanadische Dollar',
    'en': 'Canadian Dollar',
  },
  'CHF': {
    'de': 'Schweizer Franken',
    'en': 'Swiss Franc',
  },
  'CUP': {
    'de': 'Kubanische Peso',
    'en': 'Cuban Peso',
  },
  'EGP': {
    'de': 'Ägyptische Pfund',
    'en': 'Egyptian Pound',
  },
  'EGP': {
    'de': 'Ägyptische Pfund',
    'en': 'Egyptian Pound',
  },
  'GBP': {
    'de': 'Pfund Sterling',
    'en': 'Pound Sterling',
  },
};
