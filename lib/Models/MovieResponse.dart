import 'package:movie_app/Models/Movie.dart';

class MovieResponse {
  final List<Movie> movies;
  final String error;

  MovieResponse(this.movies, this.error);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List)
            .map((e) => new Movie.fromJson(e))
            .toList(),
        error = "";

  MovieResponse.withError(String errorvalue)
      // ignore: deprecated_member_use
      : movies = List<Movie>.empty(),
        error = errorvalue;
}
