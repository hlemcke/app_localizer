# AppLocalizer

`AppLocalizer` manages the apps locale.
At startup it is taken from the platform, but can be overwritten from a
persistence storage like `SharedPreferences`.

App locale can be changed both from within the app (with `LanguageChooser`)
and from platform settings (internal listener).

Translating strings can easily be done with `Translator`.

There are also choosers for `country` and `currency`.
All choosers can display flags.


### Languages

A `Language` is a a thin wrapper around `Locale` and a plain Dart class providing:

* `code` - 2 lowercase characters according to ISO-639
* `countryCode` - ISO-3166 alpha-2 for the main country where this language is spoken
* `name` - localized name of the language

`Languages` provides the list of all languages.

A __special__ language with `code` "xx" and `countryCode` "XX"
represents the current platform language.

`LanguageChooser` allows selection of a language both from the whole list or a subset.
A special selection for the platform locale can be included.


### Countries

A `Country` is a plain Dart class providing:

* `alpha2` &rarr; ISO-3166 alpha-2 code 
* `alpha3` &rarr; ISO-3166 alpha-3 code
* `num3` &rarr; ISO-3166 numerical code
* `name` &rarr; country name in countries native language
* `predial` &rarr; international phone pre-dial
* `language` &rarr; official language in the country
* `currency` &rarr; official currency in the country
* `timezone` &rarr; offset to UTC

`Countries` provides the list of all countries.

`CountryChooser` allows selection of a country both from the whole list or from a subset.


### Currencies

A `Currency` is a plain Dart class providing:

* `code` &rarr; three uppercase characters according to ISO-4217
* `minor` &rarr; number of digits for minor currency (e.g. Cents)
* `name` &rarr; the native name of the currency
* `symbol` &rarr; currency symbol (requires a UTF-8 font which contains currency symbols)

`Currencies` provides the list of all countries.

`CurrencyChooser` allows selection of a currency both from the whole list or a subset.


## Example

Please run `example` from the package to see all available features.

Use this code to have `AppLocalizer` taking care of the active locale for the app:

```dart
/// List of locales supported by your app. defaultLocale is "en"
List<Locale> supportedLocales = [
  AppLocalizer.defaultLocale,
  Locale('de', 'DE'),
  Locale('es', 'ES'),
];

  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: AppLocalizer.initialize(
        supportedLocales: supportedLocales,
      ).notifier,
      builder: (BuildContext context, Locale locale, Widget? child) =>
          MaterialApp(
        // --- builder is used here to set 24hour format. Can be omitted.
        builder: (BuildContext context, Widget? child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!),
        home: MyHomePage(),
        localeListResolutionCallback: (List<Locale>? devLocales,
                Iterable<Locale> appLocales) =>
            AppLocalizer()
                .localeListResolutionCallback(context, devLocales, appLocales),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
        ...
```