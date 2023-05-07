import 'package:medilab_prokit/osama_screens/app/notes/edit.dart';

import '../../main.dart';
import 'cardOrders.dart';
import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';

import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import 'orderDetails.dart';
// import './auth/profile.dart';
import '../leftMenu.dart';
import 'editItem.dart';

class ShowAllOrders extends StatefulWidget {
  ShowAllOrders({Key? key}) : super(key: key);

  @override
  State<ShowAllOrders> createState() => ItemState();
}

class ItemState extends State<ShowAllOrders> with Crud {
  bool isLoading = false;

  getNotes() async {
    var response = await postRequest(viewAllUser, {});
    print("leen diabn");
    print(response);
    // print("soas");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
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
          Navigator.of(context).pushNamed("adminAddItem");
        },
        child: Icon(Icons.add),
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
                                CardNotes(
                                    id: "${snapshot.data['data'][i]['id']}",
                                    image:
                                        "${snapshot.data['data'][i]['image']}",
                                    content:
                                        "${snapshot.data['data'][i]['username']}",
                                    title:
                                        "${snapshot.data['data'][i]['email']}",
                                    ontap: () async {
                                      sharedPref.setString("order_id", snapshot.data['data'][i]['id'].toString());

                                      // sharedPref.setString("id_item", snapshot.data['data'][i]['id'].toString());
                                      // sharedPref.setString("image_item", snapshot.data['data'][i]['image'].toString());
                                      // sharedPref.setString("price_item", snapshot.data['data'][i]['price'].toString());
                                      // sharedPref.setString("name_item", snapshot.data['data'][i]['name'].toString());
                                      // sharedPref.setString("des_item", snapshot.data['data'][i]['des'].toString());
                                      // Navigator.of(context).push(
                                      // MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         showOrdersDetails());
                                      Navigator.of(context).pushNamedAndRemoveUntil("showOrdersDetails", (route) => false);

                                      setState(() {});
                                      // Navigator.of(context).pushNamedAndRemoveUntil("AdminEditItem", (route) => false);

                                      // );
                                    }),
                              ],
                            );
                            // i--;
                          }
                          return CardNotes(
                              id: "${snapshot.data['data'][i]['id']}",
                              image: "${snapshot.data['data'][i]['image']}",
                              content:
                                  "${snapshot.data['data'][i]['username']}",
                              title: "${snapshot.data['data'][i]['email']}",
                              ontap: () async {
                                sharedPref.setString("order_id", snapshot.data['data'][i]['id'].toString());
                                // sharedPref.setString("order_id", snapshot.data['data'][i]['image'].toString());
                                // sharedPref.setString("order_id", snapshot.data['data'][i]['price'].toString());
                                // sharedPref.setString("order_id", snapshot.data['data'][i]['name'].toString());
                                // sharedPref.setString("order_id", snapshot.data['data'][i]['des'].toString());
                                setState(() {});
                                Navigator.of(context).pushNamedAndRemoveUntil("showOrdersDetails", (route) => false);

                                // MaterialPageRoute(
                                //     builder: (context) => showOrdersDetails());
                              });
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
