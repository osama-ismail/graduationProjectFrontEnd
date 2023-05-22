import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/model/MLTopHospitalData.dart';
import 'package:medilab_prokit/screens/MLHospitalDetailScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';

import '../main.dart';
import '../osama_screens/constant/linkapi.dart';
import 'package:http/http.dart' as http;

class MLHospitalListComponent extends StatefulWidget {
  static String tag = '/MLHospitalListComponent';

  @override
  MLHospitalListComponentState createState() => MLHospitalListComponentState();
}

class MLHospitalListComponentState extends State<MLHospitalListComponent> {
  double progressValue = 2.5;
  int? selectedIndex = 0;
  bool? liked = false;

  List<MLTopHospitalData> tophospitalList = mlHospitalListDataList();
  var response=null;
  List<Map<String, dynamic>> oo = [];
  bool isLoading = true;

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
  void initState() {
    super.initState();
    getAllServices();
  }


  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
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
                  Text('Find the Service you want', style: secondaryTextStyle()),
                  16.height,
                ],
              ).expand(),
              mlRoundedIconContainer(Icons.search, mlColorBlue),
              16.width,
              mlRoundedIconContainer(Icons.calendar_view_day_outlined, mlColorBlue),
            ],
          ).paddingOnly(right: 16.0, left: 16.0),
          8.height,
          ListView.builder(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 70),
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: oo.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(12.0),
                decoration: boxDecorationWithRoundedCorners(
                  border: Border.all(color: selectedIndex == index ? mlColorBlue : mlColorLightGrey100),
                  backgroundColor: context.cardColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: <Widget>[
                        Image.asset(
                          (tophospitalList[index].image).validate(),
                          width: double.infinity,
                          height: 150.0,
                          fit: BoxFit.fill,
                        ).cornerRadiusWithClipRRect(8.0),
                        Positioned(
                          top: 16.0,
                          right: 16.0,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: radius(24),
                            ),
                            child: liked == true && selectedIndex == index
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        liked = false;
                                      });
                                    },
                                    child: Icon(Icons.favorite, color: Colors.red, size: 16),
                                  )
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        liked = true;
                                      });
                                    },
                                    child: Icon(Icons.favorite_outline, color: Colors.grey, size: 16),
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 16.0,
                          right: 16.0,
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: mlColorDarkBlue,
                              borderRadius: radius(12),
                            ),
                            child: Text(
                              (tophospitalList[index].fees).validate(),
                              style: secondaryTextStyle(color: white),
                            ).paddingOnly(right: 8.0, left: 8.0),
                          ),
                        )
                      ],
                    ),
                    16.height,
                    Text((oo[index]['name']), style: boldTextStyle()),
                    8.height,
                    Text((oo[index]['name']), style: secondaryTextStyle()),
                    8.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.star, color: Colors.yellow).paddingRight(4),
                              ),
                              TextSpan(text: tophospitalList[index].rating, style: primaryTextStyle(color: Colors.grey.shade500)),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: 'Detail', style: primaryTextStyle(color: Colors.grey.shade500)),
                              WidgetSpan(
                                child: Icon(Icons.arrow_forward, color: mlColorDarkBlue, size: 16).paddingLeft(4),
                              ),
                            ],
                          ),
                        ).onTap((

                            ) {
                          sharedPref.setString("serviceName",oo[index]['name']);
                          sharedPref.setString("serviceId",oo[index]['id'].toString());
                          MLHospitalDetailScreen().launch(context);
                        }),
                      ],
                    ),
                  ],
                ),
              ).paddingBottom(16.0).onTap(() {
                setState(() {
                  selectedIndex = index;
                });
              });
            },
          ),
        ],
      ),
    );
  }
}
