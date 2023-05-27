import '../screens/MLDashboardScreen.dart';
import './constants.dart';
import './controllers/MenuAppController.dart';
import './screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilab_prokit/adminPages/screens/main/main_screen.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'controllers/MenuAppController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      routes: {

        "homePage": (context) => MLDashboardScreen(),
        // "MapMap": (context) => MapMap(),


      },
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}
