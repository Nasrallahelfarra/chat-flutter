import 'package:flutter/material.dart';
import 'package:flutter_app_chat/Helper/constants.dart';
import 'package:flutter_app_chat/component/WidjetRelase.dart';
import 'package:flutter_app_chat/screen/chat/user_chat/screen_user_chat.dart';
import 'package:flutter_app_chat/utility/size_config.dart';

import 'component/CustomeTabBar.dart';
import 'mychat/screen_my_chat.dart';
class MainChat extends StatefulWidget {
  @override
  _MainChatState createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> with SingleTickerProviderStateMixin{
  TabController _tabController;
  int indexTab=0;
  @override
  void initState() {
    // TODO: implement initState
    _tabController=TabController(initialIndex:0,length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }
  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle:true,
          title: Text('Main Chat',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.red,
          bottom:tabBouttom(),
        ),
      body: Container(
        alignment: Alignment.center,
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child:TabBarView(
            children: [
              MyChat(),
              UserChat(),

            ],
            controller: _tabController
        ),
      ),

    );
  }
  void _handleTabSelection() {
    setState(() {
      indexTab=_tabController.index;
    });
  }
  TabBar tabBouttom(){
    return TabBar(
      indicatorColor: kPrimaryColor,
      labelColor: kPrimaryColor,
      unselectedLabelColor: kUnSelectTabColor,
      tabs: [
        Tab(text:"My Chat",),
        Tab(text:"User" ,),
      ],
      controller: _tabController,
    );
  }
}
