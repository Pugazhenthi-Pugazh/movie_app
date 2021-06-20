import 'package:flutter/material.dart';
import 'package:movie_app/Models/Genre.dart';
import 'package:movie_app/Theme/theme.dart' as Style;
import 'package:movie_app/Widgets/geners_movies.dart';

class GenersListforScreen extends StatefulWidget {
  final List<Genere> geners;
  GenersListforScreen({Key? key, required this.geners}) : super(key: key);

  @override
  _GenersListforScreenState createState() => _GenersListforScreenState(geners);
}

class _GenersListforScreenState extends State<GenersListforScreen>
    with SingleTickerProviderStateMixin {
  final List<Genere> geners;
  _GenersListforScreenState(this.geners);

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: geners.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307,
      child: DefaultTabController(
          length: geners.length,
          child: Scaffold(
            backgroundColor: Style.Colors.mainColor,
            appBar: PreferredSize(
              child: AppBar(
                backgroundColor: Style.Colors.mainColor,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Style.Colors.secondColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.0,
                  unselectedLabelColor: Colors.grey[700],
                  labelColor: Colors.white,
                  isScrollable: true,
                  tabs: geners.map((Genere geners) {
                    return Container(
                      padding: EdgeInsets.only(bottom: 15.0, top: 10),
                      child: Text(
                        geners.name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
              ),
              preferredSize: Size.fromHeight(50.0),
            ),
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: geners.map((Genere generes) {
                return GenerMovies(generid: generes.id);
              }).toList(),
            ),
          )),
    );
  }
}
