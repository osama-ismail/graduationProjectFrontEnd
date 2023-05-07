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
import '../components/cartShow2.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => CartState();
}

class CartState extends State<Cart> with Crud {
  bool isLoading = false;

  getNotes() async {
    var response =
        await postRequest(linkviewcart, {"id": sharedPref.getString("id")});
    // print("osama diab");
    print(response);
    print("response");

    return response;
  }

  buyOrder() async {
    Navigator.of(context).pushNamedAndRemoveUntil("orders", (route) => false);

    // print();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Carts"),
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
        child: Icon(Icons.shop),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              // Text("osa"),
              FutureBuilder(
                  future: getNotes(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data['status'] == 'fail') {
                        return Center(
                            child: Text("there is no items in your cart",
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
                                CardProfile(
                                    content: "profile",
                                    title: "Edit my",
                                    ontap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Profile()));
                                    }),
                                CartCard(
                                  () {
                                    sharedPref.setString(
                                        "id_item",
                                        snapshot.data['data'][i]['id']
                                            .toString());
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ShowItem()));
                                  },
                                  "${snapshot.data['data'][i]['price']}",
                                  "${snapshot.data['data'][i]['name']}",
                                  "${snapshot.data['data'][i]['id']}",
                                  "${snapshot.data['data'][i]['count']}",
                                ),
                              ],
                            );
                            // i--;
                          }
                          return CartCard(
                            () {
                              sharedPref.setString("id_item",
                                  snapshot.data['data'][i]['id'].toString());
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ShowItem()));
                            },
                            "${snapshot.data['data'][i]['price']}",
                            "${snapshot.data['data'][i]['name']}",
                            "${snapshot.data['data'][i]['id']}",
                            "${snapshot.data['data'][i]['count']}",
                          );
                        },
                      );
                      InkWell(
                        child: Text("update"),
                        onTap: () {
                          Navigator.of(context).pushNamed("osama");
                        },
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text("loading.."));
                    }
                    return Center(child: Text("loading.."));
                  }),
              // InkWell(
              //   child: Text("Next"),
              //   onTap: () {
              //     Navigator.of(context).pushNamed("orders");
              //   },
              // ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed("orders");
                  // print("KK");
                },
                child: const Text('Next'),
              ),
            ],
          )),
    );
  }
}
