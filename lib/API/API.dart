import 'package:dio/dio.dart';
import 'package:movie_app/Models/GenereResponse.dart';
import 'package:movie_app/Models/MovieResponse.dart';
import 'package:movie_app/Models/PersonResponse.dart';

class API {
  String apiKey = "https://api.themoviedb.org/2b6e3af0b577423063b6a6e271986215";
  static String url = "https://api.themoviedb.org/3";

  final Dio dio = Dio();

  var getPopularUrl = '$url/movie/top_rated';
  var getMoviesUrl = '$url/discover/movie';
  var getPlayingUrl = '$url/movie/now_playing';
  var getGenereUrl = '$url/genre/movie/list';
  var getPersonsUrl = '$url/trending/person/week';

  Future<MovieResponse> getMovies() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page": 1,
    };
    try {
      Response response = await dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace:  $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getPlalyingMovies() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page": 1,
    };
    try {
      Response response = await dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace:  $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<GenereResponse> getGeners() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page": 1,
    };
    try {
      Response response = await dio.get(getGenereUrl, queryParameters: params);
      return GenereResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace:  $stackTrace");
      return GenereResponse.withError("$error");
    }
  }

  Future<PersonResponse> getPersons() async {
    var params = {
      "api_key": apiKey,
    };
    try {
      Response response = await dio.get(getPersonsUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace:  $stackTrace");
      return PersonResponse.withError("$error");
    }
  }

  Future<MovieResponse> getMoviesByGenere(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page": 1,
      "with_genres": id
    };
    try {
      Response response = await dio.get(getPersonsUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace:  $stackTrace");
      return MovieResponse.withError("$error");
    }
  }
}
