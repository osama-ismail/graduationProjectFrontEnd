import 'package:flutter/material.dart';
import 'package:medilab_prokit/screens/MLWalkThroughScreen.dart';
import 'package:medilab_prokit/utils/MLImage.dart';
import 'package:nb_utils/nb_utils.dart';

class MLSplashScreen extends StatefulWidget {
  @override
  _MLSplashScreenState createState() => _MLSplashScreenState();
}

class _MLSplashScreenState extends State<MLSplashScreen> {
  @override
  void initState() {
    super.initState();
    //
    init();
  }

  Future<void> init() async {
    await 1.seconds.delay;
    finish(context);
    MLWalkThroughScreen().launch(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(ml_ic_medilab_logo, height: 300, width:200, fit: BoxFit.fill).center(),
    );
  }
}
