import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
// import 'package:ecommerce_osama/app/notes/edit.dart';
import 'package:medilab_prokit/osama_screens/components/cardnote.dart';
import 'package:medilab_prokit/osama_screens/components/cardProfile.dart';
import '../components/customtextform.dart';
import 'package:medilab_prokit/osama_screens/components/crud.dart';
import 'package:medilab_prokit/osama_screens/constant/linkapi.dart';
import 'package:medilab_prokit/osama_screens/model/notemodel.dart';
import 'package:flutter/material.dart';
class CartCard extends StatefulWidget {
  final void Function() ontap;

  // final NoteModel  notemodel ;
  final String title;
  final String content;
  final String id;
  final String count;

  const CartCard(this.ontap, this.title, this.content, this.id, this.count);

  @override
  CartCardState createState() => CartCardState();
}

class CartCardState extends State<CartCard> with Crud  {
  TextEditingController count_text = TextEditingController();

  onDelete() async {
    print(widget.id);
    var response = await postRequest(
        linkDeleteNotes, {"id": widget.id.toString()});
    print("id in delete"+ " "+ widget.id.toString());

    return response;

  }
  editCard() async {
    var response;

    // if (myfile == null) {
    print("osas");
    response = await postRequest(linkEditCart, {
      "id":widget.id ,
      "count":count_text.text
    });
    setState(() {});
    if (response['status'] == "success") {
      Navigator.of(context).pushReplacementNamed("home");
    } else {
      //
    }
  }
  // linkEditCart
  @override
  void initState() {

    count_text.text =widget.count;
    // widget.notes['notes_title'];
    // content.text = sharedPref.getString("email")!;
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
                  title: Text("A new order  ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                  subtitle: Column(

                      children: [
                        Text("total price : ${widget.count}",style: TextStyle(fontSize: 18)),

                    // CustTextFormSign(
                    //     hint: "title",
                    //     mycontroller: count_text,
                    //     valid: (val) {
                    //
                    //     }),

                        Text(" count :" + widget.title,style: TextStyle(fontSize: 18)),

                    // Text(" Count :" + widget.count),
                  ]),



                )),


          ],
        ),
      ),
    );
  }
}
