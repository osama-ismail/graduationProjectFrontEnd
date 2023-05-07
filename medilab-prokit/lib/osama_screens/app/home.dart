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
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  bool isLoading = false;

  getNotes() async {
    var response =
        await postRequest(linkViewNotes, {"id": sharedPref.getString("id")});
    // print("soas");
    // print(response);
    // print("soas");
    return response;
  }

  getUser() async {
    print("wwwww");

    var response =
        await postRequest(linkViewNotes, {"id": sharedPref.getString("id")});

    return response;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("carts");
        },
        child: Icon(Icons.shopping_cart),

      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     children: [
      //       IconButton(
      //         icon: Icon(Icons.menu),
      //         onPressed: () {
      //           // Animate a bottom drawer
      //         },
      //       ),
      //       Spacer(),
      //       IconButton(icon: Icon(Icons.search), onPressed: () {}),
      //       IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
      //       IconButton(icon: Icon(Icons.home), onPressed: () {}),
      //     ],
      //   ),
      // ),

      body:
          // isLoading == true
          //     ? Center(child: CircularProgressIndicator())
          //     :
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
                                            "${snapshot.data['data'][i]['name']}",
                                        title:
                                            "${snapshot.data['data'][i]['price']}",
                                        image:"${snapshot.data['data'][i]['image']}",
                                        ontap: () {
                                          // print(snapshot.data['data'][i]['id'].toString());
                                          sharedPref.setString(
                                              "id_category",
                                              snapshot.data['data'][i]['id']
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
                                  image:"${snapshot.data['data'][i]['image']}",
                                  content:
                                      "${snapshot.data['data'][i]['name']}",
                                  title: "${snapshot.data['data'][i]['price']}",
                                  ontap: () {
                                    sharedPref.setString(
                                        "id_category",
                                        snapshot.data['data'][i]['id']
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
                          return Center(child: Text("loading.."));
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
