// Copyright 2021,2022 djarjo@djarjo.com
// Please see the LICENSE file for details.

///
/// List of all countries including attributes and translations.
///
/// The text is just a csv file with a header row and each country on one line.
/// To add a translation add a column with language code in the header row.
/// The new language will be used automatically.
///
String csvListOfCountries = '''
alpha-2,alpha-3,num-3,name,currency,language,predial,timezone
AD,AND,20,Andorra,EUR,en,376,1
AE,ARE,784,United Arab Emirates,AED,ar,971,4
AF,AFG,4,Afghanistan,AFN,fa,93,4.5
AG,ATG,28,Antigua & Barbuda,XCD,en,1268,-4
AI,AIA,660,Anguilla,XCD,en,1264,-4
AL,ALB,8,Albania,ALL,en,355,1
AM,ARM,51,Armenia,AMD,hy,374,4
AO,AGO,24,Angola,AOA,pt,244,1
AQ,ATA,10,Antarctica,,,,,
AR,ARG,32,Argentina,ARS,es,54,-3
AS,ASM,16,American Samoa,USD,en,1684,-11
AT,AUT,40,Austria,EUR,de,43,1
AU,AUS,36,Australia,AUD,en,61,9
AW,ABW,533,Aruba,AWG,es,297,-4
AX,ALA,248,Åland Islands,EUR,sv,35818,2
AZ,AZE,31,Azerbaijan,AZN,az,994,4
BA,BIH,70,Bosnia & Herzegovina,MA,hr,387,1
BB,BRB,52,Barbados,BBD,en,1246,-4
BD,BGD,50,Bangladesh,BDT,en,880,6
BE,BEL,56,Belgium,EUR,nl,32,1
BF,BFA,854,Burkina Faso,XOF,fr,226,0
BG,BGR,100,Bulgaria,BGN,bg,359,2
BH,BHR,48,Bahrain,BHD,ar,973,3
BI,BDI,108,Burundi,BIF,fr,257,2
BJ,BEN,204,Benin,XOF,fr,229,1
BL,BLM,652,Saint Barthélemy,EUR,fr,590,-4
BM,BMU,60,Bermuda,BMD,en,1441,-4
BN,BRN,96,Brunei Darussalam,BND,ms,673,8
BO,BOL,68,Bolivia,BOB,es,591,-4
BQ,BES,535,Bonaire,USD,,5997,-4
BR,BRA,76,Brazil,BRL,pt,55,-4
BS,BHS,44,Bahamas,BSD,es,1242,-5
BT,BTN,64,Bhutan,BTN,dz,975,6
BV,BVT,74,Bouvet Island,NOP,,,
BW,BWA,72,Botswana,BWP,en,267,2
BY,BLR,112,Belarus,BYN,ru,375,3
BZ,BLZ,84,Belize,BZD,en,501,-6
CA,CAN,124,Canada,CAD,en,1,-5
CC,CCK,166,Cocos Islands,AUD,en,6189162,6.5
CD,COD,180,Congo Democratic Republic,CDF,fr,243,1
CF,CAF,140,Central African Republic,XAF,fr,236,1
CG,COG,178,Congo,XAF,fr,242,1
CH,CHE,756,Switzerland,CHF,de,41,1
CI,CIV,384,Côte d'Ivoire,XOF,fr,225,0
CK,COK,184,Cook Islands,NZD,en,682,-10
CL,CHL,152,Chile,CLP,es,56,-5
CM,CMR,120,Cameroon,XAF,en,237,1
CN,CHN,156,China,CNY,zh,86,8
CO,COL,170,Colombia,COP,es,57,-5
CR,CRI,188,Costa Rica,CRC,es,506,-6
CU,CUB,192,Cuba,CUP,es,53,-5
CV,CPV,132,Cabo Verde,CVE,,238,-1
CW,CUW,531,Curaçao,ANG,nl,5999,-4
CX,CXR,162,Christmas Island,AUD,en,6189164,7
CY,CYP,196,Cyprus,EUR,en,357,2
CZ,CZE,203,Czechia,CZK,cs,420,1
DE,DEU,276,Germany,EUR,de,49,1
DJ,DJI,262,Djibouti,DJF,fr,253,2
DK,DNK,208,Denmark,DKK,da,45,1
DM,DMA,212,Dominica,XCD,es,1767,-4
DO,DOM,214,Dominican Republic,DOP,es,1809,-4
DZ,DZA,12,Algeria,DZD,fr,213,1
EC,ECU,218,Ecuador,USD,es,593,-6
EE,EST,233,Estonia,EUR,en,372,2
EG,EGY,818,Egypt,EGP,ar,20,2
EH,ESH,732,Western Sahara,MAD,ar,,
ER,ERI,232,Eritrea,ERN,en,291,3
ES,ESP,724,Spain,EUR,es,34,1
ET,ETH,231,Ethiopia,ETB,so,251,3
FI,FIN,246,Finland,EUR,en,358,2
FJ,FJI,242,Fiji,FJD,en,679,12
FK,FLK,238,Falkland Islands,FKP,en,500,-3
FM,FSM,583,Micronesia,USD,en,691,10
FO,FRO,234,Faroe Islands,DKK,fo,298,1
FR,FRA,250,France,EUR,fr,33,1
GA,GAB,266,Gabon,XAF,fr,241,1
GB,GBR,826,United Kingdom,GBP,en,44,0
GD,GRD,308,Grenada,XCD,en,1473,-4
GE,GEO,268,Georgia,GEL,ka,995,4
GF,GUF,254,French Guiana,EUR,fr,594,-3
GG,GGY,831,Guernsey,GBP,en,44,1
GH,GHA,288,Ghana,GHS,en,233,0
GI,GIB,292,Gibraltar,GIP,en,350,1
GL,GRL,304,Greenland,DKK,da,299,-2
GM,GMB,270,Gambia,GMD,en,220,0
GN,GIN,324,Guinea,GNF,pt,224,0
GP,GLP,312,Guadeloupe,EUR,es,590,-4
GQ,GNQ,226,Equatorial Guinea,XAF,fr,240,1
GR,GRC,300,Greece,EUR,gr,30,2
GS,SGS,239,South Georgia Islands,,,500,-2
GT,GTM,320,Guatemala,GTQ,es,502,-6
GU,GUM,316,Guam,USD,en,1671,10
GW,GNB,624,Guinea-Bissau,XOF,pt,245,0
GY,GUY,328,Guyana,GYD,en,592,-4
HK,HKG,344,Hong Kong,HKD,zh,852,8
HM,HMD,334,Heard McDonald Islands,AUD,,,
HN,HND,340,Honduras,HNL,es,504,-6
HR,HRV,191,Croatia,HRK,hr,385,1
HT,HTI,332,Haiti,HTG,es,509,-5
HU,HUN,348,Hungary,HUF,en,36,1
ID,IDN,360,Indonesia,IDR,en,62,8
IE,IRL,372,Ireland,EUR,en,353,0
IL,ISR,376,Israel,ILS,en,972,2
IM,IMN,833,Isle of Man,GBP,en,44,0
IN,IND,356,India,INR,en,91,5.5
IO,IOT,86,Indian Ocean Territory,USD,en,246,6
IQ,IRQ,368,Iraq,IQD,ar,964,3
IR,IRN,364,Iran,IRR,ar,98,3.5
IS,ISL,352,Iceland,ISK,en,354,0
IT,ITA,380,Italy,EUR,it,39,1
JE,JEY,832,Jersey,GBP,en,441534,0
JM,JAM,388,Jamaica,JMD,en,1876,-5
JO,JOR,400,Jordan,JOD,ar,962,2
JP,JPN,392,Japan,JPY,ja,81,9
KE,KEN,404,Kenya,KES,en,254,3
KG,KGZ,417,Kyrgyzstan,KGS,ru,996,5
KH,KHM,116,Cambodia,KHR,km,855,7
KI,KIR,296,Kiribati,AUD,en,686,13
KM,COM,174,Comoros,KMF,fr,269,3
KN,KNA,659,Saint Kitts & Nevis,XCD,ees,1869,-4
KP,PRK,408,North Korea,KPW,,850,8.5
KR,KOR,410,South Korea,KRW,,82,9
KW,KWT,414,Kuwait,KWD,ar,965,3
KY,CYM,136,Cayman Islands,KYD,en,1345,-5
KZ,KAZ,398,Kazakhstan,KZT,ru,76,5
LA,LAO,418,Laos,LAK,lo,856,7
LB,LBN,422,Lebanon,LBP,ar,961,2
LC,LCA,662,Saint Lucia,XCD,es,1758,-4
LI,LIE,438,Liechtenstein,CHF,de,423,1
LK,LKA,144,Sri Lanka,LKR,ta,94,5.5
LR,LBR,430,Liberia,LRD,en,231,0
LS,LSO,426,Lesotho,LSL,en,266,2
LT,LTU,440,Lithuania,EUR,en,370,2
LU,LUX,442,Luxembourg,EUR,de,352,1
LV,LVA,428,Latvia,EUR,lv,371,2
LY,LBY,434,Libya,LYD,ar,218,1
MA,MAR,504,Morocco,MAD,fr,212,0
MC,MCO,492,Monaco,EUR,fr,377,1
MD,MDA,498,Moldova,MDL,ru,373,2
ME,MNE,499,Montenegro,EUR,en,382,1
MF,MAF,663,Saint Martin,EUR,fr,590,-4
MG,MDG,450,Madagascar,MGA,en,261,3
MH,MHL,584,Marshall Islands,USD,en,692,12
MK,MKD,807,North Macedonia,MKD,sq,,
ML,MLI,466,Mali,XOF,fr,223,0
MM,MMR,104,Myanmar,MMK,en,95,6.5
MN,MNG,496,Mongolia,MNT,mn,976,7
MO,MAC,446,Macao,MOP,zh,853,8
MP,MNP,580,Northern Mariana Islands,NOK,en,1670,10
MQ,MTQ,474,Martinique,EUR,fr,596,-4
MR,MRT,478,Mauritania,MRU,fr,222,0
MS,MSR,500,Montserrat,XCD,en,1664,-4
MT,MLT,470,Malta,EUR,en,356,1
MU,MUS,480,Mauritius,MUR,en,230,4
MV,MDV,462,Maldives,MVR,en,960,5
MW,MWI,454,Malawi,MWK,en,265,2
MX,MEX,484,Mexico,MXN,es,52,-7
MY,MYS,458,Malaysia,MYR,en,60,8
MZ,MOZ,508,Mozambique,MZN,pt,258,2
NA,NAM,516,Namibia,NAD,en,264,1
NC,NCL,540,New Caledonia,XPF,fr,687,11
NE,NER,562,Niger,XOF,fr,227,1
NF,NFK,574,Norfolk Island,AUD,en,6723,11
NG,NGA,566,Nigeria,NGN,en,234,1
NI,NIC,558,Nicaragua,NIO,es,505,-6
NL,NLD,528,Netherlands,EUR,nl,31,1
NO,NOR,578,Norway,OMR,se,47,2
NP,NPL,524,Nepal,NPR,ne,977,5.75
NR,NRU,520,Nauru,AUD,en,674,12
NU,NIU,570,Niue,NZD,en,683,-11
NZ,NZL,554,New Zealand,NZD,en,64,12
OM,OMN,512,Oman,PKR,ar,968,4
PA,PAN,591,Panama,USD,es,507,-5
PE,PER,604,Peru,PEN,es,51,-5
PF,PYF,258,French Polynesia,XPF,fr,689,-10
PG,PNG,598,Papua New Guinea,PGK,en,675,10
PH,PHL,608,Philippines,PHP,es,63,8
PK,PAK,586,Pakistan,USD,en,92,5
PL,POL,616,Poland,PLN,pl,48,1
PM,SPM,666,St. Pierre & Miquelon,EUR,fr,508,-3
PN,PCN,612,Pitcairn,NZD,en,64,-8
PR,PRI,630,Puerto Rico,USD,es,1787,-4
PS,PSE,275,Palestine,PAB,ar,970,2
PT,PRT,620,Portugal,EUR,pt,351,0
PW,PLW,585,Palau,,en,680,9
PY,PRY,600,Paraguay,PYG,es,595,-4
QA,QAT,634,Qatar,QAR,ar,974,3
RE,REU,638,Réunion,EUR,fr,262,4
RO,ROU,642,Romania,RON,en,40,2
RS,SRB,688,Serbia,RSD,sr,381,1
RU,RUS,643,Russian Federation,RUB,ru,7,7
RW,RWA,646,Rwanda,RWF,en,250,2
SA,SAU,682,Saudi Arabia,SAR,ar,966,3
SB,SLB,90,Solomon Islands,SBD,en,677,11
SC,SYC,690,Seychelles,SCR,fr,248,4
SD,SDN,729,Sudan,SDG,ar,249,3
SE,SWE,752,Sweden,SEK,sv,46,1
SG,SGP,702,Singapore,SGD,zh,65,8
SH,SHN,654,Saint Helena,SHP,en,290,0
SI,SVN,705,Slovenia,EUR,sl,386,1
SJ,SJM,744,Svalbard & Jan Mayen,NOK,nb,4779,1
SK,SVK,703,Slovakia,EUR,sk,421,1
SL,SLE,694,Sierra Leone,SLL,en,232,0
SM,SMR,674,San Marino,EUR,it,378,1
SN,SEN,686,Senegal,XOF,fr,221,0
SO,SOM,706,Somalia,SOS,ar,252,3
SR,SUR,740,Suriname,SRD,nl,597,-3
SS,SSD,728,South Sudan,SSP,ar,211,3
ST,STP,678,Sao Tome & Principe,STN,pt,239,0
SV,SLV,222,El Salvador,SVC,es,503,-6
SX,SXM,534,Sint Maarten,ANG,nl,1721,-4
SY,SYR,760,Syrian,SYP,ar,963,2
SZ,SWZ,748,Eswatini,SZL,en,,
TC,TCA,796,Turks and Caicos Islands,USD,es,1649,-5
TD,TCD,148,Chad,XAF,fr,235,1
TF,ATF,260,French Southern Territories,EUR,fr,,
TG,TGO,768,Togo,XOF,fr,228,0
TH,THA,764,Thailand,THB,th,66,7
TJ,TJK,762,Tajikistan,TJS,tg,992,5
TK,TKL,772,Tokelau,NZD,en,690,13
TL,TLS,626,Timor-Leste,USD,pt,,
TM,TKM,795,Turkmenistan,TMT,tk,993,5
TN,TUN,788,Tunisia,TND,fr,216,1
TO,TON,776,Tonga,TOP,en,676,13
TR,TUR,792,Turkey,TRY,tr,90,3
TT,TTO,780,Trinidad & Tobago,TTD,es,1868,-4
TV,TUV,798,Tuvalu,AUD,en,688,12
TW,TWN,158,Taiwan,TWD,zh,886,8
TZ,TZA,834,Tanzania,TZS,sw,255,3
UA,UKR,804,Ukraine,UAH,ru,380,2
UG,UGA,800,Uganda,UGX,sw,256,3
US,USA,840,United States of America,USD,en,1,-7
UY,URY,858,Uruguay,UYU,es,598,-3
UZ,UZB,860,Uzbekistan,UZS,uz,998,5
VA,VAT,336,Holy See,EUR,,,
VC,VCT,670,Saint Vincent & Grenadines,XCD,es,1784,-4
VE,VEN,862,Venezuela,VES,es,58,-4
VG,VGB,92,Virgin Islands (GB),USD,en,,
VI,VIR,850,Virgin Islands (US),USD,en,1340,-4
VN,VNM,704,Vietnam,VND,vi,84,7
VU,VUT,548,Vanuatu,VUV,fr,678,11
WF,WLF,876,Wallis and Futuna,XPF,fr,681,12
WS,WSM,882,Samoa,WST,en,685,13
YE,YEM,887,Yemen,YER,ar,967,3
YT,MYT,175,Mayotte,EUR,fr,262269,3
ZA,ZAF,710,South Africa,ZAR,af,27,2
ZM,ZMB,894,Zambia,ZMW,en,260,2
ZW,ZWE,716,Zimbabwe,ZWL,sn,263,2
''';
