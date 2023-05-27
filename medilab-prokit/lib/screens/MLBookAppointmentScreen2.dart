import 'package:flutter/material.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/model/MLBookAppointmentData.dart';
import 'package:medilab_prokit/screens/MLAddPaymentScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:medilab_prokit/main.dart';

import '../components/MLBottomNavigationBarWidget.dart';
import '../fragments/MLCalendarFragment.dart';
import '../fragments/MLChatFragment.dart';
import '../fragments/MLHomeFragment.dart';

class MLBookAppointmentScreen2 extends StatefulWidget {
  static String tag = '/MLBookAppointmentScreen';
  final int? index;

  const MLBookAppointmentScreen2({Key? key, this.index}) : super(key: key);

  @override
  MLBookAppointmentScreenState createState() => MLBookAppointmentScreenState();
}

class MLBookAppointmentScreenState extends State<MLBookAppointmentScreen2> {
  int currentWidget = 0;
  List<MLBookAppointmentData> data = mlBookAppointmentDataList2();


  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    currentWidget = widget.index!;
    changeStatusColor(appStore.isDarkModeOn ? scaffoldDarkColor : white);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    changeStatusColor(mlPrimaryColor);
  }

  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalObjectKey<NavigatorState>(context);
    String titleNumber = data[currentWidget].id.validate();
    String titleText = data[currentWidget].title.validate();
    double progress = data[currentWidget].progress.validate();

    return WillPopScope(
      key: navigatorKey,
      onWillPop: () async {
        if (currentWidget != 0) {
          if (navigatorKey.currentState!.canPop()) {
            currentWidget--;
            setState(() {});
            navigatorKey.currentState!.pop();
            return false;
          }
          return true;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Container(
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topRight: 32),
                  backgroundColor: appStore.isDarkModeOn ? black : white,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[


                      ],
                    ).paddingAll(16.0),
                    8.height,

                    8.height,
                    data[currentWidget].widget.validate().expand(),
                  ],
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
}
