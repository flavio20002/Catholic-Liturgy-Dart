import 'package:intl/intl.dart';

import '../catholic_liturgy.dart';
import '_date_utilities.dart';
import '_fixed_days.dart';

extension MyDateCompare on DateTime {
  bool isSameDate(DateTime? otherDate) =>
      otherDate != null ? isAtSameMomentAs(otherDate) : false;
}

class LiturgyFunctions {
  static DateTime christmas(int year) =>
      DateTime.utc(year, DateTime.december, 25);

  static DateTime adventStart(int year) {
    DateTime christmasDate = christmas(year);
    return DateUtilities.addWeeksToDate(
        DateUtilities.previousSunday(christmasDate),
        DateUtilities.isSunday(christmasDate) ? -4 : -3);
  }

  static DateTime easter(int year) {
    if (year < 1583) {
      throw ArgumentError.value(
          year, 'year', 'Year cannot be earlier than 1583.');
    }
    if (year > 4099) {
      throw ArgumentError.value(
          year, 'year', 'Year cannot be later than 4099.');
    }

    final g = year % 19;
    final c = year ~/ 100;
    final h = (c - (c ~/ 4) - ((8 * c + 13) ~/ 25) + 19 * g + 15) % 30;
    final i =
        h - (h ~/ 28) * (1 - (h ~/ 28) * (29 ~/ (h + 1)) * ((21 - g) ~/ 11));

    var day = i - ((year + (year ~/ 4) + i + 2 - c + (c ~/ 4)) % 7) + 28;
    var month = 3;

    if (day > 31) {
      month++;
      day -= 31;
    }

    var easter = DateTime.utc(year, month, day);
    return easter;
  }

  static DateTime maryHolyMotherOfGod(int year) =>
      DateTime.utc(year, DateTime.january, 01);

  static DateTime sixJanuary(int year) =>
      DateTime.utc(year, DateTime.january, 6);

  static DateTime sevenJanuary(int year) =>
      DateTime.utc(year, DateTime.january, 7);

  static DateTime eightJanuary(int year) =>
      DateTime.utc(year, DateTime.january, 8);

  static DateTime epiphany(int year, bool isFeast) => isFeast
      ? sixJanuary(year)
      : DateUtilities.nextSunday(maryHolyMotherOfGod(year));

  static DateTime baptismOfTheLord(int year, bool isEpiphanyOn6thJan) {
    DateTime epiphanyDate = epiphany(year, isEpiphanyOn6thJan);
    if (epiphanyDate.isSameDate(sevenJanuary(year)) ||
        epiphanyDate.isSameDate(eightJanuary(year))) {
      return (DateUtilities.addDaysToDate(epiphanyDate, 1));
    } else {
      return DateUtilities.nextSunday(epiphanyDate);
    }
  }

  static DateTime _palmSunday(int year) {
    return DateUtilities.addWeeksToDate(LiturgyFunctions.easter(year), -1);
  }

  static DateTime _secondSundayOfEaster(int year) {
    return DateUtilities.addWeeksToDate(LiturgyFunctions.easter(year), 1);
  }

  static DateTime _firstSundayLent(int year) {
    return DateUtilities.addWeeksToDate(LiturgyFunctions.easter(year), -6);
  }

  static DateTime _annunciation(int year) {
    DateTime annunciationDate = DateTime.utc(year, DateTime.march, 25);
    DateTime secondSundayOfEasterDate = _secondSundayOfEaster(year);
    DateTime palmSundayDate = _palmSunday(year);
    if (annunciationDate.isBefore(palmSundayDate) &&
        DateUtilities.isSunday(annunciationDate)) {
      return DateTime.utc(year, DateTime.march, 26);
    } else if (annunciationDate.compareTo(palmSundayDate) >= 0) {
      return DateUtilities.addDaysToDate(secondSundayOfEasterDate, 1);
    } else {
      return annunciationDate;
    }
  }

  static DateTime _saintJoseph(int year) {
    DateTime saintJosephDate = DateTime.utc(year, DateTime.march, 19);
    DateTime palmSundayDate = _palmSunday(year);
    if (saintJosephDate.isBefore(palmSundayDate) &&
        DateUtilities.isSunday(saintJosephDate)) {
      return DateTime.utc(year, DateTime.march, 20);
    } else if (saintJosephDate.compareTo(palmSundayDate) >= 0) {
      return DateUtilities.addDaysToDate(palmSundayDate, -1);
    } else {
      return saintJosephDate;
    }
  }

  static DateTime _sacredHeart(int year) {
    return DateUtilities.addDaysToDate(LiturgyFunctions.easter(year), 68);
  }

  static DateTime _immaculateHeartOfMary(int year) {
    return DateUtilities.addDaysToDate(LiturgyFunctions.easter(year), 69);
  }

  static DateTime _immaculateConception(int year) =>
      DateTime.utc(year, DateTime.december, 08);

  static DateTime _holyFamily(int year) =>
      DateUtilities.isSunday(LiturgyFunctions.christmas(year))
          ? DateTime.utc(year, DateTime.december, 30)
          : DateUtilities.nextSunday(LiturgyFunctions.christmas(year));

  static DateTime? _secondSundayAfterChristmas(
      int year, bool isEpiphanyOn6thJan) {
    DateTime sundayAfterMaryHolyMotherOfGod =
        DateUtilities.nextSunday(LiturgyFunctions.maryHolyMotherOfGod(year));
    return isEpiphanyOn6thJan &&
            sundayAfterMaryHolyMotherOfGod
                .isBefore(LiturgyFunctions.epiphany(year, isEpiphanyOn6thJan))
        ? sundayAfterMaryHolyMotherOfGod
        : null;
  }

  static DateTime _pentecost(int year) =>
      DateUtilities.addWeeksToDate(LiturgyFunctions.easter(year), 7);

  static int? _sundayOrdinaryTime(DateTime date) {
    int year = date.year;
    if (!DateUtilities.isSunday(date)) {
      return null;
    } else {
      DateTime secondSundayOrdinaryTime = DateUtilities.addWeeksToDate(
          DateUtilities.nextSunday(LiturgyFunctions.sixJanuary(year)), 1);
      int weeksOrdinaryTime =
          DateUtilities.weeksBetweenDates(secondSundayOrdinaryTime, date);
      int weeksAdvent = DateUtilities.weeksBetweenDates(
          LiturgyFunctions.adventStart(year), date);
      if (weeksOrdinaryTime >= -1 && date.isBefore(_firstSundayLent(year))) {
        return weeksOrdinaryTime + 2;
      } else if ((date.isAfter(_pentecost(year)) ||
              date.isSameDate(_pentecost(year))) &&
          weeksAdvent < 0) {
        return 35 + weeksAdvent;
      } else {
        return null;
      }
    }
  }

  static int? sundayAdvent(DateTime date) {
    DateTime adventStartDate = LiturgyFunctions.adventStart(date.year);
    if (!DateUtilities.isSunday(date) ||
        date.isBefore(adventStartDate) ||
        date.isAfter(DateUtilities.addWeeksToDate(adventStartDate, 3))) {
      return null;
    } else {
      return DateUtilities.weeksBetweenDates(adventStartDate, date) + 1;
    }
  }

  static int? lentWeek(DateTime date) {
    DateTime previousSundayDate = DateUtilities.previousSunday(date);
    DateTime firstSundayLentDate = _firstSundayLent(date.year);
    if (previousSundayDate.isBefore(firstSundayLentDate) ||
        previousSundayDate
            .isAfter(DateUtilities.addWeeksToDate(firstSundayLentDate, 4))) {
      return null;
    } else {
      return DateUtilities.weeksBetweenDates(
              firstSundayLentDate, previousSundayDate) +
          1;
    }
  }

  static int? easterWeek(DateTime date) {
    DateTime previousSundayDate = DateUtilities.previousSunday(date);
    DateTime easterDate = LiturgyFunctions.easter(date.year);
    if (previousSundayDate.isBefore(easterDate) ||
        previousSundayDate
            .isAfter(DateUtilities.addWeeksToDate(easterDate, 6))) {
      return null;
    } else {
      return DateUtilities.weeksBetweenDates(easterDate, previousSundayDate) +
          1;
    }
  }

  static int? _adventWeek(DateTime date) {
    if (!DateUtilities.isSunday(date)) {}
    DateTime previousSundayDate = DateUtilities.previousSunday(date);
    int? sundayAdventNumber = sundayAdvent(previousSundayDate);
    if (sundayAdventNumber != null &&
        sundayAdventNumber > 0 &&
        sundayAdventNumber <= 3) {
      return sundayAdventNumber;
    }
    return null;
  }

  static LiturgyEnum? solemnityAfterEaster(DateTime date) {
    if (!DateUtilities.isSunday(date)) {
      return null;
    } else {
      switch (DateUtilities.weeksBetweenDates(
              LiturgyFunctions.easter(date.year), date) +
          1) {
        case 7:
          return LiturgyEnum.ascensionOfTheLord;
        case 8:
          return LiturgyEnum.pentecost;
        case 9:
          return LiturgyEnum.theMostHolyTrinity;
        case 10:
          return LiturgyEnum.theMostHolyBodyAndBloodOfChrist;
        default:
          return null;
      }
    }
  }

  static int? holyWeek(DateTime date) {
    DateTime dateCleaned = DateUtilities.cleanDate(date);
    if (DateUtilities.isSunday(dateCleaned) ||
        !DateUtilities.nextSunday(dateCleaned)
            .isSameDate(LiturgyFunctions.easter(dateCleaned.year))) {
      return null;
    } else {
      return dateCleaned.weekday;
    }
  }

  static LiturgyEnum? solemnityCalculated(
      DateTime date, bool isEpiphanyOn6thJan) {
    int year = date.year;
    if (date.isSameDate(_sacredHeart(year))) {
      return LiturgyEnum.sacredHeart;
    } else if (date
        .isSameDate(LiturgyFunctions.epiphany(year, isEpiphanyOn6thJan))) {
      return LiturgyEnum.epiphany;
    } else if (date.isSameDate(_saintJoseph(year))) {
      return LiturgyEnum.saintJoseph;
    } else if (date.isSameDate(_annunciation(year))) {
      return LiturgyEnum.annunciation;
    } else if (date.isSameDate(_immaculateHeartOfMary(year))) {
      return LiturgyEnum.immaculateHeartOfMary;
    } else if (date.isSameDate(_holyFamily(year))) {
      return LiturgyEnum.holyFamily;
    } else if (date
        .isSameDate(_secondSundayAfterChristmas(year, isEpiphanyOn6thJan))) {
      return LiturgyEnum.secondSundayAfterChristmas;
    } else if (date.isSameDate(_immaculateConception(year))) {
      return LiturgyEnum.immaculateConception;
    } else if (date.isSameDate(
        LiturgyFunctions.baptismOfTheLord(year, isEpiphanyOn6thJan))) {
      return LiturgyEnum.baptismOfTheLord;
    } else if (date.isSameDate(_palmSunday(year))) {
      return LiturgyEnum.palmSunday;
    } else {
      return null;
    }
  }

  static bool ash(DateTime date) {
    DateTime dateCleaned = DateUtilities.cleanDate(date);
    return (dateCleaned.weekday < DateTime.wednesday ||
            dateCleaned.weekday > DateTime.saturday ||
            !DateUtilities.nextSunday(dateCleaned)
                .isSameDate(_firstSundayLent(dateCleaned.year)))
        ? false
        : true;
  }

  static LiturgyModel? _ferialFixed(DateTime date) {
    String dateFormatted = DateFormat('dd/MM').format(date);
    return ferialFixedLiturgy.containsKey(dateFormatted)
        ? LiturgyModel(
            category: ferialFixedLiturgy[dateFormatted]!, isFeast: false)
        : null;
  }

  static LiturgyModel? _feastFixed(DateTime date) {
    String dateFormatted = DateFormat('dd/MM').format(date);
    return feastFixedLiturgy.containsKey(dateFormatted)
        ? LiturgyModel(
            category: feastFixedLiturgy[dateFormatted]!, isFeast: true)
        : null;
  }

  static int? _christmasWeekDay(DateTime date, bool isEpiphanyOn6thJan) {
    if (!DateUtilities.isSunday(date)) {
      DateTime epiphanyDate =
          LiturgyFunctions.epiphany(date.year, isEpiphanyOn6thJan);
      DateTime maryHolyMotherOfGodDate =
          LiturgyFunctions.maryHolyMotherOfGod(date.year);
      if (date.isAfter(maryHolyMotherOfGodDate) &&
          date.isBefore(epiphanyDate)) {
        return date.day;
      }
    }
    return null;
  }

  static int? _ordinaryWeekDay(DateTime date, bool isEpiphanyOn6thJan) {
    if (!DateUtilities.isSunday(date)) {
      DateTime previousSundayDate = DateUtilities.previousSunday(date);
      int? week = _sundayOrdinaryTime(previousSundayDate);

      DateTime epiphanyDate =
          LiturgyFunctions.epiphany(date.year, isEpiphanyOn6thJan);
      if (epiphanyDate.isSameDate(previousSundayDate) &&
          (epiphanyDate.isSameDate(LiturgyFunctions.sevenJanuary(date.year)) ||
              epiphanyDate
                  .isSameDate(LiturgyFunctions.eightJanuary(date.year)))) {
        week = 1;
      }
      if (week != null && week > 0) {
        return week;
      }
    }
    return null;
  }

  static int? _weekdayAfterEpiphany(DateTime date, bool isEpiphanyOn6thJan) {
    if (DateUtilities.isSunday(date)) {
      return null;
    } else {
      int days = DateUtilities.daysBetweenDates(
          LiturgyFunctions.epiphany(date.year, isEpiphanyOn6thJan), date);
      return days > 0 && days <= 6 ? days : null;
    }
  }

  static LiturgyModel? ferial(DateTime date, bool isEpiphanyOn6thJan) {
    int? number;
    LiturgyModel? ferialFixed = _ferialFixed(date);
    if (ferialFixed != null) {
      return ferialFixed;
    } else if (ash(date)) {
      return LiturgyModel(
          category: LiturgyEnum.ash, dayOfWeek: date.weekday, isFeast: false);
    } else if ((number = lentWeek(date)) != null) {
      return LiturgyModel(
          category: LiturgyEnum.lent,
          number: number,
          dayOfWeek: date.weekday,
          isFeast: false);
    } else if ((number = easterWeek(date)) != null) {
      return LiturgyModel(
          category: LiturgyEnum.easter,
          number: number,
          dayOfWeek: date.weekday,
          isFeast: false);
    } else if ((number = _christmasWeekDay(date, isEpiphanyOn6thJan)) != null) {
      return LiturgyModel(
          category: LiturgyEnum.christmasWeekDay,
          number: number,
          dayOfWeek: null,
          isFeast: false);
    } else if ((number = _ordinaryWeekDay(date, isEpiphanyOn6thJan)) != null) {
      return LiturgyModel(
          category: LiturgyEnum.ordinaryTime,
          number: number,
          dayOfWeek: date.weekday,
          isFeast: false);
    } else if ((number = _weekdayAfterEpiphany(date, isEpiphanyOn6thJan)) !=
        null) {
      return LiturgyModel(
          category: LiturgyEnum.weekdayAfterEpiphany,
          number: number,
          dayOfWeek: null,
          isFeast: false);
    } else if ((number = _adventWeek(date)) != null) {
      return LiturgyModel(
          category: LiturgyEnum.advent,
          number: number,
          dayOfWeek: date.weekday,
          isFeast: false);
    } else {
      return null;
    }
  }

  static LiturgyModel? feast(DateTime date) {
    int? number;
    LiturgyModel? feastFixed = _feastFixed(date);
    if (feastFixed != null) {
      return feastFixed;
    } else if ((number = _sundayOrdinaryTime(date)) != null) {
      return LiturgyModel(
          category: LiturgyEnum.ordinaryTime, number: number, isFeast: true);
    } else {
      return null;
    }
  }

  static int liturgyYear(DateTime date) =>
      (date.compareTo(LiturgyFunctions.adventStart(date.year)) >= 0)
          ? date.year + 1
          : date.year;
}
