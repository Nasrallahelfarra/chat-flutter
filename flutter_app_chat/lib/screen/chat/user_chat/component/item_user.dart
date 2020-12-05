import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/Helper/constants.dart';
import 'package:flutter_app_chat/component/CustomeText.dart';
import 'package:flutter_app_chat/data/model/user.dart';
import 'package:flutter_app_chat/utility/size_config.dart';
import 'package:get/get.dart';
import 'package:flutter_app_chat/screen/chat/open_cat/screen_open_chat.dart';
import 'package:intl/intl.dart';
class ItemUser1 extends StatelessWidget {
  DocumentSnapshot document;

  ItemUser1({this.document});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      Get.to(OpenChat(peerId:document.data()['peerId'].toString(),name:document.data()['name'] ,imagePeer: document.data()['imagePeer'],));

      },

      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
        padding:
        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,

                children: <Widget>[

                  CircleAvatar(
                    radius: 35.0,
                    backgroundImage: AssetImage('assets/images/${document.data()['imagePeer']}.jpeg'),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          document.data()['name'],
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          child: Text(
                              document.data()['content'],
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  DateFormat('dd MMM kk:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          int.parse(document.data()['timestamp']))),
                   style: TextStyle(
                      color: kBorderColor,
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 5.0),


              ],
            ),
          ],
        ),
      ),
    );

  }
  String convertTimeStampToHumanDate(String timeStamp) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp) * 1000);
    return DateFormat('dd/MM/yyyy').format(dateToTimeStamp);
  }
}
