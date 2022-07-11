import 'package:catholic_liturgy/src/_date_utilities.dart';
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
        String formattedDate = DateUtilities.formatDate(parse(date), language);
        expect(formattedDate, expected);
      });
    }

    checkFormatDate('31/05/2020', 'it', 'Domenica, 31 maggio 2020');
    checkFormatDate('31/05/2020', 'en', 'Sunday, 31 May 2020');

    void checkFormatCurrentDate(String language) {
      test('Check Format current date in language $language', () {
        initializeDateFormatting(language, null);
        String formattedDate = DateUtilities.formatCurrentDate(language);
        expect(formattedDate,
            DateUtilities.formatDate(DateUtilities.currentDate(), language));
      });
    }

    checkFormatCurrentDate('it');
    checkFormatCurrentDate('en');
  });

  group('Lecture utilities', () {
    test('Capitalize', () {
      expect(DateUtilities.capitalize('this is a test'), 'This is a test');
    });

    test('Clean Date', () {
      DateTime currentDate = DateTime.now();
      DateTime cleanDate = DateUtilities.cleanDate(currentDate);
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
      expect(df.format(DateUtilities.currentDate()), df.format(DateTime.now()));
    });

    void checkPreviousSunday(String dateString, String expected) {
      test('Previous Sunday of $dateString should be $expected', () {
        DateTime previousSunday =
            DateUtilities.previousSunday(parse(dateString));
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
        DateTime previousSunday = DateUtilities.nextSunday(parse(dateString));
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
        expect(DateUtilities.isSunday(parse(dateString)), expected);
      });
    }

    checkIsSunday('01/06/2020', false);
    checkIsSunday('31/05/2020', true);

    void checkIsMonday(String dateString, bool expected) {
      test('Check if $dateString is Monday should be $expected', () {
        expect(DateUtilities.isMonday(parse(dateString)), expected);
      });
    }

    checkIsMonday('01/06/2020', true);
    checkIsMonday('31/05/2020', false);

    void checkAddWeeks(String dateString, int weeks, String expected) {
      test('Adding $weeks weeks to $dateString to obtain $expected', () {
        expect(
            df.format(DateUtilities.addWeeksToDate(parse(dateString), weeks)),
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
        expect(df.format(DateUtilities.addDaysToDate(parse(dateString), days)),
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
            DateUtilities.daysBetweenDates(
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
        expect(
            DateUtilities.daysBetweenCurrentDate(parse(dateString)), expected);
      });
    }

    checkDaysBetweenCurrentDate(df.format(DateUtilities.currentDate()), 0);
    checkDaysBetweenCurrentDate(
        df.format(DateUtilities.currentDate().add(const Duration(days: 1))), 1);
    checkDaysBetweenCurrentDate(
        df.format(DateUtilities.currentDate().add(const Duration(days: -1))),
        -1);

    void checkWeeksBetween(
        String dateString1, String dateString2, int expected) {
      test('Check weeks between $dateString1 and $dateString2 to be $expected',
          () {
        expect(
            DateUtilities.weeksBetweenDates(
                parse(dateString1), parse(dateString2)),
            expected);
      });
    }

    checkWeeksBetween('01/06/2020', '01/06/2020', 0);
    checkWeeksBetween('01/06/2020', '03/06/2020', 0);
    checkWeeksBetween('01/06/2020', '08/06/2020', 1);
    checkWeeksBetween('01/06/2020', '25/05/2020', -1);
  });
}
