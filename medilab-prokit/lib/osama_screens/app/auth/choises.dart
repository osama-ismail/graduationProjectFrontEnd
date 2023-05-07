import 'package:medilab_prokit/osama_screens/app/notes/edit.dart';
import 'package:medilab_prokit/osama_screens/components/cardnote.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class Choises extends StatefulWidget {
  Choises({Key? key}) : super(key: key);

  @override
  State<Choises> createState() => ChoisesState();
}

class ChoisesState extends State<Choises> with Crud {
  bool isLoading = false;

  getNotes() async {
    var response =
    await postRequest(linkViewNotes, {"id": sharedPref.getString("id")});
    print("soas");
    print(response);
    print("soas");
    return response;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("choices"),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         sharedPref.clear();
        //         Navigator.of(context)
        //             .pushNamedAndRemoveUntil("login", (route) => false);
        //       },
        //       icon: Icon(Icons.exit_to_app))
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("choices");
        },
        child: Icon(Icons.add),
      ),
      body:
      // isLoading == true
      //     ? Center(child: CircularProgressIndicator())
      //     :
      Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              InkWell(
                child: Text("My profile"),
                onTap: () {
                  // .of(context).pushNamed("profile");
                },
              ),
              InkWell(
                child: Text("Products"),
                onTap: () {
                  Navigator.of(context).pushNamed("home");
                },
              ),
              // CardNotes(content:"test",title:"se",ontap:(){}),
            ],
          )

      ),
    );
  }
}
