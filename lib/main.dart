import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wbc_detector/route.dart';
import 'package:wbc_detector/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/splash", //첫 페이지 splash
      routes: route, //루트 설정
      theme: theme(), //테마 설정
      debugShowCheckedModeBanner: false, // 우측 상단 debug 띠 해제
    );
  }
}

/*
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'pages/list/list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PatientDetail',
      //theme: ThemeData(
      // primarySwatch: Colors.orange,
      //), //테마 설정
      home: ListPage(),
    );
  }
}

 */
