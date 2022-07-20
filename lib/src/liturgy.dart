import 'package:catholic_liturgy/src/_liturgy_functions.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:intl/date_symbol_data_local.dart';

import '_date_utilities.dart';
import 'descriptions/_en.dart';
import 'descriptions/_it.dart';
import 'model.dart';

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

void initializeLanguage(LiturgyLanguage language) {
  initializeDateFormatting(EnumToString.convertToString(language), null);
}

String? liturgyDescriptions(
    LiturgyModel liturgyModel, LiturgyLanguage language) {
  if (language == LiturgyLanguage.it) {
    return LiturgyDescriptionsIT.liturgyDescriptions(liturgyModel);
  } else if (language == LiturgyLanguage.en) {
    return LiturgyDescriptionsEN.liturgyDescriptions(liturgyModel);
  }
  return null;
}

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

String ferialLectureCycle(DateTime date) {
  switch ((LiturgyFunctions.liturgyYear(date) - 2015) % 2) {
    case 0:
      return "1";
    default:
      return "2";
  }
}
