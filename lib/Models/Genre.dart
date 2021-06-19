class Genere {
  final int id;
  final String name;

  Genere(this.id, this.name);

  Genere.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}
