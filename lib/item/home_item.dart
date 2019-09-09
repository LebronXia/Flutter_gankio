import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gankio/pages/article_detail_page.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class HomeItem extends StatefulWidget{

  var itemData;

  HomeItem(var itemData){
    this.itemData = itemData;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ArticleItemState();
  }

}

class ArticleItemState extends State<HomeItem>{

    String formatDate(var dateString){

      DateTime date = DateTime.parse(dateString);

    return "${date.month + 1}月${date.day}日" ;
  }


    void itemClick(itemData) {
      Navigator.push(
          context,
          new CupertinoPageRoute<void>(
            builder: (context){
              return ArticleDetailPage(
                title: itemData["desc"],
                url: itemData["url"]
              );
            }
          ));

    }

  @override
  Widget build(BuildContext context) {

    Container rootitem = Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              //水平对齐
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.itemData["desc"],
                  style: TextStyle(color: Theme.of(context).accentColor,
                      fontSize: 16.0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      widget.itemData["who"],
                      style: TextStyle( fontSize: 12.0),
                    ),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Text(
                        formatDate(widget.itemData["publishedAt"]),
                        style: TextStyle( fontSize: 12.0),
                      ),
                    )

                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
    return Card(
      elevation: 4.0,
      child: InkWell(
        child: rootitem,
        onTap: (){
          itemClick(widget.itemData);
        },
      ),
    );
  }

}