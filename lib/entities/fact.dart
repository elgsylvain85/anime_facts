/// This class represents a "Fact" object
class Fact {
  late int id;
  late String fact;

  Fact();

  Fact.fromJson(Map<String, dynamic> json){
    id = json["fact_id"] ?? -1;
    fact = json["fact"] ?? "";
  }

}