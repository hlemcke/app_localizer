import 'package:flutter/material.dart';

import '../app_localizer.dart';

class CountryChooser extends StatelessWidget {
  /// See [DropdownButton]
  final AlignmentGeometry alignment;

  /// See [DropdownButton]
  final bool autofocus;

  /// See [DropdownButton]
  final Color? focusColor;

  /// See [DropdownButton]
  final FocusNode? focusNode;

  /// Target language in which items will be displayed.
  /// `null` will use native country name.
  final Locale? locale;

  /// If `null` then field will be disabled
  final ValueChanged<Country?>? onChanged;

  /// Filter for selectable countries.
  /// List of country codes.
  /// `null` will show full list.
  final List<String>? selectable;

  /// How each item shall be displayed
  final DisplayItemType itemDisplay;

  /// How the selection shall be displayed
  final DisplayItemType selectionDisplay;

  /// See [DropdownButton]
  final Widget? underline;

  /// Value displayed
  final Country? value;

  CountryChooser({
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
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    List<Country> countries = ((selectable != null) && (selectable!.isNotEmpty))
        ? Countries.filterByCodes(selectable!).toList()
        : Countries.values().toList();
    //--- Build display names
    Map<String, Country> data = {};
    for (Country country in countries) {
      data[country.getTranslation()] = country;
    }
    //--- Sort by display names
    List<String> sorted = data.keys.toList();
    sorted.sort((String s1, String s2) => s1.compareTo(s2));
    // debugPrint('value=$value // data=$data');
    return DropdownButton<Country>(
      alignment: alignment,
      autofocus: autofocus,
      focusColor: focusColor,
      focusNode: focusNode,
      items: sorted.map(
        (String name) {
          return DropdownMenuItem<Country>(
            value: data[name],
            child: DisplayItem(
              label: name,
              countryCode: data[name]?.alpha2 ?? 'UN',
              displayType: itemDisplay,
            ),
          );
        },
      ).toList(),
      onChanged: onChanged,
      selectedItemBuilder: (BuildContext context) => sorted
          .map((String name) => DisplayItem(
              label: name,
              countryCode: data[name]?.alpha2 ?? 'UN',
              displayType: selectionDisplay))
          .toList(),
      underline: underline,
      value: value,
    );
  }
}
