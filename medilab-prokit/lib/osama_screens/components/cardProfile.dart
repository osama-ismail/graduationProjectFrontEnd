import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';

class CardProfile extends StatelessWidget {
  final void Function() ontap;
  // final NoteModel  notemodel ;
  final String title;
  final String content;
  // final void Function()? onDelete;
  const CardProfile(
      {Key? key,
      required this.ontap,
      // required this.notemodel ,
        required this.title,
        required this.content,
      // required this.onDelete
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: ontap,
      child: Card(
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 1,

                child: Icon(Icons.edit, color: Colors.blue,)),


                  // "$linkImageRoot/${notemodel.notesImage}",
                  // width: 100,
                  // height: 100,
                  // fit: BoxFit.fill,

            Expanded(

                flex: 11,
                child: ListTile(
                  // title: Text("osama"),
                  // subtitle: Text("osama"),
                  title: Text("$title", style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40
                  ),),
                  subtitle: Text("$content",style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20
                  )),

                  // trailing: IconButton(
                  //   icon: Icon(Icons.delete),
                  //   // onPressed: onDelete,
                  // ),
                ))
          ],
        ),
      ),
    );
  }
}
