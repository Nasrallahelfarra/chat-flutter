import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/Helper/constants.dart';
import 'package:flutter_app_chat/screen/chat/fullImage/FullPhoto.dart';
import 'package:get/get.dart';
class TypeImageRight extends StatelessWidget {

  DocumentSnapshot document;
  bool islastmrssage;

  TypeImageRight({this.document, this.islastmrssage});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: FlatButton(
        child: Material(
          child: CachedNetworkImage(
            placeholder: (context, url) => Container(
              child: CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
              width: 200.0,
              height: 200.0,
              padding: EdgeInsets.all(70.0),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Material(
              child: Image.asset(
                'images/img_not_available.jpeg',
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              clipBehavior: Clip.hardEdge,
            ),
            imageUrl: document.data()['content'],
            width: 200.0,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          clipBehavior: Clip.hardEdge,
        ),
        onPressed: () {
          Get.to(FullPhoto(
              url: document.data()['content']));
        },
        padding: EdgeInsets.all(0),
      ),
      margin: EdgeInsets.only(
          bottom: islastmrssage ? 20.0 : 10.0,
          right: 10.0),
    );
  }
}
