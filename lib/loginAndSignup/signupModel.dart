import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  String name = '';
  String address = '';
  String mail = '';
  String password = '';
  String tel = '';

  Future signUp() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: mail, password: password);

    FirebaseFirestore.instance.collection('users').add(
      {
        "uid": auth.currentUser!.uid,
        'name': name,
        'address': address,
        'email': mail,
        'tel': tel,
        'createdAt': Timestamp.now(),
      },
    );
  }
}
