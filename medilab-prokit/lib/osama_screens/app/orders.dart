import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:medilab_prokit/osama_screens/app/notes/edit.dart';
import 'package:medilab_prokit/osama_screens/components/cardnote.dart';
import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import '../../main.dart';
import '../components/customtextform.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import './auth/profile.dart';
import 'showitem.dart';
import '../components/cartShow3.dart';
import 'package:geocoding/geocoding.dart';
import '../leftMenuUser.dart';
class Order extends StatefulWidget {
  Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => OrderState();
}

class OrderState extends State<Order> with Crud {
  bool isLoading = false;
  // TextEditingController username = TextEditingController();
  // username.text="";
  var totalCount = 0;
  var l1 = 0.0;
  var l2 = 0.0;
  var note="";
  Position? cl;
  var lat;
  var lng;
  CameraPosition? _kGooglePlex;
  TextEditingController title = TextEditingController();
  Crud _crud = Crud();
  var response;
  Future getLocation1() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      AwesomeDialog(
          context: context,
          title: "services",
          body: Text("ervices not enables"))
        ..show();
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    return per;
  }

  Future<void> getLanAndLongs() async {
    print("osama diab");
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl?.latitude;
    lng = cl?.longitude;

    print("lat");
    print(lat);
    print(lng);
    // print(lng);
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 1,
    );
    // uumarker.add(Marker(markerId: MarkerId('3'), position: LatLng(lat, lng)));

    setState(() {});
  }

  getorders() async {
     response =
        await postRequest(linkvieworders, {"id": sharedPref.getString("id")});
    print("osama ISMAIL");
    print(response);

    return response;
  }

  addorders() async {
    print("leen diab ");
    print(l2);
    // print(sharedPref.getString("id"));
  var  response1= await postRequest(linkAddorders, {
    "id_user": sharedPref.getString("id"),
        "lon":l2.toString(),
        "lan":l1.toString(),
        "note":title.text.toString(),
        "total_price":response['data'][0]['total'].toString()



  });


    var response3 = await _crud.postRequest(linkviewUser, {
        "id_user": sharedPref.getString("id"),

    });

    var response5 = await _crud.postRequest(linkviewId, {


    });
    // print("deema diab");
    // print(response3['data'].length);
    var response9;
      for(var i=0;i<response3['data'].length;i++){
      response9= await postRequest(linkaddDetails, {
          "id_order": response5['data']['id'].toString(),
        "id_item":response3['data'][i]['id_item'].toString() ,
        "count": response3['data'][i]['count'].toString(),

      });

      }
    // print("deema diab");
    // print(response9['status']);
    var response11 = await _crud.postRequest(linkdelete_cart, {
      "id_user":sharedPref.getString("id")
    });

    return response1;

  }

  @override
  void initState() {
    // print("osama order");
    getLocation1();
    getLanAndLongs();
    // title.text =sharedPref.getString("username")!;

    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> uumarker = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:NavBar() ,
      appBar: AppBar(
        title: Text("orders"),
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
              FutureBuilder(
                  future: getorders(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data['status'] == 'fail') {
                        return Center(
                            child: Text("there is no orders",
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
                                CartCard(
                                  () {
                                    sharedPref.setString(
                                        "id_item",
                                        snapshot.data['data'][i]['id']
                                            .toString());
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) => ShowItem()));
                                  },
                                  "${snapshot.data['data'][i]['sumCount']}",
                                  "${snapshot.data['data'][i]['name']}",
                                  "${snapshot.data['data'][i]['id']}",
                                  "${snapshot.data['data'][i]['total']}",
                                ),
                                Column(children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustTextFormSign(
                                      hint: "enter a note here",
                                      mycontroller: title,

                                      valid: (val) {
                                      }),
                                  // TextField(
                                  //   decoration: InputDecoration(
                                  //     border: OutlineInputBorder(),
                                  //     hintText: 'Enter a note for Admin',
                                  //   ),
                                  // ),
                                  Text("please pin your location",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w900)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _kGooglePlex == null
                                      ? CircularProgressIndicator()
                                      : Container(
                                          child: GoogleMap(
                                            markers: uumarker,
                                            mapType: MapType.normal,
                                            initialCameraPosition:
                                                _kGooglePlex!,
                                            onTap: (latlng) {

                                              uumarker.remove(Marker(
                                                  markerId: MarkerId("3")));
                                              uumarker.add(Marker(
                                                  markerId: MarkerId('3'),
                                                  position: latlng));
                                              l1 = latlng.latitude;
                                              l2 = latlng.longitude;
                                              print(latlng);

                                              setState(() {});
                                              // print("delete");
                                            },
                                            onMapCreated: (GoogleMapController
                                                controller) {
                                              _controller.complete(controller);
                                            },
                                          ),
                                          height: 300,
                                          width: 400,
                                        ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      // print("KK");
                                      addorders();
                                    },
                                    child: const Text('Buy'),
                                  ),
                                ]),
                              ],
                            );
                            // i--;
                          }
                          // totalCount+=int()snapshot.data['data'][i]['total']);
                          return
                              // Text("ASASASA");
                              CartCard(
                            () {
                              sharedPref.setString("id_item",
                                  snapshot.data['data'][i]['id'].toString());
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => ShowItem()));
                            },
                            "${snapshot.data['data'][i]['count']}",
                            "${snapshot.data['data'][i]['name']}",
                            "${snapshot.data['data'][i]['id']}",
                            "${snapshot.data['data'][i]['total']}",
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
            ],
          )),
    );
  }
}
