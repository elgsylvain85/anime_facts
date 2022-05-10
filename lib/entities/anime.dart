class Anime {
  late int id;
  late String name;
  late String img;

  Anime();

  Anime.fromJson(Map<String, dynamic> json){
    id = json["anime_id"] ?? -1;
    name = json["anime_name"] ?? "";
    img = json["anime_img"] ?? "";
  }
}