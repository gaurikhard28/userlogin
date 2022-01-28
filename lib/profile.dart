import 'package:example/profile_details.dart';
import 'package:example/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class profile extends StatefulWidget {


 profile({Key? key }) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.amber,
        leading: InkWell(child: Icon(Icons.compare_arrows),onTap: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.clear();
          Navigator.pushReplacementNamed(context, "/login");
        },),

        title: Text("",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) => const profile_details()), (
                  Route<dynamic> route) => false);
            },
            icon: const Icon(Icons.person_add_rounded,
              color: Colors.white,),
          ),
          FlatButton(
            onPressed: () {

              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) => const signup()), (
                  Route<dynamic> route) => false);
            },
            child: const Text("Log Out", style: TextStyle(color: Colors.white),),
          ),],
      ),
      body: Container(
        color: Colors.white,
        child: ListTile(

          leading: Icon(
         Icons.person, color: Colors.amberAccent,),
    title: Text("User1",style: TextStyle(
    fontSize: 20,
    color: Colors.amberAccent,
    fontWeight: FontWeight.bold,
    ), ),
    trailing: Icon(
    Icons.edit, color: Colors.amberAccent,),




    ),


      ),
    );
  }
}
