import 'package:flutter/material.dart';
import 'package:flutter_gankio/pages/home_list_page.dart';
import 'package:flutter_gankio/pages/login_page.dart';

import 'fuli_list_page.dart';
import 'home_page.dart';

class GankioApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GankioAppState();
  }

}

class _GankioAppState extends State<GankioApp>{

  int _tabIndex = 0;

  var appBarTitles = ['首页', '福利', '我的'];

  List<BottomNavigationBarItem> _navigationViews;

  var _body;

  //跨Widget访问状态
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    initData();
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
//        appBar: AppBar(
//          title: Text(
//            appBarTitles[_tabIndex],
//            style: TextStyle(color: Colors.white),
//          ),
//          actions: <Widget>[
//              IconButton(
//                icon: Icon(Icons.search),
//                onPressed: (){
//
//                },
//              )
//          ],
//        ),

        body: _body,
        bottomNavigationBar: BottomNavigationBar(
          items: _navigationViews
          .map((BottomNavigationBarItem navigationView) => navigationView)
          .toList(),
        currentIndex: _tabIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _navigationViews = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        title: Text(appBarTitles[0]),
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.widgets),
        title: Text(appBarTitles[1]),
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        title: Text(appBarTitles[2]),
        backgroundColor: Colors.blue,
      ),

    ];
  }

  void initData() {
    //叠加的效果
    _body = IndexedStack(
        children: <Widget>[HomePage(), FuliListPage(), LoginPage()],
        index: _tabIndex,
    );

  }

}