import 'package:flutter/material.dart';
import 'package:flutter_app_chat/component/RoundButtom.dart';
import 'package:flutter_app_chat/component/WidjetRelase.dart';
import 'package:flutter_app_chat/data/local/SharedPreferencees.dart';
import 'package:flutter_app_chat/data/model/user.dart';
import 'package:flutter_app_chat/screen/chat/main_chat.dart';
import 'package:flutter_app_chat/utility/size_config.dart';

import 'package:get/get.dart';
class HomeScreen extends StatefulWidget {
  static int typeUser=0;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User user1=User(id: 1,name: 'ali',image: 'user1');
  User user2=User(id: 2,name: 'omare',image: 'user2');
  User user3=User(id: 3,name: 'fadi',image: 'user3');
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: WidjetRelase.getIntanse().appBar(title: "Main"),

      body: Container(
        padding: EdgeInsets.all(20),
        height: SizeConfig.screenHeight,
        alignment:Alignment.center ,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(100),),

            ReoundButtom(title: "User1",
              press: (){
                PreferenceUtils.setUser(user1);
                HomeScreen.typeUser=1;
                Get.to(MainChat());

                //  Get.back();
            //  Get.to();
              },),
            SizedBox(height: 20,),
            ReoundButtom(title: "User2",
              press: (){
                HomeScreen.typeUser=2;
                PreferenceUtils.setUser(user2);

                 Get.to(MainChat());

                //  Get.back();

              },),
            SizedBox(height: 20,),
           /* ReoundButtom(title: "User3",
              press: (){
                PreferenceUtils.setUser(user3);
                HomeScreen.typeUser=3;

                Get.to(MainChat());

                //  Get.back();

              },),*/
          ],
        ),
      ),
    );
  }
}
