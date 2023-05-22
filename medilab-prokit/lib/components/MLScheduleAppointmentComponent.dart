import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medilab_prokit/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/model/MLDoctorData.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'MLCalenderComponent.dart';

import '../osama_screens/constant/linkapi.dart';
import 'package:http/http.dart' as http;

class MLScheduleApoointmentSheet extends StatefulWidget {
  static String tag = '/MLScheduleApoointmentSheet';

  @override
  MLScheduleApoointmentSheetState createState() => MLScheduleApoointmentSheetState();
}

class MLScheduleApoointmentSheetState extends State<MLScheduleApoointmentSheet> {
  List<MLDoctorData> doctorDataList = mlDoctorListDataList();
  List<String?> time() {
    List<String?> list = [];
    list.add('8:00 AM - 9:00 AM');
    list.add('9:00 AM - 10:00 AM');
    list.add('10:00 AM - 11:00 AM');
    list.add('11:00 AM - 12:00 PM');
    list.add('1:00 PM - 2:00 PM');
    list.add('2:00 PM - 3:00 PM');
    list.add('3:00 PM - 4:00 PM');
    list.add('4:00 PM - 5:00 PM');
    return list;
  }

  int? selectedIndex = 0;
  String? selectedTime;
  var response=null;
  List<Map<String, dynamic>> oo = [];
  bool isLoading = true;

  getAllServices() async {
    var response = await http.get(Uri.parse(linkIp + "/patient/PatientAppointments?date="+sharedPref.getString("day")!+"&id="+sharedPref.getString("serviceId")!));
    if (response.statusCode == 200) {
      var responseBody = response.body;
      var decodedData = jsonDecode(responseBody);

      if (decodedData is List) {
        setState(() {
          oo = List<Map<String, dynamic>>.from(decodedData.map((item) => item as Map<String, dynamic>));
          isLoading = false;

        });
      }
      print("osama");
      oo.forEach((element) {print(element);});
      print("osama");

      // print(oo[0]["time"].toString().contains("9:00 AM - 10:00 AM"));
    }

  }
   onDelete(String time) async {
    var response = await http.get(Uri.parse(linkIp + "/patient/deletePatientAppointments?time="+time+"&date="+sharedPref.getString("day")!+"&service_patient="+sharedPref.getString("id")!));
    finish(context);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (builder) {
        return MLScheduleApoointmentSheet();
      },
    );

  }
  onAdd() async {
    final headers = {'Content-Type': 'application/json'};
    print("ayat");
    print(sharedPref.getString("day")!);

    final body = json.encode({
      'serviceId':sharedPref.getString("serviceId")!,
      'status':"2",
      "time" :sharedPref.getString("time")!,
      "date" :sharedPref.getString("day")!,
      'patient_id':sharedPref.getString("id")!,
      'service_patient':sharedPref.getString("id")!,
    });
    var response = await http.post(Uri.parse(linkIp + "/patient/addPatientAppointments"), headers: headers, body: body);
    print(response.statusCode);

    finish(context);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (builder) {
        return MLScheduleApoointmentSheet();
      },
    );

  }
  List<Widget> getWidgets() {
    List<Widget> widgets = [];

    // Iterate through each time in the time() list
    for (var e in time()) {
      // Check if the time exists in the oo objects
      bool isTimeInOo = oo.any((obj) => obj['time'] == e && obj['status'] == "1");
      bool isReserved = oo.any((obj) => obj['time'] == e && obj['service_patient'] == sharedPref.getString("id"));
      bool isReserved2 = oo.any((obj) => obj['time'] == e && obj['service_patient'] != sharedPref.getString("id") && obj['servicPatient'] != "0");
      bool isServicPatientMatch = oo.any((obj) => obj['service_patient'] == sharedPref.getString("id"));

      IconData icon;
      Color iconColor;
      icon = Icons.delete;
      iconColor = Colors.black;

      widgets.add(
        InkWell(
          onTap: () {
            setState(() {
              selectedTime = e;
              sharedPref.setString("time",e.toString() );
            });
            // print("osama");
            // print( e.validate());
            // onDelete();
            // Handle onTap event
          },
          child: Container(

            width: context.width() * 0.45,
            padding: EdgeInsets.all(8.0),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: isTimeInOo ? Colors.red : isReserved ? Colors.blue : isReserved2 ? Colors.red : selectedTime == e?mlColorDarkBlue : Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isReserved!=false && isTimeInOo!=true? GestureDetector(
                  onTap: () {
                    // print(e.validate());
                    print("leen");
                    print( e.validate());
                    onDelete(e.validate().toString());
                  },
                  child: Icon(
                    Icons.delete_forever,
                    size: 19,
                    color: iconColor,
                  ),
                ): Icon(
                  null,
                  size: 0,
                  color: iconColor,
                ),
                SizedBox(width: 8.0),
                Text(
                  e.validate(),
                  style: boldTextStyle(size: 14, color: isTimeInOo ? Colors.white : isReserved ? Colors.white : isReserved2 ?selectedTime == e? Colors.white : mlColorDarkBlue:Colors.black),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );

    }

    // widgets.add(Icon(
    //   Icons.add,
    //   size: 19,
    //   color: Colors.cyan,
    // ));
    return widgets;
  }
  @override
  void initState() {
    super.initState();
    getAllServices();
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
    return Container(
      height: context.height() * 0.90,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: appStore.isDarkModeOn ? blackColor : white,
              borderRadius: radiusOnly(topRight: 24, topLeft: 24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.close, color: Colors.blue).onTap(() {
                        finish(context);
                      }),
                    ).paddingOnly(right: 16.0, top: 16.0),
                    Row(
                      children: [
                        Container(
                          height: 54,
                          width: 54,
                          padding: EdgeInsets.only(top: 4.0),
                          decoration: boxDecorationWithRoundedCorners(
                            backgroundColor: mlColorCyan,
                            borderRadius: radius(12.0),
                          ),
                          child: Image.asset((doctorDataList[0].image).validate(), fit: BoxFit.fill),
                        ),
                        8.width,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text((doctorDataList[0].title).validate(), style: boldTextStyle(size: 18)),
                            8.height,
                            Row(
                              children: [
                                Text((doctorDataList[0].subtitle).validate(), style: secondaryTextStyle()),
                                8.width,
                                RatingBarWidget(onRatingChanged: (double rating) {}, size: 16, rating: 3.5),
                                4.width,
                                Text('4.8', style: secondaryTextStyle()),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ).paddingOnly(right: 16.0, left: 16.0),
                    16.height,
                    Divider(height: 0.5),
                    Row(
                      children: [
                        Text('Schedule', style: boldTextStyle()).expand(),
                        Row(
                          children: [
                            Text(sharedPref.getString("date")==null? DateTime.now().toString().split(' ')[0]:sharedPref.getString("date")!.split(' ')[0], style:
                            secondaryTextStyle(color: Colors.yellow,size: 24)),
                            Icon(Icons.arrow_drop_down_sharp, color: mlColorLightGrey),
                          ],
                        ),
                      ],
                    ).paddingAll(16.0),
                    MLCalenderComponent(),
                    Text('Visiting Hours', style: boldTextStyle()).paddingAll(16.0),
                    Wrap(
                      runSpacing: 8.0,
                      spacing: 8.0,
                      children:getWidgets()
                    ).center(),
                  ],
                ),
              ],
            ),
          ),
          AppButton(
            width: context.width(),
            color: mlPrimaryColor,
            onTap: () {
              onAdd();
            },
            child: Text('Add +', style: boldTextStyle(color: white), textAlign: TextAlign.center),
          ).paddingOnly(right: 16, left: 16, bottom: 16),
        ],
      ),
    );
  }
}
