import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class PurchaseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'patient',
      color: context.primaryColor,
      textStyle: boldTextStyle(color: Colors.white),
      shapeBorder: RoundedRectangleBorder(borderRadius: radius(10)),
      onTap: () {
      },
    );
  }
}
