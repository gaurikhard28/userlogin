import 'package:example/profile.dart';
import 'package:example/userDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apiService.dart';

class profile_details extends StatefulWidget {

  const profile_details({ userDetails? user,  Key? key}) : super(key: key);

  @override
  _profile_detailsState createState() => _profile_detailsState();
}

class _profile_detailsState extends State<profile_details> {
  ApiService api = ApiService();
  void initState() {
    super.initState();
    getPref();
  }
  late ScaffoldMessengerState scaffoldMessenger ;
  final _addFormKey = GlobalKey<FormState>();
final _EmailController = TextEditingController();
  final _PhoneController = TextEditingController();
  final _AddressController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.purpleAccent,
        appBar: AppBar(
          title: Text('Edit Cases'),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),

          child: Container(
            color: Colors.white,
            child: Form(
              key: _addFormKey,
              child: Column(

                children: [
                  NameField(),
                  SizedBox(
                    height: 10,
                  ),
                  EmailField(),
                  SizedBox(
                    height: 10,
                  ),
                  PhoneField(),
                  SizedBox(
                    height: 10,
                  ),
                  AddressField(),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 25, right: 25),
                    width: 244,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_addFormKey.currentState!.validate()) {
                          _addFormKey.currentState!.save();
                          api.addUser(userDetails(name: _nameController.text,
                            address: _AddressController.text,
                            email: _EmailController.text,
                            phone: _PhoneController.text,
                            Authorization: _loginToken,));
                        }

                        Navigator.pop(context) ;
                        },
                        style:
                        ElevatedButton.styleFrom(
                          primary: Colors.purpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),

                        child:
                        const Text("Add User",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),

                    ),
                  ),
                ],
              ),
            )

          ),
        ),

      ),
    );
  }
  Widget NameField() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: TextFormField(

        decoration: const InputDecoration(labelText: 'Name',
            labelStyle: TextStyle(color: Colors.purpleAccent)),
        controller: _nameController,
    validator: (value){
    if (value!.isEmpty) {
    scaffoldMessenger.showSnackBar(
    const SnackBar(content: Text("Please enter name")));
    }
    return null;
  },
      ),
    );
  }
  Widget EmailField() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: TextFormField(

        decoration: const InputDecoration(labelText: 'Email',
        labelStyle: TextStyle(color: Colors.purpleAccent)),
        controller: _EmailController,
        validator: (value) {
          if (value!.isEmpty) {
            scaffoldMessenger.showSnackBar(
                const SnackBar(content: Text("Please enter email")));
          }
          return null;
        },

      ),
    );
  }
  Widget PhoneField() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: TextFormField(

        decoration: const InputDecoration(labelText: 'Phone' ,
            labelStyle: TextStyle(color: Colors.purpleAccent)),
        controller: _PhoneController,
    validator: (value){
    if (value!.isEmpty) {
    scaffoldMessenger.showSnackBar(
    const SnackBar(content: Text("Please enter phone")));
    }
    return null;
  },
      ),
    );
  }
  Widget AddressField() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: TextFormField(

        decoration: const InputDecoration(labelText: 'Address',
            labelStyle: TextStyle(color: Colors.purpleAccent)),
        controller: _AddressController,
    validator: (value){
    if (value!.isEmpty) {
    scaffoldMessenger.showSnackBar(
    const SnackBar(content: Text("Please enter address")));
    }
    return null;
  },
      ),
    );
  }
  var _loginToken="";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _loginToken= preferences.getString("token")!;
    });
  }
}


