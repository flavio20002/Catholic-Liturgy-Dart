import '../../catholic_liturgy.dart';
import '_en.dart';
import '_it.dart';

class LiturgyDescriptions {
  static String? liturgyDescriptions(
      LiturgyModel liturgyModel, String languageCode) {
    if (languageCode.toLowerCase() == 'it') {
      return LiturgyDescriptionsIT.liturgyDescriptions(liturgyModel);
    } else if (languageCode.toLowerCase() == 'en') {
      return LiturgyDescriptionsEN.liturgyDescriptions(liturgyModel);
    }
    return null;
  }
}
