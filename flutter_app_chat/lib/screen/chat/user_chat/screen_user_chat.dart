import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/Helper/constants.dart';
import 'package:flutter_app_chat/data/local/SharedPreferencees.dart';
import 'package:flutter_app_chat/data/model/user.dart';
import 'package:flutter_app_chat/screen/home/home_screen.dart';

import 'component/item_user.dart';
class UserChat extends StatefulWidget {
  User user;

  UserChat({this.user});

  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<UserChat> {
  User user1=User(id: 1,name: 'ali');
  User user2=User(id: 2,name: 'omare');
  User user3=User(id: 3,name: 'fadi');
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  int _limit = 20;
  final int _limitIncrement = 20;
  _scrollListener() {
    if (listScrollController.offset >=
        listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the bottom");
      setState(() {
        print("reach the bottom");
        _limit += _limitIncrement;
      });
    }
    if (listScrollController.offset <=
        listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the top");
      setState(() {
        print("reach the top");
      });
    }
  }

  @override
  void initState() {
    listScrollController.addListener(_scrollListener);

    // TODO: implement initState
    super.initState();
  }
  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildListMessage() ,

        ],
      ),
    );
  }
  Widget buildListMessage() {
    return Flexible(
      child:  StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(PreferenceUtils.getUser().id.toString())
            .collection('mychat')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(kPrimaryColor)));
          } else {
            listMessage.addAll(snapshot.data.documents);
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  ItemUser1(document: snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
              reverse: false,
              controller: listScrollController,
            );
          }
        },
      ),
    );
  }
}
