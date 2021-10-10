import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/dashboard.dart';

class SignUp extends StatefulWidget {


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailcontroler = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController namecontroler= new TextEditingController();
  TextEditingController phonecontroler= new TextEditingController();
  TextEditingController codecontroler= new TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  void Register(String email, String pass) async{
    print(emailcontroler.text);
    try {
      final  UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: pass);

      CollectionReference users = FirebaseFirestore.instance.collection('Total_User');
      users.add({
        'email':email,
        'name': namecontroler.text, // John Doe
        'phone Number': phonecontroler.text, // Stokes and Sons
        'City Code':  codecontroler.text
      })
          .then((value) => print("User Added"))

          .catchError((error) => print("Failed to add user: $error"));
        // users.doc(email).set({
        //   'email':email,
        //   'name': namecontroler.text, // John Doe
        //   'phone Number': phonecontroler.text, // Stokes and Sons
        //   'City Code':  codecontroler.text
        //
        //   });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {

        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      print("not ok");
    }

  }
  void Signin(String email , String pass) async{
    print("Ok");
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass
      );
      print("user login");

      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => DashBoard(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {

        print('No user found for that email.');

      } else if (e.code == 'wrong-password') {

        print('Wrong password provided for that user.');


      }
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase"),),
      body: Column(
        children: [
          TextFormField(
            controller:  namecontroler,
            decoration: const InputDecoration(
              label: Text("Enter Your Name"),
            ),
          ),

          TextFormField(
            controller:  phonecontroler,
            decoration: const InputDecoration(
              label: Text("Enter phone number"),
            ),
          ),

          TextFormField(
            controller: codecontroler,
            decoration: const InputDecoration(
              label: Text("Enter city code"),
            ),
          ),
          TextField(
            controller: emailcontroler,
            decoration: InputDecoration(hintText: "Enter Email"),
          ),
          TextField(
            controller: password,
            decoration: InputDecoration(hintText: "Enter Pass"),
          ),
          ElevatedButton(onPressed: (){

          Register(emailcontroler.text,password.text);

          }, child: Text("Click"))
        ],

      ),


    );

  }

}






// void Signup(String email, String pass) async{
//
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: pass
//     );

//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The password provided is too weak.');
//
//     } else if (e.code == 'email-already-in-use') {
//       snak("already in use");
//       print('The account already exists for that email.');
//
//     }
//   } catch (e) {
//     print(e);
//   }
// }
// void Register() async{
//   print(emailcontroler.text);
//   try {
//     final  UserCredential userCredential = await auth.createUserWithEmailAndPassword(
//       email: emailcontroler.text,
//       password: password.text,);
//
//
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//
//       print('The password provided is too weak.');
//     } else if (e.code == 'email-already-in-use') {
//
//       print('The account already exists for that email.');
//     }
//   } catch (e) {
//     print(e);
//     print("not ok");
//   }
//
// }