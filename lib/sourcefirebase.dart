import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/datafetch.dart';
import 'package:flutter_fire/singup.dart';

class FirebaseClass extends StatefulWidget {


  @override
  _FirebaseClassState createState() => _FirebaseClassState();
}

class _FirebaseClassState extends State<FirebaseClass> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("Error");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return DataFetch();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Text("");
      },
    );
  }
}
