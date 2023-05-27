// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:medilab_prokit/osama_screens/app/notes/edit.dart';
// import 'package:medilab_prokit/osama_screens/components/cardnote.dart';
// import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:async';
// import '../../main.dart';
// import '../components/customtextform.dart';
// import 'package:medilab_prokit/osama_screens/components/crud.dart';
// import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
// import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
// import 'package:flutter/material.dart';
// import '../components/cartShow3.dart';
// import 'package:geocoding/geocoding.dart';
// import '../leftMenu.dart';
// class MapMap extends StatefulWidget {
//   MapMap({Key? key}) : super(key: key);
//
//   @override
//   State<MapMap> createState() => OrderState();
// }
//
// class OrderState extends State<MapMap> {
//   Set<Marker> uumarker = {};
//
//   final CameraPosition _kGooglePlex2 = CameraPosition(
//     target: LatLng(37.42796133580664, 35.085749655962),
//     zoom: 1.4746,
//   );
//   CameraPosition? _kGooglePlex;
//
//   @override
//   void initState() {
//     getLocation1();
//     getLanAndLongs();
//     super.initState();
//   }
//   bool isLoading = false;
//   // TextEditingController username = TextEditingController();
//   // username.text="";
//   var totalCount = 0;
//   var l1 = 0.0;
//   var l2 = 0.0;
//   var note="";
//   Position? cl;
//   var lat;
//   var lng;
//   TextEditingController title = TextEditingController();
//   Crud _crud = Crud();
//   var response;
//   Future getLocation1() async {
//     bool services;
//     LocationPermission per;
//     services = await Geolocator.isLocationServiceEnabled();
//     if (services == false) {
//       AwesomeDialog(
//           context: context,
//           title: "services",
//           body: Text("ervices not enables"))
//         ..show();
//     }
//     per = await Geolocator.checkPermission();
//     if (per == LocationPermission.denied) {
//       per = await Geolocator.requestPermission();
//     }
//     return per;
//   }
//
//   Completer<GoogleMapController> _controller = Completer();
//
//   Future<void> getLanAndLongs() async {
//     print("osama diab");
//     cl = await Geolocator.getCurrentPosition().then((value) => value);
//     lat = cl?.latitude;
//     lng = cl?.longitude;
//
//     print("lat");
//     print(lat);
//     print(lng);
//     // print(lng);
//     _kGooglePlex = CameraPosition(
//       target: LatLng(lat, lng),
//       zoom: 1,
//     );
//     uumarker.add(Marker(markerId: MarkerId('3'), position: LatLng(
//         37.42796133580664, 35.085749655962
//     )
//     )
//     );
//     uumarker.add(Marker(markerId: MarkerId('1'), position: LatLng(
//         38.42796133580664, 36.085749655962
//     )
//     )
//     );
//     setState(() {});
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           padding: EdgeInsets.all(10),
//           child: ListView(
//             children: [
//               Container(
//                 child: Column(children: [
//             SizedBox(
//             height: 10,
//           ),
//         CustTextFormSign(
//             hint: "enter the status of the order",
//             mycontroller: title,
//
//             valid: (val) {
//             }),
//         Text("please pin your location",
//             style: TextStyle(
//                 fontSize: 22,
//                 color: Colors.blue,
//                 fontWeight: FontWeight.w900)),
//         SizedBox(
//           height: 10,
//         ),
//         _kGooglePlex == null
//             ? CircularProgressIndicator()
//             : Container(
//           child: GoogleMap(
//             markers: uumarker,
//             mapType: MapType.normal,
//             initialCameraPosition:
//             _kGooglePlex2!,
//             onTap: (latlng) {
//
//               // print("delete");
//             },
//             onMapCreated: (GoogleMapController
//             controller) {
//               _controller.complete(controller);
//             },
//           ),
//           height: 300,
//           width: 400,
//         ),
//
//         ]
//                 )
//
//           )]),
//     ));
//   }
// }
