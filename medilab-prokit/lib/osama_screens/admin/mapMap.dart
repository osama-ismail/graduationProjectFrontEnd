import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:medilab_prokit/osama_screens/app/notes/edit.dart';
import 'package:medilab_prokit/osama_screens/components/cardnote.dart';
import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../adminPages/controllers/MenuAppController.dart';
import '../../adminPages/screens/main/main_screen.dart';
import '../../main.dart';
import '../components/customtextform.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import '../components/cartShow3.dart';
import 'package:geocoding/geocoding.dart';
import '../leftMenu.dart';
class MapMap extends StatefulWidget {
  MapMap({Key? key}) : super(key: key);

  @override
  State<MapMap> createState() => OrderState();
}

class OrderState extends State<MapMap> {
  Set<Marker> uumarker = {};

  final CameraPosition _kGooglePlex2 = CameraPosition(
    target: LatLng(double.parse(sharedPref.getString("lon")!), double.parse(sharedPref.getString("lat")!)),    zoom: 1.4746,
  );
  CameraPosition? _kGooglePlex;

  @override
  void initState() {
    sharedPref.setString("istick","1");

    getLocation1();
    getLanAndLongs();
    super.initState();
  }
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

  Completer<GoogleMapController> _controller = Completer();

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
    double.parse(sharedPref.getString("lon")!), double.parse(sharedPref.getString("lat")!)
    )
    )
    );
    // uumarker.add(Marker(markerId: MarkerId('1'), position: LatLng(
    //     38.42796133580664, 36.085749655962
    // )
    // )
    // );
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    Future<void> _sendDataToServer() async {
      final body = json.encode({
        'id': sharedPref.getString("id")!,
        'name': sharedPref.getString("username")!,
        'password': sharedPref.getString("password")!,
        'email': sharedPref.getString("email")!,
        'address': sharedPref.getString("address")!,
        'longitude': l1.toString(),
        'latitude': l2.toString(),
        'phone': "0599"

      });
      final headers = {'Content-Type': 'application/json'};

      final response = await http.post(
        Uri.parse(linkIp+"/admin/addNewPatient"),
        headers: headers,
        body: body,
      );
      print(response.statusCode);
    }




    return Scaffold(
        appBar: AppBar(
          leading:sharedPref.getString("username")!.startsWith("d")? IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              if(sharedPref.getString("username")!.startsWith("d")
              ){
                print("ali");
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (context) => MenuAppController(),
                          ),
                        ],
                        child: MainScreen(),
                      );
                    },
                  ),
                      (Route<dynamic> route) => false,
                );}
              else{
                Navigator.of(context).pushNamedAndRemoveUntil("homePage", (route) => true);

              }
            },
          ):null,
          title: Text('Your App'),
        ),
      body: Container(

          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                child: Column(children: [
            SizedBox(
            height: 10,
          ),
        CustTextFormSign(
            hint: "enter the status of the order",
            mycontroller: title,

            valid: (val) {
            }),
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
            _kGooglePlex2!,
            onTap: (latlng) {
              uumarker.removeWhere((marker) => marker.markerId.value == '3');
              print(latlng);
              uumarker.remove(Marker(markerId: MarkerId("3")));
              l1 = latlng.latitude;
              l2 = latlng.longitude;
              uumarker.add(Marker(
                markerId: MarkerId('3'),
                position: LatLng(l1, l2),
              ));

              setState(() {
                // Update the state variables synchronously inside setState()
              });

              // Perform the asynchronous work outside of setState()
              _sendDataToServer();
            }   ,
            onMapCreated: (GoogleMapController
            controller) {
              _controller.complete(controller);
            },
          ),
          height: 300,
          width: 400,
        ),

        ]
                )

          )]),
    ));
  }
}
