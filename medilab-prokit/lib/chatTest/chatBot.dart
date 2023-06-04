import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medilab_prokit/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'firebase_options.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  int i=0;
  void _sendMessage() {
    String message = _messageController.text.trim().toLowerCase();
    if (message.isNotEmpty) {
      FirebaseFirestore.instance.collection('messages').add({
        'text': message,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'additionalString': i,
      });

      // Check if the message contains "hello"
      if (message.contains('hello')) {
        FirebaseFirestore.instance.collection('messages').add({
          'text': 'How can I help you?',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
      } else if (message.contains('location')) {
        FirebaseFirestore.instance.collection('messages').add({
          'text': 'Nablus-Rafedia, here is the link on the Google Maps...',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
      } else if (message.contains('hi')) {
        FirebaseFirestore.instance.collection('messages').add({
          'text': 'How can I help you?',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
      } else if (message.contains('do you love me?')) {
        FirebaseFirestore.instance.collection('messages').add({
          'text': 'dooo you dooo youu',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
      } else if (message.contains('meen 3ammak wala?')) {
        FirebaseFirestore.instance.collection('messages').add({
          'text': 'mohammad jury 3ammy w taj rase',
          'timestamp': DateTime.now().day,
        });
      }
      else{
        FirebaseFirestore.instance.collection('messages').add({
          'text': 'please ask again',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
      }


      _messageController.clear();
    }
  }
  void _onIconTap() {
    // Perform the desired action when the icon is tapped
    if(sharedPref.getString("istick")=="0"){
      Navigator.of(context).pushNamedAndRemoveUntil("Admincategory", (route) => false);

    }
    else{
      Navigator.of(context).pushNamedAndRemoveUntil("homePage", (route) => false);

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ChatBot'),  leading: GestureDetector(
        onTap: _onIconTap, // Add the onTap callback here
        child: Icon(Icons.arrow_back), // Add the icon here
      ),),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var message = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text(
                          message['text'],
                          style: TextStyle(fontSize: 16.0),
                        ),
                        subtitle: Text(
                          '${DateTime.fromMillisecondsSinceEpoch(message['timestamp'])}',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
