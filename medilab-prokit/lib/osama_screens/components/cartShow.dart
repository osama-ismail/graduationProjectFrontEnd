import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';

class CartCard extends StatelessWidget {
  final void Function() ontap;
  // final NoteModel  notemodel ;
  final String title;
  final String content;
  final String id;
  // final void Function()? onDelete;
  const CartCard(
      {Key? key,
      required this.ontap,
      // required this.notemodel ,
        required this.title,
        required this.content,
        required this.id,
      // required this.onDelete
      })
      : super(key: key);
onDelete ()async{
  // var response = await postRequest(
  //     linkViewNotes2, {"id": sharedPref.getString("id_category")});
  // print("soas");
  // print(response);
  // print("soas");
  // return response;

  // var response = await _crud.postRequest(linkSignUp, {
  //   "username": username.text,
  //   "email": email.text,
  //   "password": password.text
  // });
  // print("$id");
}
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.asset(
                  "images/osama.png",
                )),


                  // "$linkImageRoot/${notemodel.notesImage}",
                  // width: 100,
                  // height: 100,
                  // fit: BoxFit.fill,

            Expanded(
                flex: 2,
                child: ListTile(
                  // title: Text("osama"),
                  // subtitle: Text("osama"),
                  title: Text("Product Name : $content"),
                  subtitle: Text(" Price : $title"),

                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
