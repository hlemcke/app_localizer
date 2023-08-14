import 'package:app_localizer/app_localizer.dart';
import 'package:app_localizer/src/language.i18n.dart';
import 'package:flutter/material.dart';

import 'display_item.dart';
import 'language.dart';

///
/// [DropdownButton] to select a language.
///
/// Languages are loaded from `language.csv.dart`.
/// A subset of these languages can be used by setting [selectable].
///
/// Language names will be translated by using [AppLocalizer.activeLocale].
/// Can be overwritten by providing [locale].
/// [useNativeNames] = true will display the native name of the language.
///
class LanguageChooser extends StatelessWidget {
  /// See [DropdownButton]
  final AlignmentGeometry alignment;

  /// See [DropdownButton]
  final bool autofocus;

  /// See [DropdownButton]
  final Color? focusColor;

  /// See [DropdownButton]
  final FocusNode? focusNode;

  /// How each item shall be displayed
  final DisplayItemType itemDisplay;

  /// If `null` then field will be disabled
  final ValueChanged<Locale?>? onChanged;

  /// Filter for selectable languages.
  /// List of language codes.
  /// `null` will show full list.
  final List<String>? selectable;

  /// Target language in which language names will be displayed.
  /// This value is only used if [useNativeNames] is `false`.
  /// `null` will use native language name.
  final Locale? locale;

  /// How the selection shall be displayed
  final DisplayItemType selectionDisplay;

  /// See [DropdownButton]
  final Widget? underline;

  /// `false` will translate names to [locale] or [AppLocalizer.activeLocale].
  /// Default is `true`.
  final bool useNativeNames;

  /// Value displayed
  final Locale? value;

  /// `true` adds language with code 'xx' to start of selection list.
  /// This locale can be used to get the language from platform (e.g. mobile).
  /// Default is `false`.
  final bool withPlatform;

  LanguageChooser({
    this.alignment = AlignmentDirectional.centerStart,
    this.autofocus = false,
    this.focusColor,
    this.focusNode,
    this.locale,
    this.onChanged,
    this.selectable,
    this.itemDisplay = DisplayItemType.flagAndName,
    this.selectionDisplay = DisplayItemType.flagAndName,
    this.underline,
    this.useNativeNames = true,
    this.value,
    this.withPlatform = false,
  });

  @override
  Widget build(BuildContext context) {
    //--- Build item list
    List<Language> languages = (selectable != null)
        ? Languages.filterByCodes(selectable!).toList()
        : Languages.values().toList();
    //--- Build display names
    Map<String, Language> data = {};
    for (Language language in languages) {
      String name = useNativeNames ? language.name : language.getTranslation();
      data[name] = language;
    }
    //--- Sort by display names
    List<String> sorted = data.keys.toList()
      ..sort((String s1, String s2) => s1.compareTo(s2));
    //--- Insert "from platform" at start of list
    if (withPlatform) {
      String displayedPlatformName = ((locale == null) || useNativeNames)
          ? Language.platformLanguage.name
          : Language.platformLanguage.code.i18n;
      sorted.insert(0, displayedPlatformName);
      data[displayedPlatformName] = Language.platformLanguage;
    }
    return DropdownButton<Locale>(
      alignment: alignment,
      autofocus: autofocus,
      focusColor: focusColor,
      focusNode: focusNode,
      items: sorted
          .map(
            (String name) => DropdownMenuItem<Locale>(
              value: data[name]?.toLocale(),
              child: DisplayItem(
                label: name,
                countryCode: data[name]!.countryCode,
                displayType: itemDisplay,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      selectedItemBuilder: (BuildContext context) => sorted
          .map((String name) => DisplayItem(
                label: name,
                countryCode: data[name]!.countryCode,
                displayType: selectionDisplay,
              ))
          .toList(),
      underline: underline,
      value: value,
    );
  }
}
