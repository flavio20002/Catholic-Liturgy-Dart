import '../../catholic_liturgy.dart';

class LiturgyDescriptionsIT {
  static Map<LiturgyEnum, String> singleDays = {
    LiturgyEnum.palmSunday: 'Domenica delle Palme',
    LiturgyEnum.ascensionOfTheLord: 'Ascensione del Signore',
  };

  static String? liturgyDescriptions(LiturgyModel liturgyModel) {
    if (liturgyModel.category == LiturgyEnum.lent) {
      if (liturgyModel.isFeast) {
        return '${liturgyModel.number}° Domenica di Quaresima';
      }
    } else if (liturgyModel.category == LiturgyEnum.easter) {
      if (liturgyModel.isFeast) {
        return liturgyModel.number! >= 2
            ? '${liturgyModel.number}° Domenica di Pasqua'
            : 'Domenica di Pasqua: Risurrezione del Signore';
      }
    }
    return singleDays[liturgyModel.category];
  }
}
/*

Giovedì santo: Messa del Crisma
Venerdì Santo: Passione del Signore
Veglia Pasquale
Pentecoste: Messa della Vigilia
Pentecoste
Santissima Trinità
Santissimo Corpo e Sangue di Cristo
Sacro Cuore di Gesù
2° Domenica del Tempo ordinario
3° Domenica del Tempo ordinario
4° Domenica del Tempo ordinario
5° Domenica del Tempo ordinario
6° Domenica del Tempo ordinario
7° Domenica del Tempo ordinario
8° Domenica del Tempo ordinario
9° Domenica del Tempo ordinario
10° Domenica del Tempo ordinario
11° Domenica del Tempo ordinario
12° Domenica del Tempo ordinario
13° Domenica del Tempo ordinario
14° Domenica del Tempo ordinario
15° Domenica del Tempo ordinario
16° Domenica del Tempo ordinario
17° Domenica del Tempo ordinario
18° Domenica del Tempo ordinario
19° Domenica del Tempo ordinario
20° Domenica del Tempo ordinario
21° Domenica del Tempo ordinario
22° Domenica del Tempo ordinario
23° Domenica del Tempo ordinario
24° Domenica del Tempo ordinario
25° Domenica del Tempo ordinario
26° Domenica del Tempo ordinario
27° Domenica del Tempo ordinario
28° Domenica del Tempo ordinario
29° Domenica del Tempo ordinario
30° Domenica del Tempo ordinario
31° Domenica del Tempo ordinario
32° Domenica del Tempo ordinario
33° Domenica del Tempo ordinario
34° Domenica del Tempo ordinario: Cristo Re
1° Domenica di Avvento
2° Domenica di Avvento
3° Domenica di Avvento
4° Domenica di Avvento
Natale del Signore: Messa Vespertina nella Vigilia
Natale del Signore: Messa della notte
Natale del Signore: Messa dell'aurora
Natale del Signore: Messa del Giorno
Domenica fra l'ottava di Natale: Santa Famiglia
Maria Ss. Madre di Dio
2° Domenica dopo Natale
Epifania del Signore
Battesimo del Signore
Presentazione del Signore
San Giuseppe
Annunciazione del Signore
Natività di San Giovanni Battista: Messa Vespertina nella Vigilia
Natività di San Giovanni Battista: Messa del Giorno
Santi Pietro e Paolo, Apostoli: Messa Vespertina nella Vigilia
Santi Pietro e Paolo, Apostoli: Messa del Giorno
Trasfigurazione del Signore
Assunzione della Beata Vergine Maria: Messa Vespertina nella Vigilia
Assunzione della Beata Vergine Maria: Messa del Giorno
Esaltazione della Santa Croce
Tutti i Santi
Commemorazione di tutti i fedeli defunti
Dedicazione della  Basilica Lateranense
Immacolata Concezione della Beata Vergine Maria
Cuore Immacolato della Beata Vergine Maria
Giovedì Santo: Cena del Signore
Mercoledì delle ceneri*/
