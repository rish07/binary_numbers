import 'dart:async';

import 'package:binary_numbers/widgets/popUpDialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var _connectionStatus = 'Unknown';

  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<Widget> _children = [
    HomePage(),
    Container(
      color: Colors.black,
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
      color: Colors.black,
      child: Center(
        child: Text(
          'Dummy Text',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectivity = new Connectivity();
    subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result.toString();
      print(_connectionStatus);
      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      } else {
        popDialog(
            title: 'No Network!',
            context: context,
            content: 'Please recheck your internet connection and try again!',
            buttonTitle: 'Okay',
            onPress: () {
              SystemChannels.platform.invokeListMethod('SystemNavigator.pop');
            });
      }
    });
  }

  int _currentNav = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _children[_currentNav],
      endDrawer: Drawer(
        child: Center(
          child: Text(
            'Drawer',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Color(0xFF171717),
        ),
        padding: EdgeInsets.only(top: 10),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xFF171717),
            primaryColor: Colors.red,
            bottomAppBarColor: Colors.green,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentNav,
            onTap: (index) {
              (index == 3)
                  ? _scaffoldKey.currentState.openEndDrawer()
                  : setState(() {
                      _currentNav = index;
                    });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                  color: _currentNav == 0 ? Colors.red : Color(0xFF434242),
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.star,
                  size: 30,
                  color: _currentNav == 1 ? Colors.red : Color(0xFF434242),
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.bookmark,
                  size: 30,
                  color: _currentNav == 2 ? Colors.red : Color(0xFF434242),
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: Color(0xFF434242),
                ),
                title: Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
