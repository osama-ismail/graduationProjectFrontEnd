import 'package:flutter/material.dart';
import '../main.dart';
import 'constant/linkapi.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'admin/category.dart';

class NavBar extends StatelessWidget {
  String? userName = "osama";
  String? userImage = "sd";
  String? userEmail = "osama@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName!),
            accountEmail: Text(userEmail!),
            currentAccountPicture: CircleAvatar(
              child: CircleAvatar(child:
              // Icon(Icons., color: white, size: 24),
              Image.asset("images/person.png"),
                  radius: 22, backgroundColor: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage("images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Users'),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("Admincategory", (route) => false);
            },
          ),
          ListTile(

            leading: Icon(Icons.person),
            title: Text('Doctors '),
            onTap: (){
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("Admincategory", (route) => false);
            },
          ),

          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Request'),
            onTap: () {

            },
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("Admincategory", (route) => false);
            },
          ),

          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {sharedPref.clear();
            Navigator.of(context)
                .pushNamedAndRemoveUntil("login", (route) => false);},
          ),
        ],
      ),
    );
  }
}
