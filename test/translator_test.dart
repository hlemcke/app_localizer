import 'package:app_localizer/app_localizer.dart';
import 'package:flutter_test/flutter_test.dart';

///
/// Unit tests for [translate], [translateOrNull], [translateFill]
/// and [translatePlural].
///
void main() {
  final Translator t = Translator(
    translations: {
      'greeting': {'de': 'Hallo', 'en': 'Hello', 'fr': 'Bonjour'},
      'onlyEnglish': {'en': 'English only'},
      'onlyGerman': {'de': 'Nur Deutsch'},
      'filled': {'de': '%s hat %d Äpfel', 'en': '%s has %d apples'},
      'filledEnglish': {'en': '%s has %d pears'},
      'clicks': {
        'de': 'Du hast %d mal geklickt'
            .zero('Du hast nicht geklickt')
            .one('Du hast einmal geklickt'),
        'en': 'You clicked %d times'
            .zero('You did not click')
            .one('You clicked once'),
      },
      'clicksEnglish': {
        'en': 'You clicked %d times'.one('You clicked once'),
      },
    },
  );

  //--- Static state of Translator must not leak from one test into the next
  setUp(() {
    Translator.activeLanguageCode = 'de';
    Translator.fallbackLanguageCode = 'en';
    Translator.missingKeys.clear();
    Translator.missingTranslations.clear();
    Translator.missingKeyRecording = true;
    Translator.missingTranslationRecording = true;
    //--- Keep test output clean
    Translator.missingKeyCallback = (_) {};
    Translator.missingTranslationCallback = (_, _) {};
  });

  group('translate', () {
    test('returns text in active language', () {
      expect(translate('greeting', t), 'Hallo');
      expect(Translator.missingKeys, isEmpty);
      expect(Translator.missingTranslations, isEmpty);
    });

    test('parameter langCode overrides active language', () {
      expect(translate('greeting', t, langCode: 'fr'), 'Bonjour');
    });

    test('Translator.langCode overrides active language', () {
      Translator tFr = Translator(translations: t.translations, langCode: 'fr');
      expect(translate('greeting', tFr), 'Bonjour');
    });

    test('missing key returns key and records it', () {
      expect(translate('unknown', t), 'unknown');
      expect(Translator.missingKeys, {'unknown'});
      expect(Translator.missingTranslations, isEmpty);
    });

    test('missing language falls back to English and records it', () {
      expect(translate('onlyEnglish', t), 'English only');
      expect(Translator.missingTranslations, {'onlyEnglish de'});
      expect(Translator.missingKeys, isEmpty);
    });

    test('fallback: false returns key and records missing language', () {
      expect(translate('onlyEnglish', t, fallback: false), 'onlyEnglish');
      expect(Translator.missingTranslations, {'onlyEnglish de'});
    });

    test('missing language without English text returns key', () {
      Translator.activeLanguageCode = 'fr';
      expect(translate('onlyGerman', t), 'onlyGerman');
      expect(Translator.missingTranslations, {'onlyGerman fr'});
    });

    test('fallbackLanguageCode = null disables fallback', () {
      Translator.fallbackLanguageCode = null;
      expect(translate('onlyEnglish', t), 'onlyEnglish');
    });

    test('other fallbackLanguageCode is used', () {
      Translator.activeLanguageCode = 'fr';
      Translator.fallbackLanguageCode = 'de';
      expect(translate('onlyGerman', t), 'Nur Deutsch');
    });

    test('missing recordings can be switched off', () {
      Translator.missingKeyRecording = false;
      Translator.missingTranslationRecording = false;
      translate('unknown', t);
      translate('onlyEnglish', t);
      expect(Translator.missingKeys, isEmpty);
      expect(Translator.missingTranslations, isEmpty);
    });
  });

  group('translate with keyIsTranslationTo', () {
    //--- Keys are the English texts themselves
    final Translator tKeyEn = Translator(
      translations: {
        'Hello': {'de': 'Hallo'},
        'Good bye': {'de': 'Tschüss', 'en': 'Bye'},
      },
      keyIsTranslationTo: 'en',
    );

    test('key is returned for its own language without recording', () {
      Translator.activeLanguageCode = 'en';
      expect(translate('Hello', tKeyEn), 'Hello');
      expect(Translator.missingTranslations, isEmpty);
    });

    test('explicit text wins over key for its own language', () {
      Translator.activeLanguageCode = 'en';
      expect(translate('Good bye', tKeyEn), 'Bye');
    });

    test('other language without text falls back to English text', () {
      Translator.activeLanguageCode = 'fr';
      expect(translate('Good bye', tKeyEn), 'Bye');
      expect(Translator.missingTranslations, {'Good bye fr'});
    });

    test('other language without any text returns key', () {
      Translator.activeLanguageCode = 'fr';
      expect(translate('Hello', tKeyEn), 'Hello');
    });
  });

  group('translateOrNull', () {
    test('returns text in active language', () {
      expect(translateOrNull('greeting', t), 'Hallo');
    });

    test('parameter langCode overrides active language', () {
      expect(translateOrNull('greeting', t, langCode: 'fr'), 'Bonjour');
    });

    test('missing key returns null and is NOT recorded', () {
      expect(translateOrNull('unknown', t), isNull);
      expect(Translator.missingKeys, isEmpty);
    });

    test('missing language falls back to English and records it', () {
      expect(translateOrNull('onlyEnglish', t), 'English only');
      expect(Translator.missingTranslations, {'onlyEnglish de'});
    });

    test('fallback: false returns null and records missing language', () {
      expect(translateOrNull('onlyEnglish', t, fallback: false), isNull);
      expect(Translator.missingTranslations, {'onlyEnglish de'});
    });

    test('missing language without English text returns null', () {
      Translator.activeLanguageCode = 'fr';
      expect(translateOrNull('onlyGerman', t), isNull);
    });

    test('fallbackLanguageCode = null returns null', () {
      Translator.fallbackLanguageCode = null;
      expect(translateOrNull('onlyEnglish', t), isNull);
    });
  });

  group('translateFill', () {
    test('replaces parameters in active language', () {
      expect(translateFill('filled', t, ['Anna', 3]), 'Anna hat 3 Äpfel');
    });

    test('parameter langCode overrides active language', () {
      expect(
        translateFill('filled', t, ['Anna', 3], langCode: 'en'),
        'Anna has 3 apples',
      );
    });

    test('missing language falls back to English', () {
      expect(translateFill('filledEnglish', t, ['Anna', 2]), 'Anna has 2 pears');
    });

    test('fallback: false returns key', () {
      expect(
        translateFill('filledEnglish', t, ['Anna', 2], fallback: false),
        'filledEnglish',
      );
    });

    test('missing key returns key', () {
      expect(translateFill('unknown', t, ['Anna']), 'unknown');
    });
  });

  group('translatePlural', () {
    test('selects plural variant in active language', () {
      expect(translatePlural('clicks', t, 0), 'Du hast nicht geklickt');
      expect(translatePlural('clicks', t, 1), 'Du hast einmal geklickt');
      expect(translatePlural('clicks', t, 5), 'Du hast 5 mal geklickt');
    });

    test('parameter langCode overrides active language', () {
      expect(translatePlural('clicks', t, 1, langCode: 'en'), 'You clicked once');
    });

    test('missing language falls back to English', () {
      expect(translatePlural('clicksEnglish', t, 1), 'You clicked once');
      expect(translatePlural('clicksEnglish', t, 4), 'You clicked 4 times');
    });

    test('fallback: false returns key', () {
      expect(
        translatePlural('clicksEnglish', t, 1, fallback: false),
        'clicksEnglish',
      );
    });

    test('missing key returns key', () {
      expect(translatePlural('unknown', t, 1), 'unknown');
    });
  });
}
