// Copyright 2021,2022 dev@djarjo.com
// Please see the LICENSE file for details.

///
/// List of all currencies.
/// Column `country` denotes the main country of the currency.
///
/// The text is just a csv file with a header row and each currency on one line.
///
String csvListOfCurrencies = '''
alpha-3,name,minor,symbol,country
AED,UAE Dirham,2,,AE
AFN,Afghani,2,,AF
ALL,Lek,2,,AL,Albanische Lek
AMD,Armenian Dram,2,,AM
AOA,Kwanza,2,,AO
ARS,Argentine Peso,2,,AR,Argentinische Peso
AUD,Australian Dollar,2,,AU,Australische Dollar
AWG,Aruban Florin,2,,AW
AZN,Azerbaijan Manat,2,,AZ
BAM,Convertible Mark,2,,BA
BBD,Barbados Dollar,2,,BB
BDT,Taka,2,,BD
BGN,Bulgarian Lev,2,,BG
BHD,Bahraini Dinar,3,,BH
BIF,Burundi Franc,0,,BI
BMD,Bermudian Dollar,2,,BM
BND,Brunei Dollar,2,,BN
BOB,Boliviano,2,,BO
BOV,Mvdol,2,,BO
BRL,Brazilian Real,2,,BR
BSD,Bahamian Dollar,2,,BS
BTN,Ngultrum,2,,BT
BWP,Pula,2,,BW
BYN,Belarusian Ruble,2,,BY
BZD,Belize Dollar,2,,BZ
CAD,Canadian Dollar,2,,CA
CDF,Congolese Franc,2,,CD
CHF,Swiss Franc,2,,CH
CHW,WIR Franc,2,,CH
CLF,Unidad de Fomento,4,,CL
CLP,Chilean Peso,0,,CL
CNY,Yuan Renminbi,2,元,CN
COP,Colombian Peso,2,,CO
COU,Unidad de Valor Real,2,,CO
CRC,Costa Rican Colon,2,,CR
CUC,Peso Convertible,2,,CU
CUP,Cuban Peso,2,,CU
CVE,Cabo Verde Escudo,2,,CV
CZK,Czech Koruna,2,,CZ
DJF,Djibouti Franc,0,,DJ
DKK,Danish Krone,2,,DK
DOP,Dominican Peso,2,,DO
DZD,Algerian Dinar,2,,DZ
EGP,Egyptian Pound,2,,EG
ERN,Nakfa,2,,ER
ETB,Ethiopian Birr,2,,ET
EUR,Euro,2,€,EU
FJD,Fiji Dollar,2,,FJ
FKP,Falkland Islands Pound,2,,FK
GBP,Pound Sterling,2,,GB
GEL,Lari,2,,GE
GHS,Ghana Cedi,2,,GH
GIP,Gibraltar Pound,2,,GI
GMD,Dalasi,2,,GM
GNF,Guinean Franc,0,,GN
GTQ,Quetzal,2,,GT
GYD,Guyana Dollar,2,,GY
HKD,Hong Kong Dollar,2,,HK
HNL,Lempira,2,,HN
HRK,Kuna,2,,HR
HTG,Gourde,2,,HT
HUF,Forint,2,,HU
IDR,Rupiah,2,,ID
ILS,New Israeli Sheqel,2,,IL
INR,Indian Rupee,2,,IN
IQD,Iraqi Dinar,3,,IQ
IRR,Iranian Rial,2,,IR
ISK,Iceland Krona,0,,IS
JMD,Jamaican Dollar,2,,JM
JOD,Jordanian Dinar,3,,JO
JPY,Yen,0,¥,JP
KES,Kenyan Shilling,2,,KE
KGS,Som,2,,KG
KHR,Riel,2,,KH
KMF,Comorian Franc ,0,,KM
KPW,North Korean Won,2,,KP
KRW,Won,0,,KR
KWD,Kuwaiti Dinar,3,,KW
KYD,Cayman Islands Dollar,2,,KY
KZT,Tenge,2,,KZ
LAK,Lao Kip,2,,LA
LBP,Lebanese Pound,2,,LB
LKR,Sri Lanka Rupee,2,,LK
LRD,Liberian Dollar,2,,LR
LSL,Loti,2,,LS
LYD,Libyan Dinar,3,,LY
MAD,Moroccan Dirham,2,,MA
MDL,Moldovan Leu,2,,MD
MGA,Malagasy Ariary,2,,MG
MKD,Denar,2,,MK
MMK,Kyat,2,,MM
MNT,Tugrik,2,,MN
MOP,Pataca,2,,MO
MRU,Ouguiya,2,,MR
MUR,Mauritius Rupee,2,,MU
MVR,Rufiyaa,2,,MV
MWK,Malawi Kwacha,2,,MW
MXN,Mexican Peso,2,,MX
MXV,Mexican Unidad,2,,MX
MYR,Malaysian Ringgit,2,,MY
MZN,Mozambique Metical,2,,MZ
NAD,Namibia Dollar,2,,NA
NGN,Naira,2,,NG
NIO,Cordoba Oro,2,,NI
NOK,Norwegian Krone,2,,NO
NPR,Nepalese Rupee,2,,NP
NZD,New Zealand Dollar,2,,NZ
OMR,Rial Omani,3,,OM
PAB,Balboa,2,,PA
PEN,Sol,2,,PE
PGK,Kina,2,,PG
PHP,Philippine Peso,2,,PH
PKR,Pakistan Rupee,2,,PK
PLN,Zloty,2,,PL
PYG,Guarani,0,,PY
QAR,Qatari Rial,2,,QA
RON,Romanian Leu,2,,RO
RSD,Serbian Dinar,2,,RS
RUB,Russian Ruble,2,,RU
RWF,Rwanda Franc,0,,RW
SAR,Saudi Riyal,2,,SA
SBD,Solomon Islands Dollar,2,,SB
SCR,Seychelles Rupee,2,,SC
SDG,Sudanese Pound,2,,SD
SEK,Swedish Krona,2,,SE
SGD,Singapore Dollar,2,,SG
SHP,Saint Helena Pound,2,,SH
SLL,Leone,2,,SL
SOS,Somali Shilling,2,,SO
SRD,Surinam Dollar,2,,SR
SSP,South Sudanese Pound,2,,SS
STN,Dobra,2,,ST
SVC,El Salvador Colon,2,,SV
SYP,Syrian Pound,2,,SY
SZL,Lilangeni,2,,SZ
THB,Baht,2,฿,TH
TJS,Somoni,2,,TJ
TMT,Turkmenistan New Manat,2,,TM
TND,Tunisian Dinar,3,,TN
TOP,Pa’anga,2,,TO
TRY,Turkish Lira,2,,TR
TTD,Trinidad and Tobago Dollar,2,,TT
TWD,New Taiwan Dollar,2,,TW
TZS,Tanzanian Shilling,2,,TZ
UAH,Hryvnia,2,,UA
UGX,Uganda Shilling,0,,UG
USD,US Dollar,2,\u{24},US
UYU,Peso Uruguayo,2,,UY
UYW,Unidad Previsional,4,,UY
UZS,Uzbekistan Sum,2,,UZ
VES,Bolívar Soberano,2,,VE
VND,Dong,0,,VN
VUV,Vatu,0,,VU
WST,Tala,2,,WS
XAF,Central African Franc,0,,CF
XCD,East Caribbean Dollar,2,,AG
XOF,West African Franc,2,,BJ
XPF,Central Pacific Franc,0,,PF
YER,Yemeni Rial,2,,YE
ZAR,Rand,2,,ZA
ZMW,Zambian Kwacha,2,,ZM
ZWL,Zimbabwe Dollar,2,,ZW
''';
