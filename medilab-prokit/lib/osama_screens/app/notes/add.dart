import 'dart:io';
// import 'dart:io' as io;


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/components/customtextform.dart';
import 'package:medilab_prokit/osama_screens/components/valid.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNotes extends StatefulWidget {
  AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Crud {
  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;

  addNotes() async {
    print("osama1");
    // if (myfile == null)
    //   return AwesomeDialog(
    //       context: context,
    //       title: "هام",
    //       body: Text("الرجاء اضافة الصورة الخاصة بالملاحظة"))
    //     ..show();
    // if (formstate.currentState!.validate()) {
    //   isLoading = true;
    //   setState(() {});
    var response9= await postRequestWithFile(linkosamaa, {
      "id_order":"55",
      "id_item":"1",
      "count": "4",

    },
    myfile!);
      isLoading = false;
      print("deem");
    print(response9);
      setState(() {});
      if (response9['status'] == "success") {
        print("osama2");
        // Navigator.of(context).pushReplacementNamed("add");
      } else {
        //
        print("osama2");
      }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
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
                    MaterialButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                height: 120,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Please Choose Image",
                                          style: TextStyle(fontSize: 22)),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        XFile? xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        Navigator.of(context).pop();
                                        myfile = File(xfile!.path);
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
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        XFile? xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        Navigator.of(context).pop();

                                        myfile = File(xfile!.path);
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
                                    )
                                  ],
                                )));
                      },

                      child: Text("Choose Image"),
                      textColor: Colors.white,
                      color: myfile == null ? Colors.blue : Colors.green,
                    ),
                    Container(height: 20),
                    MaterialButton(
                      onPressed: () async {
                        await addNotes();
                      },
                      child: Text("Add"),
                      textColor: Colors.white,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
