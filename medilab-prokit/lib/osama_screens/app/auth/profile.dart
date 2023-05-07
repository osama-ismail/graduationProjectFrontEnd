import 'dart:io';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/components/customtextform.dart';
import 'package:medilab_prokit/osama_screens/components/valid.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilab_prokit/osama_screens/leftMenuUser.dart';

import '../../../main.dart';
class Profile extends StatefulWidget {
  final notes;
  Profile({Key? key, this.notes}) : super(key: key);

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> with Crud {
  File? myfile=File('');
  XFile? xfile;
  String imageFile="0";
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;
  editNotes() async {
    print("profike ");
    print(myfile);
    if (formstate.currentState!.validate()) {
      isLoading = true;
      // var response;
      // response = await postRequest(linkEditNotes, {
      //   "title": title.text,
      //   "content": content.text,
      //   "id": sharedPref.getString("id"),
      //
      // });

      var response = await postRequestWithFile(linkEditNotes, {
        "title": title.text,
        "content": content.text,
        "id": sharedPref.getString("id"),

      },
          myfile!);

      print("deema987");
      print(myfile);

      print(response);
      setState(() {
        // sharedPref.setString("image",response['data']);
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        //
      }
    }
  }

  @override
  void initState() {

    title.text =sharedPref.getString("username")!;
    // widget.notes['notes_title'];
    content.text = sharedPref.getString("email")!;
    super.initState();

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
  Widget build(BuildContext context) {

    return Scaffold(
      drawer:NavBar() ,
      appBar: AppBar(
        title: Text("Edit profile"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("carts");
        },
        child: Icon(Icons.shopping_cart),
      ),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formstate,
          child: ListView(
            children: [
              CustTextFormSign(
                  hint: "title",
                  mycontroller: title,
                  valid: (val) {
                    return validInput(val!, 1, 40);
                  }),

              CustTextFormSign(
                  hint: "content",
                  mycontroller: content,
                  valid: (val) {
                    return validInput(val!, 10, 255);
                  }),
              Container(height: 20),
              getIMage(),
              Padding(
                  padding: const EdgeInsets.only(left: 1, top: 20),

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
                                          print("osama147852");
                                          print(myfile);
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



              MaterialButton(
                onPressed: () async{
                  await editNotes();

                },

                child:Text("edit"),
                textColor:Colors.white,
                color:Colors.blue,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
