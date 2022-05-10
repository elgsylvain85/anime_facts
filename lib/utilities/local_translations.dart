import 'package:get/route_manager.dart';

class LocalTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "fr": {
          "noDataRefresh":
              "aucune information disponible. Veuillez actualiser svp",
          "seeFacts": "voir les faits",
          "errorDataRefresh": "une erreur est survenue. Veuillez actualiser svp"
        },
        "en": {
          "noDataRefresh": "no data available. Please refresh",
          "seeFacts": "see facts",
          "errorDataRefresh": "an error has occurred. Please refresh"
        }
      };
}
