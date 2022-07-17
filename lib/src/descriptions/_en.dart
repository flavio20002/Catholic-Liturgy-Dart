import '../../catholic_liturgy.dart';

class LiturgyDescriptionsEN {
  static String _ordinal(int number) {
    if (!(number >= 1)) {
      throw Exception('Invalid number');
    }

    if (number >= 11 && number <= 13) {
      return 'th';
    }

    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static Map<LiturgyEnum, String> singleDays = {
    LiturgyEnum.palmSunday: 'Palm Sunday',
    LiturgyEnum.ascensionOfTheLord: 'Ascension of the Lord',
  };

  static String? liturgyDescriptions(LiturgyModel liturgyModel) {
    if (liturgyModel.category == LiturgyEnum.lent) {
      if (liturgyModel.isFeast) {
        return '${liturgyModel.number}${_ordinal(liturgyModel.number!)} Sunday of Lent';
      }
    } else if (liturgyModel.category == LiturgyEnum.easter) {
      if (liturgyModel.isFeast) {
        return liturgyModel.number! >= 2
            ? '${liturgyModel.number}${_ordinal(liturgyModel.number!)} Sunday of Easter'
            : 'Easter Sunday: Resurrection of the Lord';
      }
    }
    return singleDays[liturgyModel.category];
  }
}
/*



Holy Week, Chrism Mass
Good Friday of the Lord's Passion
Easter Vigil







Pentecost Sunday: Vigil Mass
Pentecost Sunday
Sunday after Pentecost: Holy Trinity
Sunday after Trinity Sun: Body and Blood of Christ
Sacred Heart Friday
2nd Sunday in Ordinary Time
3rd Sunday in Ordinary Time
4th Sunday in Ordinary Time
5th Sunday in Ordinary Time
6th Sunday in Ordinary Time
7th Sunday in Ordinary Time
8th Sunday in Ordinary Time
9th Sunday in Ordinary Time
10th Sunday in Ordinary Time
11th Sunday in Ordinary Time
12th Sunday in Ordinary Time
13th Sunday in Ordinary Time
14th Sunday in Ordinary Time
15th Sunday in Ordinary Time
16th Sunday in Ordinary Time
17th Sunday in Ordinary Time
18th Sunday in Ordinary Time
19th Sunday in Ordinary Time
20th Sunday in Ordinary Time
21st Sunday in Ordinary Time
22nd Sunday in Ordinary Time
23rd Sunday in Ordinary Time
24th Sunday in Ordinary Time
25th Sunday in Ordinary Time
26th Sunday in Ordinary Time
27th Sunday in Ordinary Time
28th Sunday in Ordinary Time
29th Sunday in Ordinary Time
30th Sunday in Ordinary Time
31st Sunday in Ordinary Time
32nd Sunday in Ordinary Time
33rd Sunday in Ordinary Time
34th Sunday in Ordinary Time: Christ the King
1st Sunday of Advent
2nd Sunday of Advent
3rd Sunday of Advent
4th Sunday of Advent
Christmas: Vigil Mass
Christmas: Mass at Midnight
Christmas: Mass at Dawn
Christmas: Mass during the Day
Sunday in Octave of Christmas: Holy Family
Jan. 1: Mary, Mother of God
2nd Sunday after Christmas
The Epiphany of the Lord
Baptism of the Lord
The Presentation of the Lord
St. Joseph, Spouse of the Blessed Virgin Mary
The Annunciation of the Lord
The Nativity of St. John the Baptist: Vigil
The Nativity of St. John the Baptist: Mass during the Day
SS. Peter and Paul, Apostles: Vigil
SS. Peter and Paul, Apostles: Mass during the Day
The Transfiguration of the Lord
The Assumption of the Blessed Virgin Mary: Vigil
The Assumption of the Blessed Virgin Mary: Mass during the Day
The Exaltation of the Cross
All Saints
The Commemoration of All the Faithful Departed (All Souls)
The Dedication of the Lateran Basilica
The Immaculate Conception of the Blessed Virgin Mary
Immaculate Heart of Mary
Holy Thursday: Mass of the Lord's Supper
Ash Wednesday*/
