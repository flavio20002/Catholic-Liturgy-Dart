import 'dart:io';

import 'package:catholic_liturgy/catholic_liturgy.dart';
import 'package:csv/csv.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

main() async {
  var df = DateFormat('dd/MM/yyyy');

  parse(String dateString) => df.parseUTC(dateString);

  group('Home lectures card Test', () {
    void checkFormatDate(String date, String language, String expected) {
      test('$date in language $language should be formatted as $expected', () {
        initializeDateFormatting(language, null);
        String formattedDate =
            LecturesUtilities.formatDate(parse(date), language);
        expect(formattedDate, expected);
      });
    }

    checkFormatDate('31/05/2020', 'it', 'Domenica, 31 maggio 2020');
    checkFormatDate('31/05/2020', 'en', 'Sunday, 31 May 2020');

    void checkFormatCurrentDate(String language) {
      test('Check Format current date in language $language', () {
        initializeDateFormatting(language, null);
        String formattedDate = LecturesUtilities.formatCurrentDate(language);
        expect(
            formattedDate,
            LecturesUtilities.formatDate(
                LecturesUtilities.currentDate(), language));
      });
    }

    checkFormatCurrentDate('it');
    checkFormatCurrentDate('en');
  });

  group('Lecture utilities', () {
    test('Capitalize', () {
      expect(LecturesUtilities.capitalize('this is a test'), 'This is a test');
    });

    test('Clean Date', () {
      DateTime currentDate = DateTime.now();
      DateTime cleanDate = LecturesUtilities.cleanDate(currentDate);
      expect(cleanDate.year, currentDate.year);
      expect(cleanDate.month, currentDate.month);
      expect(cleanDate.day, currentDate.day);
      expect(cleanDate.hour, 0);
      expect(cleanDate.minute, 0);
      expect(cleanDate.second, 0);
      expect(cleanDate.microsecond, 0);
      expect(cleanDate.isUtc, true);
    });

    test('Current Date', () {
      expect(df.format(LecturesUtilities.currentDate()),
          df.format(LecturesUtilities.currentDate()));
    });

    void checkPreviousSunday(String dateString, String expected) {
      test('Previous Sunday of $dateString should be $expected', () {
        DateTime previousSunday =
            LecturesUtilities.previousSunday(parse(dateString));
        String previousSundayString = df.format(previousSunday);
        expect(previousSundayString, expected);
      });
    }

    checkPreviousSunday('01/06/2020', '31/05/2020');
    checkPreviousSunday('31/05/2020', '31/05/2020');
    checkPreviousSunday('30/05/2020', '24/05/2020');
    checkPreviousSunday('29/05/2020', '24/05/2020');
    checkPreviousSunday('28/05/2020', '24/05/2020');
    checkPreviousSunday('27/05/2020', '24/05/2020');
    checkPreviousSunday('26/05/2020', '24/05/2020');
    checkPreviousSunday('25/05/2020', '24/05/2020');
    checkPreviousSunday('24/05/2020', '24/05/2020');
    checkPreviousSunday('09/01/2020', '05/01/2020');

    void checkNextSunday(String dateString, String expected) {
      test('Next Sunday of $dateString to be $expected', () {
        DateTime previousSunday =
            LecturesUtilities.nextSunday(parse(dateString));
        String previousSundayString = df.format(previousSunday);
        expect(previousSundayString, expected);
      });
    }

    checkNextSunday('01/06/2020', '07/06/2020');
    checkNextSunday('31/05/2020', '07/06/2020');
    checkNextSunday('30/05/2020', '31/05/2020');
    checkNextSunday('29/05/2020', '31/05/2020');
    checkNextSunday('28/05/2020', '31/05/2020');
    checkNextSunday('27/05/2020', '31/05/2020');
    checkNextSunday('26/05/2020', '31/05/2020');
    checkNextSunday('25/05/2020', '31/05/2020');
    checkNextSunday('24/05/2020', '31/05/2020');
    checkNextSunday('09/01/2020', '12/01/2020');

    void checkIsSunday(String dateString, bool expected) {
      test('Check if $dateString is Sunday should be $expected', () {
        expect(LecturesUtilities.isSunday(parse(dateString)), expected);
      });
    }

    checkIsSunday('01/06/2020', false);
    checkIsSunday('31/05/2020', true);

    void checkIsMonday(String dateString, bool expected) {
      test('Check if $dateString is Monday should be $expected', () {
        expect(LecturesUtilities.isMonday(parse(dateString)), expected);
      });
    }

    checkIsMonday('01/06/2020', true);
    checkIsMonday('31/05/2020', false);

    void checkAddWeeks(String dateString, int weeks, String expected) {
      test('Adding $weeks weeks to $dateString to obtain $expected', () {
        expect(
            df.format(
                LecturesUtilities.addWeeksToDate(parse(dateString), weeks)),
            expected);
      });
    }

    checkAddWeeks('01/06/2020', 1, '08/06/2020');
    checkAddWeeks('01/06/2020', -1, '25/05/2020');
    checkAddWeeks('01/06/2020', 5, '06/07/2020');
    checkAddWeeks('01/06/2020', -5, '27/04/2020');
    checkAddWeeks('12/04/2020', -6, '01/03/2020');
    checkAddWeeks('04/04/2021', -6, '21/02/2021');

    void checkAddDays(String dateString, int days, String expected) {
      test('Adding $days days to $dateString to obtain $expected', () {
        expect(
            df.format(LecturesUtilities.addDaysToDate(parse(dateString), days)),
            expected);
      });
    }

    checkAddDays('01/06/2020', 1, '02/06/2020');
    checkAddDays('01/06/2020', -1, '31/05/2020');
    checkAddDays('01/06/2020', 5, '06/06/2020');
    checkAddDays('01/06/2020', 7, '08/06/2020');
    checkAddDays('01/06/2020', -7, '25/05/2020');
    checkAddDays('12/04/2020', -42, '01/03/2020');

    void checkDaysBetween(
        String dateString1, String dateString2, int expected) {
      test('Check days between $dateString1 and $dateString2 to be $expected',
          () {
        expect(
            LecturesUtilities.daysBetweenDates(
                parse(dateString1), parse(dateString2)),
            expected);
      });
    }

    checkDaysBetween('01/06/2020', '01/06/2020', 0);
    checkDaysBetween('01/06/2020', '02/06/2020', 1);
    checkDaysBetween('01/06/2020', '04/06/2020', 3);
    checkDaysBetween('01/06/2020', '31/05/2020', -1);
    checkDaysBetween('01/06/2020', '29/05/2020', -3);

    void checkDaysBetweenCurrentDate(String dateString, int expected) {
      test('Check days between current Date and $dateString to be $expected',
          () {
        expect(LecturesUtilities.daysBetweenCurrentDate(parse(dateString)),
            expected);
      });
    }

    checkDaysBetweenCurrentDate(df.format(LecturesUtilities.currentDate()), 0);
    checkDaysBetweenCurrentDate(
        df.format(LecturesUtilities.currentDate().add(const Duration(days: 1))),
        1);
    checkDaysBetweenCurrentDate(
        df.format(
            LecturesUtilities.currentDate().add(const Duration(days: -1))),
        -1);

    void checkWeeksBetween(
        String dateString1, String dateString2, int expected) {
      test('Check weeks between $dateString1 and $dateString2 to be $expected',
          () {
        expect(
            LecturesUtilities.weeksBetweenDates(
                parse(dateString1), parse(dateString2)),
            expected);
      });
    }

    checkWeeksBetween('01/06/2020', '01/06/2020', 0);
    checkWeeksBetween('01/06/2020', '03/06/2020', 0);
    checkWeeksBetween('01/06/2020', '08/06/2020', 1);
    checkWeeksBetween('01/06/2020', '25/05/2020', -1);

    void checkChristmas(int year, String expected) {
      test('Christmas of $year should be on $expected', () {
        expect(df.format(LecturesUtilities.christmas(year)), expected);
      });
    }

    checkChristmas(2020, '25/12/2020');
    checkChristmas(2021, '25/12/2021');

    void checkAdventStart(int year, String expected) {
      test('Advent start of $year should be on $expected', () {
        expect(df.format(LecturesUtilities.adventStart(year)), expected);
      });
    }

    checkAdventStart(2021, '28/11/2021');
    checkAdventStart(2020, '29/11/2020');
    checkAdventStart(2019, '01/12/2019');
    checkAdventStart(2018, '02/12/2018');

    void checkFeastLecturesCycle(String date, String expected) {
      test('Feast lecture cycle of $date should be $expected', () {
        expect(LecturesUtilities.feastLecturesCycle(parse(date)), expected);
      });
    }

    checkFeastLecturesCycle('01/08/2003', 'B');
    checkFeastLecturesCycle('01/05/2019', 'C');
    checkFeastLecturesCycle('01/06/2020', 'A');
    checkFeastLecturesCycle('29/11/2020', 'B');

    void checkFerialLecturesCycle(String date, String expected) {
      test('Ferial lecture cycle of $date should be $expected', () {
        expect(LecturesUtilities.ferialLectureCycle(parse(date)), expected);
      });
    }

    checkFerialLecturesCycle('01/08/2003', '1');
    checkFerialLecturesCycle('01/05/2019', '1');
    checkFerialLecturesCycle('01/06/2020', '2');
    checkFerialLecturesCycle('29/11/2020', '1');

    void checkEaster(int year, String expected) {
      test('Easter of $year should be on $expected', () {
        expect(df.format(LecturesUtilities.easter(year)), expected);
      });
    }

    checkEaster(2020, '12/04/2020');
    checkEaster(2021, '04/04/2021');
    checkEaster(2035, '25/03/2035');
    checkEaster(2038, '25/04/2038');
    checkEaster(2285, '22/03/2285');

    void checkSixJanuary(int year, String expected) {
      test('Six January of $year should be on $expected', () {
        expect(df.format(LecturesUtilities.sixJanuary(year)), expected);
      });
    }

    checkSixJanuary(2020, '06/01/2020');
    checkSixJanuary(2021, '06/01/2021');

    void checkSevenJanuary(int year, String expected) {
      test('Seven January of $year should be on $expected', () {
        expect(df.format(LecturesUtilities.sevenJanuary(year)), expected);
      });
    }

    checkSevenJanuary(2020, '07/01/2020');
    checkSevenJanuary(2021, '07/01/2021');

    void checkEightJanuary(int year, String expected) {
      test('Eight January of $year should be on $expected', () {
        expect(df.format(LecturesUtilities.eightJanuary(year)), expected);
      });
    }

    checkEightJanuary(2020, '08/01/2020');
    checkEightJanuary(2021, '08/01/2021');

    void checkEpiphany(int year, bool isFeast, String expected) {
      test('Epiphany of $year with isFeast $isFeast should be on $expected',
          () {
        expect(df.format(LecturesUtilities.epiphany(year, isFeast)), expected);
      });
    }

    checkEpiphany(2018, true, '06/01/2018');
    checkEpiphany(2018, false, '07/01/2018');
    checkEpiphany(2020, true, '06/01/2020');
    checkEpiphany(2020, false, '05/01/2020');
    checkEpiphany(2021, true, '06/01/2021');
    checkEpiphany(2021, false, '03/01/2021');

    void checkFirstSundayLent(int year, String expected) {
      test('First Sunday of Lent of $year should be on $expected', () {
        expect(df.format(LecturesUtilities.firstSundayLent(year)), expected);
      });
    }

    checkFirstSundayLent(2020, '01/03/2020');
    checkFirstSundayLent(2021, '21/02/2021');
    checkFirstSundayLent(2035, '11/02/2035');
    checkFirstSundayLent(2038, '14/03/2038');
    checkFirstSundayLent(2285, '08/02/2285');

    void checkSecondSundayOfEaster(int year, String expected) {
      test('Second Sunday of Easter of $year should be on $expected', () {
        expect(
            df.format(LecturesUtilities.secondSundayOfEaster(year)), expected);
      });
    }

    checkSecondSundayOfEaster(2020, '19/04/2020');
    checkSecondSundayOfEaster(2021, '11/04/2021');

    void checkAnnunciation(int year, String expected) {
      test('Annunciation of $year should be on $expected', () {
        expect(df.format(LecturesUtilities.annunciation(year)), expected);
      });
    }

    checkAnnunciation(2003, '25/03/2003');
    checkAnnunciation(2004, '25/03/2004');
    checkAnnunciation(2005, '04/04/2005');
    checkAnnunciation(2006, '25/03/2006');
    checkAnnunciation(2007, '26/03/2007');
    checkAnnunciation(2008, '31/03/2008');
    checkAnnunciation(2009, '25/03/2009');
    checkAnnunciation(2010, '25/03/2010');
    checkAnnunciation(2011, '25/03/2011');
    checkAnnunciation(2012, '26/03/2012');
    checkAnnunciation(2013, '08/04/2013');
    checkAnnunciation(2014, '25/03/2014');
    checkAnnunciation(2015, '25/03/2015');
    checkAnnunciation(2016, '04/04/2016');
    checkAnnunciation(2017, '25/03/2017');
    checkAnnunciation(2018, '09/04/2018');
    checkAnnunciation(2019, '25/03/2019');
    checkAnnunciation(2020, '25/03/2020');
    checkAnnunciation(2021, '25/03/2021');
    checkAnnunciation(2022, '25/03/2022');
    checkAnnunciation(2023, '25/03/2023');
    checkAnnunciation(2024, '08/04/2024');
    checkAnnunciation(2025, '25/03/2025');
    checkAnnunciation(2026, '25/03/2026');
    checkAnnunciation(2027, '05/04/2027');
    checkAnnunciation(2028, '25/03/2028');
    checkAnnunciation(2035, '02/04/2035');
    checkAnnunciation(2038, '25/03/2038');
    checkAnnunciation(2285, '30/03/2285');

    void checkSaintJoseph(int year, String expected) {
      test('SaintJoseph of $year should be on $expected', () {
        expect(df.format(LecturesUtilities.saintJoseph(year)), expected);
      });
    }

    checkSaintJoseph(2001, '19/03/2001');
    checkSaintJoseph(2002, '19/03/2002');
    checkSaintJoseph(2003, '19/03/2003');
    checkSaintJoseph(2004, '19/03/2004');
    checkSaintJoseph(2005, '19/03/2005');
    checkSaintJoseph(2006, '20/03/2006');
    checkSaintJoseph(2007, '19/03/2007');
    checkSaintJoseph(2008, '15/03/2008');
    checkSaintJoseph(2009, '19/03/2009');
    checkSaintJoseph(2010, '19/03/2010');
    checkSaintJoseph(2011, '19/03/2011');
    checkSaintJoseph(2012, '19/03/2012');
    checkSaintJoseph(2013, '19/03/2013');
    checkSaintJoseph(2014, '19/03/2014');
    checkSaintJoseph(2015, '19/03/2015');
    checkSaintJoseph(2016, '19/03/2016');
    checkSaintJoseph(2017, '20/03/2017');
    checkSaintJoseph(2018, '19/03/2018');
    checkSaintJoseph(2019, '19/03/2019');
    checkSaintJoseph(2020, '19/03/2020');
    checkSaintJoseph(2021, '19/03/2021');
    checkSaintJoseph(2022, '19/03/2022');

/*    void checkLiturgy(String dateString, String language, String expected) {
      test('Lectures card liturgy $language', () {
        initializeDateFormatting(language, null);
        var date = parse(dateString);
        String formattedDate =
            LecturesUtilities.liturgyDescription(date, language);
        expect(formattedDate, expected);
      });
    }*/

    //checkLiturgy('31/05/2020', 'it', 'Pentecoste');
    //checkLiturgy('31/05/2020', 'en', 'Pentecost Sunday');
  });

  String testData;
  const filePath = 'test/catholic_liturgy_test.csv';
  try {
    testData = await File(filePath).readAsString();
  } catch (e) {
    testData = await File("../$filePath").readAsString();
  }

  List<List<dynamic>> testDataRows =
      const CsvToListConverter().convert(testData, eol: '\n');

  void checkFeastLiturgy(
      String date, bool isEpiphanyFeast, LiturgyModel? expected) {
    final actual = LecturesUtilities.liturgy(parse(date), isEpiphanyFeast);
    test('Liturgy of $date ($isEpiphanyFeast) should be $expected', () {
      expect(actual, expected);
    });
  }

  group('Liturgy codes', () {
    for (final row in testDataRows) {
      LiturgyModel? expected = LiturgyModel(
          category: EnumToString.fromString(LiturgyEnum.values, row[2]),
          number: row[3] == 'null' ? null : row[3],
          dayOfWeek: row[4] == 'null' ? null : row[4],
          isFeast: row[5] == 'true');
      if (row[1] == '*') {
        checkFeastLiturgy(row[0], true, expected);
        checkFeastLiturgy(row[0], false, expected);
      } else {
        checkFeastLiturgy(row[0], row[1] == 'true', expected);
      }
    }
  });
}
