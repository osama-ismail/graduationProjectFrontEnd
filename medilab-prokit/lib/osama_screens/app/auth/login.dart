import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/components/customtextform.dart';
import 'package:medilab_prokit/osama_screens/components/valid.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'dart:convert';

import '../../../components/MLSocialAccountComponent.dart';
import '../../../main.dart';
import '../../../screens/MLDashboardScreen.dart';
import '../../../screens/MLRegistrationScreen.dart';
import '../../../utils/MLColors.dart';
import '../../../utils/MLString.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey();
  bool _isObscure = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud crud = Crud();

  bool isLoading = false;

  login() async {
    Navigator.of(context).pushNamedAndRemoveUntil("homePage", (route) => true);
    if (formstate.currentState!.validate()) {

      final headers = {'Content-Type': 'application/json'};
      isLoading = true;
      isLoading = false;
      var data;
      final body = json.encode({'username': this.email.text+"",
        'password':this.password.text+""
      });
        final response = await http.post(
            Uri.parse(linkIp+"/authinticate"),
            headers: headers, body: body);
      print(response.body);
        if (response?.statusCode == 200) {
          print(response.body);


        if (response.body.isEmpty) {
            AwesomeDialog(
                context: context,
                title: "تنبيه",
                body: Text(
                    "اسم المستخدم او كلمة المرور خطأ او الحساب غير موجود"))
              ..show();
          }
          else{
            sharedPref.setString("id", json.decode(response.body)["id"].toString());
            sharedPref.setString(
                "username", json.decode(response.body)['name'].toString());
            print(sharedPref.getString("name"));
            sharedPref.setString("email", json.decode(response.body)['email'].toString());
            sharedPref.setString(
                "password", json.decode(response.body)['password'].toString());
            if(this.email.text.startsWith("p")){
              sharedPref.setString("address", json.decode(response.body)['address'].toString());

            }
            else if(this.email.text.startsWith("d")){
              sharedPref.setString("salary", json.decode(response.body)['salary'].toString());
              sharedPref.setString("service_id", json.decode(response.body)['service_id'].toString());
            }
            Navigator.of(context).pushNamedAndRemoveUntil("homePage", (route) => true);
            return;
          }
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
                        style: TextStyle(color: Colors.white),

                        cursorColor: Color.fromRGBO(255, 192, 0, 1.0),

                        controller: email,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(255, 192, 0, 1.0),
                              width: 1.8,
                              // set the color for the underline here
                            ),
                          ),
                          icon: Icon(Icons.email,color: Color.fromRGBO(255, 192, 0, 1.0),
                          ),
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(255, 192, 0, 1.0) ,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
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
                          style: TextStyle(color: Colors.white),

                        cursorColor: Color.fromRGBO(255, 192, 0, 1.0),
                        obscureText: _isObscure,
                        controller: password,

                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(255, 192, 0, 1.0),
                              width: 1.8,
                              // set the color for the underline here
                            ),
                          ),
                          labelText: 'Password',
                          icon: Icon(Icons.lock,color: Color.fromRGBO(255, 192, 0, 1.0),),
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(255, 192, 0, 1.0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                          suffixIcon: IconButton(

                            icon: Icon(
                              _isObscure ? Icons.visibility_off : Icons.visibility,
                              color: Color.fromRGBO(255, 192, 0, 1.0),
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

                      SizedBox(
                        height: 50,
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                        onPressed: () async {
                          await login();
                        },
                        child: Text("Login"),
                      ),
                      Container(height: 10),
                      // InkWell(
                      //   child: Text("Sign Up"),
                      //   onTap: () {
                      //     Navigator.of(context).pushNamed("signup");
                      //   },
                      // ),
                      // AppButton(
                      //   color: mlPrimaryColor,
                      //   width: double.infinity,
                      //   onTap: () {
                      //
                      //        login();
                      //
                      //     // finish(context);
                      //     // MLDashboardScreen().launch(context);
                      //   },
                      //   child: Text(mlLogin!, style: boldTextStyle(color: white)),
                      // ),
                      // 22.height,
                      // Text(mlLogin_with!, style: secondaryTextStyle(size: 16)).center(),
                      // 22.height,
                      MLSocialAccountsComponent(),
                      22.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(mlDont_have_account!, style: primaryTextStyle()),
                          8.width,
                          Text(
                            mlRegister!,
                            style: boldTextStyle(color: Colors.deepPurple, decoration: TextDecoration.underline),
                          ).onTap(
                                () {
                                  Navigator.of(context).pushNamed("signup");
                            },
                          ),
                        ],
                      ),
                      32.height,
                    ],
                  ),
                ),
              ],
            ),
    ));
  }
}
