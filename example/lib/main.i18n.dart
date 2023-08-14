import 'package:app_localizer/app_localizer.dart';
import 'package:app_localizer_example/main.i19n.dart';

extension Localization on String {
  String plural(int count) => translatePlural(this, _t, count);
  String fill(List<Object> params) => translateFill(this, _t, params);
  String get i18n => translate(this, _t);

  // --- This technique allows integration of other translations by reusing them
  static Translator _t = Translator(translations: {
    ...exampleTranslations,
    // ...otherTranslations,
  });
}
