import 'package:flutter/material.dart';
import 'package:flutterproviderapp/provider_test2.dart';
import 'package:flutterproviderapp/provider_test3.dart';
import 'package:flutterproviderapp/provider_test4.dart';
import 'package:flutterproviderapp/provider_test5.dart';
import 'package:flutterproviderapp/provider_test6.dart';
import 'complete_provider.dart';
import 'provider_test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Provider Demo',
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
      home: MyHomePage7(),
    );
  }
}
