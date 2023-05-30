// import 'package:ecommerce_osama/app/notes/edit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:medilab_prokit/osama_screens/components/cardnote.dart';
import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';
import '../../main.dart';
import '../leftMenu.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/osama_screens/Sample .dart';
import '../components/cardnote.dart';
import '../app/items.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'dart:io' as io;
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:medilab_prokit/osama_screens/components/valid.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminaddCategory extends StatefulWidget {
  AdminaddCategory({Key? key}) : super(key: key);

  @override
  State<AdminaddCategory> createState() => _HomeState();
}
class _HomeState extends State<AdminaddCategory> with Crud {
  bool isLoading = false;
  String? selectedValue;
  Map<String, String> dropdownItems = {

  };
  findDoctors() async{
    var response = await http.get(Uri.parse(linkIp + "/admin/getAlllDoctors"));
    var responseBody = jsonDecode(response.body);
    for (var doctor in responseBody) {
      String id = doctor['id'].toString();
      String name = doctor['name'].toString();
      dropdownItems[name] = id;
    }
    print(dropdownItems);
  }
  TextEditingController email = TextEditingController();
  File? myfile=File('');
  String? selectedOption;

  XFile? xfile;
  String imageFile="0";
  addCtegories() async {
    final headers = {'Content-Type': 'application/json'};
    isLoading = true;
    isLoading = false;
    var data;
    final body = json.encode({'name':email.text+""


    });
    // final body = json.encode({'name':sharedPref.getString("addNewService"),
    //
    //
    // });
    var response = await http.post(
        Uri.parse(linkIp+"/admin/addNewService"),
        headers: headers, body: body);

    print(response.statusCode);
  }
  getIMage (){
    if(  imageFile=="1") {
      return Image.file(myfile!, height: 100,);
    }
    else{
  return Text("no image");

  }
  }
  @override
  void initState() {
    findDoctors();
    // TODO: implement initState
    // getCtegories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String? tt = sharedPref.getString("username");
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("Add Category"),
          actions: [
            IconButton(
                onPressed: () {
                  sharedPref.clear();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),

        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 350,
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Service name',
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  icon: Icon(
                    Icons.category_sharp,
                    color: Colors.black,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty)
                    return "The name shouldn't be empty!";
                  else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              width: 310,
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.fromLTRB(40, 50, 0, 0),
              child: DropdownButton<String>(
                value: selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    sharedPref.setString("docService", newValue!);
                    selectedOption = newValue;
                  });
                },
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                iconSize: 100,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                dropdownColor: Colors.white, // Set the dropdown background color
                isExpanded: true, // Expand the dropdown to fit the container width
                items: dropdownItems.keys.map<DropdownMenuItem<String>>((String key) {
                  return DropdownMenuItem<String>(
                    value: dropdownItems[key],
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding for each item
                      child: Text(
                        key,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
,

            Container(
              width: 300,
              padding: EdgeInsets.fromLTRB(50, 50, 10, 10),

              child:getIMage(),


            ),
            Padding(
                padding: const EdgeInsets.only(left: 110, top: 50),

                child: MaterialButton(
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                  // margin:EdgeInsets.all(10),
                  // shape: Border.symmetric(),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [



                                Padding(
                                  padding: const EdgeInsets.only(left: 40, right: 40),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.red),
                                          ),
                                          color: Colors.blue,
                                          textColor: Colors.white,
                                          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                                          onPressed: () async {
                                            xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                            Navigator.of(context).pop();
                                            myfile = File(xfile!.path);
                                            imageFile = "1";
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            padding: EdgeInsets.all(1),
                                            child: Text(
                                              "From Gallery",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10), // Add spacing between the buttons
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.red),
                                          ),
                                          color: Colors.blue,
                                          textColor: Colors.white,
                                          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                                          onPressed: () async {
                                            xfile = await ImagePicker().pickImage(source: ImageSource.camera);
                                            Navigator.of(context).pop();
                                            myfile = File(xfile!.path);
                                            imageFile = "1";
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            padding: EdgeInsets.all(1),
                                            child: Text(
                                              "From Camera",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),





                              ],
                            )));
                  },

                  child: Text("Choose Image"),
                  textColor: Colors.white,
                  color: myfile == null ? Colors.blue : Colors.green,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 110,right: 60),

            child:  MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              padding:
              EdgeInsets.symmetric(horizontal: 43, vertical: 10),
              onPressed: ()  {
                addCtegories();
              },
              child: Text("save"),
            ),),
          ],
        )));
  }
}
