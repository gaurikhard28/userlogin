import 'package:example/profile.dart';
import 'package:example/updateDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apiService.dart';

class profile_details extends StatefulWidget {

  const profile_details({ Datum? user,  Key? key}) : super(key: key);

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
  var reg=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  var regnum=RegExp("^[0-9]");
  var name, email,address,phone;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return SafeArea(

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.purpleAccent,
        appBar: AppBar(
          title: Text('Add Cases'),
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

                        if(_nameController.text.isEmpty)
                        {
                          scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Enter Name")));
                          return;
                        }

                        if(!reg.hasMatch(_EmailController.text)||_EmailController.text.isEmpty)
                        {
                          scaffoldMessenger.showSnackBar(SnackBar(content:Text("Enter Valid Email")));
                          return;}
                        if(_PhoneController.text.isEmpty||_PhoneController.text.length!=10||!regnum.hasMatch(_PhoneController.text))
                        {
                          scaffoldMessenger.showSnackBar(SnackBar(content:Text("Phone Number should be 10 digits")));
                          return;}
                        if(_AddressController.text.isEmpty)
                        {
                          scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Enter address")));
                          return;
                        }
                        if (_addFormKey.currentState!.validate()) {
                          _addFormKey.currentState!.save();
                          api.addUser(Datum(name: _nameController.text,
                            email: _EmailController.text,
                            phone: _PhoneController.text,
                            address: _AddressController.text,),
                             _loginToken,);
                          print(_PhoneController.text);
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
        onSaved: (val) {
          name = val!;
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
        onSaved: (val) {
          email = val!;
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

        onSaved: (val) {
          phone = val!;
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
        onSaved: (val) {
          address = val!;
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


