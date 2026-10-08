## [3.0.0] - 2026-10-08

* BREAKING: `langCode` of `translate()`, `translateFill()` and
  `translatePlural()` is now a named parameter
* `translate()`, `translateFill()` and `translatePlural()` fall back to
  `Translator.fallbackLanguageCode` (default `en`) if a key has no text for the
  target language. Named parameter `fallback: false` disables it per call
* New `translateOrNull()` returns `null` instead of the key for optional texts.
  Missing keys are not recorded

## [2.2.0] - 2022-09-21 - Initial Release as a new package

* This package is an enhanced development of "input_country"
* __AppLocalizer__ completely manages the active app locale
* __Translator__ is included for string translations
* Choosers are simple [DropdownButton]s
* 253 flag images are included

## [2.0.0] - 2021-03-25 - Full null-safety

* Package is completely null-safe
