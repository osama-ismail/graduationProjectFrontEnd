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
import '../components/cartShow3.dart';
import 'package:geocoding/geocoding.dart';
import '../leftMenu.dart';
class Map extends StatefulWidget {
  Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => OrderState();
}

class OrderState extends State<Map> with Crud {
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
    uumarker.add(Marker(markerId: MarkerId('3'), position: LatLng(
        double.parse(sharedPref.getString("order_lan")!)
      // lat,lng
        ,double.parse(sharedPref.getString("order_lon")!)
    )
    )
    );

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
    print(sharedPref.getString("user_status_id"));
print(title.text.toString()!);
    var response1 = await _crud.postRequest(addStatus, {
      "id":sharedPref.getString("user_status_id"),
      "his_status":title.text.toString()!
    });
print("jenin1");
    print(response1);

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


                                Column(children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustTextFormSign(
                                      hint: "enter the status of the order",
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
                                    child: const Text('save'),
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
