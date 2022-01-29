import 'dart:convert';
import 'package:example/profile.dart';
import 'package:example/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile.dart';
import 'package:http/http.dart'as http;
import 'package:path/path.dart' as path;


class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String phone, password;
  bool isLoading=false;
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger ;


  @override
  Widget build(BuildContext context) {
    final formKey= GlobalKey<FormState>();
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:  [
            Center(
              child: Text(" Log In ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.purple,

                ),),
            ),
             SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child
                : Column(
                  children: [
                    ContactField(),
              SizedBox(
                height: 20,
              ),
              PasswordField(),
              SizedBox(
                height: 20,
              ),
                    Stack(
                      children: [

                           Container(
                            width: 300,
                            height: 80,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ElevatedButton(
                              onPressed: () async{

                                  if (isLoading) {
                                    return;
                                  }
                                  if (_contactController.text.isEmpty ||
                                      _passwordController.text.isEmpty) {

                                    scaffoldMessenger.showSnackBar(const SnackBar(
                                        content: Text(
                                            "Please Fill all fileds")));
                                    return;
                                  }
                                  login(_contactController.text,
                                      _passwordController.text);

                                },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.purpleAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),

                              child: const Text(" Login ",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),

                            ),
                            ),


                        Positioned(child: (isLoading)?Center(child: Container(height:26,width: 26,child: CircularProgressIndicator(backgroundColor: Colors.black,))):Container(),right: 30,bottom: 0,top: 0,)
                      ],),
                      ],
                    ),
    ),



            Container(
              height: 80,
              padding: EdgeInsets.only(left: 25, right: 25, bottom: 20),
              width: 364,
              child: Center(
                child: TextButton(
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, "/signup");

                  },
                  child: const Text(" Sign Up ? ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.purple,
                    ),),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
  Widget ContactField(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(

        decoration: InputDecoration(labelText: 'Phone',
            labelStyle: TextStyle(color: Colors.purpleAccent)),
        controller: _contactController,
        validator: (value)=>null,
        onSaved: (val) {
          phone = val!;
        },
      ),
    );

  }
  Widget PasswordField(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Password',
            labelStyle: TextStyle(color: Colors.purpleAccent)),
        controller: _passwordController,
        validator: (value)=>null,
        onSaved: (val) {
          password = val!;
        },
      ),
    );
  }

  login(contact,password) async
  {
    setState(() {
      isLoading = true;
    });
    Map data = {
      'contact': contact,
      'password': password
    };
    print(data.toString());
    final  response= await http.post(
        Uri.parse("https://sandbox.9930i.com/central/login"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8")
    )  ;
    setState(() {
      var isLoading=false;
    });
    print(response.body);
    if (response.statusCode == 200) {
      Map<String,dynamic> resposne=jsonDecode(response.body);
      if(resposne['status']==0)
      {
        Map<String,dynamic> user=resposne['data'];
        print(" Name ${user['user_id']}");
        savePref(resposne['status'],user['name'],user['phone'],user['token']);
        Navigator.pushReplacementNamed(context, "/profile");
      }else{
        print(" ${resposne['message']}");
      }
      scaffoldMessenger.showSnackBar(SnackBar(content:Text("${resposne['message']}")));

    } else {
      scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please try again!")));
    }


  }
  savePref(int status, String name, String phone, String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("status", status.toInt());
    preferences.setString("name", name);
    preferences.setString("phone", phone);
    preferences.setString("token", token);


  }

  }



