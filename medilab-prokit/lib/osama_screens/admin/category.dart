// import 'package:ecommerce_osama/app/notes/edit.dart';
import '../../main.dart';
import 'cardnote.dart';
import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';
import '../leftMenu.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/osama_screens/Sample .dart';
// import '../components/cardnote.dart';
import 'items.dart';
class Admincategory extends StatefulWidget {
  Admincategory({Key? key}) : super(key: key);

  @override
  State<Admincategory> createState() => _HomeState();
}

class _HomeState extends State<Admincategory> with Crud {
  bool isLoading = false;
  //
  getCtegories() async {
    var response =
        await postRequest(linkViewNotes, {"id": sharedPref.getString("id")});
    // print("soas");
    // print(response);
    // print("soas");

    return response;
  }
  @override
  void initState() {
    // TODO: implement initState
    // getCtegories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? tt=sharedPref.getString("username");
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("Categories"),
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
          Navigator.of(context).pushNamed("AdminaddCategory");
        },
        child: Icon(Icons.add),

      ),


      body:
          // isLoading == true
          //     ? Center(child: CircularProgressIndicator())
          //     :
      Container(

          padding: EdgeInsets.all(10),
          child: Column(

            children: [

              FutureBuilder(
                  future: getCtegories(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data['status'] == 'fail') {
                        return Center(
                            child: Text("there is no categories",
                                style: TextStyle(fontSize: 20)));
                      }
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 11/4,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),

                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          if (i == 0) {
                            return Column(
                              children: [

                                CardNotes(
                                    id:"${snapshot.data['data'][i]['id']}",
                                    content:
                                    "",
                                    title:
                                    "${snapshot.data['data'][i]['image']}",
                                    image:"${snapshot.data['data'][i]['image']}",
                                    ontap: () {
                                      // print(snapshot.data['data'][i]['id'].toString());
                                      sharedPref.setString(
                                          "id_category",
                                          snapshot.data['data'][i]['id']
                                              .toString());  setState(() {

                                      });
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Item()
                                          )
                                      );
                                    }),
                              ],
                            );
                            // i--;
                          }
                          return CardNotes(
                              id:"${snapshot.data['data'][i]['id']}",

                              image:"${snapshot.data['data'][i]['image']}",
                              content:
                              "",
                              title: "${snapshot.data['data'][i]['image']}",
                              ontap: () {
                                sharedPref.setString(
                                    "id_category",
                                    snapshot.data['data'][i]['id']
                                        .toString());
                                setState(() {

                                });
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Item()));
                                // print(snapshot.data['data'][i]['id'].toString());
                              });

                        },
                      );
                    }
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: Text("loading.."));
                    }
                    return Center(child: Text("loading.."));
                  })
              // CardNotes(content:"test",title:"se",ontap:(){}),
            ],
          )

      ),
    );
  }
}
