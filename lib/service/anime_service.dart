import 'package:anime_facts/entities/anime.dart';
import 'package:anime_facts/entities/fact.dart';
import 'package:anime_facts/utilities/utility.dart';
import 'package:get/get.dart';

///This class is a business class that manages the "Anime" object and its derivatives
class AnimeService {

  ///load and convert "Anime" from the web service
  Future<List<Anime>> loadAllAnime() async {
    List<Anime> result = [];

    var response =
        await GetConnect().get(Utility.apiUrl).timeout(const Duration(seconds: Utility.timeOut));

    if (response.isOk) {
      result = List<Anime>.from((response.body["data"]).map((e) {
        return Anime.fromJson(e);
      }));

      return result;
    } else {
      throw Exception(response.bodyString);
    }
  }

  /// load and convert the "fact" of the "anime" into a parameter
  Future<List<Fact>> loadFactsByAnime(Anime anime) async {
    List<Fact> result = [];

    var response = await GetConnect()
        .get("${Utility.apiUrl}/${anime.name}")
        .timeout(const Duration(seconds: Utility.timeOut));

    if (response.isOk) {
      result = List<Fact>.from((response.body["data"]).map((e) {
        return Fact.fromJson(e);
      }));

      return result;
    } else {
      throw Exception(response.bodyString);
    }
  }
}
