import 'dart:io';

import 'package:catholic_liturgy/catholic_liturgy.dart';
import 'package:catholic_liturgy/src/cycles.dart';
import 'package:catholic_liturgy/src/descriptions/liturgy_descriptions.dart';
import 'package:csv/csv.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

main() async {
  var df = DateFormat('dd/MM/yyyy');

  parse(String dateString) => df.parseUTC(dateString);

  group('Lecture utilities', () {
    void checkFeastLecturesCycle(String date, String expected) {
      test('Feast lecture cycle of $date should be $expected', () {
        expect(CyclesUtilities.feastLecturesCycle(parse(date)), expected);
      });
    }

    checkFeastLecturesCycle('01/08/2003', 'B');
    checkFeastLecturesCycle('01/05/2019', 'C');
    checkFeastLecturesCycle('01/06/2020', 'A');
    checkFeastLecturesCycle('29/11/2020', 'B');

    void checkFerialLecturesCycle(String date, String expected) {
      test('Ferial lecture cycle of $date should be $expected', () {
        expect(CyclesUtilities.ferialLectureCycle(parse(date)), expected);
      });
    }

    checkFerialLecturesCycle('01/08/2003', '1');
    checkFerialLecturesCycle('01/05/2019', '1');
    checkFerialLecturesCycle('01/06/2020', '2');
    checkFerialLecturesCycle('29/11/2020', '1');
  });

  String testData;
  const filePath = 'test/catholic_liturgy_codes_test.csv';
  try {
    testData = await File(filePath).readAsString();
  } catch (e) {
    testData = await File("../$filePath").readAsString();
  }

  List<List<dynamic>> testDataRows =
      const CsvToListConverter().convert(testData, eol: '\n');

  void checkLiturgy(String date, bool isEpiphanyFeast, LiturgyModel? expected) {
    final actual = Liturgy.liturgy(parse(date), isEpiphanyFeast);
    test('Liturgy of $date ($isEpiphanyFeast) should be $expected', () {
      expect(actual, expected);
    });
  }

  void checkLiturgyDescription(
      LiturgyModel liturgyModel, String language, String expected) {
    final actual =
        LiturgyDescriptions.liturgyDescriptions(liturgyModel, language);
    test('Liturgy of ${liturgyModel.toString()} should be $expected', () {
      expect(actual, expected);
    });
  }

  group('Liturgy codes', () {
    initializeDateFormatting('it', null);
    initializeDateFormatting('en', null);
    for (final row in testDataRows) {
      LiturgyModel? expected = LiturgyModel(
          category: EnumToString.fromString(LiturgyEnum.values, row[2])!,
          number: row[3] == 'null' ? null : row[3],
          dayOfWeek: row[4] == 'null' ? null : row[4],
          isFeast: row[5] == 'true');
      if (row[1] == '*') {
        checkLiturgy(row[0], true, expected);
        checkLiturgy(row[0], false, expected);
      } else {
        checkLiturgy(row[0], row[1] == 'true', expected);
      }
      if (row.length > 6) {
        String? descriptionExpectedIT = row[6];
        String? descriptionExpectedEN = row[7];
        checkLiturgyDescription(expected, 'it', descriptionExpectedIT!);
        checkLiturgyDescription(expected, 'en', descriptionExpectedEN!);
      }
    }
  });
}
