import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:medilab_prokit/components/MLAppointmentDetailListComponent.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/screens/PurchaseMoreScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLString.dart';
import 'package:nb_utils/nb_utils.dart';

import '../osama_screens/constant/linkapi.dart';

class MLCalendarFragment extends StatefulWidget {
  static String tag = '/MLCalendarFragment';

  @override
  MLCalendarFragmentState createState() => MLCalendarFragmentState();
}

class MLCalendarFragmentState extends State<MLCalendarFragment> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> oo = [];
  bool isLoading = true;

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
          isLoading = false;
        });
      }


    }
  }

  @override
  void initState() {
    getAllServices();
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Column(
          children: [
            Row(
              children: [
                Text(mlMy_activity!, style: boldTextStyle(size: 20, color: white)).expand(),
                Text(mlHistory!, style: secondaryTextStyle(color: white)).paddingRight(8.0),
              ],
            ).paddingAll(16.0),
            8.width,
            Container(
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32),
                backgroundColor: appStore.isDarkModeOn ? black : white,
              ),
              child: Column(
                children: [
                  16.height,
                  TabBar(
                    controller: _tabController,
                    labelColor: mlColorBlue,
                    indicatorColor: mlColorBlue,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: primaryTextStyle(size: 14),
                    tabs: [
                      Tab(text: mlAppointment),

                    ],
                  ),
                  TabBarView(
                    controller: _tabController,
                    children: [
                      MLAppointmentDetailListComponent(),

                    ],
                  ).expand(),
                ],
              ),
            ).expand()
          ],
        ),
      ),
    );
  }
}
