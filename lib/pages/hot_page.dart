import 'package:flutter/material.dart';
import 'package:flutter_gankio/constant/constants.dart';
import 'package:flutter_gankio/pages/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HotPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new HotPageState();
  }
}

class HotPageState extends State<HotPage>{

  List<String> list = ["all","Android","iOS","前端","拓展资源","福利","休息视频"];
  List<String> historyList;
  int _valueChoice = null;

  Future _getHistorys() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    historyList = sp.get(Constants.HISTORY_DATA);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getHistorys();
    if(historyList == null){
      historyList = List<String>();
    }
  }
g
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
              "搜索范围",
              style: TextStyle(color: Theme.of(context).accentColor, fontSize: 18.0))),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: List<Widget>.generate(    //自动生成Widget
                list.length,
                    (int index){
                  return _builtem(index);
                }
            ).toList(),
          ),
        )
      ],
    );
  }

  Widget _builtem(int position){
    return new ChoiceChip(
      selectedColor: Colors.blue,
        disabledColor: Colors.blue[100],
        onSelected: (bool selected){
          print("postion:${position}");
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return SearchPage(list[position]);
          }));
          setState(() {
            _valueChoice = selected ? position : null;
          });
        },
        selected: _valueChoice == position,
        label: Text(
          list[position],
          style: TextStyle(color: Colors.white),
        ));
  }

}