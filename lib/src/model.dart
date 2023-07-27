import 'dart:convert';

enum LiturgyEnum {
  ash,
  lent,
  palmSunday,
  holyWeek,
  easter,
  ascensionOfTheLord,
  pentecost,
  theMostHolyTrinity,
  theMostHolyBodyAndBloodOfChrist,
  advent,
  christmas,
  maryHolyMotherOfGod,
  baptismOfTheLord,
  ordinaryTime,
  sacredHeart,
  epiphany,
  weekdayAfterEpiphany,
  saintJoseph,
  annunciation,
  immaculateHeartOfMary,
  holyFamily,
  secondSundayAfterChristmas,
  immaculateConception,
  christmasWeekDay,
  theNativityOfTheBlessedVirginMary,
  theHolyGuardianAngels,
  ourLadyOfSorrows,
  adventWeekDay17December,
  adventWeekDay18December,
  adventWeekDay19December,
  adventWeekDay20December,
  adventWeekDay21December,
  adventWeekDay22December,
  adventWeekDay23December,
  adventWeekDay24December,
  theNativityOfSaintJohnTheBaptist,
  theAssumptionOfTheBlessedVirginMary,
  theExaltationOfTheHolyCross,
  theDedicationOfTheLateranBasilica,
  theTransfigurationOfTheLord,
  allSaints,
  thePresentationOfTheBlessedVirginMary,
  thePassionOfSaintJohnTheBaptist,
  theCommemorationOfAllTheFaithfulDeparted,
  theChairOfSaintPeterTheApostle,
  theConversionOfSaintPaulTheApostle,
  thePresentationOfTheLord,
  theHolyInnocentsMartyrs,
  fifthDayWithinOctaveOfNativity,
  sixthDayWithinOctaveOfNativity,
  seventhDayWithinOctaveOfNativity,
  theVisitationOfTheBlessedVirginMary,
  saintAndrewApostle,
  saintMarkEvangelist,
  saintCatherineOfSiena,
  saintJosephTheWorker,
  saintAthanasius,
  saintsPhilipAndJamesApostles,
  saintThomasApostle,
  saintFrancisOfAssisi,
  saintsSimonAndJudeApostles,
  saintLukeEvangelist,
  saintTeresaBenedictaOfTheCross,
  saintLawrencer,
  saintMaryMagdalene,
  saintBarnabasApostle,
  saintBenedictAbbot,
  saintBridget,
  saintStephenTheFirstMartyr,
  saintAnthonyOfPadua,
  saintMatthewApostleAndEvangelist,
  saintBartholomewApostle,
  saintsCyrilAndMethodius,
  saintMartha,
  saintJamesApostle,
  saintMatthiasApostle,
  saintsPeterAndPaul,
  saintsTimothyAndTitusBishops,
  saintJohnApostleAndEvangelist,
  saintsMichaelGabrielAndRaphaelArchangels,
  memorialOfTheBlessedVirginMaryMotherOfTheChurch
}

enum SaintMemoryEnum { saintsBasilAndGregoryNazianzen }

enum LiturgyLanguage { it, en }

class LiturgyModel {
  final LiturgyEnum category;
  final int? number;
  final int? dayOfWeek;
  final bool isFeast;
  LiturgyModel(
      {required this.category,
      this.number,
      this.dayOfWeek,
      required this.isFeast});

  @override
  bool operator ==(other) =>
      other is LiturgyModel &&
      category == other.category &&
      number == other.number &&
      dayOfWeek == other.dayOfWeek &&
      isFeast == other.isFeast;

  @override
  int get hashCode =>
      category.hashCode +
      number.hashCode +
      dayOfWeek.hashCode +
      isFeast.hashCode;

  @override
  String toString() {
    return const JsonEncoder.withIndent('  ').convert(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category.toString(),
      'number': number,
      'dayOfWeek': dayOfWeek,
      'isFeast': isFeast
    };
  }
}
