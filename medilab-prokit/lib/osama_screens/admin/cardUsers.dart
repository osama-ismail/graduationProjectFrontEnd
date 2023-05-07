import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/crud.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class CardNotes extends StatefulWidget {
  final void Function() ontap;

  // final NoteModel  notemodel ;
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
      required this.id})
      : super(key: key);

  // const CardNotes( this.ontap, this.title, this.content, this.image);

  @override
  CartCardState createState() => CartCardState();
}

class CartCardState extends State<CardNotes> with Crud {
  // --------
// class CardNotes extends StatelessWidget {

  // final void Function()? onDelete;

  onCall() async {
    launch("tel://21213123123");
  }

  @override
  void initState() {
    super.initState();
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
                  title: Text(
                    " ${widget.content}",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w700,fontSize: 20),
                  ),
                  subtitle: Text(" ${widget.title}",style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500,fontSize: 14),),
                  trailing: IconButton(
                    icon: Icon(Icons.call,color: Colors.blue,),
                    onPressed: onCall,
                  ),
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
