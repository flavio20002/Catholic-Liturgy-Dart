import 'package:intl/intl.dart';

import 'data.dart';
import 'model.dart';

extension MyDateCompare on DateTime {
  bool isSameDate(DateTime? otherDate) =>
      otherDate != null ? isAtSameMomentAs(otherDate) : false;
}

class LecturesUtilities {
  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  static DateTime cleanDate(DateTime date) =>
      DateTime.utc(date.year, date.month, date.day);

  static DateTime currentDate() => cleanDate(DateTime.now());

  static String formatDate(DateTime date, String locale) =>
      capitalize(DateFormat('EEEE, d MMMM yyyy', locale).format(date));

  static String formatCurrentDate(String locale) =>
      formatDate(currentDate(), locale);

  static bool isSunday(DateTime date) => date.weekday == DateTime.sunday;

  static DateTime previousSunday(DateTime date) =>
      isSunday(date) ? date : date.add(Duration(days: -date.weekday));

  static DateTime nextSunday(DateTime date) => date.weekday == DateTime.sunday
      ? date.add(const Duration(days: 7))
      : date.add(Duration(days: 7 - date.weekday));

  static bool isMonday(DateTime date) => date.weekday == DateTime.monday;

  static DateTime addWeeksToDate(DateTime date, int weeks) =>
      date.add(Duration(days: 7 * weeks));

  static DateTime addDaysToDate(DateTime date, int days) =>
      date.add(Duration(days: days));

  static int daysBetweenDates(DateTime date1, DateTime date2) =>
      date2.difference(date1).inDays;

  static int daysBetweenCurrentDate(DateTime date) =>
      daysBetweenDates(currentDate(), date);

  static int weeksBetweenDates(DateTime date1, DateTime date2) =>
      (date2.difference(date1).inDays / 7).truncate();

  static DateTime christmas(int year) =>
      DateTime.utc(year, DateTime.december, 25);

  static DateTime adventStart(int year) {
    DateTime christmasDate = christmas(year);
    return addWeeksToDate(
        previousSunday(christmasDate), isSunday(christmasDate) ? -4 : -3);
  }

  static int liturgyYear(DateTime date) =>
      (date.compareTo(adventStart(date.year)) >= 0) ? date.year + 1 : date.year;

  static String feastLecturesCycle(DateTime date) {
    switch ((liturgyYear(date) - 2014) % 3) {
      case 0:
        return "A";
      case 1:
        return "B";
      default:
        return "C";
    }
  }

  static String ferialLectureCycle(DateTime date) {
    switch ((liturgyYear(date) - 2015) % 2) {
      case 0:
        return "1";
      default:
        return "2";
    }
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

  static DateTime _maryHolyMotherOfGod(int year) =>
      DateTime.utc(year, DateTime.january, 01);

  static DateTime sixJanuary(int year) =>
      DateTime.utc(year, DateTime.january, 6);

  static DateTime sevenJanuary(int year) =>
      DateTime.utc(year, DateTime.january, 7);

  static DateTime eightJanuary(int year) =>
      DateTime.utc(year, DateTime.january, 8);

  static DateTime epiphany(int year, bool isFeast) =>
      isFeast ? sixJanuary(year) : nextSunday(_maryHolyMotherOfGod(year));

  static DateTime _baptismOfTheLord(int year, bool isEpiphanyFeast) {
    DateTime epiphanyDate = epiphany(year, isEpiphanyFeast);
    if (epiphanyDate.isSameDate(sevenJanuary(year)) ||
        epiphanyDate.isSameDate(eightJanuary(year))) {
      return (addDaysToDate(epiphanyDate, 1));
    } else {
      return nextSunday(epiphanyDate);
    }
  }

  static DateTime _palmSunday(int year) {
    return addWeeksToDate(easter(year), -1);
  }

  static DateTime secondSundayOfEaster(int year) {
    return addWeeksToDate(easter(year), 1);
  }

  static DateTime firstSundayLent(int year) {
    return addWeeksToDate(easter(year), -6);
  }

  static DateTime annunciation(int year) {
    DateTime annunciationDate = DateTime.utc(year, DateTime.march, 25);
    DateTime secondSundayOfEasterDate = secondSundayOfEaster(year);
    DateTime palmSundayDate = _palmSunday(year);
    if (annunciationDate.isBefore(palmSundayDate) &&
        isSunday(annunciationDate)) {
      return DateTime.utc(year, DateTime.march, 26);
    } else if (annunciationDate.compareTo(palmSundayDate) >= 0) {
      return addDaysToDate(secondSundayOfEasterDate, 1);
    } else {
      return annunciationDate;
    }
  }

  static DateTime saintJoseph(int year) {
    DateTime saintJosephDate = DateTime.utc(year, DateTime.march, 19);
    DateTime palmSundayDate = _palmSunday(year);
    if (saintJosephDate.isBefore(palmSundayDate) && isSunday(saintJosephDate)) {
      return DateTime.utc(year, DateTime.march, 20);
    } else if (saintJosephDate.compareTo(palmSundayDate) >= 0) {
      return addDaysToDate(palmSundayDate, -1);
    } else {
      return saintJosephDate;
    }
  }

  static DateTime _sacredHeart(int year) {
    return addDaysToDate(easter(year), 68);
  }

  static DateTime _immaculateHeartOfMary(int year) {
    return addDaysToDate(easter(year), 69);
  }

  static DateTime _immaculateConception(int year) =>
      DateTime.utc(year, DateTime.december, 08);

  static DateTime _holyFamily(int year) => isSunday(christmas(year))
      ? DateTime.utc(year, DateTime.december, 30)
      : nextSunday(christmas(year));

  static DateTime? _secondSundayAfterChristmas(int year, bool isEpiphanyFeast) {
    DateTime sundayAfterMaryHolyMotherOfGod =
        nextSunday(_maryHolyMotherOfGod(year));
    return isEpiphanyFeast &&
            sundayAfterMaryHolyMotherOfGod
                .isBefore(epiphany(year, isEpiphanyFeast))
        ? sundayAfterMaryHolyMotherOfGod
        : null;
  }

  static DateTime _pentecost(int year) => addWeeksToDate(easter(year), 7);

  static int? _sundayOrdinaryTime(DateTime date) {
    int year = date.year;
    if (!isSunday(date)) {
      return null;
    } else {
      DateTime secondSundayOrdinaryTime =
          addWeeksToDate(nextSunday(sixJanuary(year)), 1);
      int weeksOrdinaryTime = weeksBetweenDates(secondSundayOrdinaryTime, date);
      int weeksAdvent = weeksBetweenDates(adventStart(year), date);
      if (weeksOrdinaryTime >= 0 && date.isBefore(firstSundayLent(year))) {
        return weeksOrdinaryTime + 2;
      } else if (date.isAfter(_pentecost(year)) && weeksAdvent < 0) {
        return 35 + weeksAdvent;
      } else {
        return null;
      }
    }
  }

  static int? _sundayAdvent(DateTime date) {
    DateTime adventStartDate = adventStart(date.year);
    if (!isSunday(date) ||
        date.isBefore(adventStartDate) ||
        date.isAfter(addWeeksToDate(adventStartDate, 3))) {
      return null;
    } else {
      return weeksBetweenDates(adventStartDate, date) + 1;
    }
  }

  static int? _lentWeek(DateTime date) {
    DateTime previousSundayDate = previousSunday(date);
    DateTime firstSundayLentDate = firstSundayLent(date.year);
    if (previousSundayDate.isBefore(firstSundayLentDate) ||
        previousSundayDate.isAfter(addWeeksToDate(firstSundayLentDate, 4))) {
      return null;
    } else {
      return weeksBetweenDates(firstSundayLentDate, previousSundayDate) + 1;
    }
  }

  static int? _easterWeek(DateTime date) {
    DateTime previousSundayDate = previousSunday(date);
    DateTime easterDate = easter(date.year);
    if (previousSundayDate.isBefore(easterDate) ||
        previousSundayDate.isAfter(addWeeksToDate(easterDate, 5))) {
      return null;
    } else {
      return weeksBetweenDates(easterDate, previousSundayDate) + 1;
    }
  }

  static LiturgyEnum? _solemnityAfterEaster(DateTime date) {
    if (!isSunday(date)) {
      return null;
    } else {
      switch (weeksBetweenDates(easter(date.year), date) + 1) {
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

  static int? _holyWeek(DateTime date) {
    DateTime dateCleaned = cleanDate(date);
    if (isSunday(dateCleaned) ||
        !nextSunday(dateCleaned).isSameDate(easter(dateCleaned.year))) {
      return null;
    } else {
      return dateCleaned.weekday;
    }
  }

  static LiturgyEnum? _solemnityCalculated(
      DateTime date, bool isEpiphanyFeast) {
    int year = date.year;
    if (date.isSameDate(_sacredHeart(year))) {
      return LiturgyEnum.sacredHeart;
    } else if (date.isSameDate(epiphany(year, isEpiphanyFeast))) {
      return LiturgyEnum.epiphany;
    } else if (date.isSameDate(saintJoseph(year))) {
      return LiturgyEnum.saintJoseph;
    } else if (date.isSameDate(annunciation(year))) {
      return LiturgyEnum.annunciation;
    } else if (date.isSameDate(_immaculateHeartOfMary(year))) {
      return LiturgyEnum.immaculateHeartOfMary;
    } else if (date.isSameDate(_holyFamily(year))) {
      return LiturgyEnum.holyFamily;
    } else if (date
        .isSameDate(_secondSundayAfterChristmas(year, isEpiphanyFeast))) {
      return LiturgyEnum.secondSundayAfterChristmas;
    } else if (date.isSameDate(_immaculateConception(year))) {
      return LiturgyEnum.immaculateConception;
    } else if (date.isSameDate(_baptismOfTheLord(year, isEpiphanyFeast))) {
      return LiturgyEnum.baptismOfTheLord;
    } else if (date.isSameDate(_palmSunday(year))) {
      return LiturgyEnum.palmSunday;
    } else {
      return null;
    }
  }

  static int? _ash(DateTime date) {
    DateTime dateCleaned = cleanDate(date);
    return (dateCleaned.weekday < DateTime.wednesday ||
            dateCleaned.weekday > DateTime.saturday ||
            !nextSunday(dateCleaned)
                .isSameDate(firstSundayLent(dateCleaned.year)))
        ? null
        : dateCleaned.weekday;
  }

  static LiturgyModel? _ferialFixed(DateTime date) {
    String dateFormatted = DateFormat('dd/MM').format(date);
    return ferialFixedLiturgy.containsKey(dateFormatted)
        ? LiturgyModel(
            category: ferialFixedLiturgy[dateFormatted], isFeast: false)
        : null;
  }

  static LiturgyModel? _feastFixed(DateTime date) {
    String dateFormatted = DateFormat('dd/MM').format(date);
    return feastFixedLiturgy.containsKey(dateFormatted)
        ? LiturgyModel(
            category: feastFixedLiturgy[dateFormatted], isFeast: true)
        : null;
  }

  static int? _christmasWeekDay(DateTime date, bool isEpiphanyFeast) {
    if (!isSunday(date)) {
      DateTime epiphanyDate = epiphany(date.year, isEpiphanyFeast);
      DateTime maryHolyMotherOfGodDate = _maryHolyMotherOfGod(date.year);
      if (date.isAfter(maryHolyMotherOfGodDate) &&
          date.isBefore(epiphanyDate)) {
        return date.day;
      }
    }
    return null;
  }

  static int? _ordinaryWeekDay(DateTime date, bool isEpiphanyFeast) {
    if (!isSunday(date)) {
      DateTime previousSundayDate = previousSunday(date);
      int? week = _sundayOrdinaryTime(previousSundayDate);

      DateTime epiphanyDate = epiphany(date.year, isEpiphanyFeast);
      if (epiphanyDate.isSameDate(previousSundayDate) &&
          (epiphanyDate.isSameDate(sevenJanuary(date.year)) ||
              epiphanyDate.isSameDate(eightJanuary(date.year)))) {
        week = 1;
      }
      if (week != null && week > 0) {
        return week;
      }
    }
    return null;
  }

  static int? _weekdayAfterEpiphany(DateTime date, bool isEpiphanyFeast) {
    if (isSunday(date)) {
      return null;
    } else {
      int days = daysBetweenDates(epiphany(date.year, isEpiphanyFeast), date);
      return days > 0 && days <= 6 ? days : null;
    }
  }

  static LiturgyModel? _ferial(DateTime date, bool isEpiphanyFeast) {
    int? number;
    LiturgyModel? ferialFixed = _ferialFixed(date);
    if (ferialFixed != null) {
      return ferialFixed;
    } else if ((number = _lentWeek(date)) != null) {
      return LiturgyModel(
          category: LiturgyEnum.lent,
          number: number,
          dayOfWeek: date.weekday,
          isFeast: false);
    } else if ((number = _easterWeek(date)) != null) {
      return LiturgyModel(
          category: LiturgyEnum.easter,
          number: number,
          dayOfWeek: date.weekday,
          isFeast: false);
    } else if ((number = _christmasWeekDay(date, isEpiphanyFeast)) != null) {
      return LiturgyModel(
          category: LiturgyEnum.christmasWeekDay,
          number: number,
          dayOfWeek: null,
          isFeast: false);
    } else if ((number = _weekdayAfterEpiphany(date, isEpiphanyFeast)) !=
        null) {
      return LiturgyModel(
          category: LiturgyEnum.weekdayAfterEpiphany,
          number: number,
          dayOfWeek: null,
          isFeast: false);
    } else if ((number = _ordinaryWeekDay(date, isEpiphanyFeast)) != null) {
      return LiturgyModel(
          category: LiturgyEnum.ordinaryTime,
          number: number,
          dayOfWeek: date.weekday,
          isFeast: false);
    } else {
      return null;
    }
  }

  static LiturgyModel? _feast(DateTime date) {
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

  static LiturgyModel? liturgy(DateTime date, bool isEpiphanyFeast) {
    DateTime dateCleaned = cleanDate(date);
    int? lentWeekNumber = _lentWeek(dateCleaned);
    if (lentWeekNumber != null && isSunday(dateCleaned)) {
      return LiturgyModel(
          category: LiturgyEnum.lent, number: lentWeekNumber, isFeast: true);
    }
    int? ashNumber = _ash(dateCleaned);
    if (ashNumber != null && ashNumber == DateTime.wednesday) {
      return LiturgyModel(
          category: LiturgyEnum.ash, dayOfWeek: ashNumber, isFeast: true);
    }
    int? holyWeekNumber = _holyWeek(dateCleaned);
    if (holyWeekNumber != null) {
      return LiturgyModel(
          category: LiturgyEnum.holyWeek,
          dayOfWeek: holyWeekNumber,
          isFeast: holyWeekNumber >= DateTime.thursday &&
              holyWeekNumber <= DateTime.saturday);
    }
    int? sundayEasterNumber = _easterWeek(dateCleaned);
    if (sundayEasterNumber != null && isSunday(dateCleaned)) {
      return LiturgyModel(
          category: LiturgyEnum.easter,
          number: sundayEasterNumber,
          isFeast: true);
    }
    int? sundayAdventNumber = _sundayAdvent(dateCleaned);
    if (sundayAdventNumber != null) {
      return LiturgyModel(
          category: LiturgyEnum.advent,
          number: sundayAdventNumber,
          isFeast: true);
    }
    LiturgyEnum? solemnityCalculatedCategory =
        _solemnityCalculated(dateCleaned, isEpiphanyFeast);
    if (solemnityCalculatedCategory != null) {
      return LiturgyModel(category: solemnityCalculatedCategory, isFeast: true);
    }
    LiturgyEnum? solemnityAfterEasterCategory =
        _solemnityAfterEaster(dateCleaned);
    if (solemnityAfterEasterCategory != null) {
      return LiturgyModel(
          category: solemnityAfterEasterCategory, isFeast: true);
    }
    LiturgyModel? feastLiturgy = _feast(dateCleaned);
    if (feastLiturgy != null) {
      return feastLiturgy;
    }
    LiturgyModel? ferialLiturgy = _ferial(dateCleaned, isEpiphanyFeast);
    if (ferialLiturgy != null) {
      return ferialLiturgy;
    }
    return null;
  }
}
