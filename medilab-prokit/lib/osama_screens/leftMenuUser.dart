import 'package:flutter/material.dart';
import '../main.dart';
import 'constant/linkapi.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'admin/category.dart';
class NavBar extends StatelessWidget {
  String? userName = "OSAMA";
  String? userImage = "OSAMA";
  String? userEmail = "OSMA";

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
              child: ClipOval(

              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(userImage!)),
            ),
          ),


          ListTile(
            leading: Icon(Icons.share),
            title: Text('My profile'),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil("profile", (route) => false);


            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Request'),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil("ShowRequests", (route) => false);

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
            leading: Icon(Icons.settings),
            title: Text('Categories'),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("home", (route) => false);
            },
          ),

          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              sharedPref.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);

            },
          ),
        ],
      ),
    );
  }
}
