import 'package:catholic_liturgy/src/_liturgy_functions.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:intl/date_symbol_data_local.dart';

import '_date_utilities.dart';
import 'descriptions/_en.dart';
import 'descriptions/_it.dart';
import 'model.dart';

/// Calculate liturgy of the [date] day, using the [isEpiphanyOn6thJan] flag.
LiturgyModel? liturgy(DateTime date, bool isEpiphanyOn6thJan) {
  DateTime dateCleaned = DateUtilities.cleanDate(date);
  int? lentWeekNumber = LiturgyFunctions.lentWeek(dateCleaned);
  if (lentWeekNumber != null && DateUtilities.isSunday(dateCleaned)) {
    return LiturgyModel(
        category: LiturgyEnum.lent, number: lentWeekNumber, isFeast: true);
  }
  bool ashResult = LiturgyFunctions.ash(dateCleaned);
  if (ashResult && dateCleaned.weekday == DateTime.wednesday) {
    return LiturgyModel(
        category: LiturgyEnum.ash,
        dayOfWeek: dateCleaned.weekday,
        isFeast: true);
  }
  int? holyWeekNumber = LiturgyFunctions.holyWeek(dateCleaned);
  if (holyWeekNumber != null) {
    return LiturgyModel(
        category: LiturgyEnum.holyWeek,
        dayOfWeek: holyWeekNumber,
        isFeast: holyWeekNumber >= DateTime.thursday &&
            holyWeekNumber <= DateTime.saturday);
  }
  LiturgyEnum? solemnityAfterEasterCategory =
      LiturgyFunctions.solemnityAfterEaster(dateCleaned);
  if (solemnityAfterEasterCategory != null) {
    return LiturgyModel(category: solemnityAfterEasterCategory, isFeast: true);
  }
  int? sundayEasterNumber = LiturgyFunctions.easterWeek(dateCleaned);
  if (sundayEasterNumber != null && DateUtilities.isSunday(dateCleaned)) {
    return LiturgyModel(
        category: LiturgyEnum.easter,
        number: sundayEasterNumber,
        isFeast: true);
  }
  int? sundayAdventNumber = LiturgyFunctions.sundayAdvent(dateCleaned);
  if (sundayAdventNumber != null) {
    return LiturgyModel(
        category: LiturgyEnum.advent,
        number: sundayAdventNumber,
        isFeast: true);
  }
  LiturgyEnum? solemnityCalculatedCategory =
      LiturgyFunctions.solemnityCalculated(dateCleaned, isEpiphanyOn6thJan);
  if (solemnityCalculatedCategory != null) {
    return LiturgyModel(category: solemnityCalculatedCategory, isFeast: true);
  }
  LiturgyModel? feastLiturgy = LiturgyFunctions.feast(dateCleaned);
  if (feastLiturgy != null) {
    return feastLiturgy;
  }
  LiturgyModel? ferialLiturgy =
      LiturgyFunctions.ferial(dateCleaned, isEpiphanyOn6thJan);
  if (ferialLiturgy != null) {
    return ferialLiturgy;
  }
  return null;
}

/// Initialize the [language] language.
Future<void> initializeLanguage(LiturgyLanguage language) async {
  await initializeDateFormatting(EnumToString.convertToString(language), null);
}

/// Get the description of the [liturgyModel] model in the [language] language.
String? liturgyDescription(
    LiturgyModel liturgyModel, LiturgyLanguage language) {
  if (language == LiturgyLanguage.it) {
    return LiturgyDescriptionsIT.liturgyDescription(liturgyModel);
  } else if (language == LiturgyLanguage.en) {
    return LiturgyDescriptionsEN.liturgyDescription(liturgyModel);
  }
  return null;
}

/// Get feast lecture cycle of the provided [date]
String feastLecturesCycle(DateTime date) {
  switch ((LiturgyFunctions.liturgyYear(date) - 2014) % 3) {
    case 0:
      return "A";
    case 1:
      return "B";
    default:
      return "C";
  }
}

/// Get ferial lecture cycle of the provided [date]
String ferialLectureCycle(DateTime date) {
  switch ((LiturgyFunctions.liturgyYear(date) - 2015) % 2) {
    case 0:
      return "1";
    default:
      return "2";
  }
}
