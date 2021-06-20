import 'package:movie_app/API/API.dart';
import 'package:movie_app/Models/PersonResponse.dart';
import 'package:rxdart/rxdart.dart';

class PersonsList {
  final API _api = API();
  final BehaviorSubject<PersonResponse> _subject =
      BehaviorSubject<PersonResponse>();

  getPersons() async {
    PersonResponse response = await _api.getPersons();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _subject;
}

final personslist = PersonsList();
