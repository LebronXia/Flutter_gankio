import 'package:flutter/material.dart';
import 'package:flutter_gankio/constant/constants.dart';
import 'package:flutter_gankio/pages/search_listpage.dart';

import 'hot_page.dart';

class SearchPage extends StatefulWidget {

  String searchStr;

  SearchPage(this.searchStr);

  @override
  State<StatefulWidget> createState() {
    return new SearchPageState(searchStr);
  }
}

class SearchPageState extends State<SearchPage>{

  //监听控制器
  TextEditingController _searchController = TextEditingController();
  String searchStr;
  SearchListPage _searchListPage;

  SearchPageState(this.searchStr);
  List<String> historyList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController(text: searchStr);
    _searchListPage = SearchListPage(ValueKey(_searchController.text));
   // _getHistorys();
    if(historyList == null){
      historyList = List<String>();
    }
  }


  void changeContent(){
    setState(() {
      _searchListPage = SearchListPage(ValueKey(_searchController.text));
    });
  }

//  static Future saveHistorys(List<String> list) async {
//    SharedPreferences sp = await SharedPreferences.getInstance();
//    await sp.setStringList(Constants.HISTORY_DATA, list);
//  }

//   Future _getHistorys() async{
//    SharedPreferences sp = await SharedPreferences.getInstance();
//    historyList = sp.get(Constants.HISTORY_DATA);
//  }

  @override
  Widget build(BuildContext context) {
    Widget widget = new Container(
      margin: const EdgeInsets.only(
          top:10.0,
      bottom: 10.0),
      padding: const EdgeInsets.only(
          left:8.0,
          right: 8.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(20.0)
      ),
      child: new Center(
        child: new TextFormField(
           style: TextStyle(fontSize: 15.0, color: Colors.blue),
            decoration: InputDecoration(
                hintText: "来不来",
                hintStyle: TextStyle(color: Colors.blue),
                border: InputBorder.none,
            ),
          controller: _searchController,
        )
      )
    );

//    TextField textField = TextField(
//      autofocus: true,
//      autocorrect: true,
//      style: TextStyle(fontSize: 15.0, color: Colors.white),
//      onChanged: (text){
//        print("change ${text}");
//      },
//      onSubmitted: (text){
//        print("submit ${text}");
//      },
//      decoration: InputDecoration(
//        hintText: "来不来",
//        hintStyle: TextStyle(color: Colors.white),
//        border: OutlineInputBorder(
//          borderRadius: BorderRadius.circular(20.0),
//          borderSide: BorderSide(color: Colors.green)
//        )
//      ),
//    );

    return Scaffold(
      appBar: AppBar(
        title: widget,
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
          margin: const EdgeInsets.only(
              right: 12.0),
          child: GestureDetector(
            child: Text(
              "搜索",
              style: TextStyle( fontSize: 16.0),
            ),
            onTap: (){
              changeContent();
              if(_searchController.text.isEmpty){
                  historyList.add(_searchController.text);
                 // saveHistorys(historyList);
              }
              //print("点击了搜索");

            },
          )
      )],
      ),
      body: new Center(
        child: (_searchController.text == null || _searchController.text.isEmpty)
        ? Center(
          child: HotPage(),
        ) : _searchListPage,
      )
    );
  }
}