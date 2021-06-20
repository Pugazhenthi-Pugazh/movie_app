import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/Lists/getPersons.dart';
import 'package:movie_app/Models/PersonResponse.dart';
import 'package:movie_app/Models/person(Stars).dart';
import 'package:movie_app/Theme/theme.dart' as Style;

class Personslist extends StatefulWidget {
  const Personslist({Key? key}) : super(key: key);

  @override
  _PersonslistState createState() => _PersonslistState();
}

class _PersonslistState extends State<Personslist> {
  @override
  void initState() {
    super.initState();
    personslist.getPersons();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0, left: 10.0),
          child: Text(
            "TRENDING PERSONS OF THE WEEK",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<PersonResponse>(
          stream: personslist.subject.stream,
          builder: (context, AsyncSnapshot<PersonResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.error != null &&
                  snapshot.data!.error.length > 0) {
                return _buildErrorWidget(snapshot.data!.error);
              }
              return _buildPersonslistWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.data!.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: "),
      ],
    ));
  }

  Widget _buildPersonslistWidget(PersonResponse? data) {
    List<Person> person = data!.persons;
    return Container(
      height: 130.0,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        itemCount: person.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                person[index].profileImage == null
                    ? Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Style.Colors.secondColor,
                        ),
                        child: Icon(
                          FontAwesomeIcons.userAlt,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        width: 70.0,
                        height: 70.0,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://image.tmdb.org/t/p/w200" +
                                    person[index].profileImage)),
                      ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  person[index].name,
                  maxLines: 2,
                  style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 9.0),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                  "Trending for ${person[index].known}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 7.0),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
