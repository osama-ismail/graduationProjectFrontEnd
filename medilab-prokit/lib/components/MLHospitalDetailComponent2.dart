import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medilab_prokit/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/utils/MLColors.dart';

import '../osama_screens/constant/linkapi.dart';
import 'MLScheduleAppointmentComponent.dart';
import 'package:http/http.dart' as http;

class MLHospitalDetailComponent2 extends StatefulWidget {
  static String tag = '/MLHospitalDetailComponent';

  @override
  MLHospitalDetailComponentState createState() => MLHospitalDetailComponentState();
}

class MLHospitalDetailComponentState extends State<MLHospitalDetailComponent2> {
  String? hospitalName = sharedPref.getString("serviceName");
  String? hospitalCity = 'Central Hills';
  String? rating = '4.8 (456 Reviews)';

  @override
  void initState() {
    super.initState();
    getAllServices();
  }
  var response=null;
  List<Map<String, dynamic>> oo = [];
  bool isLoading = true;

  getAllServices() async {
    print(sharedPref.getString("serviceId")!);

    var response = await http.get(Uri.parse(
        linkIp + "/admin/getDoctorsOfService?id=" +
            sharedPref.getString("serviceId")!));
    if (response.statusCode == 200) {
      var responseBody = response.body;
      var decodedData = jsonDecode(responseBody);

      if (decodedData is List) {
        setState(() {
          oo = List<Map<String, dynamic>>.from(
              decodedData.map((item) => item as Map<String, dynamic>));
          isLoading = false;
        });
      }
      sharedPref.setString("doctorName", oo[0]["name"].substring(2));
      sharedPref.setString("doctorName", oo[0]["name"].substring(2));

    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget mOption(var value, var heading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(child: Icon(Icons.home, color: mlColorBlue, size: 18).paddingRight(4)),
                TextSpan(text: value, style: primaryTextStyle()),
              ],
            ),
          ),
          Text(heading, style: secondaryTextStyle(size: 16)),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      height: context.height(),
      color: appStore.isDarkModeOn ? blackColor : white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Text(sharedPref.getString("serviceName")!, style: boldTextStyle(size: 22)),
          8.height,
          Row(
            children: [
              RatingBarWidget(onRatingChanged: (v) {}, rating: 3.5, size: 18),
              Text(rating!, style: secondaryTextStyle()),
            ],
          ),
          // 16.height,
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: oo.length,
            itemBuilder: (context, index) {
              sharedPref.setString("doctorName",oo[index]["name"].substring(2));
              return Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                                  Container(
                    margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0,top: 10),
                    padding: EdgeInsets.all(10),
                    decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: mlColorBlue,
                      borderRadius: radius(10),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Doctor "+
                        oo[index]["name"].substring(2),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),

                    ),
                  ), // instead of background

                ],
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // mOption('34', 'Rooms'),
        Text(
          'Schedule appointment time',
          style: boldTextStyle(color: mlColorDarkBlue, decoration: TextDecoration.underline),
        )
      .paddingOnly(right: 16, bottom: 1).onTap(
            () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (builder) {
              return MLScheduleApoointmentSheet();
            },
          );
        },
      )            ],
          ),
          Divider(height: 0.5),
          Text('Information', style: boldTextStyle()),
          16.height,
          Text('Location', style: boldTextStyle(color: mlColorBlue)),
          8.height,
          Container(
            padding: EdgeInsets.all(4.0),
            decoration: boxDecorationWithRoundedCorners(
              border: Border.all(color: Colors.grey),
              backgroundColor: context.cardColor,
            ),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined, size: 20, color: Colors.grey),
                4.width,
                Text('35 St Martin\'s St West end', style: boldTextStyle(size: 14, color: Colors.grey)),
              ],
            ),
          ),
          16.height,
          Text('Other Information', style: boldTextStyle(color: mlColorBlue)),
          8.height,
          Text(
            'Doctors play a crucial role in diagnosing and treating illnesses and injuries. They conduct thorough examinations of patients to assess their medical condition and determine the underlying causes of their symptoms. Based on their findings, doctors arrive at '
                "accurate diagnoses, enabling them to develop appropriate treatment plans."

              "In addition to diagnosis, doctors may also perform surgical procedures to address various medical conditions. They possess the skills and expertise necessary to operate on patients, whether it involves a minor procedure or a complex surgery."
            ,
            style: secondaryTextStyle(size: 16),
            textAlign: TextAlign.justify,
          ),
          32.height,
        ],
      ),
    );
  }
}
