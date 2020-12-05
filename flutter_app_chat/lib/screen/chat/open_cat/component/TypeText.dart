import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/Helper/constants.dart';
class TypeText extends StatelessWidget {
  DocumentSnapshot document;
  bool islastmrssage;
  bool isMe;
  TypeText({this.document, this.islastmrssage,this.isMe});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Text(
        document.data()['content'],
        style: TextStyle(color:(isMe) ?Colors.white:Colors.black),
      ),
      margin: isMe
          ? EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 80.0,
      )
          : EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ?kPrimaryColor : Color(0xFFFFEFEE),
        borderRadius: isMe
            ? BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        )
            : BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
    );
  }
}
