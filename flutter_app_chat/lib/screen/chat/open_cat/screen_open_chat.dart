import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_app_chat/Helper/constants.dart';
import 'package:flutter_app_chat/component/Loading.dart';
import 'package:flutter_app_chat/component/WidjetRelase.dart';
import 'package:flutter_app_chat/data/local/SharedPreferencees.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/TypeImageLeft.dart';
import 'component/TypeImageRight.dart';
import 'component/TypeText.dart';

class OpenChat extends StatefulWidget {
   String peerId;
   String name;
   String imagePeer;

   OpenChat({this.peerId, this.name,this.imagePeer});

  @override
  _OpenChatState createState() => _OpenChatState();
}

class _OpenChatState extends State<OpenChat> {
  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  int _limit = 20;
  final int _limitIncrement = 20;
  String groupChatId;
  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;
  String id;
  SharedPreferences prefs;

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
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);

    groupChatId = '';

    isLoading = false;
    isShowSticker = false;
    imageUrl = '';

    readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = PreferenceUtils.getUser().id.toString();

    print(widget.peerId);
    print(id);
    int newid=int.parse(id);
    int pe=int.parse(widget.peerId);
    if (newid < pe) {
      groupChatId = '$id-${widget.peerId}';
    } else {
      groupChatId = '${widget.peerId}-$id';
    }
     if(5>6){

     }


    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: WidjetRelase.getIntanse().appBar(title: widget.name),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),

              // Sticker
              // Input content
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
      //onWillPop: onBackPress,
    );

  }
  bool isLastMessageRight(int index) {
    if ((index > 0 &&
        listMessage != null &&
        listMessage[index - 1].data()['idFrom'] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }
  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
        listMessage != null &&
        listMessage[index - 1].data()['idFrom'] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }
  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);

    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadFile();
    }
  }


  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference reference = FirebaseStorage.instance.ref().child(fileName);
    await reference.putFile(imageFile);
     reference.getDownloadURL().then((downloadUrl) {
       imageUrl = downloadUrl;
       setState(() {
         isLoading = false;
         onSendMessage(imageUrl, 1);
       });

     }, onError: (err) {
       setState(() {
         isLoading = false;
       });
       Fluttertoast.showToast(msg: 'This file is not an image');
     });

  }
  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.peerId)
        .collection('mychat').doc(widget.peerId).set({
      'peerId': PreferenceUtils.getUser().id,
      'imagePeer':PreferenceUtils.getUser().image,
      'name': PreferenceUtils.getUser().name,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'content': content,
      'type': type
    },);
    if (content.trim() != '') {
      textEditingController.clear();
      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': id,
            'imagePeer':widget.imagePeer,
            'idTo': widget.peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send',
          backgroundColor: Colors.black,
          textColor: Colors.red);
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document.data()['idFrom'] == id) {
      // Right (my message)
      return Row(
        children: <Widget>[
          document.data()['type'] == 0
          // Text
              ? TypeText(document:document,islastmrssage:isLastMessageRight(index)  ,isMe: true,)
              : document.data()['type'] == 1
          // Image
              ? TypeImageRight(document:document,islastmrssage:isLastMessageRight(index)  ,)
          // Sticker
              : Container(
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {

      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)?
        ClipOval(
          child: Image.asset('assets/images/${widget.imagePeer}.jpeg',
            height: 35,
            width: 35,
            fit: BoxFit.cover,
          ),
        )
              /*  Material(
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      ),
                      width: 35.0,
                      height: 35.0,
                      padding: EdgeInsets.all(10.0),
                    ),
                    imageUrl: widget.imagePeer,
                    width: 35.0,
                    height: 35.0,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                )*/
                    : Container(width: 35.0),
                document.data()['type'] == 0
                // Text
                    ? TypeText(document:document,islastmrssage:isLastMessageRight(index)  ,isMe: false,)
                    : document.data()['type'] == 1
                // Image
                    ? TypeImageLeft(document:document,islastmrssage:isLastMessageLeft(index)  ,)
                // Sticker
                    : Container(
                ),
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
              child: Text(
                DateFormat('dd MMM kk:mm').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        int.parse(document.data()['timestamp']))),
                style: TextStyle(
                    color: kBorderColor,
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic),
              ),
              margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
            )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }
  Widget buildListMessage() {
    print("groupChatId $groupChatId");
    return Flexible(
      child: groupChatId == ''
          ? Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)))
          : StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .doc(groupChatId)
            .collection(groupChatId)
            .orderBy('timestamp', descending: true)
            .limit(_limit)
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
                  buildItem(index, snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
              reverse: true,
              controller: listScrollController,
            );
          }
        },
      ),
    );
  }
  Widget buildLoading() {
    return Positioned(
      child: isLoading ? const Loading() : Container(),
    );
  }

  buildInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              getImage();
            },
          ),
          Expanded(
            child: TextField(
              onSubmitted: (value) {
                onSendMessage(textEditingController.text, 0);
              },
              controller: textEditingController,

              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},

              decoration: InputDecoration(
                hintText: 'Send a message...',
                contentPadding: EdgeInsets.all(10.0),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              focusNode: focusNode,

            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () => onSendMessage(textEditingController.text, 0),
          ),
        ],
      ),
    );
  }
}
