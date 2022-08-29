import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:disasteravert/pages/loading.dart';
import 'package:disasteravert/pages/home.dart';


Future <void> main ()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    //initialRoute: '/',
    //routes: {
      //'/': (context) => loading(),
      //'/home': (context) => Home(),
      home: loading(),
    //},
  ));
}