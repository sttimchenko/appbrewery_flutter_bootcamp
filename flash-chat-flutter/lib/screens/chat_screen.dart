import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

User loggedInUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  void fetchCurrentUser() {
    final user = _auth.currentUser;

    if (user != null) {
      loggedInUser = user;
    }
  }

  @override
  void initState() {
    super.initState();

    fetchCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                      controller: messageTextController,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      messageTextController.clear();

                      final data = {
                        "text": messageText,
                        "sender": loggedInUser.email,
                        'timestamp': Timestamp.now(),
                      };

                      await _firestore.collection('messages').add(data);
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages')
          .orderBy('timestamp')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final messages = snapshot.data.docs.reversed;

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: messages.map((e) {
              final message = e.data()['text'];
              final sender = e.data()['sender'];

              return MessageBubble(
                sender: sender,
                text: message,
                isFromTheUser: loggedInUser.email == sender,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}


class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isFromTheUser;

  MessageBubble({this.sender, this.text, this.isFromTheUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isFromTheUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            color: isFromTheUser ? Colors.lightBlueAccent : Colors.white,
            elevation: 6.0,
            borderRadius: BorderRadius.only(
              topLeft:
                  isFromTheUser ? Radius.circular(30.0) : Radius.circular(0.0),
              topRight:
                  isFromTheUser ? Radius.circular(0.0) : Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 16.0,
                  color: isFromTheUser ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

