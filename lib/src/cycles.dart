import '_liturgy_functions.dart';

extension MyDateCompare on DateTime {
  bool isSameDate(DateTime? otherDate) =>
      otherDate != null ? isAtSameMomentAs(otherDate) : false;
}

class CyclesUtilities {
  static int _liturgyYear(DateTime date) =>
      (date.compareTo(LiturgyFunctions.adventStart(date.year)) >= 0)
          ? date.year + 1
          : date.year;

  static String feastLecturesCycle(DateTime date) {
    switch ((_liturgyYear(date) - 2014) % 3) {
      case 0:
        return "A";
      case 1:
        return "B";
      default:
        return "C";
    }
  }

  static String ferialLectureCycle(DateTime date) {
    switch ((_liturgyYear(date) - 2015) % 2) {
      case 0:
        return "1";
      default:
        return "2";
    }
  }
}
