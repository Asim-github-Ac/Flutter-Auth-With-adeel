import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataFetch extends StatefulWidget {


  @override
  _DataFetchState createState() => _DataFetchState();
}

class _DataFetchState extends State<DataFetch> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Total_User').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Column(children: [
                  Text(data['phone Number']),
                  Text(data['City Code'])
                ],),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
