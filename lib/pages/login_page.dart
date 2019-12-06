import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage>{

  TextEditingController _unameController = new TextEditingController();

  //保证全局唯一
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Form Test"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Form(
            key: _formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    controller: _unameController,
                    decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      icon: Icon(Icons.person)
                    ),
                  )
                ],
              )
          ),)
      ,
    );
  }

}