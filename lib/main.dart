import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

Future testData() async {
  await Firebase.initializeApp();
  FirebaseFirestore db = FirebaseFirestore.instance;

  var data = await db
      .collection('patient_details')
      .get(); //patient_details컬렉션에서 get메서드이용해 모든 데이터 가져옴
  var details = data.docs.toList(); //null이 아닌경우 details리스트에 넣는다.

  details.forEach((d) {
    print(d.id); //id는 firestore내부 고유 식별자
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    testData();
    return MaterialApp(
      title: 'Events',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ), //테마 설정
      home: Scaffold(),
    );
  }
}