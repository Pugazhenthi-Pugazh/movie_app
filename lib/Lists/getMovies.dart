import 'package:movie_app/API/API.dart';
import 'package:movie_app/Models/MovieResponse.dart';
import 'package:rxdart/rxdart.dart';

class MoviesList {
  final API _api = API();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovies() async {
    MovieResponse response = await _api.getMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesList = MoviesList();
