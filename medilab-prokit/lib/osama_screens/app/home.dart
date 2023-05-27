import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
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
import 'items.dart';
import 'package:medilab_prokit/osama_screens/Sample .dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  bool isLoading = false;

  getNotes() async {
    var response = await http.get(Uri.parse(linkIp + "/admin/getAlllPatients"));
    var responseBody = jsonDecode(response.body);
    // print("responseBody");
    //
    // print(responseBody);

    return responseBody;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("Home"),
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
                  FutureBuilder(
                      future: getNotes(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          var responseData = snapshot.data;

                          // if (snapshot.data['status'] == 'fail') {
                          //   return Center(
                          //       child: Text("there is no categories",
                          //           style: TextStyle(fontSize: 20)));
                          // }
                          print(responseData.length);
                          return ListView.builder(
                            itemCount: responseData.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              if (i == 0) {
                                return Column(
                                  children: [
                                    // CardProfile(
                                    //     content: "profile",
                                    //     title: "Edit my",
                                    //     ontap: () {
                                    //       Navigator.of(context).push(
                                    //           MaterialPageRoute(
                                    //               builder: (context) => Profile(
                                    //                   notes: snapshot
                                    //                       .data['data'][i])));
                                    //     }),
                                    CardNotes(
                                        content:
                                            "${snapshot.data[i]['name']}",
                                        title:
                                            "${snapshot.data[i]['email']}",
                                        image:"${snapshot.data[i]['address']}",
                                        ontap: () {
                                          // print(snapshot.data['data'][i]['id'].toString());
                                          sharedPref.setString(
                                              "id_category",
                                              snapshot.data[i]['id']
                                                  .toString());
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Item()));
                                        }),
                                  ],
                                );
                                // i--;
                              }
                              return CardNotes(
                                  image:"${snapshot.data[i]['address']}",
                                  content:
                                      "${snapshot.data[i]['name']}",
                                  title: "${snapshot.data[i]['address']}",
                                  ontap: () {
                                    sharedPref.setString(
                                        "id_category",
                                        snapshot.data[i]['id']
                                            .toString());
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Item()));
                                    // print(snapshot.data['data'][i]['id'].toString());
                                  });

                            },
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                        }
                        return Center(child: Text("loading.."));
                      })
                  // CardNotes(content:"test",title:"se",ontap:(){}),
                ],
              )

              ),
    );
  }
}
