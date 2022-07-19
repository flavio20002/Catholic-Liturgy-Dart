import '../../catholic_liturgy.dart';
import '../_date_utilities.dart';

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
    LiturgyEnum.allSaints: 'All Saints',
    LiturgyEnum.annunciation: 'The Annunciation of the Lord',
    LiturgyEnum.ascensionOfTheLord: 'Ascension of the Lord',
    LiturgyEnum.baptismOfTheLord: 'Baptism of the Lord',
    LiturgyEnum.christmas: 'Christmas',
    LiturgyEnum.epiphany: 'The Epiphany of the Lord',
    LiturgyEnum.holyFamily: 'Sunday in Octave of Christmas: Holy Family',
    LiturgyEnum.immaculateConception:
        'The Immaculate Conception of the Blessed Virgin Mary',
    LiturgyEnum.immaculateHeartOfMary: 'Immaculate Heart of Mary',
    LiturgyEnum.maryHolyMotherOfGod: 'Jan. 1: Mary, Mother of God',
    LiturgyEnum.theNativityOfSaintJohnTheBaptist:
        'The Nativity of St. John the Baptist',
    LiturgyEnum.palmSunday: 'Palm Sunday',
    LiturgyEnum.pentecost: 'Pentecost Sunday',
    LiturgyEnum.sacredHeart: 'Sacred Heart Friday',
    LiturgyEnum.saintJoseph: 'St. Joseph, Spouse of the Blessed Virgin Mary',
    LiturgyEnum.saintsPeterAndPaul: 'SS. Peter and Paul, Apostles',
    LiturgyEnum.secondSundayAfterChristmas: '2nd Sunday after Christmas',
    LiturgyEnum.theAssumptionOfTheBlessedVirginMary:
        'The Assumption of the Blessed Virgin Mary',
    LiturgyEnum.theCommemorationOfAllTheFaithfulDeparted:
        'The Commemoration of All the Faithful Departed (All Souls)',
    LiturgyEnum.theDedicationOfTheLateranBasilica:
        'The Dedication of the Lateran Basilica',
    LiturgyEnum.theExaltationOfTheHolyCross: 'The Exaltation of the Holy Cross',
    LiturgyEnum.theMostHolyBodyAndBloodOfChrist:
        'Sunday after Trinity Sun: Body and Blood of Christ',
    LiturgyEnum.theMostHolyTrinity: 'Sunday after Pentecost: Holy Trinity',
    LiturgyEnum.thePresentationOfTheLord: 'The Presentation of the Lord',
    LiturgyEnum.theTransfigurationOfTheLord: 'The Transfiguration of the Lord',
  };

  static String? liturgyDescriptions(LiturgyModel liturgyModel) {
    if (liturgyModel.category == LiturgyEnum.lent) {
      if (liturgyModel.dayOfWeek == null) {
        return '${liturgyModel.number}${_ordinal(liturgyModel.number!)} Sunday of Lent';
      } else {
        return 'Lent, Week ${liturgyModel.number}, ${DateUtilities.dayOfWeek(liturgyModel.dayOfWeek!, 'en', true)}';
      }
    } else if (liturgyModel.category == LiturgyEnum.advent) {
      if (liturgyModel.isFeast) {
        return '${liturgyModel.number}${_ordinal(liturgyModel.number!)} Sunday of Advent';
      }
    } else if (liturgyModel.category == LiturgyEnum.easter) {
      if (liturgyModel.isFeast) {
        return liturgyModel.number! >= 2
            ? '${liturgyModel.number}${_ordinal(liturgyModel.number!)} Sunday of Easter'
            : 'Easter Sunday: Resurrection of the Lord';
      }
    } else if (liturgyModel.category == LiturgyEnum.ash) {
      if (liturgyModel.dayOfWeek == 3) {
        return 'Ash Wednesday';
      } else if (liturgyModel.dayOfWeek == 4) {
        return 'Thursday after Ash Wed.';
      } else if (liturgyModel.dayOfWeek == 5) {
        return 'Friday after Ash Wed.';
      } else if (liturgyModel.dayOfWeek == 6) {
        return 'Saturday after Ash Wed.';
      }
    } else if (liturgyModel.category == LiturgyEnum.ordinaryTime) {
      if (liturgyModel.isFeast) {
        return liturgyModel.number == 34
            ? '34th Sunday in Ordinary Time: Christ the King'
            : '${liturgyModel.number}${_ordinal(liturgyModel.number!)} Sunday in Ordinary Time';
      }
    } else if (liturgyModel.category == LiturgyEnum.holyWeek) {
      if (liturgyModel.dayOfWeek == 4) {
        return 'Holy Thursday';
      } else if (liturgyModel.dayOfWeek == 5) {
        return "Good Friday of the Lord's Passion";
      } else if (liturgyModel.dayOfWeek == 6) {
        return 'Easter Vigil';
      }
    }
    return singleDays[liturgyModel.category];
  }
}
/*


Lent, Week 3, Mon
Lent, Week 3, Tues
Lent, Week 3, Wed
Lent, Week 3, Thurs
Lent, Week 3, Fri
Lent, Week 3, Sat
Lent, Week 4, Mon
Lent, Week 4, Tues
Lent, Week 4, Wed
Lent, Week 4, Thurs
Lent, Week 4, Fri
Lent, Week 4, Sat
Lent, Week 5, Mon
Lent, Week 5, Tues
Lent, Week 5, Wed
Lent, Week 5, Thurs
Lent, Week 5, Fri
Lent, Week 5, Sat
Holy Week, Mon
Holy Week, Tues
Holy Week, Wed
Easter Octave, Mon
Easter Octave, Tues
Easter Octave, Wed
Easter Octave, Thurs
Easter Octave, Fri
Easter Octave, Sat
Easter, Week 2, Mon
Easter, Week 2, Tues
Easter, Week 2, Wed
Easter, Week 2, Thurs
Easter, Week 2, Fri
Easter, Week 2, Sat
Easter, Week 3, Mon
Easter, Week 3, Tues
Easter, Week 3, Wed
Easter, Week 3, Thurs
Easter, Week 3, Fri
Easter, Week 3, Sat
Easter, Week 4, Mon
Easter, Week 4, Tues
Easter, Week 4, Wed
Easter, Week 4, Thurs
Easter, Week 4, Fri
Easter, Week 4, Sat
Easter, Week 5, Mon
Easter, Week 5, Tues
Easter, Week 5, Wed
Easter, Week 5, Thurs
Easter, Week 5, Fri
Easter, Week 5, Sat
Easter, Week 6, Mon
Easter, Week 6, Tues
Easter, Week 6, Wed
Easter, Week 6, Thurs
Easter, Week 6, Fri
Easter, Week 6, Sat
Easter, Week 7, Mon
Easter, Week 7, Tues
Easter, Week 7, Wed
Easter, Week 7, Thurs
Easter, Week 7, Fri
Easter, Week 7, Sat morn.
Ord. Time, Week 1, Mon
Ord. Time, Week 1, Tues
Ord. Time, Week 1, Wed
Ord. Time, Week 1, Thurs
Ord. Time, Week 1, Fri
Ord. Time, Week 1, Sat
Ord. Time, Week 2, Mon
Ord. Time, Week 2, Tues
Ord. Time, Week 2, Wed
Ord. Time, Week 2, Thurs
Ord. Time, Week 2, Fri
Ord. Time, Week 2, Sat
Ord. Time, Week 3, Mon
Ord. Time, Week 3, Tues
Ord. Time, Week 3, Wed
Ord. Time, Week 3, Thurs
Ord. Time, Week 3, Fri
Ord. Time, Week 3, Sat
Ord. Time, Week 4, Mon
Ord. Time, Week 4, Tues
Ord. Time, Week 4, Wed
Ord. Time, Week 4, Thurs
Ord. Time, Week 4, Fri
Ord. Time, Week 4, Sat
Ord. Time, Week 5, Mon
Ord. Time, Week 5, Tues
Ord. Time, Week 5, Wed
Ord. Time, Week 5, Thurs
Ord. Time, Week 5, Fri
Ord. Time, Week 5, Sat
Ord. Time, Week 6, Sat
Ord. Time, Week 6, Mon
Ord. Time, Week 6, Tues
Ord. Time, Week 6, Wed
Ord. Time, Week 6, Thurs
Ord. Time, Week 6, Fri
Ord. Time, Week 7, Mon
Ord. Time, Week 7, Tues
Ord. Time, Week 7, Wed
Ord. Time, Week 7, Thurs
Ord. Time, Week 7, Fri
Ord. Time, Week 7, Sat
Ord. Time, Week 8, Mon
Ord. Time, Week 8, Tues
Ord. Time, Week 8, Wed
Ord. Time, Week 8, Thurs
Ord. Time, Week 8, Fri
Ord. Time, Week 8, Sat
Ord. Time, Week 9, Mon
Ord. Time, Week 9, Tues
Ord. Time, Week 9, Wed
Ord. Time, Week 9, Thurs
Ord. Time, Week 9, Fri
Ord. Time, Week 9, Sat
Ord. Time, Week 10, Mon
Ord. Time, Week 10, Tues
Ord. Time, Week 10, Wed
Ord. Time, Week 10, Thurs
Ord. Time, Week 10, Fri
Ord. Time, Week 10, Sat
Ord. Time, Week 11, Mon
Ord. Time, Week 11, Tues
Ord. Time, Week 11, Wed
Ord. Time, Week 11, Thurs
Ord. Time, Week 11, Fri
Ord. Time, Week 11, Sat
Ord. Time, Week 12, Mon
Ord. Time, Week 12, Tues
Ord. Time, Week 12, Wed
Ord. Time, Week 12, Thurs
Ord. Time, Week 12, Fri
Ord. Time, Week 12, Sat
Ord. Time, Week 13, Mon
Ord. Time, Week 13, Tues
Ord. Time, Week 13, Wed
Ord. Time, Week 13, Thurs
Ord. Time, Week 13, Fri
Ord. Time, Week 13, Sat
Ord. Time, Week 14, Mon
Ord. Time, Week 14, Tues
Ord. Time, Week 14, Wed
Ord. Time, Week 14, Thurs
Ord. Time, Week 14, Fri
Ord. Time, Week 14, Sat
Ord. Time, Week 15, Mon
Ord. Time, Week 15, Tues
Ord. Time, Week 15, Wed
Ord. Time, Week 15, Thurs
Ord. Time, Week 15, Fri
Ord. Time, Week 15, Sat
Ord. Time, Week 16, Mon
Ord. Time, Week 16, Tues
Ord. Time, Week 16, Wed
Ord. Time, Week 16, Thurs
Ord. Time, Week 16, Fri
Ord. Time, Week 16, Sat
Ord. Time, Week 17, Mon
Ord. Time, Week 17, Tues
Ord. Time, Week 17, Wed
Ord. Time, Week 17, Thurs
Ord. Time, Week 17, Fri
Ord. Time, Week 17, Sat
Ord. Time, Week 18, Mon
Ord. Time, Week 18, Tues
Ord. Time, Week 18, Wed
Ord. Time, Week 18, Thurs
Ord. Time, Week 18, Fri
Ord. Time, Week 18, Sat
Ord. Time, Week 19, Mon
Ord. Time, Week 19, Tues
Ord. Time, Week 19, Wed
Ord. Time, Week 19, Thurs
Ord. Time, Week 19, Fri
Ord. Time, Week 19, Sat
Ord. Time, Week 20, Mon
Ord. Time, Week 20, Tues
Ord. Time, Week 20, Wed
Ord. Time, Week 20, Thurs
Ord. Time, Week 20, Fri
Ord. Time, Week 20, Sat
Ord. Time, Week 21, Mon
Ord. Time, Week 21, Tues
Ord. Time, Week 21, Wed
Ord. Time, Week 21, Thurs
Ord. Time, Week 21, Fri
Ord. Time, Week 21, Sat
Ord. Time, Week 22, Mon
Ord. Time, Week 22, Tues
Ord. Time, Week 22, Wed
Ord. Time, Week 22, Thurs
Ord. Time, Week 22, Fri
Ord. Time, Week 22, Sat
Ord. Time, Week 23, Mon
Ord. Time, Week 23, Tues
Ord. Time, Week 23, Wed
Ord. Time, Week 23, Thurs
Ord. Time, Week 23, Fri
Ord. Time, Week 23, Sat
Ord. Time, Week 24, Mon
Ord. Time, Week 24, Tues
Ord. Time, Week 24, Wed
Ord. Time, Week 24, Thurs
Ord. Time, Week 24, Fri
Ord. Time, Week 24, Sat
Ord. Time, Week 25, Mon
Ord. Time, Week 25, Tues
Ord. Time, Week 25, Wed
Ord. Time, Week 25, Thurs
Ord. Time, Week 25, Fri
Ord. Time, Week 25, Sat
Ord. Time, Week 26, Mon
Ord. Time, Week 26, Tues
Ord. Time, Week 26, Wed
Ord. Time, Week 26, Thurs
Ord. Time, Week 26, Fri
Ord. Time, Week 26, Sat
Ord. Time, Week 27, Mon
Ord. Time, Week 27, Tues
Ord. Time, Week 27, Wed
Ord. Time, Week 27, Thurs
Ord. Time, Week 27, Fri
Ord. Time, Week 27, Sat
Ord. Time, Week 28, Mon
Ord. Time, Week 28, Tues
Ord. Time, Week 28, Wed
Ord. Time, Week 28, Thurs
Ord. Time, Week 28, Fri
Ord. Time, Week 28, Sat
Ord. Time, Week 29, Mon
Ord. Time, Week 29, Tues
Ord. Time, Week 29, Wed
Ord. Time, Week 29, Thurs
Ord. Time, Week 29, Fri
Ord. Time, Week 29, Sat
Ord. Time, Week 30, Mon
Ord. Time, Week 30, Tues
Ord. Time, Week 30, Wed
Ord. Time, Week 30, Thurs
Ord. Time, Week 30, Fri
Ord. Time, Week 30, Sat
Ord. Time, Week 31, Mon
Ord. Time, Week 31, Tues
Ord. Time, Week 31, Wed
Ord. Time, Week 31, Thurs
Ord. Time, Week 31, Fri
Ord. Time, Week 31, Sat
Ord. Time, Week 32, Mon
Ord. Time, Week 32, Tues
Ord. Time, Week 32, Wed
Ord. Time, Week 32, Thurs
Ord. Time, Week 32, Fri
Ord. Time, Week 32, Sat
Ord. Time, Week 33, Mon
Ord. Time, Week 33, Tues
Ord. Time, Week 33, Wed
Ord. Time, Week 33, Thurs
Ord. Time, Week 33, Fri
Ord. Time, Week 33, Sat
Ord. Time, Week 34, Mon
Ord. Time, Week 34, Tues
Ord. Time, Week 34, Wed
Ord. Time, Week 34, Thurs
Ord. Time, Week 34, Fri
Ord. Time, Week 34, Sat
Advent, Week 1, Mon
Advent, Week 1, Tues
Advent, Week 1, Wed
Advent, Week 1, Thurs
Advent, Week 1, Fri
Advent, Week 1, Sat
Advent, Week 2, Mon
Advent, Week 2, Tues
Advent, Week 2, Wed
Advent, Week 2, Thurs
Advent, Week 2, Fri
Advent, Week 2, Sat
Advent, Week 3, Mon
Advent, Week 3, Tues
Advent, Week 3, Wed
Advent, Week 3, Thurs
Advent, Week 3, Fri
Advent, Dec. 17
Advent, Dec. 18
Advent, Dec. 19
Advent, Dec. 20
Advent, Dec. 21
Advent, Dec. 22
Advent, Dec. 23
Advent, Dec. 24
5th Day in Xmas Octave, Dec. 29
6th Day in Xmas Octave, Dec. 30
7th Day in Xmas Octave, Dec. 31
Jan. 2
Jan. 3
Jan. 4
Jan. 5
Jan. 6 (if Epiphany is Jan. 7 or 8)
Jan. 7 (if Epiphany is Jan. 8)
Mon after Epiphany, or Jan. 7
Tues after Epiphany, or Jan. 8
Wed after Epiphany, or Jan. 9
Thurs after Epiphany, or Jan. 10
Fri after Epiphany, or Jan. 11
Sat after Epiphany, or Jan. 12
St. Stephen, the first martyr
St. John, Apostle and evangelist
The Holy Innocents, martyrs
The Visitation of the Blessed Virgin Mary
The Nativity of the Blessed Virgin Mary
Our Lady of Guadalupe
The Conversion of St. Paul, Apostle
The Chair of St. Peter, Apostle
St. Mark, evangelist
Sts. Philip and James, Apostles
St. Matthias, Apostle
St. Thomas, Apostle
St. Mary Magdalene
St. James, Apostle
St. Bartholomew, Apostle
St. Matthew, Apostle and evangelist
St. Luke, evangelist
Sts. Simon and Jude, Apostles
St. Andrew, Apostle
St. Lawrence, deacon and martyr
Sts. Michael, Gabriel, and Raphael, archangels
Sts. Timothy and Titus, bishops
St. Barnabas, Apostle
Sts. Joachim and Anne, parents of BVM
St. Martha
The Martyrdom of St. John the Baptist
Our Lady of Sorrows
The Holy Guardian Angels
St. Ignatius of Antioch, bishop and martyr
St. Benedict, abbot
St. Bridget of Sweden, religious
St. Teresa Benedicta of the Cross, virgin and martyr
St. Francis of Assisi, religious
The Presentation of the Blessed Virgin Mary
Sts. Cyril, monk, and Methodius, bishop
St. Catherine of Siena
St. Anthony of Padua
 */
