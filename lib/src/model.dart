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

enum SaintMemoryEnum {
  santantonioAbatesant,
  santiBasilioMagnoEGregorioNazianzenoVescoviEDottoriDellaChiesa,
  santagneseVergineEMartire,
  sanFrancescoDiSalesVescovoEDottoreDellaChiesa,
  santiTimoteoETitoVescovi,
  sanTommasoDAquinoPresbiteroEDottoreDellaChiesa,
  sanGiovanniBoscoPresbitero,
  santaTeresaDiGesuBambinodiLisieuxVergineEDottoreDellaChiesa,
  santaTeresaDiGesudAvilaVergineEDottoreDellaChiesa,
  santignazioDiAntiochiaVescovoEMartire,
  santiAngeliCustodi,
  beataMariaVergineDelRosario,
  sanLeoneMagnoPapaEDottoreDellaChiesa,
  sanMartinoDiToursVescovo,
  sanGiosafatVescovoEMartire,
  santaElisabettaDUngheria,
  presentazioneDellaBeataVergineMariaAlTempio,
  santaCeciliaVergineEMartire,
  santiAndreaDungLacPresbiteroECompagniMartiri,
  sanCarloBorromeoVescovo,
  santaLuciaVergineEMartire,
  sanGiovanniDellaCrocePresbiteroEDottoreDellaChiesa,
  sanFrancescoSaverioPresbitero,
  sanNicolaVescovo,
  santambrogioVescovoEDottoreDellaChiesa,
  santaScolasticaVergine,
  sanPolicarpoVescovoEMartire,
  santagataVergineEMartire,
  sanPaoloMikiECompagniMartiri,
  santePerpetuaEFelicitaMartiri,
  santoStanislaoVescovoEMartire,
  sanGiovanniBattistaDeLaSallePresbitero,
  sanGiuseppeLavoratore,
  santatanasioVescovoEDottoreDellaChiesa,
  sanFilippoNeriPresbitero,
  sanGiustinoMartire,
  sanBarnabaApostolo,
  sAntonioDiPadovaPresbiteroEDottoreDellaChiesa,
  sanLuigiGonzagaReligioso,
  santireneoVescovoEMartire,
  sanCarloLwangaECompagniMartiri,
  sanBonifacioVescovoEMartire,
  sanBonaventuraVescovoEDottoreDellaChiesa,
  santiGioacchinoEAnnaGenitoriDellaBeataVergineMaria,
  santaMartaConMariaELazzaro,
  santignazioDiLoyolaPresbiteroFondatoreDeiGesuiti,
  santalfonsoMariaDeLiguoriVescovoEDottoreDellaChiesa,
  santaChiaraVergine,
  sanMassimilianoMariaKolbePresbiteroEMartire,
  sanBernardoAbateEDottoreDellaChiesa,
  sanPioXPapa,
  beataVergineMariaRegina,
  santaMonica,
  santagostinoVescovoEDottoreDellaChiesa,
  martirioDiSanGiovanniBattista,
  sanGiovanniMariaVianneyPresbitero,
  sanDomenicoPresbitero,
  sanGiovanniCrisostomoVescovoEDottoreDellaChiesa,
  beataVergineMariaAddolorata,
  santiCornelioPapaECiprianoVescovoMartiri,
  santiAndreaKimTaegonPresbiteroPaoloChongHasangECompagniMartiri,
  sanPioDaPietrelcinaPresbitero,
  sanVincenzoDePaoliPresbitero,
  sanGregorioMagnoPapaEDottoreDellaChiesa,
  sanGirolamoPresbiteroEDottoreDellaChiesa,
}

enum FacultativeSaintMemoryEnum {
  sanGiovanniXXIIIPapa,
  sanGiovanniPaoloIIPapa,
  beataVergineMariaDiLourdes,
  beataVergineMariaDiFatima,
  beataVergineMariaDelMonteCarmelo,
}

enum FranciscanFeastMemoryEnum {
  dedicazioneDellaBasilicaDiSanFrancescoInAssisi,
  sanBonaventuraVescovoEDottoreDellaChiesa,
  santaMadreChiaraVergineCofondatriceDelIIOrdineFrancescano,
  sanMassimilianoMariaKolbePresbiteroEMartire,
  santaMariaDegliAngeliAllaPorziuncolaPerdonDAssisi,
  sanDomenicoPresbitero,
  impressioneDelleStimmateDiSanFrancesco,
  sanGiuseppeDaCopertinoPresbitero,
  santiBerardoECompagniProtomartiriDellOrdineFrancescano,
  santaGiacintaMariscottiVergine,
  santissimoNomediGesu,
  sanGiovanniDaCapestranoPresbitero,
  sanNicolaTavelicPresbiteroECompagniMartiri,
  sanLeonardoDaPortoMaurizioPresbitero,
  sanFrancescoAntonioFasaniPresbitero,
  ssPietroBattistaPaoloMikiECompagniProtomartiriDelGiappone,
  sColetaDaCorbieVergine,
  sFedeleDaSigmaringenSacerdoteEMartire,
  sanLeopoldoMandicDaCastelnuovoPresbitero,
  santaMargheritaDaCortonaPenitente,
  sanPasqualeBaylonReligioso,
  sanFeliceDaCantaliceReligioso,
  sanBernardinoDaSienaPresbitero,
  santaVeronicaGiulianiVergine,
  sanLorenzoDaBrindisiPresbiteroEDottoreDellaChiesa,
  sanLudovicoIXRePatronoDelOrdineFrancescanoSecolare,
  santaElisabettaDUngheriaPatronaDellOrdineFrancescanoSecolare,
  sAntonioDiPadovaPresbiteroEDottoreDellaChiesa
}

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
