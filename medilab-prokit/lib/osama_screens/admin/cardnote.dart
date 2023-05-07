import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/crud.dart';

class CardNotes extends StatefulWidget {
  final void Function() ontap;
  // final NoteModel  notemodel ;
  final String title;
  final String id;

  final String content;
  final String image;
  const CardNotes(
      {Key? key,
        required this.ontap,
        // required this.notemodel ,
        required this.title,
        required this.content,
        required this.image,
        required this.id,

      })
      : super(key: key);
  // const CardNotes( this.ontap, this.title, this.content, this.image);

  @override
  CartCardState createState() => CartCardState();
}

class CartCardState extends State<CardNotes> with Crud {



  // final void Function()? onDelete;
  onDelete() async {
// print(widget.id);
    var response =
    await postRequest(deleteCategoryAdmin, {"id":widget.id });
    // print("ibrahim");
    // print(response);
Navigator.of(context)
    .pushNamedAndRemoveUntil("Admincategory", (route) => false);
    return response;
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [

            Expanded(
                flex: 1,
                child: Image.network(
                  "$linkImageRoot/${widget.image}",
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
                  title: Text(" ${widget.content}"),
                    // subtitle: Text(" ${widget.title}"),
                    trailing:
                    IconButton(
                icon: Icon(Icons.delete),
              onPressed:  onDelete,
            ),
                  // subtitle: Text(" Price : $title"),

                  // trailing: IconButton(
                  //   icon: Icon(Icons.delete),
                  //   onPressed: onDelete,
                  // ),
                )
            )
          ],
        ),
      ),
    );
  }
}
