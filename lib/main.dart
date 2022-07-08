import 'package:flutter/material.dart';
import 'employee_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("error");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return employeeUI();
          }

          return Loading();
        },
      ),
    );
  }
}
