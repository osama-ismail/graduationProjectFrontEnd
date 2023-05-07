import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/components/customtextform.dart';
import 'package:medilab_prokit/osama_screens/components/valid.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignupState();
}

class _SignupState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();
  bool _isObscure = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController address = TextEditingController();
  Crud crud = Crud();

  bool isLoading = false;

  signup() async {
    if (formstate.currentState!.validate()) {
      final headers = {'Content-Type': 'application/json'};
      isLoading = true;
      isLoading = false;
      var data;
      final body = json.encode({'name': this.username.text+"",
        'password':this.password.text+"", 'email':this.email.text+"", 'address':this.address.text+""
      });
        final response = await http.post(
            Uri.parse(linkIp+"/patient/addNewPatient"),
            headers: headers, body: body);
      if(response.statusCode==200){
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          body: Text("تمت العملية بنجاح."),
        )..show().then((_) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => true);
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
                        child: Text("Sign Up"),
                      ),
                      Container(height: 10),
                      InkWell(
                        child: Text("Login"),
                        onTap: () {
                          Navigator.of(context).pushNamed("login");
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
    ));
  }
}
