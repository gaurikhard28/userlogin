import 'package:example/profile_details.dart';
import 'package:example/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'userDetails.dart';


class profile extends StatefulWidget {


 profile({Key? key }) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  late final List<userDetails> users;
  void initState() {
    super.initState();
    getPref();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.purple,
        leading: InkWell(child: Icon(Icons.arrow_back_ios_sharp),onTap: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.clear();
          Navigator.pushReplacementNamed(context, "/login");
        },),

        title: Text(_loginName,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {

              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) => const signup()), (
                  Route<dynamic> route) => false);
            },
            child: const Text("Log Out", style: TextStyle(color: Colors.white),),
          ),],
      ),
      body: ListView.builder(
          itemCount: users == null ? 0 : users.length,
          itemBuilder: (BuildContext context, int index) {
          return Card(
          child: InkWell(
          onTap: ()
          {
            Navigator.push(
              context, MaterialPageRoute(
                builder: (context) => profile_details(users[index])),
            );},
            child:
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(users[index].name),
                        Text(users[index].email),
                        Text(users[index].phone),


                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () async {},
                    icon: const Icon(Icons.edit,
                      color: Colors.purpleAccent,),
                  ),
                  IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.delete, color: Colors.purpleAccent,
                    ),
                  ),
                ],
              ),
            ),

                  ),
          );
    }
    ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.person_add_rounded,
          color: Colors.white,),
      ),
    );
  }
  var _loginName="";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _loginName= preferences.getString("name")!;
    });
    }

  }

