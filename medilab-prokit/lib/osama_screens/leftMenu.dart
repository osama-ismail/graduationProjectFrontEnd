import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../adminPages/controllers/MenuAppController.dart';
import '../adminPages/screens/main/main_screen.dart';
import '../main.dart';
import 'constant/linkapi.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'admin/category.dart';

class NavBar extends StatelessWidget {
  String userName = sharedPref.getString("username")!;
  String userEmail = sharedPref.getString("email")!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userEmail),
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
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (context) => MenuAppController(),
                        ),
                      ],
                      child: MainScreen(),
                    );
                  },
                ),
                    (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Pateints'),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("Admincategory", (route) => false);
            },
          ),
          ListTile(

            leading: Icon(Icons.person_pin),
            title: Text('Doctors '),
            onTap: (){
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("AdminDoctors", (route) => false);
            },
          ),

          ListTile(
            leading: Icon(Icons.medical_services),
            title: Text('Services'),
            onTap: () {sharedPref.setString("istick","0");
    Navigator.of(context)
        .pushNamedAndRemoveUntil("MLBookAppointmentScreen2", (route) => false);
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
          // ListTile(
          //   leading: Icon(Icons.date_range),
          //   title: Text('Reservations'),
          //   onTap: () {
          //     Navigator.of(context)
          //         .pushNamedAndRemoveUntil("Admincategory", (route) => false);
          //   },
          // ),
          //
          // Divider(),
          ListTile(

            leading: Icon(Icons.dark_mode),
            title: Text('Dark mode '),
            onTap: (){
              appStore.toggleDarkMode();

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
