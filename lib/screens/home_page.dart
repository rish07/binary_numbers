import 'dart:convert';

import 'package:binary_numbers/models/movie.dart';
import 'package:binary_numbers/widgets/popUpDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'movie_detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabController _tabController;
  bool _isLoading = false;
  List _movies = [];
  Future _getMovies() async {
    try {
      var response = await http.get("http://www.omdbapi.com/?s=Movies&apikey=5661d041");
      setState(() {
        _movies = jsonDecode(response.body)['Search'];
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      popDialog(
          title: "Error",
          context: context,
          content: "Error:" + e.toString(),
          onPress: () {
            Navigator.pop(context);
          },
          buttonTitle: "Okay");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isLoading = true;
      _currentTab = 0;
    });
    _getMovies();
  }

  int _currentTab = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.1,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('images/account.png'),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Chelsie Brett',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  width: size.width * 0.2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 40,
                  width: 105,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFF202020),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Color(0xFF434242),
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF434242),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            DefaultTabController(
              initialIndex: 1,
              length: 3,
              child: SizedBox(
                height: size.height * 0.8,
                child: Column(
                  children: [
                    TabBar(
                      onTap: (index) {
                        setState(() {
                          _currentTab = index;
                        });
                      },
                      labelPadding: EdgeInsets.symmetric(horizontal: 20),
                      unselectedLabelColor: Colors.grey,
                      indicator: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Container(
                            height: 35,
                            width: 90,
                            decoration: BoxDecoration(
                              color: _currentTab == 0 ? null : Color(0xFF222021),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text('Movies'),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 35,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text('Shows'),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 35,
                            width: 90,
                            decoration: BoxDecoration(
                              color: _currentTab == 2 ? null : Color(0xFF222021),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(child: Text('Music')),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(
                            child: Center(
                              child: Text(
                                'Dummy Text',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: ListView(
                              children: [
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Text(
                                  'NEW',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 250,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: _movies.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        var movie = Movie.fromJson(_movies[index]);
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => MovieDetail(movieName: movie.title),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Stack(
                                              fit: StackFit.loose,
                                              children: [
                                                Container(
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(16),
                                                    child: Image.network(
                                                      movie.poster,
                                                      width: 150,
                                                      height: 225,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 210.0, left: 55),
                                                  child: Container(
                                                    child: Text(
                                                      'New',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(3),
                                                      color: Colors.green,
                                                    ),
                                                    padding: EdgeInsets.all(5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Text(
                                  'POPULAR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 250,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: _movies.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        var movie = Movie.fromJson(_movies[index]);
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => MovieDetail(movieName: movie.title),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(16),
                                                child: Image.network(
                                                  movie.poster,
                                                  width: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Text(
                                  'TRENDING',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 250,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: _movies.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        var movie = Movie.fromJson(_movies[index]);
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => MovieDetail(movieName: movie.title),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(16),
                                                child: Image.network(
                                                  movie.poster,
                                                  width: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                'Dummy Text',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
