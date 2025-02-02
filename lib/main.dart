import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmate/homescreen.dart';
import 'package:taskmate/login_screen.dart';
//import 'package:taskmate/signup_screen.dart';


import 'firebase_options.dart';

// ...





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
    print('Firebase Initialized');
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TaskMate",
      theme: ThemeData(primarySwatch: Colors.indigo,primaryColor: Colors.indigo),
      home: _auth.currentUser!=null? HomeScreen(): LoginScreen(),

    );
  }
}

