import 'package:movie_app/Models/Genre.dart';

class GenereResponse {
  final List<Genere> geners;
  final String error;

  GenereResponse(this.geners, this.error);

  GenereResponse.fromJson(Map<String, dynamic> json)
      : geners = (json["genres"] as List)
            .map((e) => new Genere.fromJson(e))
            .toList(),
        error = "";

  GenereResponse.withError(String errorvalue)
      // ignore: deprecated_member_use
      : geners = List<Genere>.empty(),
        error = errorvalue;
}
