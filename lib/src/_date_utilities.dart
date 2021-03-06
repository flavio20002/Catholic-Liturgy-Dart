import 'package:catholic_liturgy/src/model.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:intl/intl.dart';

class DateUtilities {
  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  static DateTime cleanDate(DateTime date) =>
      DateTime.utc(date.year, date.month, date.day);

  static DateTime currentDate() => cleanDate(DateTime.now());

  static String formatDate(DateTime date, LiturgyLanguage language) =>
      capitalize(DateFormat(
              'EEEE, d MMMM yyyy', EnumToString.convertToString(language))
          .format(date));

  static String dayOfWeek(int dayOfWeek, LiturgyLanguage language, bool short) {
    final date = addDaysToDate(previousSunday(currentDate()), dayOfWeek);
    return DateFormat(
            short ? 'EEE' : 'EEEE', EnumToString.convertToString(language))
        .format(date);
  }

  static String formatCurrentDate(LiturgyLanguage language) =>
      formatDate(currentDate(), language);

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
}
