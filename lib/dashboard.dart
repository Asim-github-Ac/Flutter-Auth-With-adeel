import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {


  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  TextEditingController namecontroler= new TextEditingController();
  TextEditingController phonecontroler= new TextEditingController();
  TextEditingController codecontroler= new TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  void AddUserDetails(){
    CollectionReference users = FirebaseFirestore.instance.collection('Total_User');
    users.add({
    'name': namecontroler.text, // John Doe
    'phone Number': phonecontroler.text, // Stokes and Sons
    'City Code':  codecontroler.text
    })
        .then((value) => print("User Added"))

        .catchError((error) => print("Failed to add user: $error"));


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar( title: Text("DashBoard"),),
      body: Container(

        child: Column(

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
            ElevatedButton(onPressed: (){
              AddUserDetails();


            }, child: Text("Insert")),



          ],
        ),


      ),


    );
  }
}
