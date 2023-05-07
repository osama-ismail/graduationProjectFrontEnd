import 'package:medilab_prokit/osama_screens/app/notes/edit.dart';
import 'package:medilab_prokit/osama_screens/components/cardnote.dart';
import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';
import '../../main.dart';
import '../leftMenuUser.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import './auth/profile.dart';

class ShowRequests extends StatefulWidget {
  ShowRequests({Key? key}) : super(key: key);

  @override
  State<ShowRequests> createState() => ShowItemState();
  // ShowItemState createState() => ShowItemState();

}

class ShowItemState extends  State<ShowRequests> with Crud {
  bool isLoading = false;

  // var response=[];
var oo={"status": "success", "data": "in progress"};
  getStatus() async {

    // print( sharedPref.getString("his_status"));

    var response = await postRequest(viewStatus, {
      "id": sharedPref.getString("id"),

    });
    oo=response;
print(response);
// print( oo['status'].runtimeType);
  }

  @override
  void initState() {

    super.initState();
    print('osas');
    print(sharedPref.getString("image"));

    getStatus();
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

      body:
      Container(

          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Text("${oo['data']}"),
              FutureBuilder(
                  future: getStatus(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data['status'] == 'fail') {
                        return Center(
                            child: Text("there is no categories",
                                style: TextStyle(fontSize: 20)));
                      }
                      return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          if (i == 0) {
                            return Column(
                              children: [
                              ],
                            );
                            // i--;
                          }
                          return Text("osas");

                        },
                      );
                    }

                    return Center(child: Text(""));
                  })
              // CardNotes(content:"test",title:"se",ontap:(){}),
            ],
          )

      ),

      //  Container(
     //
     //
     // child :ListView.builder(
     //      children: [
     //      FutureBuilder(
     //          future: getStatus(),
     //          builder: (BuildContext context, AsyncSnapshot snapshot) {
     //            if (snapshot.hasData) {
     //              if (snapshot.data['status'] == 'fail') {
     //                return Center(
     //                    child: Text("there is no categories",
     //                        style: TextStyle(fontSize: 20)));
     //              }
     //              return ListView.builder(
     //                itemCount: snapshot.data['data'].length,
     //                shrinkWrap: true,
     //                physics: NeverScrollableScrollPhysics(),
     //                itemBuilder: (context, i) {
     //                  if (i == 0) {
     //                    return Column(
     //                      children: [
     //
     //
     //                      ],
     //                    );
     //                    // i--;
     //                  }
     //                  return Text("osama");
     //
     //                },
     //              );
     //            }

        // if(snapshot.connectionState == ConnectionState.waiting) {
        //           return Center(child: Text("loading.."));
        //         }
        //         return Center(child: Text("loading.."));
              // }
              // )]
     //    ),)
    );
  }

}
