import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medilab_prokit/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/model/MLAppointmentData.dart';
import 'package:medilab_prokit/screens/MLAppintmentDetailScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:medilab_prokit/utils/MLString.dart';

import '../osama_screens/constant/linkapi.dart';
import 'package:http/http.dart' as http;

class MLAppointmentDetailListComponent extends StatefulWidget {
  static String tag = '/MLAppointmentDetailListComponent';

  @override
  MLAppointmentDetailListComponentState createState() => MLAppointmentDetailListComponentState();
}

class MLAppointmentDetailListComponentState extends State<MLAppointmentDetailListComponent> {
  String? time = 'Today, 9:30 PM';
  List<MLAppointmentData> data = mlAppointmentDataList();
  List<Map<String, dynamic>> oo = [];

  getAllServices() async {

    var response = await http.get(Uri.parse(
        linkIp + "/patient/getMyServices?id=${sharedPref.getString("id")}"));
    if (response.statusCode == 200) {
      var responseBody = response.body;
      var decodedData = jsonDecode(responseBody);

      if (decodedData is List) {
        setState(() {
          oo = List<Map<String, dynamic>>.from(
              decodedData.map((item) => item as Map<String, dynamic>));
        });
      }


    }
  }
  @override
  void initState() {
    getAllServices();
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Column(
            children: oo.map(
              (e) {

                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: appStore.isDarkModeOn ? scaffoldDarkColor : Colors.grey.shade50,
                        borderRadius: radius(12),
                      ),
                      child: Column(
                        children: [
                          20.height,
                          Row(
                            children: [
                              Container(
                                height: 75,
                                width: 75,
                                decoration: boxDecorationWithRoundedCorners(
                                  backgroundColor: mlColorDarkBlue,
                                  borderRadius: radius(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(e['date'], style: boldTextStyle(size: 32, color: white)),
                                    Text("June", style: secondaryTextStyle(color: white)),
                                  ],
                                ),
                              ),
                              8.width,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(e['name'], style: boldTextStyle(size: 18)),
                                      8.height,
                                      Text(e['date'], style: secondaryTextStyle()),
                                      8.height,
                                      Text('Patient: ' + e['name'], style: secondaryTextStyle()),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.all(8.0),
                                    decoration: boxDecorationWithRoundedCorners(
                                      backgroundColor: Colors.transparent,
                                      borderRadius: radius(30),
                                      border: Border.all(color: Colors.grey.withOpacity(0.1)),
                                    ),
                                    child: Icon(
                                      Icons.notifications_none,
                                      color: e.toString() == 'General Care' ? mlColorBlue : Colors.grey.shade400,
                                      size: 24,
                                    ),
                                  ).paddingBottom(16.0)
                                ],
                              ).expand(),
                            ],
                          ).paddingOnly(right: 16.0, left: 16.0),
                          8.height,
                          Divider(thickness: 0.5),
                          8.height,
                          Row(
                            children: [
                              Text(e['time'], style: boldTextStyle(color: mlColorDarkBlue)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Text(mlAppointment_detail!, style: secondaryTextStyle(color: mlColorDarkBlue)),
                                  4.width,
                                  // Icon(Icons.arrow_forward, color: mlPrimaryColor, size: 16),
                                ],
                              ).onTap(
                                () {
                                  MLAppointmentDetailScreen().launch(context);
                                },
                              ).expand()
                            ],
                          ).paddingOnly(right: 16.0, left: 16.0),
                          16.height,
                        ],
                      ),
                    ).paddingBottom(16.0),
                    Positioned(
                      left: 16.0,
                      child: Container(
                        // padding: EdgeInsets.all(2.0),
                        // decoration: boxDecorationWithRoundedCorners(backgroundColor: mlColorDarkBlue, borderRadius: radius(20)),
                        // child: Text(
                        //   (e.toString()),
                        //   style: secondaryTextStyle(color: white),
                        // ).paddingOnly(right: 10.0, left: 10.0),
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
