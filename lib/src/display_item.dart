import 'package:flutter/material.dart';

import '../app_localizer.dart';

///
/// Displays a localized country name with its flag image.

/// Resolves [locale] to a supported locale (see [AppLocalizer.supportedLocales])
/// for translation of [countryCode].
///
class LocalizedCountryDisplayItem extends StatelessWidget {
  /// Target language to display name.
  /// `null` will use [AppLocalizer.activeLocale]
  final Locale? locale;

  /// Code (2 chars uppercase) to select the country
  final String countryCode;

  /// Order and content of display
  final DisplayItemType displayType;

  LocalizedCountryDisplayItem({
    this.locale,
    required this.countryCode,
    this.displayType = DisplayItemType.flagAndName,
  });

  @override
  Widget build(BuildContext context) {
    Country? country = Countries.find(countryCode);
    country ??= Country.unknown;
    return DisplayItem(
      label: country.getTranslation(locale),
      countryCode: country.alpha2,
      displayType: displayType,
    );
  }
}

///
/// Displays a localized language name with its flag image.
///
/// Resolves [locale] to a supported locale (see [AppLocalizer.supportedLocales])
/// for translation of [languageCode].
///
class LocalizedLanguageDisplayItem extends StatelessWidget {
  /// Target language to display name.
  /// `null` will use [AppLocalizer.activeLocale]
  final Locale? locale;

  /// Code (2 chars lowercase) to select the language
  final String languageCode;

  /// Order and content of display
  final DisplayItemType displayType;

  LocalizedLanguageDisplayItem({
    this.locale,
    required this.languageCode,
    this.displayType = DisplayItemType.flagAndName,
  });

  @override
  Widget build(BuildContext context) {
    Language? lang = Languages.findByCode(languageCode);
    lang ??= Language.defaultLanguage;
    return DisplayItem(
      label: lang.getTranslation(locale),
      countryCode: lang.countryCode,
      displayType: displayType,
    );
  }
}

///
/// Displays a single item from a choosers selection list
/// or the selected item itself.
///
class DisplayItem extends StatelessWidget {
  /// Displayed text. No translation done here
  final String label;

  /// Code (2 chars uppercase) used to select the flag
  final String countryCode;

  /// What shall be displayed
  final DisplayItemType displayType;

  DisplayItem({
    required this.label,
    required this.countryCode,
    this.displayType = DisplayItemType.flagAndName,
  });

  /// Get the flag image by country code (2 uppercase characters)
  static Image getFlagByCode(String countryCode) => Image.asset(
        'lib/assets/flags/$countryCode.png',
        package: 'app_localizer',
      );

  @override
  Widget build(BuildContext context) {
    Widget? flag, name;
    //--- Maps currencies without proper country to XX
    String code = countryCode;
    if (countryCode.startsWith('X')) {
      code = 'XX';
    }
    flag = countryCode.isEmpty ? null : getFlagByCode(code);
    Widget hGap = SizedBox(width: kMinInteractiveDimension / 3);
    name = label.isEmpty
        ? null
        : Text(
            label,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          );
    if (displayType == DisplayItemType.flagAndName) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          flag!,
          hGap,
          SingleChildScrollView(scrollDirection: Axis.horizontal, child: name)
        ],
      );
    }
    if (displayType == DisplayItemType.flagOnly) {
      return flag!;
    }
    if (displayType == DisplayItemType.nameAndFlag) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [name!, hGap, flag!],
      );
    }
    return name!;
  }
}

enum DisplayItemType {
  flagAndName,
  flagOnly,
  nameAndFlag,
  nameOnly;
}
