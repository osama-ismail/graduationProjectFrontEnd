import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medilab_prokit/screens/MLDashboardScreen.dart';
import 'package:medilab_prokit/screens/MLSplashScreen.dart';
import 'package:medilab_prokit/store/AppStore.dart';
import 'package:medilab_prokit/utils/AppTheme.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:nb_utils/nb_utils.dart';

import 'osama_screens/app/auth/login.dart';
import 'osama_screens/app/auth/signUp.dart';

AppStore appStore = AppStore();
late SharedPreferences sharedPref ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance() ;

  await initialize(aLocaleLanguageList: languageList());

  appStore.toggleDarkMode(value: getBoolAsync('isDarkModeOnPref'));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        routes: {
          "login": (context) => Login(),
          "signup": (context) => SignUp(),
          "homePage": (context) => MLDashboardScreen(),



        },
        debugShowCheckedModeBanner: false,
        title: '${'Here for you'}${!isMobile ? ' ${platformName()}' : ''}',
        home: MLDashboardScreen(),
        // home: MLSplashScreen(),

        theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localeResolutionCallback: (locale, supportedLocales) => locale,
      ),
    );
  }
}
