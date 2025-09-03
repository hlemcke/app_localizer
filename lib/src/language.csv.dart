// Copyright 2021,2022 djarjo@djarjo.com
// Please see the LICENSE file for details.

/// List of languages. Columns contain:
///
/// * `alpha-2` = IANA language code according to ISO-639
/// * `country` = IANA country code according to ISO-3166. Used to display flag
/// * `name` = Name of language in that language
///
/// Mobile device character `📱` can be used as name for Language.platform
///
String csvListOfLanguages = '''
alpha-2,country,name
de,DE,Deutsch
en,US,English
es,ES,Español 
fr,FR,Français
it,IT,Italiano
ja,JP,日本語
nl,NL,Nederlands
ru,RU,Русский
th,TH,ไทย
zh,CN,中文
''';
