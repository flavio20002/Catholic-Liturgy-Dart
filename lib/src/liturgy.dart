import 'package:catholic_liturgy/src/_liturgy_functions.dart';

import '_date_utilities.dart';
import 'model.dart';

class Liturgy {
  static LiturgyModel? liturgy(DateTime date, bool isEpiphanyFeast) {
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
      return LiturgyModel(
          category: solemnityAfterEasterCategory, isFeast: true);
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
        LiturgyFunctions.solemnityCalculated(dateCleaned, isEpiphanyFeast);
    if (solemnityCalculatedCategory != null) {
      return LiturgyModel(category: solemnityCalculatedCategory, isFeast: true);
    }
    LiturgyModel? feastLiturgy = LiturgyFunctions.feast(dateCleaned);
    if (feastLiturgy != null) {
      return feastLiturgy;
    }
    LiturgyModel? ferialLiturgy =
        LiturgyFunctions.ferial(dateCleaned, isEpiphanyFeast);
    if (ferialLiturgy != null) {
      return ferialLiturgy;
    }
    return null;
  }
}
