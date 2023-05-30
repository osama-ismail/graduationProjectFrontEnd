import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medilab_prokit/screens/MLBookAppointmentScreen2.dart';
import 'package:medilab_prokit/screens/MLDashboardScreen.dart';
import 'package:medilab_prokit/screens/MLSplashScreen.dart';
import 'package:medilab_prokit/store/AppStore.dart';
import 'package:medilab_prokit/utils/AppTheme.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'adminPages/controllers/MenuAppController.dart';
import 'adminPages/screens/main/main_screen.dart';
import 'osama_screens/admin/addCategory.dart';
import 'osama_screens/admin/cardnoteAdmin.dart';
import 'osama_screens/admin/category.dart';
import 'osama_screens/admin/categoryDoctor.dart';
import 'osama_screens/admin/editItem.dart';
import 'osama_screens/admin/map.dart';
import 'osama_screens/admin/mapMap.dart';
import 'osama_screens/app/auth/addDoctors.dart';
import 'osama_screens/app/auth/addPatient.dart';
import 'osama_screens/app/auth/login.dart';
import 'osama_screens/app/auth/signUp.dart';
import 'osama_screens/app/home.dart';
import 'osama_screens/app/orders.dart';

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
          "MLBookAppointmentScreen2": (context) => MLBookAppointmentScreen2(),

          // "MapMap": (context) => MapMap(),

          "Home": (context) => Home(),
          "AdminEditItem":(context)=>AdminEditItem(),
          "Admincategory" :(context)=>Admincategory(),
          "AdminaddCategory" :(context)=>AdminaddCategory(),
          "AdminaddPateint" :(context)=>AdminaddPateint(),
          "Adminpage" :(context)=>MainScreen(),
          "AdminDoctors" :(context)=>AdminDoctorcategory(),


        },
        debugShowCheckedModeBanner: false,
        title: '${'Here for you'}${!isMobile ? ' ${platformName()}' : ''}',
        // home:MainScreen(),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuAppController(),
            ),
          ],
          // child: MainScreen(),
          child: Login(),


        ),

        theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localeResolutionCallback: (locale, supportedLocales) => locale,
      ),
    );
  }
}
