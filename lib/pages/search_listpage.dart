
import 'package:flutter/material.dart';
import 'package:flutter_gankio/http/HttpUtil.dart';
import 'package:flutter_gankio/http/api.dart';
import 'package:flutter_gankio/item/home_item.dart';

class SearchListPage extends StatefulWidget{

  String searchStr;

  SearchListPage(ValueKey<String> key) : super(key : key){
    this.searchStr = key.value.toString();
  }


  @override
  State<StatefulWidget> createState() {
    return new SearchListPageState();
  }
}

class SearchListPageState extends State<SearchListPage>{

  var curPage = 1;
  int listTotalSize = 0;
  List listData = List();
  ScrollController _contraller =  ScrollController();

  @override
  void initState() {
    super.initState();
    _contraller.addListener((){
      var maxScroll = _contraller.position.maxScrollExtent;
      var pixels = _contraller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        _queryData();
      }
    });

    _queryData();
  }

  Future<Null> pullToRefresh() async{
    curPage = 0;
    _queryData();
    return null;
  }

  void _queryData(){
    String url = Api.QUERYDATA;
    url = url + "${widget.searchStr}/count/10/page/${curPage}";
    HttpUtil.get(url, (data){
        if(data != null){
          setState(() {
            List list1 = List();
            if(curPage == 0){
              listData.clear();
            }

            curPage ++;
            listTotalSize = 10 * curPage;
            list1.addAll(listData);
            list1.addAll(data);
            listData = list1;
          });

        }
    });

  }

  @override
  void dispose() {
    super.dispose();
    _contraller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(listData == null || listData.isEmpty){
      return new Center(
        child: CircularProgressIndicator(),
      );
    } else {
      Widget listView = ListView.builder(
          itemCount: listData.length,
          controller: _contraller,
          itemBuilder: (context, i) => itemWidget(context, i));
      return RefreshIndicator(
          child: listView,
          onRefresh: pullToRefresh);
    }
  }

  //listview加载那个个组件
  Widget itemWidget(BuildContext context, int position){
    var itemData = listData[position];
    return HomeItem(itemData);
  }

}