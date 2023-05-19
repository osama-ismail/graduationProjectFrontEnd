import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medilab_prokit/model/MLDepartmentData.dart';
import 'package:medilab_prokit/screens/PurchaseMoreScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../osama_screens/constant/linkapi.dart';

class MLClinicVisitComponent extends StatefulWidget {
  @override
  MLClinicVisitComponentState createState() => MLClinicVisitComponentState();
}

class MLClinicVisitComponentState extends State<MLClinicVisitComponent> {
  static String tag = '/MLClinicVisitComponent';
  List<MLDepartmentData> departmentList = mlServiceListDataList();
  int? selectedIndex = 0;
  List<Map<String, dynamic>> oo = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getMyServices();
  }
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  getMyServices() async {
    var response = await http.get(Uri.parse(linkIp + "/patient/getMyServices?id="+sharedPref.getString("id")!));

    if (response.statusCode == 200) {
      var responseBody = response.body;
      var decodedData = jsonDecode(responseBody);

      if (decodedData is List) {
        setState(() {
          oo = List<Map<String, dynamic>>.from(decodedData.map((item) => item as Map<String, dynamic>));
          isLoading = false;

        });
      }
      print("OSAMA");
      print(oo);

    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          16.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Clinic Visit', style: boldTextStyle(size: 24)),
                  8.height,
                  Text('Find the service you are', style: secondaryTextStyle()),
                  16.height,
                ],
              ).expand(),
              mlRoundedIconContainer(Icons.search, mlColorBlue),
              16.width,
              mlRoundedIconContainer(Icons.calendar_view_day_outlined, mlColorBlue),
            ],
          ).paddingOnly(right: 16.0, left: 16.0),
          8.height,
          PurchaseMoreScreen().withHeight(context.height() * 0.7),
        ],
      ),
    );
  }
}
