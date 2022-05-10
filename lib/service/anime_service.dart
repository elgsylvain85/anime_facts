import 'package:anime_facts/entities/anime.dart';
import 'package:anime_facts/entities/fact.dart';
import 'package:anime_facts/utilities/utility.dart';
import 'package:get/get.dart';

class AnimeService {
  // final apiUrl = "https://kd-anime-facts.herokuapp.com/api/v1";

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
