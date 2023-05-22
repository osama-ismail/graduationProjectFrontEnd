import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medilab_prokit/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/utils/MLColors.dart';

import 'MLScheduleAppointmentComponent.dart';

import '../osama_screens/constant/linkapi.dart';
import 'package:http/http.dart' as http;
class MLCalenderComponent extends StatefulWidget {
  static String tag = '/MLCalenderComponent';

  @override
  MLCalenderComponentState createState() => MLCalenderComponentState();
}

class MLCalenderComponentState extends State<MLCalenderComponent> {
  DateTime selectedDate = DateTime.now();

  int currentDateSelectedIndex = sharedPref.getString("day")==null? 0 :int.parse(sharedPref.getString("day")!) ;
  ScrollController scrollController = ScrollController();
  var response=null;
  List<Map<String, dynamic>> oo = [];
  bool isLoading = true;
  List<String> listOfMonths = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  getAllServices() async {

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
      height: 80,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 0);
        },
        itemCount: 365,
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 70,
            width: 60,
            alignment: Alignment.center,
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: currentDateSelectedIndex == index
                  ? mlColorBlue
                  : appStore.isDarkModeOn
                      ? scaffoldDarkColor
                      : white,
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(
                builder: (context) {
                 // print(DateTime.now().add(Duration(days: index)).day.toString());
                  return SizedBox(); // Replace SizedBox with your desired widget
          },
          ),

                sharedPref.getString("day")== DateTime.now().add(Duration(days: index)).day.toString()? Text(
                  listOfDays[DateTime.now().add(Duration(days: index)).weekday - 1].toString(),
                  style: secondaryTextStyle(size: 16, color: currentDateSelectedIndex == index ? Colors.red : mlColorBlue),
                ):Text(
                  listOfDays[DateTime.now().add(Duration(days: index)).weekday - 1].toString(),
                  style: secondaryTextStyle(size: 16, color: currentDateSelectedIndex == index ? Colors.red : mlColorBlue),
                ),
                4.height,
                Text(
                  DateTime.now().add(Duration(days: index)).day.toString(),
                  style: boldTextStyle(
                      size: 22,
                      color: currentDateSelectedIndex == index
                          ? white
                          : appStore.isDarkModeOn
                              ? white
                              : black),
                ),
                4.height,
              ],
            ),
          ).paddingLeft(8.0).onTap(
            () {
              setState(
                () {
                  currentDateSelectedIndex = index;
                  selectedDate = DateTime.now().add(Duration(days: index));
                  sharedPref.setString("date",selectedDate.toString());
                  sharedPref.setString("day",selectedDate.day.toString());
                  // print(selectedDate.day.toString());
                  finish(context);
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (builder) {
                      return MLScheduleApoointmentSheet();
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
