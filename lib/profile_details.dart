import 'package:example/profile.dart';
import 'package:example/userDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profile_details extends StatefulWidget {

  const profile_details(userDetails user,  {Key? key}) : super(key: key);

  @override
  _profile_detailsState createState() => _profile_detailsState();
}

class _profile_detailsState extends State<profile_details> {

  void initState() {
    super.initState();
    getPref();
  }
final _EmailController = TextEditingController();
  final _PhoneController = TextEditingController();
  final _AddressController = TextEditingController();
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.purple,
        body: Padding(
          padding: const EdgeInsets.all(20.0),

          child: Container(
            color: Colors.white,
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
                      setState(() {

                      });
                      Navigator.of(context) .push(
                          MaterialPageRoute(builder: (context)=> profile())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),

                    child: const Text("Add User",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),

                  ),
                ),
              ],
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

        decoration: InputDecoration(labelText: 'Name',
            labelStyle: TextStyle(color: Colors.purpleAccent)),
        controller: _nameController,

      ),
    );
  }
  Widget EmailField() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: TextFormField(

        decoration: InputDecoration(labelText: 'Email',
        labelStyle: TextStyle(color: Colors.purpleAccent)),
        controller: _EmailController,

      ),
    );
  }
  Widget PhoneField() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: TextFormField(

        decoration: InputDecoration(labelText: 'Phone' ,
            labelStyle: TextStyle(color: Colors.purpleAccent)),
        controller: _PhoneController,

      ),
    );
  }
  Widget AddressField() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: TextFormField(

        decoration: InputDecoration(labelText: 'Address',
            labelStyle: TextStyle(color: Colors.purpleAccent)),
        controller: _AddressController,

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
