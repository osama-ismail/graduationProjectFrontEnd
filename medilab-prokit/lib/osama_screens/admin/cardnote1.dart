import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardNotes extends StatelessWidget {
  final void Function() ontap;
  // final NoteModel  notemodel ;
  final String title;
  final String content;
  final String image;
// asd
  // final void Function()? onDelete;
  const CardNotes(
      {Key? key,
      required this.ontap,
      // required this.notemodel ,
        required this.title,
        required this.content,
        required this.image,
      // required this.onDelete
      })
      : super(key: key);
onDelete(){
  print("delete item cart");
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
                child: Image.network(
                  "$linkImageRoot/${image}",
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
                  title: Text(" $content"),
                  // subtitle: Text(" Price : $title"),

                  // trailing: IconButton(
                  //   icon: Icon(Icons.delete),
                  //   onPressed: onDelete,
                  // ),
                ))
          ],
        ),
      ),
    );
  }
}
