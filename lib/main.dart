import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'signup.dart';
import 'profile.dart';

void main() {
  runApp( MaterialApp(home: MyApp(),));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 void initState() {
   super.initState();
   getPref();
 }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


          routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => new login_page(),
          '/signup': (BuildContext context) => new signup(),
          '/profile': (BuildContext context) => new profile(),
          },
        home:(
      (_loginStatus==0)?profile():signup()
      )
    );
  }
  var _loginStatus=0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _loginStatus = preferences.getInt("status")!;


    });
}

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}


