import 'package:medilab_prokit/osama_screens/app/notes/edit.dart';
import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';
import '../../main.dart';
import 'card.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import '../leftMenu.dart';
// import './auth/profile.dart';
// import 'showitem.dart';
class showOrdersDetails extends StatefulWidget {
  showOrdersDetails({Key? key}) : super(key: key);

  @override
  State<showOrdersDetails> createState() => ItemState();
}

class ItemState extends State<showOrdersDetails> with Crud {
  bool isLoading = false;

  getNotes() async {

    var response = await postRequest(viewAdmin1, {
      "id":sharedPref.getString("order_id"),
    },);
    print(sharedPref.getString("order_id"));
    print(response);
    print("ali 2");
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
                            child: Text("there is no orders for this user",
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
                                    "${snapshot.data['data'][i]['lon']}",
                                    content:
                                    "${snapshot.data['data'][i]['lan']}",
                                    title:
                                    "${snapshot.data['data'][i]['total_price']}",
                                    id_order:
                                    "${snapshot.data['data'][i]['id_item']}",
                                    count:
                                    "${snapshot.data['data'][i]['count']}",

                                    ontap: () async {
                                      sharedPref.setString("order_lon", snapshot.data['data'][i]['lon'].toString());
                                      sharedPref.setString("order_lan", snapshot.data['data'][i]['lan'].toString());
                                      sharedPref.setString("user_status_id", snapshot.data['data'][i]['id_user'].toString());

                                      sharedPref.setString("order_id", snapshot.data['data'][i]['id'].toString());
                                      // sharedPref.setString("order_id", snapshot.data['data'][i]['image'].toString());
                                      // sharedPref.setString("order_id", snapshot.data['data'][i]['price'].toString());
                                      // sharedPref.setString("order_id", snapshot.data['data'][i]['name'].toString());
                                      // sharedPref.setString("order_id", snapshot.data['data'][i]['des'].toString());
                                      setState(() {});
                                      // Navigator.of(context).pushNamedAndRemoveUntil("showOrdersDetails", (route) => false);
                                      Navigator.of(context).pushNamedAndRemoveUntil("Map", (route) => false);

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
                              image:
                              "${snapshot.data['data'][i]['lon']}",
                              content:
                              "${snapshot.data['data'][i]['lan']}",
                              title:
                              "${snapshot.data['data'][i]['total_price']}",
                              id_order:
                              "${snapshot.data['data'][i]['id_item']}",
                              count:
                              "${snapshot.data['data'][i]['count']}",
                              ontap: () async {
                                sharedPref.setString("order_lon", snapshot.data['data'][i]['lon'].toString());
                                sharedPref.setString("order_lan", snapshot.data['data'][i]['lan'].toString());
                                sharedPref.setString("user_status_id", snapshot.data['data'][i]['id_user'].toString());

                                sharedPref.setString("order_id", snapshot.data['data'][i]['id'].toString());
                                // sharedPref.setString("order_id", snapshot.data['data'][i]['image'].toString());
                                // sharedPref.setString("order_id", snapshot.data['data'][i]['price'].toString());
                                // sharedPref.setString("order_id", snapshot.data['data'][i]['name'].toString());
                                // sharedPref.setString("order_id", snapshot.data['data'][i]['des'].toString());
                                setState(() {});
                                // Navigator.of(context).pushNamedAndRemoveUntil("showOrdersDetails", (route) => false);
                                Navigator.of(context).pushNamedAndRemoveUntil("Map", (route) => false);

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
                  }),
              ElevatedButton(
                onPressed: () async {
                  // print("KK");
                  Navigator.of(context).pushNamedAndRemoveUntil("Map", (route) => false);

                },
                child: const Text('see the location for the user'),
              ),
            ],
          )),
    );
  }
}
