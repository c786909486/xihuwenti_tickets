import 'package:base_flutter/base_flutter.dart';
import 'package:flutter/material.dart';

import 'package:xihuwenti_tickets/ui/select_venue_page.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,cons){
      ScreenHelper.initHelper(cons);
       return MaterialApp(
        title: '冲冲冲',
        navigatorKey: NavigateService.getInstance().key,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: SelectVenuePage(),
      );
    });
  }
}

