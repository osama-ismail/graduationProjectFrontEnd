import 'package:medilab_prokit/osama_screens/app/notes/edit.dart';
import 'package:medilab_prokit/osama_screens/components/cardnote.dart';
import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';

import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import './auth/profile.dart';

class ShowItem extends StatefulWidget {
  ShowItem({Key? key}) : super(key: key);

  @override
  State<ShowItem> createState() => ShowItemState();
  // ShowItemState createState() => ShowItemState();

}

class ShowItemState extends State<ShowItem> with Crud {
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

      // "id": widget.notes['notes_id'].toString(),
      // "imagename": widget.notes['notes_image'].toString(),
    });
    isLoading = false;
    setState(() {});
    // if (response['status'] == "success") {
    //   print("sdsdsd");
    //   Navigator.of(context).pushReplacementNamed("home");
    // } else {  print("sdsdsd");
    //   //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("carts");
        },
        child: Icon(Icons.shopping_cart),
      ),
      body: Container(
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
                                //               builder: (context) => Profile()));
                                //     }),
                                CardNotes(
                                    image:"${snapshot.data['data'][i]['image']}",
                                    content:
                                        "${snapshot.data['data'][i]['name']}",
                                    title:
                                        "${snapshot.data['data'][i]['price']}",
                                    ontap: () {}),
                                InkWell(
                                  child: Text("Add to cart"),
                                  onTap: () {
                                    future:
                                    AddToCart();
                                    // Navigator.of(context).pushNamed("signup");
                                  },
                                ),
                              ],
                            );
                            // i--;
                          }
                          return CardNotes(
                              image:"${snapshot.data['data'][i]['image']}",
                              content: "${snapshot.data['data'][i]['name']}",
                              title: "${snapshot.data['data'][i]['price']}",
                              ontap: () {});
                        },
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text("loading.."));
                    }
                    return Center(child: Text("loading.."));
                  })
            ],
          )),
    );
  }
}
