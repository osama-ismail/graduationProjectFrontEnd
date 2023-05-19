import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/model/MLDepartmentData.dart';
import 'package:medilab_prokit/model/MLTopHospitalData.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:medilab_prokit/utils/MLString.dart';
import 'package:http/http.dart' as http;

import '../osama_screens/constant/linkapi.dart';

class MLHomeBottomComponent extends StatefulWidget {
  static String tag = '/MLHomeBottomComponent';

  @override
  MLHomeBottomComponentState createState() => MLHomeBottomComponentState();
}

class MLHomeBottomComponentState extends State<MLHomeBottomComponent> {
  List<MLDepartmentData> departmentList = mlDepartmentDataList();
  var response=null;
  List<Map<String, dynamic>> oo = [];
  bool isLoading = true;

  List<MLTopHospitalData> tophospitalList = mlTopHospitalDataList();
  @override
  void initState() {
    super.initState();
     getAllServices();

  }

  getAllServices() async {
    var response = await http.get(Uri.parse(linkIp + "/admin/getAllServices"));
    if (response.statusCode == 200) {
      var responseBody = response.body;
      var decodedData = jsonDecode(responseBody);

      if (decodedData is List) {
        setState(() {
          oo = List<Map<String, dynamic>>.from(decodedData.map((item) => item as Map<String, dynamic>));
          isLoading = false;

        });
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        8.height,
        Row(
          children: [
            Text(mlDepartment!, style: boldTextStyle(size: 18)).expand(),
            Text(mlView_all!, style: secondaryTextStyle(color: mlColorBlue)),
            4.width,
            Icon(Icons.keyboard_arrow_right, color: mlColorBlue, size: 16),
          ],
        ).paddingOnly(left: 16, right: 16),
        10.height,
        // oo.length==0? // Display a loading indicator if data is still loading
        //
        // Center(child: CircularProgressIndicator()):
        HorizontalList(
          padding: EdgeInsets.only(right: 16.0, left: 8.0),
          wrapAlignment: WrapAlignment.spaceEvenly,
          itemCount: oo.length,
          itemBuilder: (BuildContext context, int index) {
            print(oo);
            // print("leen");
            // print(jsonDecode(oo)[index]['name']);

            return Container(
              margin: EdgeInsets.only(top: 8, bottom: 8, left: 8),
              padding: EdgeInsets.all(10),
              decoration: boxDecorationRoundedWithShadow(12, backgroundColor: context.cardColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    (departmentList[index].image).validate(),
                    height: 80,
                    width: 80,
                    fit: BoxFit.fill,
                  ).paddingAll(8.0),
                  // Text(oo[index]['name'] != null ? oo[index]['name'] : "dep1", style: boldTextStyle()),
                  Text(oo[index]['name']!, style: boldTextStyle()),

                  4.height,
                  Text((departmentList[index].subtitle).validate(), style: secondaryTextStyle()),
                  8.height,
                ],
              ),
            );
          },
        ),


        Row(
          children: [
            Text(mlTop_hospital!, style: boldTextStyle(size: 18)).expand(),
            Text(mlView_all!, style: secondaryTextStyle(color: mlColorBlue)),
            4.width,
            Icon(Icons.keyboard_arrow_right, color: mlColorBlue, size: 16),
          ],
        ).paddingAll(16.0),
        HorizontalList(
          padding: EdgeInsets.only(right: 16.0, left: 8.0),
          wrapAlignment: WrapAlignment.spaceBetween,
          itemCount: tophospitalList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(bottom: 8, left: 8),
              decoration: boxDecorationRoundedWithShadow(12, backgroundColor: context.cardColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonCachedNetworkImage(
                    (tophospitalList[index].image).validate(),
                    height: 140,
                    width: 250,
                    fit: BoxFit.fill,
                  ).cornerRadiusWithClipRRectOnly(topLeft: 8, topRight: 8),
                  8.height,
                  Text((tophospitalList[index].title).validate(), style: boldTextStyle()).paddingOnly(left: 8.0),
                  4.height,
                  Text((tophospitalList[index].subtitle).validate(), style: secondaryTextStyle()).paddingOnly(left: 8.0),
                  10.height
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
