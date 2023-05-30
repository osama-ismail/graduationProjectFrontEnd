import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/components/customtextform.dart';
import 'package:medilab_prokit/osama_screens/components/valid.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../../adminPages/controllers/MenuAppController.dart';
import '../../../adminPages/screens/main/main_screen.dart';
import '../../../main.dart';

class AdminaddPateint extends StatefulWidget {
  AdminaddPateint({Key? key}) : super(key: key);

  @override
  State<AdminaddPateint> createState() => _SignupState();
}

class _SignupState extends State<AdminaddPateint> {
  GlobalKey<FormState> formstate = GlobalKey();
  bool _isObscure = true;
  dynamic yourObject ;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  Crud crud = Crud();

  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    if(sharedPref.getString("editPatient").toString()!="") {
    String jsonString = sharedPref.getString("editPatient").toString();

    // Convert the JSON string back to an object
    yourObject = jsonDecode(jsonString);
    // Initialize the username controller with the object's name
    if(yourObject!=""){
      username = TextEditingController(text: yourObject?["name"]);
      email = TextEditingController(text: yourObject?["email"]);
      address = TextEditingController(text: yourObject?["address"]);
      phone = TextEditingController(text: yourObject?["phone"]);
      password = TextEditingController(text: yourObject?["password"]);

    }}
  }
  signup() async {
    final body;

    if (formstate.currentState!.validate()) {
      final headers = {'Content-Type': 'application/json'};
      isLoading = true;
      isLoading = false;
      var data;
      final body0;

      if (sharedPref.getString("editPatient").toString() != "") {
        String jsonString = sharedPref.getString("editPatient").toString();

        yourObject = jsonDecode(jsonString);
        final response;

        if (sharedPref.getString("isAdmin") == "1"){
          print("ali");

          body = json.encode({'id': yourObject?["id"],
            'name': this.username.text + "",
            'password': this.password.text + "",
            'email': this.email.text + "",
            'address': this.address.text + "",
            'salary': this.address.text + "",
            'service_id': "1",


          });
          response = await http.post(
              Uri.parse(linkIp + "/admin/addNewDoctor"),
              headers: headers, body: body);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            body: Text("تمت العملية بنجاح."),
          )..show().then((_) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pushNamedAndRemoveUntil("AdminDoctors", (route) => true);
            });
          });
        }
        else{
          body = json.encode({'id': yourObject?["id"],
            'name': this.username.text + "",
            'password': this.password.text + "", 'email': this.email.text + "",
            'address': this.address.text + "",
            'longitude': "0",
            'phone': this.phone.text + "",
            'latitude': "0",


          });
          response = await http.post(
              Uri.parse(linkIp + "/admin/addNewPatient"),
              headers: headers, body: body);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            body: Text("تمت العملية بنجاح."),
          )..show().then((_) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pushNamedAndRemoveUntil("Admincategory", (route) => true);
            });
          });

        }

      }
      else {
        if (sharedPref.getString("isAdmin") == "1") {
          final body0;
          body0 = json.encode({
            'name': this.username.text + "",
            'password': this.password.text + "",
            'email': this.email.text + "",
            'address': this.address.text + "",
            'salary': this.address.text + "",
            'service_id': "1",


          });
        var response = await http.post(
              Uri.parse(linkIp + "/admin/addNewDoctor"),
              headers: headers, body: body0);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            body: Text("تمت العملية بنجاح."),
          )..show().then((_) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pushNamedAndRemoveUntil("AdminDoctors", (route) => true);
            });
          });
        }
          body = json.encode({'name': this.username.text + "",
          'password': this.password.text + "", 'email': this.email.text + "",
          'address': this.address.text + "",
          'longitude': "0",
          'phone': this.phone.text + "",
          'latitude': "0",


        });
       var response = await http.post(
            Uri.parse(linkIp + "/admin/addNewPatient"),
            headers: headers, body: body); AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          body: Text("تمت العملية بنجاح."),
        )..show().then((_) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pushNamedAndRemoveUntil("Admincategory", (route) => true);
          });
        });
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
      padding: EdgeInsets.all(10),
      child: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Form(
                  key: formstate,
                  child: Column(
                    children: [
                      Image.asset(
                        "images/osama6.png",
                        width: 200,
                        height: 200,
                      ),
                      TextFormField(

                        cursorColor: Color.fromRGBO(255, 192, 0, 1.0),
                        // decoration: InputDecoration(
                        //   hintText: "Enter your email",
                        //   icon: Icon(Icons.email),
                        // ),
                        controller: username,

                        decoration: InputDecoration(
                          labelText: 'username',
                          icon: Icon(Icons.person,color: Color.fromRGBO(255, 192, 0, 1.0),
                          ),
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(255, 192, 0, 1.0) ,
                          ),
                        ),
                        validator:(value) {
                          if(value!.isEmpty)
                            return "Enter corect username";
                          else{
                            return null;
                          }
                        },
                      ),

                      TextFormField(

                        cursorColor: Color.fromRGBO(255, 192, 0, 1.0),
                        // decoration: InputDecoration(
                        //   hintText: "Enter your email",
                        //   icon: Icon(Icons.email),
                        // ),
                        controller: email,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email,color: Color.fromRGBO(255, 192, 0, 1.0),
                          ),
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(255, 192, 0, 1.0) ,
                          ),
                        ),
                        validator:(value) {
                          if(value!.isEmpty)
                            return "Enter corect email";
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(

                        cursorColor: Color.fromRGBO(255, 192, 0, 1.0),
                        // decoration: InputDecoration(
                        //   hintText: "Enter your email",
                        //   icon: Icon(Icons.email),
                        // ),
                        controller: phone,
                        decoration: InputDecoration(
                          labelText: 'phone',
                          icon: Icon(Icons.phone,color: Color.fromRGBO(255, 192, 0, 1.0),
                          ),
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(255, 192, 0, 1.0) ,
                          ),
                        ),
                        validator:(value) {
                          if(value!.isEmpty)
                            return "Enter corect email";
                          else{
                            return null;
                          }
                        },
                      ),
                      TextFormField(

                        cursorColor: Color.fromRGBO(255, 192, 0, 1.0),
                        obscureText: _isObscure,
                        controller: password,
                        decoration: InputDecoration(

                          labelText: 'Password',
                          icon: Icon(Icons.lock,color: Color.fromRGBO(255, 192, 0, 1.0),),
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(255, 192, 0, 1.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        validator:(value) {
                          if(value!.isEmpty)
                            return "Enter corect password";
                          else{
                            return null;
                          }
                        },
                      ),
                      TextFormField(

                        cursorColor: Color.fromRGBO(255, 192, 0, 1.0),
                        controller: address,
                        decoration: InputDecoration(

                          labelText: 'address',
                          icon: Icon(Icons.home,color: Color.fromRGBO(255, 192, 0, 1.0),),
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(255, 192, 0, 1.0),
                          ),

                        ),
                        validator:(value) {
                          if(value!.isEmpty)
                            return "Enter corect address";
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 59,
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                        onPressed: () async {
                          await signup();
                        },
                        child: Text("Add"),
                      ),
                      Container(height: 10),
                      InkWell(
                        child: Text("Back"),
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
                          );                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
    ));
  }
}
