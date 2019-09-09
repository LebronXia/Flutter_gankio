import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gankio/pages/search_page.dart';
import 'package:flutter_gankio/res/strings.dart';

import 'home_list_page.dart';

class _Page {
  final String lableId;

  _Page(this.lableId);

}

final List<_Page> allPages = <_Page>[
  new _Page(Ids.title_android),
  new _Page(Ids.title_ios),
  new _Page(Ids.title_qianduan),
  new _Page(Ids.title_tuozhanziyuan),
];

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'Tab1'),
    new Tab(text: 'Tab2'),
    new Tab(text: 'Tab3')
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: allPages.length);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
      length: allPages.length,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.orangeAccent,
          title: new TabBar(
            labelPadding: EdgeInsets.all(12.0),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: allPages.map((_Page page) => new Tab(text: page.lableId)).toList(),
            indicatorColor: Colors.white,),
        ),
        body: new TabBarViewLayout(),

        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.search),
            onPressed: (){
              Navigator.push(
                  context,
                  new CupertinoPageRoute<void>(
                      builder: (context){
                        return SearchPage("");
                      }
                  ));
            }
        ),
      ),

    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

}

class TabBarViewLayout extends StatelessWidget{


  Widget buildTabView(BuildContext context, _Page page){
      String labelId = page.lableId;
      return HomeListPage(labelId: labelId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new TabBarView(
        children: allPages.map((_Page page){
          return buildTabView(context, page);
        }).toList());
  }

}