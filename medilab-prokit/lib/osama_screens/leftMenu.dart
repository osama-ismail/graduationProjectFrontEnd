import 'package:flutter/material.dart';
import '../main.dart';
import 'constant/linkapi.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'admin/category.dart';
class NavBar extends StatelessWidget {
  String? userName = sharedPref.getString("username");
  String? userImage = sharedPref.getString("image");
  String? userEmail = sharedPref.getString("email");

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
                // child: Image.network(
                //   "$linkImageRoot/${userImage!}",
                //   fit: BoxFit.cover,
                //   width: 90,
                //   height: 90,
                // ),
              ),
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
                  .pushNamedAndRemoveUntil("allUser", (route) => false);
            },
          ),
          ListTile(

            leading: Icon(Icons.person),
            title: Text('Orders'),
            onTap: (){
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("Showorders", (route) => false);
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
