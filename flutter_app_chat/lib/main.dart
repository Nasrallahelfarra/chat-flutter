import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Helper/theme.dart';
import 'data/local/SharedPreferencees.dart';
import 'screen/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp();
  PreferenceUtils.init();
  runApp(MyHomePage());
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(home:HomeScreen(),
        theme: theme(),
        title: 'Flutter Demo',
        locale:Locale('en'),
        fallbackLocale: Locale('en'),
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == '/') {
            return new MaterialPageRoute<Null>(
              settings: settings,
              builder: (_) => new MyHomePage(),
              maintainState: false,
            );
          }
          return null;
        }
    );
  }



}
