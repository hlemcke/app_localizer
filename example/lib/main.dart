import 'dart:ui';

import 'package:app_localizer/app_localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'counter_page.dart';
import 'main.i18n.dart';

const double SAFE_AREA_PADDING = 5.0;
List<Locale> supportedLocales = [
  AppLocalizer.defaultLocale,
  Locale('de', 'DE'),
  Locale('es', 'ES'),
];

/// Entry point for example application
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => AppLocalizer(
        supportedLocales: supportedLocales,
        child: MaterialApp(
          builder: (BuildContext context, Widget? child) => MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!),
          home: MyHomePage(),
          localeListResolutionCallback:
              (List<Locale>? devLocales, Iterable<Locale> appLocales) =>
                  AppLocalizer.localeListResolutionCallback(
                      context, devLocales, appLocales),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: supportedLocales,
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          title: 'AppLocalizer',
        ),
      );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Country? _country1, _country2;
  Currency? _currency1, _currency2;
  DisplayItemType displayItem = DisplayItemType.flagAndName,
      displaySelection = DisplayItemType.flagAndName;
  Locale? _language1, _language2;

  @override
  Widget build(BuildContext context) {
    debugPrint('MyHomePageState.build()');
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        minimum: EdgeInsets.all(SAFE_AREA_PADDING),
        child: SingleChildScrollView(
          child: _buildBody(context),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() => AppBar(
        title: Text('app_localizer ' + 'example.label'.i18n),
        actions: [
          IconButton(
            tooltip: 'counter.navigate.tooltip'.i18n,
            icon: Icon(Icons.numbers),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CounterPage(),
              ),
            ),
          ),
          LanguageChooser(
            onChanged: (v) => AppLocalizer.activeLocale = v,
            selectionDisplay: DisplayItemType.flagAndName,
            value: AppLocalizer.activeLocale,
            withPlatform: true,
          ),
        ],
      );

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildLanguageSelector(),
          _buildAllItems(),
          _buildSelectableItems(),
          _buildItemDisplaySelection(),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() => Padding(
        padding: EdgeInsets.all(SAFE_AREA_PADDING),
        child: InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            labelText: 'In-App Language Selection'.i18n,
          ),
          child: Table(
              columnWidths: {
                0: FractionColumnWidth(0.2),
                1: FlexColumnWidth(1.0),
                2: FractionColumnWidth(0.1),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  Text('window.locale'),
                  Text('${PlatformDispatcher.instance.locale}'),
                  HelpButtonWithDialog(content: 'window.locale.help'.i18n),
                ]),
                TableRow(children: [
                  Text('usePlatform'),
                  Text('${AppLocalizer.usePlatformLocale}'),
                  HelpButtonWithDialog(
                      content: 'useLocaleFromPlatform.help'.i18n)
                ]),
                TableRow(children: [
                  Text('activeLocale'),
                  Text('${AppLocalizer.activeLocale}'),
                  HelpButtonWithDialog(content: 'activeLocale.help'.i18n)
                ]),
                TableRow(children: [
                  Text('targetCode'),
                  Text('${Translator.activeLanguageCode}'),
                  HelpButtonWithDialog(content: 'Localization.code.help'.i18n)
                ]),
                TableRow(children: [
                  Text('Select language'.i18n),
                  LanguageChooser(
                    itemDisplay: displayItem,
                    onChanged: (Locale? newLang) =>
                        setState(() => AppLocalizer.activeLocale = newLang),
                    selectables: supportedLocales,
                    selectionDisplay: displaySelection,
                    value: AppLocalizer.usePlatformLocale
                        ? Language.platformLocale
                        : AppLocalizer.activeLocale,
                    withPlatform: true,
                  ),
                  HelpButtonWithDialog(content: 'languageSelector.help'.i18n)
                ]),
              ]),
        ),
      );

  Widget _buildAllItems() {
    return Padding(
      padding: EdgeInsets.all(SAFE_AREA_PADDING),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelText: 'All items'.i18n,
        ),
        child: Table(
          columnWidths: {
            0: FractionColumnWidth(0.2),
            1: FlexColumnWidth(1.0),
            2: FractionColumnWidth(0.1),
            3: FractionColumnWidth(0.1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Text('All'.i18n),
                Text('Selection'.i18n),
                Text('Code', textAlign: TextAlign.center),
                Text('column.help'.i18n, textAlign: TextAlign.center),
              ],
            ),
            TableRow(
              children: [
                Text('countries.label'.i18n),
                CountryChooser(
                  onChanged: (v) => setState(() => _country1 = v),
                  value: _country1,
                ),
                Text('${_country1?.alpha2}', textAlign: TextAlign.center),
                HelpButtonWithDialog(content: 'all.ctry.help'.i18n),
              ],
            ),
            if (_country1 != null)
              TableRow(
                children: [
                  SizedBox.shrink(),
                  Text('code=${_country1!.alpha2}  '
                      'num=${_country1!.num3}  '
                      'predial=+${_country1!.predial}  '
                      'TZ=${_country1!.timezone}h'),
                  SizedBox.shrink(),
                  SizedBox.shrink(),
                ],
              ),
            TableRow(
              children: [
                Text('currencies.label'.i18n),
                CurrencyChooser(
                  onChanged: (v) => setState(() => _currency1 = v!),
                  value: _currency1,
                ),
                Text('${_currency1?.code}', textAlign: TextAlign.center),
                HelpButtonWithDialog(content: 'all.cur.help'.i18n),
              ],
            ),
            if (_currency1 != null)
              TableRow(
                children: [
                  SizedBox.shrink(),
                  Text('code=${_currency1!.code}  '
                      'symbol=${_currency1!.symbol}  '
                      'minor=${_currency1!.minor}  '
                      'country=${_currency1!.country}'),
                  SizedBox.shrink(),
                  SizedBox.shrink(),
                ],
              ),
            TableRow(children: [
              Text('languages.label'.i18n),
              LanguageChooser(
                value: _language1,
                onChanged: (v) => setState(() => _language1 = v),
                withPlatform: true,
              ),
              Text('${_language1?.languageCode}', textAlign: TextAlign.center),
              HelpButtonWithDialog(content: 'all.lang.help'.i18n),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectableItems() {
    List<String> _selectableCountries = ['DE', 'ES', 'FR', 'IT'];
    List<String> _selectableCurrencies = ['EUR', 'USD'];
    List<Locale> _selectableLocales = [Locale('en'), Locale('es')];

    return Padding(
      padding: EdgeInsets.all(SAFE_AREA_PADDING),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelText: 'Selectable Items'.i18n,
        ),
        child: Table(
          columnWidths: {
            0: FractionColumnWidth(0.2),
            1: FlexColumnWidth(1.0),
            2: FractionColumnWidth(0.1),
            3: FractionColumnWidth(0.1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Text('Selectables'.i18n),
                Text('Selection'.i18n),
                Text('Code', textAlign: TextAlign.center),
                Text('column.help'.i18n, textAlign: TextAlign.center),
              ],
            ),
            TableRow(
              children: [
                Text('$_selectableCountries'),
                CountryChooser(
                  onChanged: (v) => setState(() => _country2 = v!),
                  selectable: _selectableCountries,
                  value: _country2,
                ),
                Text('${_country2?.alpha2}', textAlign: TextAlign.center),
                HelpButtonWithDialog(content: 'sel.ctry.help'.i18n),
              ],
            ),
            TableRow(
              children: [
                Text('$_selectableCurrencies'),
                CurrencyChooser(
                  onChanged: (v) => setState(() => _currency2 = v),
                  selectable: _selectableCurrencies,
                  value: _currency2,
                ),
                Text('${_currency2?.code}', textAlign: TextAlign.center),
                HelpButtonWithDialog(content: 'sel.cur.help'.i18n),
              ],
            ),
            TableRow(children: [
              Text(_selectableLocales.toString()),
              LanguageChooser(
                onChanged: (v) => setState(() => _language2 = v),
                selectables: _selectableLocales,
                value: _language2,
              ),
              Text('${_language2?.languageCode}', textAlign: TextAlign.center),
              HelpButtonWithDialog(content: 'sel.lang.help'.i18n),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildItemDisplaySelection() {
    List<DropdownMenuItem<DisplayItemType>> items = [
      DropdownMenuItem(
          value: DisplayItemType.flagAndName,
          child: Text(DisplayItemType.flagAndName.toString().i18n)),
      DropdownMenuItem(
          value: DisplayItemType.flagOnly,
          child: Text(DisplayItemType.flagOnly.toString().i18n)),
      DropdownMenuItem(
          value: DisplayItemType.nameAndFlag,
          child: Text(DisplayItemType.nameAndFlag.toString().i18n)),
      DropdownMenuItem(
          value: DisplayItemType.nameOnly,
          child: Text(DisplayItemType.nameOnly.toString().i18n)),
    ];
    return Padding(
      padding: EdgeInsets.all(SAFE_AREA_PADDING),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelText: 'items.display.label'.i18n,
        ),
        child: Table(
            columnWidths: {
              0: FractionColumnWidth(0.2),
              1: FlexColumnWidth(1.0),
              2: FractionColumnWidth(0.1),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  Text('display.selection.label'.i18n),
                  DropdownButton<DisplayItemType>(
                    items: items,
                    onChanged: (v) => setState(() => displaySelection = v!),
                    value: displaySelection,
                  ),
                  HelpButtonWithDialog(content: 'display.selection.help'.i18n),
                ],
              ),
              TableRow(
                children: [
                  Text('display.item.label'.i18n),
                  DropdownButton<DisplayItemType>(
                    items: items,
                    onChanged: (v) => setState(() => displayItem = v!),
                    value: displayItem,
                  ),
                  HelpButtonWithDialog(content: 'display.item.help'.i18n),
                ],
              ),
            ]),
      ),
    );
  }
}

class HelpButtonWithDialog extends StatelessWidget {
  ///
  /// Content of help dialog supporting markdown.
  ///
  /// If the first sentence ends with "=="
  /// then it will be interpreted as the title of the help dialog.
  ///
  /// If there is a second separator "=="
  /// then the remaining text will be used for the buttons tooltip.
  final String content;

  HelpButtonWithDialog({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    Widget? title;
    String text = content;
    String? tooltip;
    int i = content.indexOf("==");
    if (i > 0) {
      title = Text(content.substring(0, i));
      int j = content.indexOf("==", i + 2);
      if (j > 0) {
        tooltip = content.substring(j + 2);
        text = content.substring(i + 2, j);
      } else {
        text = content.substring(i + 2);
      }
    }
    return IconButton(
      icon: Icon(Icons.help_outline),
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: title,
          content: Text(text),
          actions: [
            ElevatedButton.icon(
              icon: Icon(Icons.thumb_up_outlined),
              label: Text('thanks.action'.i18n),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
      tooltip: tooltip,
    );
  }
}
