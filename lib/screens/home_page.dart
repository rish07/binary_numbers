import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                      unselectedLabelColor: Colors.grey,
                      indicator: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Text('Movies'),
                        ),
                        Tab(
                          child: Text('Shows'),
                        ),
                        Tab(
                          child: Text('Music'),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(
                            color: Colors.green,
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
//                                ListView.builder(itemBuilder: null),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.blue,
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
