import 'package:example/profile_details.dart';
import 'package:example/signup.dart';
import 'package:example/updateDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'apiService.dart';
import 'editUser.dart';
import 'userDetails.dart';


class profile extends StatefulWidget {


 profile({Key? key }) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  late final List<userDetails>? users;
  late final List<Datum>? userupdate;
   ApiService api = ApiService();
  void initState() {
    super.initState();
    getPref();
  }
  

  @override
  Widget build(BuildContext context) {
    loadListWithId();
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
      body: FutureBuilder(
        
          future: loadListWithId(),
          builder: (context,snapshot) {
             if(snapshot.hasData) {
               return ListView.builder(
                   itemCount: userupdate == null ? 0 : userupdate!.length,
                   itemBuilder: (BuildContext context, int index) {
                     return Card(
                       child:
                       Padding(
                         padding: const EdgeInsets.all(8),
                         child: Row(
                           children: <Widget>[
                             Expanded(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Text(userupdate![index].name.toString()),
                                   Text(userupdate![index].email.toString()),
                                   Text(userupdate![index].phone.toString()),


                                 ],
                               ),
                             ),
                             IconButton(
                               onPressed: () async {
                                 await Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) =>
                                           editUser(userupdate![index].id.toString())),
                                 );
                               },
                               icon: const Icon(Icons.edit,
                                 color: Colors.purpleAccent,),
                             ),
                             IconButton(
                               onPressed: () {
                                 {
                                   String id;
                                   api.deleteUser(
                                       userupdate![index].id.toString(), _loginToken);
                                   Navigator.popUntil(
                                       context, ModalRoute.withName(
                                       Navigator.defaultRouteName));
                                 };
                               },
                               icon: const Icon(
                                 Icons.delete, color: Colors.purpleAccent,
                               ),
                             ),
                           ],
                         ),
                       ),


                     );
                   }
               );
             }
             else
               return Center(child: CircularProgressIndicator(backgroundColor: Colors.purpleAccent,));
                }
            ),



      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => profile_details()));
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.person_add_rounded,
          color: Colors.white,),
      ),
    );
  }

  Future loadListWithId()async {
    List<Datum> futureCases = await api.getUsersWithId(_loginToken);
    //setState(() {
    //  this.userupdate = userupdate;
    //});
    return futureCases;
  }

  var _loginName="";
  var _loginToken="";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _loginName= preferences.getString("name")!;
      _loginToken=preferences.getString("token")!;
    });
    }

  }

