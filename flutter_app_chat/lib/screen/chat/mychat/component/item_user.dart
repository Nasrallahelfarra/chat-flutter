import 'package:flutter/material.dart';
import 'package:flutter_app_chat/Helper/constants.dart';
import 'package:flutter_app_chat/component/CustomeText.dart';
import 'package:flutter_app_chat/data/model/user.dart';
import 'package:get/get.dart';
import 'package:flutter_app_chat/screen/chat/open_cat/screen_open_chat.dart';
class ItemUser extends StatelessWidget {
  User user;

  ItemUser({this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Get.to(OpenChat(peerId: user.id.toString(),name:user.name ,imagePeer: user.image,));},
      child: Container(
          margin: EdgeInsets.all(10),

          decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kBorderColor,width: 1),
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        padding: EdgeInsets.all(20),
        child:   Row(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.asset('assets/images/${user.image}.jpeg',
                height: 75,
                width: 75,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10,),
            Flexible(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomeText(title: user.name,fontSize: 15,),
                Icon(Icons.chat),
              ],
            ),)

          ],
        )


      ),
    );
  }
}
