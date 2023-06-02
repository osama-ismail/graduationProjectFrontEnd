import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'chatpage.dart';
import 'login.dart';

//Future<void> 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCirX946oOpXRBhXovLRLqEfKT6K2MHtxY",
    appId: "1:181691481978:web:71e5a69d756ad1dc5be0c3",
    messagingSenderId: "181691481978",
    projectId: "chatapp-15cc5",
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chat',
      theme: ThemeData(
        primaryColor: Colors.orange[900],
      ),
      home: chatpage(email: 'mohammad',),
      debugShowCheckedModeBanner: false,
    );
  }
}