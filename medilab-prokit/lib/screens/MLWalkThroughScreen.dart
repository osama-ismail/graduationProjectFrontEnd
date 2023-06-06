import 'package:flutter/material.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/model/MLWalkThroughData.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:medilab_prokit/utils/MLString.dart';
import 'package:medilab_prokit/main.dart';

import '../osama_screens/app/auth/login.dart';
import 'MLLoginScreen.dart';

class MLWalkThroughScreen extends StatefulWidget {
  static String tag = '/MLWalkThroughScreen';

  @override
  _MLWalkThroughScreenState createState() => _MLWalkThroughScreenState();
}

class _MLWalkThroughScreenState extends State<MLWalkThroughScreen> {
  PageController controller = PageController();

  List<MLWalkThroughData> list = mlWalkThroughDataList();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    changeStatusColor(mlPrimaryColor);
  }

  @override
  void dispose() {
    super.dispose();
    changeStatusColor(appStore.isDarkModeOn ? scaffoldDarkColor : white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mlPrimaryColor,
      body: Stack(
        children: [
          PageView(
            controller: controller,
            children: list.map(
              (e) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: boxDecorationWithRoundedCorners(
                        boxShape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.white, Colors.green],
                        ),
                      ),
                      height: 470,
                      width: 430,
                      child: commonCachedNetworkImage(e.imagePath.validate(), fit: BoxFit.contain),
                    ),
                    48.height,
                    Text(e.title.validate(), style: boldTextStyle(size: 24, color: whiteColor)),
                    16.height,
                    Text(
                      e.subtitle.validate(),
                      style: secondaryTextStyle(color: whiteColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ).paddingAll(16.0);
              },
            ).toList(),
          ),
          Positioned(
            bottom: 30,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DotIndicator(pageController: controller, pages: list),
                AppButton(
                  onTap: () {
                    return Login().launch(context);
                  },
                  color: white,
                  child: Text(mlGet_started!, style: boldTextStyle(color: mlPrimaryColor)),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            right: 16,
            child: Text(mlSkip!, style: boldTextStyle(color: whiteColor)).paddingOnly(top: 8, right: 8).onTap(
              () {
                Login().launch(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
