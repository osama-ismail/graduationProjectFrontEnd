


// import 'package:ecommerce_osama/app/auth/signUp.dart';
import './app/cart.dart';
// import 'package:ecommerce_osama/app/auth/signup.dart';

// import 'package:ecommerce_osama/app/notes/addImage.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './app/orders.dart';
import 'Sample .dart';
import 'admin/addItem.dart';
import 'app/ClinicHomePage.dart';
import 'app/auth/choises.dart';
import 'app/auth/login.dart';
import 'app/auth/profile.dart';
import 'app/auth/signUp.dart';
import 'app/auth/success.dart';
import 'app/home.dart';
import 'app/notes/add.dart';
import 'app/notes/edit.dart';
import 'leftMenu.dart';
import 'admin/Admin.dart';
import 'admin/category.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'admin/addCategory.dart';
import 'admin/editItem.dart';
import 'admin/users.dart';
import 'app/requests.dart';
import 'admin/orders.dart';
import 'admin/orderDetails.dart';
import 'admin/map.dart';
late SharedPreferences sharedPref ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized() ;
  sharedPref = await SharedPreferences.getInstance() ;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  getUser(){
    if(sharedPref.getString("idAdmin")=="1"){
         return "Map";

    }else{

      return "Map";
    }
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Course PHP Rest API',
      initialRoute:sharedPref.getString("id") == null ? "login" :getUser() ,

      routes: {
        "login": (context) => Login(),
        "signup": (context) => SignUp(),

        "ClinicHomePage":(context)=>ClinicHomePage(),
        "home": (context) => Home(),
        "success": (context) => Success(),
        "profile": (context) => Profile(),
        "choises": (context) => Choises(),
        // "addnotes": (context) => AddNotes()   ,
        "editnotes": (context) => EditNotes()   ,
        "carts": (context) => Cart()   ,
        "add" :(context)=> AddNotes(),
        "sample" :(context)=> Sample(),
        "leftMenu" :(context)=>NavBar(),
        "adminMain" :(context)=>AdminHome(),
        "Admincategory" :(context)=>Admincategory(),
        "AdminaddCategory" :(context)=>AdminaddCategory(),
        "adminAddItem":(context)=>AdminaddItem(),
        "AdminEditItem":(context)=>AdminEditItem(),
        "allUser":(context)=>ShowAllUsers(),
        "ShowRequests":(context)=>ShowRequests(),
        "Showorders":(context)=>ShowAllOrders(),
        "showOrdersDetails":(context)=>showOrdersDetails(),



        // showOrdersDetails
      },
    );
  }
}

class Order {
}
