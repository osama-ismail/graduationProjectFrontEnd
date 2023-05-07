// import 'package:ecommerce_osama/app/notes/edit.dart';
import 'package:medilab_prokit/osama_screens/components/cardnote.dart';
import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';
import '../../main.dart';
import '../leftMenu.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/osama_screens/Sample .dart';
import './category.dart';
class AdminHome extends StatefulWidget {
  AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _HomeState();
}

class _HomeState extends State<AdminHome> with Crud {
  bool isLoading = false;
  //
  // getNotes() async {
  //   var response =
  //       await postRequest(linkViewNotes, {"id": sharedPref.getString("id")});
  //   // print("soas");
  //   // print(response);
  //   // print("soas");
  //   return response;
  // }
  //
  // getUser() async {
  //   print("wwwww");
  //
  //   var response =
  //       await postRequest(linkViewNotes, {"id": sharedPref.getString("id")});
  //
  //   return response;
  // }

  @override
  Widget build(BuildContext context) {
    String? tt=sharedPref.getString("username");
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("admin"),
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("carts");
        },
        child: Icon(Icons.shopping_cart),

      ),


      body:
          // isLoading == true
          //     ? Center(child: CircularProgressIndicator())
          //     :
      Center(
       child: Text("hi ${tt!}",style:TextStyle(fontSize: 40),),
      )
    );
  }
}
