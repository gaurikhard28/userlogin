
import 'dart:convert';
import 'package:example/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile.dart';
import 'package:http/http.dart'as http;
import 'package:example/profile.dart';


class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {

  late String phone, password, name;
  final _formKey = GlobalKey<FormState>();
  bool isLoading=false;
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger ;
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();


    @override
    Widget build(BuildContext context) {

        scaffoldMessenger = ScaffoldMessenger.of(context);

      return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: const Text(" Sign Up ",
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
                child:

                  Column(
                    children: [


              ContactField(),
              SizedBox(
                height: 20,
              ),
              PasswordField(),
              SizedBox(
                height: 20,
              ),
              NameField(),
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
                                onPressed: () async {
                                      if(isLoading)
                                         {
                                        return;
                                           }
                                         if(_nameController.text.isEmpty)
                                          {
                                           scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Enter Name")));
                                               return;
                                             }
                                         if(_passwordController.text.isEmpty)
                                          {
                                             scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Enter Password")));
                                                 return;
                                               }
                                            signup(_nameController.text,_contactController.text,_passwordController.text);
                                           },



                                style: ElevatedButton.styleFrom(
                                  primary: Colors.purpleAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),

                                child: const Text(" Sign In ",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),

                              ),
                            ),

                          Positioned(child: (isLoading)?Center(child: Container(height:26,width: 26,child: CircularProgressIndicator(backgroundColor: Colors.black,))):Container(),right: 30,bottom: 0,top: 0,)

                        ],
                      ),

                    ],
                  ),
              ),
              Container(
                height: 80,
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 20),
                width: 364,
                child:
                Center(
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, "/login");

                    },
                    child: const Text(" Log In ? ",
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
          onSaved: (val) {
            password = val!;
          },
        ),
      );
    }
    Widget NameField(){
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(

          decoration: InputDecoration(labelText: 'Name',
              labelStyle: TextStyle(color: Colors.purpleAccent)),
          controller: _nameController,
          onSaved: (val) {
            name = val!;
          },
        ),
      );
    }
  signup(name,contact ,password) async
  {
    setState(() {
      isLoading = true;
    });
    print("Calling");

    Map data = {
      "contact":contact ,
      "password": password,
      "name": "$name"
    };
    print(data);
    final response = await http.post(
        Uri.parse("https://sandbox.9930i.com/central/register"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },


        body: data,
        encoding: Encoding.getByName("utf-8")
    );
 print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> resposne = jsonDecode(response.body);
      if (resposne['status'] == 0) {
        Map<String, dynamic>user = resposne['data'];
        print(" User name ${user['user_id']}");
        savePref(resposne['status'], user['name'], user['phone'], user['token']);
        Navigator.pushReplacementNamed(context, "/profile");

      } else {
        print("Already Registered");
      }
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text("Already Registered")));
    } else {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text("Please Try again")));
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

