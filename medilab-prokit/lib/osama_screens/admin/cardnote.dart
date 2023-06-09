import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilab_prokit/main.dart';
import '../components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:http/http.dart' as http;

class CardNotes extends StatefulWidget {
  final void Function() ontap;
  final String address;
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  const CardNotes({
    Key? key,
    required this.ontap,
    required this.name,
    required this.address,
    required this.id,
    required this.email,
    required this.password,
    required this.phone,
  }) : super(key: key);

  @override
  CartCardState createState() => CartCardState();
}

class CartCardState extends State<CardNotes> with Crud {
  onDelete() async {
    var response = await http.get(Uri.parse(linkIp + "/admin/deletePatientById?id="+widget.id));

    Navigator.of(context).pushNamedAndRemoveUntil("Admincategory", (route) => false);
  }
  onChat(){
    sharedPref.setString("istick","0");

    Navigator.of(context).pushNamedAndRemoveUntil("chatpage", (route) => false);


  }

  onevent_available(){

    sharedPref.setString("istick","0");

    Navigator.of(context).pushNamedAndRemoveUntil("MapMap", (route) => false);


  }

  onEdit() async {
    sharedPref.setString("isAdmin","0");

    String jsonString = jsonEncode({
      "id":widget.id,
      "name":widget.name,
      "address":widget.address,
      "phone":widget.phone,
      "email":widget.email,
      "password":widget.password,
    });
    sharedPref.setString('editPatient', jsonString);
    sharedPref.setString("isAdmin","0");
    sharedPref.setString("istick","0");

    Navigator.of(context).pushNamedAndRemoveUntil("AdminaddPateint", (route) => false);

  }

  onClick() async{
    print("osanaaa");
    print(widget.id);

  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,

      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,

            ),
            borderRadius: BorderRadius.circular(1.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onClick, // Define the onTap callback function
                child: CircleAvatar(
                  child: CircleAvatar(
                    child: Image.asset("images/person.png"),
                    radius: 25,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ListTile(
                  title: Text(
                    "${widget.name.substring(2)} ,\n ${widget.address}  ",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(iconSize: 20,
                        icon: Icon(Icons.edit),
                        color: Colors.blue,
                        onPressed: onEdit, // Define the edit callback function
                      ),
                      IconButton(iconSize: 20,
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: onDelete,
                      ),
                      IconButton(iconSize: 20,
                        icon: Icon(Icons.chat),
                        color: Colors.blue,
                        onPressed: onChat,
                      ),
                      Column(
                        children: [
                          IconButton(
                            iconSize: 20,
                            icon: Icon(Icons.zoom_in_map_rounded),
                            color: Colors.blue,
                            onPressed: onevent_available,
                          ),

                        ],
                      )

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
