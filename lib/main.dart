import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lpggasmaster1/DB.dart';
import 'package:lpggasmaster1/Screens/QrScan.dart';

import 'package:lpggasmaster1/Screens/Search.dart';
import 'package:lpggasmaster1/Screens/login.dart';
import 'package:lpggasmaster1/Screens/prelogin.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();

  runApp(MyApp());
  // print(profile);
  // await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'LPG Gas Meter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null ? PreLogin() : SearchId(),
    );
  }
}
