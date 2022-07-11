import 'dart:io';

import 'package:catholic_liturgy/catholic_liturgy.dart';
import 'package:catholic_liturgy/src/cycles.dart';
import 'package:csv/csv.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_test/flutter_test.dart';
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
  const filePath = 'test/catholic_liturgy_codes_test.csv';
  try {
    testData = await File(filePath).readAsString();
  } catch (e) {
    testData = await File("../$filePath").readAsString();
  }

  List<List<dynamic>> testDataRows =
      const CsvToListConverter().convert(testData, eol: '\n');

  void checkFeastLiturgy(
      String date, bool isEpiphanyFeast, LiturgyModel? expected) {
    final actual = Liturgy.liturgy(parse(date), isEpiphanyFeast);
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
