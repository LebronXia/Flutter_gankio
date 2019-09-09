import 'package:flutter/material.dart';
import 'package:flutter_gankio/http/HttpUtil.dart';
import 'package:flutter_gankio/http/api.dart';
import 'package:flutter_gankio/item/home_item.dart';

class HomeListPage extends StatefulWidget{

  const HomeListPage({Key key, this.labelId}) : super(key: key);

  final String labelId;

  @override
  State<StatefulWidget> createState() {
    return HomeListPageState();
  }
}

class HomeListPageState extends State<HomeListPage>{

  List listData = List();
  var curPage = 1;
  var listTotalSize = 0;

  ScrollController scrollController = ScrollController();


  HomeListPageState(){

    scrollController.addListener((){
      var maxScroll = scrollController.position.maxScrollExtent;
      var pixels = scrollController.position.pixels;
      if(maxScroll == pixels && listData.length <= listTotalSize){
        debugPrint('滑动到了最底部了 ${pixels}');
        getData();
      }

    });
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
          controller: scrollController,
          itemBuilder: (context, i) => itemWidget(context, i));
      return RefreshIndicator(
          child: listView,
          onRefresh: pullToRefresh);
    }
  }

  @override
  void initState() {
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    //手动停止滑动监听
    scrollController.dispose();
  }

  Future<Null> pullToRefresh() async{
    curPage = 0;
    getData();
    return null;
  }

  void getData() {

    String url = Api.THEMEDATA;
    url = url + "${widget.labelId}/10/${curPage}";

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

  //listview加载那个个组件
  Widget itemWidget(BuildContext context, int position){
    var itemData = listData[position];
      return HomeItem(itemData);
  }

}