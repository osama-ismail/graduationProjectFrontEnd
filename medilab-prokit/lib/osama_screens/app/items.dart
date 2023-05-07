import 'package:medilab_prokit/osama_screens/app/notes/edit.dart';
import 'package:medilab_prokit/osama_screens/components/cardnote.dart';
import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';

import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import './auth/profile.dart';
import 'showitem.dart';
class Item extends StatefulWidget {
  Item({Key? key}) : super(key: key);

  @override
  State<Item> createState() => ItemState();
}

class ItemState extends State<Item> with Crud {
  bool isLoading = false;

  getNotes() async {
    var response = await postRequest(
        linkViewNotes2, {"id": sharedPref.getString("id_category")});
    // print("soas");
    // print(response);
    // print("soas");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("items"),
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

          Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  FutureBuilder(
                      future: getNotes(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data['status'] == 'fail') {
                            return Center(
                                child: Text("there is no items in this category",
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
                                    // CardProfile(
                                    //     content: "profile",
                                    //     title: "Edit my",
                                    //     ontap: () {
                                    //       Navigator.of(context).push(
                                    //           MaterialPageRoute(
                                    //               builder: (context) =>Profile() ));
                                    //     }),
                                    CardNotes(
                                      image:"${snapshot.data['data'][i]['image']}",
                                        content:
                                            "${snapshot.data['data'][i]['name']}",
                                        title:
                                            "${snapshot.data['data'][i]['price']}",
                                        ontap: () {
                                          sharedPref.setString(
                                              "id_item",
                                              snapshot.data['data'][i]['id']
                                                  .toString());
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>ShowItem() ));
                                        }

                                        ),
                                  ],
                                );
                                // i--;
                              }
                              return CardNotes(
                                  image:"${snapshot.data['data'][i]['image']}",
                                  content:
                                      "${snapshot.data['data'][i]['name']}",
                                  title: "${snapshot.data['data'][i]['price']}",

                                  ontap: () {
                                    sharedPref.setString("id_item", snapshot.data['data'][i]['id'].toString());
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ShowItem()));
                                    // print(snapshot.data['data'][i]['id'].toString());

                                  });

                            },
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: Text("loading.."));
                        }
                        return Center(child: Text("loading.."));
                      })
                ],
              )

              ),
    );
  }
}
