import '../../catholic_liturgy.dart';
import '../_date_utilities.dart';

class LiturgyDescriptionsIT {
  static Map<LiturgyEnum, String> singleDays = {
    LiturgyEnum.allSaints: 'Tutti i Santi',
    LiturgyEnum.annunciation: 'Annunciazione del Signore',
    LiturgyEnum.ascensionOfTheLord: 'Ascensione del Signore',
    LiturgyEnum.baptismOfTheLord: 'Battesimo del Signore',
    LiturgyEnum.christmas: 'Natale del Signore',
    LiturgyEnum.epiphany: 'Epifania del Signore',
    LiturgyEnum.holyFamily: "Domenica fra l'ottava di Natale: Santa Famiglia",
    LiturgyEnum.immaculateConception:
        'Immacolata Concezione della Beata Vergine Maria',
    LiturgyEnum.immaculateHeartOfMary:
        'Cuore Immacolato della Beata Vergine Maria',
    LiturgyEnum.maryHolyMotherOfGod: 'Maria Ss. Madre di Dio',
    LiturgyEnum.theNativityOfSaintJohnTheBaptist:
        'Natività di San Giovanni Battista',
    LiturgyEnum.palmSunday: 'Domenica delle Palme',
    LiturgyEnum.pentecost: 'Pentecoste',
    LiturgyEnum.sacredHeart: 'Sacro Cuore di Gesù',
    LiturgyEnum.saintJoseph: 'San Giuseppe',
    LiturgyEnum.saintsPeterAndPaul: 'Santi Pietro e Paolo, Apostoli',
    LiturgyEnum.secondSundayAfterChristmas: '2° Domenica dopo Natale',
    LiturgyEnum.theAssumptionOfTheBlessedVirginMary:
        'Assunzione della Beata Vergine Maria',
    LiturgyEnum.theCommemorationOfAllTheFaithfulDeparted:
        'Commemorazione di tutti i fedeli defunti',
    LiturgyEnum.theDedicationOfTheLateranBasilica:
        'Dedicazione della  Basilica Lateranense',
    LiturgyEnum.theExaltationOfTheHolyCross: 'Esaltazione della Santa Croce',
    LiturgyEnum.theMostHolyBodyAndBloodOfChrist:
        'Santissimo Corpo e Sangue di Cristo',
    LiturgyEnum.theMostHolyTrinity: 'Santissima Trinità',
    LiturgyEnum.thePresentationOfTheLord: 'Presentazione del Signore',
    LiturgyEnum.theTransfigurationOfTheLord: 'Trasfigurazione del Signore',
  };

  static String? liturgyDescriptions(LiturgyModel liturgyModel) {
    if (liturgyModel.category == LiturgyEnum.lent) {
      if (liturgyModel.dayOfWeek == null) {
        return '${liturgyModel.number}° Domenica di Quaresima';
      } else {
        return '${liturgyModel.number}° settimana di quaresima, ${DateUtilities.dayOfWeek(liturgyModel.dayOfWeek!, 'it', false)}';
      }
    } else if (liturgyModel.category == LiturgyEnum.advent) {
      if (liturgyModel.isFeast) {
        return '${liturgyModel.number}° Domenica di Avvento';
      }
    } else if (liturgyModel.category == LiturgyEnum.easter) {
      if (liturgyModel.isFeast) {
        return liturgyModel.number! >= 2
            ? '${liturgyModel.number}° Domenica di Pasqua'
            : 'Domenica di Pasqua: Risurrezione del Signore';
      }
    } else if (liturgyModel.category == LiturgyEnum.ash) {
      if (liturgyModel.dayOfWeek == 3) {
        return 'Mercoledì delle ceneri';
      } else if (liturgyModel.dayOfWeek == 4) {
        return 'Giovedì dopo le Ceneri';
      } else if (liturgyModel.dayOfWeek == 5) {
        return 'Venerdì dopo le Ceneri';
      } else if (liturgyModel.dayOfWeek == 6) {
        return 'Sabato dopo le Ceneri';
      }
    } else if (liturgyModel.category == LiturgyEnum.ordinaryTime) {
      if (liturgyModel.isFeast) {
        return liturgyModel.number == 34
            ? '34° Domenica del Tempo ordinario: Cristo Re'
            : '${liturgyModel.number}° Domenica del Tempo ordinario';
      }
    } else if (liturgyModel.category == LiturgyEnum.holyWeek) {
      if (liturgyModel.dayOfWeek == 4) {
        return 'Giovedì santo';
      } else if (liturgyModel.dayOfWeek == 5) {
        return 'Venerdì Santo: Passione del Signore';
      } else if (liturgyModel.dayOfWeek == 6) {
        return 'Veglia Pasquale';
      }
    }
    return singleDays[liturgyModel.category];
  }
}

/*


3° settimana di quaresima, lunedì
3° settimana di quaresima, martedì
3° settimana di quaresima, mercoledì
3° settimana di quaresima, giovedì
3° settimana di quaresima, venerdì
3° settimana di quaresima, sabato
4° settimana di quaresima, lunedì
4° settimana di quaresima, martedì
4° settimana di quaresima, mercoledì
4° settimana di quaresima, giovedì
4° settimana di quaresima, venerdì
4° settimana di quaresima, sabato
5° settimana di quaresima, lunedì
5° settimana di quaresima, martedì
5° settimana di quaresima, mercoledì
5° settimana di quaresima, giovedì
5° settimana di quaresima, venerdì
5° settimana di quaresima, sabato
Lunedì santo
Martedì santo
Mercoledì santo
Ottava di Pasqua, lunedì
Ottava di Pasqua, martedì
Ottava di Pasqua, mercoledì
Ottava di Pasqua, giovedì
Ottava di Pasqua, venerdì
Ottava di Pasqua, sabato
2° settimana di Pasqua, lunedì
2° settimana di Pasqua, martedì
2° settimana di Pasqua, mercoledì
2° settimana di Pasqua, giovedì
2° settimana di Pasqua, venerdì
2° settimana di Pasqua, sabato
3° settimana di Pasqua, lunedì
3° settimana di Pasqua, martedì
3° settimana di Pasqua, mercoledì
3° settimana di Pasqua, giovedì
3° settimana di Pasqua, venerdì
3° settimana di Pasqua, sabato
4° settimana di Pasqua, lunedì
4° settimana di Pasqua, martedì
4° settimana di Pasqua, mercoledì
4° settimana di Pasqua, giovedì
4° settimana di Pasqua, venerdì
4° settimana di Pasqua, sabato
5° settimana di Pasqua, lunedì
5° settimana di Pasqua, martedì
5° settimana di Pasqua, mercoledì
5° settimana di Pasqua, giovedì
5° settimana di Pasqua, venerdì
5° settimana di Pasqua, sabato
6° settimana di Pasqua, lunedì
6° settimana di Pasqua, martedì
6° settimana di Pasqua, mercoledì
6° settimana di Pasqua, giovedì
6° settimana di Pasqua, venerdì
6° settimana di Pasqua, sabato
7° settimana di Pasqua, lunedì
7° settimana di Pasqua, martedì
7° settimana di Pasqua, mercoledì
7° settimana di Pasqua, giovedì
7° settimana di Pasqua, venerdì
7° settimana di Pasqua, sabato
1° settimana del Tempo ordinario, lunedì
1° settimana del Tempo ordinario, martedì
1° settimana del Tempo ordinario, mercoledì
1° settimana del Tempo ordinario, giovedì
1° settimana del Tempo ordinario, venerdì
1° settimana del Tempo ordinario, sabato
2° settimana del Tempo ordinario, lunedì
2° settimana del Tempo ordinario, martedì
2° settimana del Tempo ordinario, mercoledì
2° settimana del Tempo ordinario, giovedì
2° settimana del Tempo ordinario, venerdì
2° settimana del Tempo ordinario, sabato
3° settimana del Tempo ordinario, lunedì
3° settimana del Tempo ordinario, martedì
3° settimana del Tempo ordinario, mercoledì
3° settimana del Tempo ordinario, giovedì
3° settimana del Tempo ordinario, venerdì
3° settimana del Tempo ordinario, sabato
4° settimana del Tempo ordinario, lunedì
4° settimana del Tempo ordinario, martedì
4° settimana del Tempo ordinario, mercoledì
4° settimana del Tempo ordinario, giovedì
4° settimana del Tempo ordinario, venerdì
4° settimana del Tempo ordinario, sabato
5° settimana del Tempo ordinario, lunedì
5° settimana del Tempo ordinario, martedì
5° settimana del Tempo ordinario, mercoledì
5° settimana del Tempo ordinario, giovedì
5° settimana del Tempo ordinario, venerdì
5° settimana del Tempo ordinario, sabato
6° settimana del Tempo ordinario, sabato
6° settimana del Tempo ordinario, lunedì
6° settimana del Tempo ordinario, martedì
6° settimana del Tempo ordinario, mercoledì
6° settimana del Tempo ordinario, giovedì
6° settimana del Tempo ordinario, venerdì
7° settimana del Tempo ordinario, lunedì
7° settimana del Tempo ordinario, martedì
7° settimana del Tempo ordinario, mercoledì
7° settimana del Tempo ordinario, giovedì
7° settimana del Tempo ordinario, venerdì
7° settimana del Tempo ordinario, sabato
8° settimana del Tempo ordinario, lunedì
8° settimana del Tempo ordinario, martedì
8° settimana del Tempo ordinario, mercoledì
8° settimana del Tempo ordinario, giovedì
8° settimana del Tempo ordinario, venerdì
8° settimana del Tempo ordinario, sabato
9° settimana del Tempo ordinario, lunedì
9° settimana del Tempo ordinario, martedì
9° settimana del Tempo ordinario, mercoledì
9° settimana del Tempo ordinario, giovedì
9° settimana del Tempo ordinario, venerdì
9° settimana del Tempo ordinario, sabato
10° settimana del Tempo ordinario, lunedì
10° settimana del Tempo ordinario, martedì
10° settimana del Tempo ordinario, mercoledì
10° settimana del Tempo ordinario, giovedì
10° settimana del Tempo ordinario, venerdì
10° settimana del Tempo ordinario, sabato
11° settimana del Tempo ordinario, lunedì
11° settimana del Tempo ordinario, martedì
11° settimana del Tempo ordinario, mercoledì
11° settimana del Tempo ordinario, giovedì
11° settimana del Tempo ordinario, venerdì
11° settimana del Tempo ordinario, sabato
12° settimana del Tempo ordinario, lunedì
12° settimana del Tempo ordinario, martedì
12° settimana del Tempo ordinario, mercoledì
12° settimana del Tempo ordinario, giovedì
12° settimana del Tempo ordinario, venerdì
12° settimana del Tempo ordinario, sabato
13° settimana del Tempo ordinario, lunedì
13° settimana del Tempo ordinario, martedì
13° settimana del Tempo ordinario, mercoledì
13° settimana del Tempo ordinario, giovedì
13° settimana del Tempo ordinario, venerdì
13° settimana del Tempo ordinario, sabato
14° settimana del Tempo ordinario, lunedì
14° settimana del Tempo ordinario, martedì
14° settimana del Tempo ordinario, mercoledì
14° settimana del Tempo ordinario, giovedì
14° settimana del Tempo ordinario, venerdì
14° settimana del Tempo ordinario, sabato
15° settimana del Tempo ordinario, lunedì
15° settimana del Tempo ordinario, martedì
15° settimana del Tempo ordinario, mercoledì
15° settimana del Tempo ordinario, giovedì
15° settimana del Tempo ordinario, venerdì
15° settimana del Tempo ordinario, sabato
16° settimana del Tempo ordinario, lunedì
16° settimana del Tempo ordinario, martedì
16° settimana del Tempo ordinario, mercoledì
16° settimana del Tempo ordinario, giovedì
16° settimana del Tempo ordinario, venerdì
16° settimana del Tempo ordinario, sabato
17° settimana del Tempo ordinario, lunedì
17° settimana del Tempo ordinario, martedì
17° settimana del Tempo ordinario, mercoledì
17° settimana del Tempo ordinario, giovedì
17° settimana del Tempo ordinario, venerdì
17° settimana del Tempo ordinario, sabato
18° settimana del Tempo ordinario, lunedì
18° settimana del Tempo ordinario, martedì
18° settimana del Tempo ordinario, mercoledì
18° settimana del Tempo ordinario, giovedì
18° settimana del Tempo ordinario, venerdì
18° settimana del Tempo ordinario, sabato
19° settimana del Tempo ordinario, lunedì
19° settimana del Tempo ordinario, martedì
19° settimana del Tempo ordinario, mercoledì
19° settimana del Tempo ordinario, giovedì
19° settimana del Tempo ordinario, venerdì
19° settimana del Tempo ordinario, sabato
20° settimana del Tempo ordinario, lunedì
20° settimana del Tempo ordinario, martedì
20° settimana del Tempo ordinario, mercoledì
20° settimana del Tempo ordinario, giovedì
20° settimana del Tempo ordinario, venerdì
20° settimana del Tempo ordinario, sabato
21° settimana del Tempo ordinario, lunedì
21° settimana del Tempo ordinario, martedì
21° settimana del Tempo ordinario, mercoledì
21° settimana del Tempo ordinario, giovedì
21° settimana del Tempo ordinario, venerdì
21° settimana del Tempo ordinario, sabato
22° settimana del Tempo ordinario, lunedì
22° settimana del Tempo ordinario, martedì
22° settimana del Tempo ordinario, mercoledì
22° settimana del Tempo ordinario, giovedì
22° settimana del Tempo ordinario, venerdì
22° settimana del Tempo ordinario, sabato
23° settimana del Tempo ordinario, lunedì
23° settimana del Tempo ordinario, martedì
23° settimana del Tempo ordinario, mercoledì
23° settimana del Tempo ordinario, giovedì
23° settimana del Tempo ordinario, venerdì
23° settimana del Tempo ordinario, sabato
24° settimana del Tempo ordinario, lunedì
24° settimana del Tempo ordinario, martedì
24° settimana del Tempo ordinario, mercoledì
24° settimana del Tempo ordinario, giovedì
24° settimana del Tempo ordinario, venerdì
24° settimana del Tempo ordinario, sabato
25° settimana del Tempo ordinario, lunedì
25° settimana del Tempo ordinario, martedì
25° settimana del Tempo ordinario, mercoledì
25° settimana del Tempo ordinario, giovedì
25° settimana del Tempo ordinario, venerdì
25° settimana del Tempo ordinario, sabato
26° settimana del Tempo ordinario, lunedì
26° settimana del Tempo ordinario, martedì
26° settimana del Tempo ordinario, mercoledì
26° settimana del Tempo ordinario, giovedì
26° settimana del Tempo ordinario, venerdì
26° settimana del Tempo ordinario, sabato
27° settimana del Tempo ordinario, lunedì
27° settimana del Tempo ordinario, martedì
27° settimana del Tempo ordinario, mercoledì
27° settimana del Tempo ordinario, giovedì
27° settimana del Tempo ordinario, venerdì
27° settimana del Tempo ordinario, sabato
28° settimana del Tempo ordinario, lunedì
28° settimana del Tempo ordinario, martedì
28° settimana del Tempo ordinario, mercoledì
28° settimana del Tempo ordinario, giovedì
28° settimana del Tempo ordinario, venerdì
28° settimana del Tempo ordinario, sabato
29° settimana del Tempo ordinario, lunedì
29° settimana del Tempo ordinario, martedì
29° settimana del Tempo ordinario, mercoledì
29° settimana del Tempo ordinario, giovedì
29° settimana del Tempo ordinario, venerdì
29° settimana del Tempo ordinario, sabato
30° settimana del Tempo ordinario, lunedì
30° settimana del Tempo ordinario, martedì
30° settimana del Tempo ordinario, mercoledì
30° settimana del Tempo ordinario, giovedì
30° settimana del Tempo ordinario, venerdì
30° settimana del Tempo ordinario, sabato
31° settimana del Tempo ordinario, lunedì
31° settimana del Tempo ordinario, martedì
31° settimana del Tempo ordinario, mercoledì
31° settimana del Tempo ordinario, giovedì
31° settimana del Tempo ordinario, venerdì
31° settimana del Tempo ordinario, sabato
32° settimana del Tempo ordinario, lunedì
32° settimana del Tempo ordinario, martedì
32° settimana del Tempo ordinario, mercoledì
32° settimana del Tempo ordinario, giovedì
32° settimana del Tempo ordinario, venerdì
32° settimana del Tempo ordinario, sabato
33° settimana del Tempo ordinario, lunedì
33° settimana del Tempo ordinario, martedì
33° settimana del Tempo ordinario, mercoledì
33° settimana del Tempo ordinario, giovedì
33° settimana del Tempo ordinario, venerdì
33° settimana del Tempo ordinario, sabato
34° settimana del Tempo ordinario, lunedì
34° settimana del Tempo ordinario, martedì
34° settimana del Tempo ordinario, mercoledì
34° settimana del Tempo ordinario, giovedì
34° settimana del Tempo ordinario, venerdì
34° settimana del Tempo ordinario, sabato
1° settimana di avvento, lunedì
1° settimana di avvento, martedì
1° settimana di avvento, mercoledì
1° settimana di avvento, giovedì
1° settimana di avvento, venerdì
1° settimana di avvento, sabato
2° settimana di avvento, lunedì
2° settimana di avvento, martedì
2° settimana di avvento, mercoledì
2° settimana di avvento, giovedì
2° settimana di avvento, venerdì
2° settimana di avvento, sabato
3° settimana di avvento, lunedì
3° settimana di avvento, martedì
3° settimana di avvento, mercoledì
3° settimana di avvento, giovedì
3° settimana di avvento, venerdì
Avvento, 17 dicembre
Avvento, 18 dicembre
Avvento, 19 dicembre
Avvento, 20 dicembre
Avvento, 21 dicembre
Avvento, 22 dicembre
Avvento, 23 dicembre
Avvento, 24 dicembre
Ottava di Natale, 5° giorno
Ottava di Natale, 6° giorno
Ottava di Natale, 7° giorno
Tempo di Natale, 2 gennaio
Tempo di Natale, 3 gennaio
Tempo di Natale, 4 gennaio
Tempo di Natale, 5 gennaio
Tempo di Natale, 6 gennaio
Tempo di Natale, 7 gennaio
Tempo di Natale dopo l'Epifania, 1° giorno
Tempo di Natale dopo l'Epifania, 2° giorno
Tempo di Natale dopo l'Epifania, 3° giorno
Tempo di Natale dopo l'Epifania, 4° giorno
Tempo di Natale dopo l'Epifania, 5° giorno
Tempo di Natale dopo l'Epifania, 6° giorno
Santo Stefano, primo martire
San Giovanni, Apostolo ed evangelista
Santi Innocenti, martiri
Visitazione della Beata Vergine Maria
Natività della Beata Vergine Maria
Nostra Signora di Guadalupe
Conversione di San Paolo, Apostolo
Cattedra di San Pietro, Apostolo
San Marco, evangelista
Santi Filippo e Giacomo, Apostoli
San Mattia, Apostolo
San Tommaso, Apostolo
Santa Maria Maddalena
San Giacomo, Apostolo
San Bartolomeo, Apostolo
San Matteo, Apostolo ed evengelista
San Luca, evangelista
Santi Simone e Giuda, Apostoli
Sant'Andrea, Apostolo
San Lorenzo, diacono e martire
Santi Michele, Gabriele e Raffaele, arcangeli
Santi Timoteo e Tito, vescovi
San Barnaba, Apostolo
Santi Gioacchino ed Anna, genitori della Beata Vergine Maria
Santa Marta
Martirio di San Giovanni Battista
Beata Vergine Maria Addolorata
Santi Angeli Custodi
Sant'Ignazio di Antiochia, vescovo e martire
San Benedetto
Santa Brigida di Svezia
Santa Teresa Benedetta della Croce, vergine e martire
San Francesco d'Assisi, patrono d'Italia
Presentazione della Beata Vergine Maria
Santi Cirillo e Metodio
Santa Caterina da Siena
Sant'Antonio di Padova
 */
