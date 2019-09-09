import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ArticleDetailPage extends StatefulWidget{
  final String title;
  final String url;

  ArticleDetailPage({Key key, this.title, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ArticleDetailPageState();
  }
}

class ArticleDetailPageState extends State<ArticleDetailPage> {

  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /**
     * 监听web页结束状态
     */
    flutterWebviewPlugin.onDestroy.listen((_){
        Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: new Text(widget.title),
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }


}