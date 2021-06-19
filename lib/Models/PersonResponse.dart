import 'package:movie_app/Models/person(Stars).dart';

class PersonResponse {
  final List<Person> persons;
  final String error;

  PersonResponse(this.persons, this.error);

  PersonResponse.fromJson(Map<String, dynamic> json)
      : persons = (json["results"] as List)
            .map((e) => new Person.fromJson(e))
            .toList(),
        error = "";

  PersonResponse.withError(String errorvalue)
      // ignore: deprecated_member_use
      : persons = List<Person>.empty(),
        error = errorvalue;
}
