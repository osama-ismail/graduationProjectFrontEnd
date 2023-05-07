import 'package:medilab_prokit/osama_screens/app/notes/edit.dart';
import 'package:medilab_prokit/osama_screens/components/cardnote.dart';
import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';
import '../../main.dart';
import '../leftMenuUser.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';

class ShowRequests extends StatefulWidget {
  ShowRequests({Key? key}) : super(key: key);

  @override
  State<ShowRequests> createState() => ShowItemState();
  // ShowItemState createState() => ShowItemState();

}

class ShowItemState extends State<ShowRequests> with Crud {
  bool isLoading = false;

  getNotes() async {
    var response = await postRequest(
        linkViewNotes3, {"id": sharedPref.getString("id_item")});
    // print("soas");
    // print(response);
    print("soas");
    return response;
  }

  AddToCart() async {
    isLoading = true;
    setState(() {});
    var response;

    response = await postRequest(linkaddtocart, {
      "id_user": sharedPref.getString("id"),
      "id_item": sharedPref.getString("id_item"),
      "count": "1",
    });
    isLoading = false;
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:NavBar() ,
      appBar: AppBar(

        title: Text("show item"),
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

      body: Container(
           child: Text("Your request is in progres"),
         ),
    );
  }
}
