// import 'package:ecommerce_osama/app/notes/edit.dart';
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

class AdminEditItem extends StatefulWidget {
  AdminEditItem({Key? key}) : super(key: key);

  @override
  State<AdminEditItem> createState() => _HomeState();
}

class _HomeState extends State<AdminEditItem> with Crud {
  bool isLoading = false;
  TextEditingController name = new TextEditingController(text: sharedPref.getString("name_item"));

  TextEditingController description = TextEditingController(text: sharedPref.getString("des_item"));
  TextEditingController price = TextEditingController(text: sharedPref.getString("price_item"));

  File? myfile=File('');
  XFile? xfile;
  String imageFile="0";
  addCtegories() async {

    if (imageFile == "0") {
      return AwesomeDialog(
          context: context,
          title: "هام",
          body: Text("الرجاء اضافة الصورة الخاصة بالصنف"))
        ..show();
    }
    print(myfile);
    if (name.text == ""||description.text == ""||price.text == "") {
      return AwesomeDialog(
          context: context,
          title: "هام",
          body: Text("الرجاء تعبئةالحقول الفارغة   "))
        ..show();
    }
    var response9 = await postRequestWithFile(linkAdminEditItem, {
      "name": name.text!,
      "description" : description.text!,
      "price" : price.text!,
      "id_category":sharedPref.getString("id_item").toString(),

    },
        myfile!);
    isLoading = false;
    // print("deem");
    // print(sharedPref.getString("id_item").toString());
    //
    // print(response9);
    setState(() {});
    if (response9['status'] == "success") {
      // Navigator.of(context).pushReplacementNamed("add");
      Navigator.of(context).pushNamedAndRemoveUntil("Admincategory", (route) => false);
    } else {
      //
    }
  }


  getIMage (){

    // if(myfile==File('')){
    if(  imageFile=="1") {
      return Image.file(myfile!, height: 100,);

    }


    else{

      return Text("no image");

    }
  }
  @override
  void initState() {
    print("osa");
    print("${name.text}") ;
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
          title: Text("Edit Item"),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.of(context).pushNamed("carts");
          },
          child: Icon(Icons.add),
        ),
        body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 300,
                  padding: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      icon: Icon(Icons.category_sharp),
                    ),
                    validator: (value) {
                      if (value!.isEmpty)
                        return " the name shouldn't be empty ! ";
                      else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  width: 300,
                  padding: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: description,
                    decoration: InputDecoration(
                      labelText: 'description',
                      icon: Icon(Icons.category_sharp),
                    ),
                    validator: (value) {
                      if (value!.isEmpty)
                        return " the name shouldn't be empty ! ";
                      else {
                        return null;
                      }
                    },
                  ),
                ),

                Container(
                  width: 300,
                  padding: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: price,
                    decoration: InputDecoration(
                      labelText: 'price',
                      icon: Icon(Icons.category_sharp),
                    ),
                    validator: (value) {
                      if (value!.isEmpty)
                        return " the name shouldn't be empty ! ";
                      else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  width: 300,
                  padding: EdgeInsets.only(top: 20),

                  child:getIMage(),


                ),
                Padding(
                    padding: const EdgeInsets.only(left: 100, top: 20),

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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Please Choose Image",
                                          style: TextStyle(fontSize: 22)),
                                    ),


                                    Padding(

                                      padding: const EdgeInsets.only(left: 40,right: 40),

                                      child: Container(
                                        margin: EdgeInsets.only(top:10),
                                        child:       MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              side: BorderSide(color: Colors.red)
                                          ),
                                          color: Colors.blue,
                                          textColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 70, vertical: 10),
                                          onPressed: () async {
                                            xfile = await ImagePicker()
                                                .pickImage(source: ImageSource.gallery);
                                            Navigator.of(context).pop();
                                            myfile = File(xfile!.path);
                                            imageFile="1";
                                            // image:Image.file(File(xfile!.path), height: 300,);

                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              "From Gallery",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),),
                                    ),
                                    Padding(

                                      padding: const EdgeInsets.only(left: 40,right: 40),
                                      child: Container(
                                        margin: EdgeInsets.only(top:10),
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              side: BorderSide(color: Colors.red)
                                          ),
                                          color: Colors.blue,
                                          textColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 70, vertical: 10),

                                          onPressed: () async {
                                            xfile = await ImagePicker()
                                                .pickImage(source: ImageSource.camera);
                                            Navigator.of(context).pop();

                                            myfile = File(xfile!.path);
                                            imageFile="1";
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,

                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              "From Camera",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),),
                                    ),



                                  ],
                                )));
                      },

                      child: Text("Choose Image"),
                      textColor: Colors.white,
                      color: myfile == null ? Colors.blue : Colors.green,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 100,right: 60),

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
