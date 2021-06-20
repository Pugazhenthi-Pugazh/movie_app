import 'package:flutter/material.dart';
import 'package:movie_app/Lists/getGeneres.dart';
import 'package:movie_app/Models/GenereResponse.dart';
import 'package:movie_app/Models/Genre.dart';
import 'package:movie_app/Widgets/geners_list.dart';

class GenersScreen extends StatefulWidget {
  const GenersScreen({Key? key}) : super(key: key);

  @override
  _GenersScreenState createState() => _GenersScreenState();
}

class _GenersScreenState extends State<GenersScreen> {
  @override
  void initState() {
    super.initState();
    genersList.getGeners();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenereResponse>(
      stream: genersList.subject.stream,
      builder: (context, AsyncSnapshot<GenereResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null && snapshot.data!.error.length > 0) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildGenersWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.data!.error);
        } else {
          return _buildLoadingWidget();
        }
      },
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

  Widget _buildGenersWidget(GenereResponse? data) {
    List<Genere> geners = data!.geners;
    if (geners.length == 0) {
      return Column(
        children: <Widget>[
          Text(
            "No Gener",
            style: TextStyle(color: Colors.black45),
          )
        ],
      );
    } else
      return GenersListforScreen(geners: geners);
  }
}
