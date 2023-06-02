import 'dart:convert';

import '../../main.dart';
import 'cardnote.dart';
import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';
import '../leftMenu.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/osama_screens/Sample .dart';
import 'package:http/http.dart' as http;

import 'items.dart';

class Admincategory extends StatefulWidget {
  Admincategory({Key? key}) : super(key: key);

  @override
  State<Admincategory> createState() => _HomeState();
}

class _HomeState extends State<Admincategory> with Crud {
  bool isLoading = false;

  getCtegories() async {
    var response = await http.get(Uri.parse(linkIp + "/admin/getAlllPatients"));
    var responseBody = jsonDecode(response.body);
    return responseBody;
  }

  @override
  Widget build(BuildContext context) {
    String? tt = sharedPref.getString("id");
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("Patients"),
        actions: [
          IconButton(
            onPressed: () {
              sharedPref.clear();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "login", (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {    sharedPref.setString('editPatient', "");

        Navigator.of(context).pushNamed("AdminaddPateint");
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: getCtegories(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var responseData = snapshot.data;
                    print(responseData.length);

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: responseData.length,
                      itemBuilder: (context, i) {
                        if (i == 0) {

                        }
                        return CardNotes(
                          id: "${snapshot.data[i]['id']}",
                          name: "${snapshot.data[i]['name']}",
                          address: "${snapshot.data[i]['address']}",
                          phone: "${snapshot.data[i]['phone']}",
                          password: "${snapshot.data[i]['password']}",
                          email: "${snapshot.data[i]['email']}",

                          ontap: () {
                            sharedPref.setString(
                              "id_category",
                              snapshot.data[i]['id'].toString(),
                            );
                            setState(() {});
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Item(),
                              ),
                            );
                            // print(snapshot.data['data'][i]['id'].toString());
                          },
                        );
                      },
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text("loading.."));
                  }
                  return Center(child: Text("loading.."));
                },
              )
              // CardNotes(content:"test",title:"se",ontap:(){}),
            ],
          ),
        ),
      ),
    );
  }
}
