import 'package:flutter/material.dart';
import 'package:flutter_app_chat/Helper/constants.dart';
import 'package:get/get.dart';

class CustomeTabBar extends StatelessWidget {

   TabController controller;

   CustomeTabBar({Key key,this.controller}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: kPrimaryColor,
      labelColor: kPrimaryColor,
      unselectedLabelColor: kUnSelectTabColor,
      tabs: [
        Tab(text:"User" ,),
        Tab(text:"My Chat",),
      ],
  controller: controller,
    );
  }
}
