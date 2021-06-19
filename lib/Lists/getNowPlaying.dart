import 'package:movie_app/API/API.dart';
import 'package:movie_app/Models/MovieResponse.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingList {
  final API _api = API();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovies() async {
    MovieResponse response = await _api.getPlalyingMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final nowPlayingList = NowPlayingList();
