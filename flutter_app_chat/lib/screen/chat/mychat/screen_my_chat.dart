import 'package:flutter/material.dart';
import 'package:flutter_app_chat/data/model/user.dart';
import 'package:flutter_app_chat/screen/home/home_screen.dart';

import 'component/item_user.dart';
class MyChat extends StatefulWidget {
  User user;

  MyChat({this.user});

  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  User user1=User(id: 1,name: 'ali',image: 'user1');
  User user2=User(id: 2,name: 'omare',image: 'user2');
  User user3=User(id: 3,name: 'fadi',image: 'user3');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ItemUser(user: (HomeScreen.typeUser==1)?user2:user1,),

        ],
      ),
    );
  }
}
