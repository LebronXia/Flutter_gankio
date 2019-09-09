import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gankio/http/HttpUtil.dart';
import 'package:flutter_gankio/http/api.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FuliListPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FuliListPageState();
  }
}

class FuliListPageState extends State<FuliListPage>{

  List listData = List();

  bool isLoading = true;

  var curPage = 1;

  var listTotalSize = 0;

  ScrollController scrollController = ScrollController();

  FuliListPageState(){

    scrollController.addListener((){
      var maxScroll = scrollController.position.maxScrollExtent;
      var pixels = scrollController.position.pixels;
      if(maxScroll == pixels && listData.length <= listTotalSize){
        debugPrint('滑动到了最底部了 ${pixels}');
        getFuliData();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //请求网络无数据
    getFuliData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildImgScene();
  }

  void getFuliData(){
    String url = Api.THEMEDATA;
    url = url + "福利/10/${curPage}";

    HttpUtil.get(url, (data){
      if(data != null){
        
        this.setState((){

          List list = List();
          if(curPage == 0){
            listData.clear();
          }
          curPage ++;
          listTotalSize = 10 * curPage;
          list.addAll(listData);
          list.addAll(data);
          this.listData = list;
        });
      }
    });
  }


  @override
  void dispose() {
    //手动停止滑动监听
    scrollController.dispose();
  }

  Future<Null> pullToRefresh() async{
    curPage = 0;
    getFuliData();
    return null;
  }

  //构建布局
  Widget buildImgScene(){
    Widget scene = new StaggeredGridView.countBuilder(

      physics: BouncingScrollPhysics(),
      itemCount: this.listData != null ? this.listData.length : 0,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      crossAxisCount: 2,
      controller: scrollController,
      itemBuilder: (context, index){
        var item = this.listData[index];
        return new GestureDetector(

          onTapUp:(TapUpDetails detail){
            debugPrint("点击了图片~~~~~");
          },
          child: new Container(
            width: 100,
            height: 100,
            color: Color(0xFF2FC77D),
            child: new CachedNetworkImage(
                imageUrl: item["url"],
            fit: BoxFit.fill,
            placeholder: (context, index){
                  return new Center(child: new CupertinoActivityIndicator());
            })
          ),
        );
      },

      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(1, index.isEven ? 1.5 : 1),
    );
    return RefreshIndicator(
      child: scene,
      onRefresh: pullToRefresh,
    );
  }

}