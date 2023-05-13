import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/model/MLServiceData.dart';
import 'package:medilab_prokit/screens/MLAddToCartScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:medilab_prokit/utils/MLImage.dart';
import 'package:medilab_prokit/utils/MLString.dart';

import '../main.dart';

class MLHomeTopComponent extends StatefulWidget {
  static String tag = '/MLHomeTopComponent';

  @override
  _MLHomeTopComponentState createState() => _MLHomeTopComponentState();
}

class _MLHomeTopComponentState extends State<MLHomeTopComponent> {
  int counter = 2;
  List<MLServicesData> data = mlServiceDataList();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: context.width(),
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: Colors.indigo
        ,
        borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width, 80.0)),
      ),
      child: Column(
        children: [
          16.height,
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(child:
                  // Icon(Icons., color: white, size: 24),
                  Image.asset("images/person.png"),
                       radius: 22, backgroundColor: Colors.white),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hi "+sharedPref.getString("username")!.substring(2), style: boldTextStyle(color: whiteColor)),
                      4.height,
                      Text(mlWelcome!, style: secondaryTextStyle(color: white.withOpacity(0.7))),

                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  // Icon(Icons.search, color: white, size: 24),
                  10.width,
                  Stack(
                    children: [
                      Icon(Icons.logout, color: white, size: 24),

                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: Text("")
                      ),

                    ],
                  ).onTap(() {
                    Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => true);

                  }),
                ],
              )
            ],
          ).paddingOnly(right: 16.0, left: 16.0),
          Container(
            margin: EdgeInsets.only(right: 16.0, left: 16.0),
            transform: Matrix4.translationValues(0, 16.0, 0),
            alignment: Alignment.center,
            decoration: boxDecorationRoundedWithShadow(12, backgroundColor: context.cardColor),
            child: Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              spacing: 8.0,
              children: data.map(
                (e) {
                  return Container(
                    constraints: BoxConstraints(minWidth: context.width() * 0.25),
                    padding: EdgeInsets.only(top: 20, bottom: 20.0),
                    child: Column(
                      children: [
                        Image.asset(e.image!, width: 28, height: 25, fit: BoxFit.fill),
                        8.height,
                        Text(e.title.toString(), style: boldTextStyle(size: 12), textAlign: TextAlign.center),
                      ],
                    ),
                  ).onTap(
                    () {
                      e.widget.launch(context);
                    },
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
